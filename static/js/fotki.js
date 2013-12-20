(function() {
  window.fotki = {
    preferences: {
      author: 'nim579'
    },
    models: {},
    views: {},
    app: null
  };

  fotki.models.album = Backbone.Model.extend({});

  fotki.models.albums = Backbone.Collection.extend({
    model: fotki.models.album,
    initialize: function() {
      $.ajaxSettings.dataType = 'jsonp';
      this.view = new fotki.views.albums({
        model: this
      });
      this.selected = null;
      return this.on('sync', this.initView);
    },
    url: function() {
      return "http://api-fotki.yandex.ru/api/users/" + fotki.preferences.author + "/albums/?format=json&callback=?";
    },
    parse: function(data) {
      _.map(data.entries, function(entry) {
        entry.img.M = {
          href: entry.img.S.href.replace(/_S$/, '_M')
        };
        entry.collection = new fotki.models.photos();
        entry.collection.link = entry.links.photos;
        return entry;
      });
      data.entries = _.filter(data.entries, function(entry) {
        return entry.imageCount > 0;
      });
      data.entries = _.sortBy(data.entries, function(entry) {
        return entry.published;
      }).reverse();
      data.entries = _.reject(data.entries, function(entry) {
        return entry.id === 'urn:yandex:fotki:nim579:album:11940';
      });
      return data.entries;
    },
    initView: function() {
      return this.albumView = new fotki.views.album();
    },
    select: function(model) {
      var _this = this;
      this.selected = model;
      if (model != null) {
        return model.get('collection').fetch().done(function() {
          var _ref;
          if ((_ref = _this.albumView) != null) {
            _ref.addModel(_this.get(model));
          }
          return _this.trigger('albumSelected');
        });
      }
    },
    deselect: function() {
      var _ref;
      this.selected = null;
      if ((_ref = this.albumView) != null) {
        _ref.removeModel();
      }
      return this.trigger('albumDeselected');
    }
  });

  fotki.models.photo = Backbone.Model.extend({});

  fotki.models.photos = Backbone.Collection.extend({
    model: fotki.models.photo,
    url: function() {
      return this.link + '&callback=?';
    },
    parse: function(data) {
      return data.entries;
    }
  });

  fotki.views.albums = Backbone.View.extend({
    id: 'albums',
    events: {
      "click .jsOpenAlbum": "openAlbum",
      "click .jsCloseAlbum": "closeAlbum"
    },
    initialize: function() {
      this.$el = $('#' + this.id);
      this.el = this.$el[0];
      this.listenTo(this.model, 'albumsLoaded', this.render);
      this.listenTo(this.model, 'albumDeselected', this.render);
      return this.listenTo(this.model, 'albumSelected', this.renderTitle);
    },
    render: function() {
      var album, albums, albumsHTML, i, link, maxWidth, _i, _j, _len;
      albums = this.model.toJSON();
      albumsHTML = [];
      for (_i = 0, _len = albums.length; _i < _len; _i++) {
        album = albums[_i];
        maxWidth = (150 * album.img.S.width) / album.img.S.height;
        link = '#albums/' + album.id.replace(/^.*:(\w+)$/, '$1');
        albumsHTML.push(("<div class=\"bPhotoPage__eAlbumsItem jsOpenAlbum\" id=\"" + album.id + "\" style=\"max-width: " + maxWidth + "px\">") + ("<a href=\"" + link + "\" class=\"mNoline\"><img class=\"bPhotoPage__eAlbumsImg\" src=\"" + album.img.M.href + "\" alt=\"\"></a>") + ("<span class=\"bPhotoPage__eAlbumsText\"><a href=\"" + link + "\">" + album.title + "</a></span>") + "</div>");
      }
      for (i = _j = 0; _j <= 6; i = ++_j) {
        albumsHTML.push('<div class=\"bPhotoPage__eAlbumsItem mEmpty\"></div>');
      }
      return this.$el.html(albumsHTML.join(' '));
    },
    renderTitle: function() {
      var album;
      album = this.model.selected;
      if (album != null) {
        return this.$el.html("<span class=\"bPhotoPage__eAlbum\"><a href=\"#albums\" class=\"bPhotoPage__eAlbumLink jsCloseAlbum\">Альбомы</a> &rarr; <span class=\"bPhotoPage__eAlbumTitle\">" + (album.get('title')) + "</span></span>");
      }
    },
    openAlbum: function(e) {
      var albumId;
      albumId = $(e.currentTarget).attr('id');
      this.model.select(this.model.get(albumId));
      fotki.router.navigate('albums/' + albumId.replace(/^.*:(\w+)$/, '$1'));
      return false;
    },
    closeAlbum: function() {
      this.model.deselect();
      fotki.router.navigate('albums');
      return false;
    }
  });

  fotki.views.album = Backbone.View.extend({
    id: 'photos',
    initialize: function() {
      var _this = this;
      this.$el = $('#' + this.id);
      this.el = this.$el[0];
      this.columnWidth = $('.bPhotoPage__eHiddenPhoto').outerWidth(true);
      this.columnsCount = Math.floor(this.$el.width() / this.columnWidth);
      this.resize = _.debounce(function() {
        var newColumnsCount;
        _this.columnWidth = $('.bPhotoPage__eHiddenPhoto').outerWidth(true);
        newColumnsCount = Math.floor(_this.$el.width() / _this.columnWidth);
        if (newColumnsCount !== _this.columnsCount) {
          _this.columnsCount = newColumnsCount;
          return _this.render();
        }
      }, 200);
      return $(window).bind('resize', _.bind(this.resize, this));
    },
    addModel: function(model) {
      this.model = model;
      this.listenTo(this.model, 'albumSelected', this.open);
      this.listenTo(this.model, 'albumDeselected', this.close);
      return this.open();
    },
    removeModel: function() {
      this.stopListening(this.model, 'albumSelected');
      this.stopListening(this.model, 'albumDeselected');
      this.model = null;
      return this.close();
    },
    open: function() {
      return this.render();
    },
    close: function() {
      return this.unrender();
    },
    render: function() {
      var $column, group, groupedPhotos, img, link, onload, photo, photos, renderData, _i, _j, _len, _len1,
        _this = this;
      if (this.model != null) {
        photos = this.model.get('collection').toJSON();
        groupedPhotos = _.values(_.groupBy(photos, function(photo, i) {
          return i % _this.columnsCount;
        }));
        renderData = [];
        for (_i = 0, _len = groupedPhotos.length; _i < _len; _i++) {
          group = groupedPhotos[_i];
          $column = $('<div></div>').addClass('bPhotoPage__eColumn').css({
            'min-width': this.columnWidth,
            width: 100 / this.columnsCount + '%'
          });
          renderData.push($column);
          for (_j = 0, _len1 = group.length; _j < _len1; _j++) {
            photo = group[_j];
            img = new Image();
            img.src = photo.img.M.href;
            img.id = photo.id;
            img.alt = photo.img.orig.href;
            img.className = "bPhotoPage__ePhotosImg";
            link = $("<a href=\"" + photo.img.orig.href + "\"></a>").addClass('bPhotoPage__ePhotosLink jsFotka');
            link.html(img.outerHTML).hide();
            onload = function(linkEl) {
              return function() {
                return linkEl.show();
              };
            };
            img.onload = onload(link);
            $column.append(link);
          }
        }
        return this.$el.html(renderData);
      }
    },
    unrender: function() {
      return this.$el.empty();
    }
  });

  fotki.models.router = Backbone.Router.extend({
    routes: {
      "": "albumsList",
      "albums": "albumsList",
      "albums/:id": "photosList"
    },
    photosList: function(album) {
      var model;
      model = fotki.app.find(function(model) {
        var exp;
        exp = new RegExp(':' + album + '$');
        return model.id.match(exp) != null;
      });
      if (model != null) {
        return fotki.app.select(model);
      } else {
        return this.albumsList();
      }
    },
    albumsList: function() {
      fotki.app.trigger('albumsLoaded');
      return fotki.app.deselect();
    }
  });

  $(function() {
    fotki.app = new fotki.models.albums();
    return fotki.app.fetch().done(function() {
      fotki.router = new fotki.models.router();
      return Backbone.history.start();
    });
  });

}).call(this);
