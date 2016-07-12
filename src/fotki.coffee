window.fotki =
    preferences:
        author: 'nim579'

    models: {}
    views: {}
    app: null

fotki.models.album = Backbone.Model.extend({})

fotki.models.albums = Backbone.Collection.extend
    model: fotki.models.album

    initialize: ->
        $.ajaxSettings.dataType = 'jsonp'

        @view = new fotki.views.albums {model: @}
        @selected = null

        @on 'sync', @initView

    url: ->
        return "//api-fotki.yandex.ru/api/users/#{fotki.preferences.author}/albums/?format=json&callback=?"

    parse: (data)->
        data.entries = _.reject data.entries, (entry)->
            return entry.protected

        _.map data.entries, (entry)->
            entry.img.M =
                href: entry.img.S.href.replace(/_S$/, '_M')

            entry.collection = new fotki.models.photos()
            entry.collection.link = entry.links.photos
            return entry

        data.entries = _.filter data.entries, (entry)->
            return entry.imageCount > 0

        data.entries = _.sortBy data.entries, (entry)->
            return entry.published
        .reverse()

        data.entries = _.reject data.entries, (entry)->
            return entry.id is 'urn:yandex:fotki:nim579:album:11940'

        return data.entries

    initView: ->
        @albumView = new fotki.views.album()

    select: (model)->
        if model? and @selected?.id isnt model.id
            @selected = model

            @trigger 'albumSelectStart'

            model.get('collection').fetch().done =>
                @albumView?.addModel @get model
                @trigger 'albumSelected'

    deselect: ()->
        @selected = null
        @albumView?.removeModel()
        @trigger 'albumDeselected'

fotki.models.photo = Backbone.Model.extend({})

fotki.models.photos = Backbone.Collection.extend
    model: fotki.models.photo

    url: ->
        return @link + '&callback=?'

    parse: (data)->
        return data.entries

fotki.views.albums = Backbone.View.extend
    el: '.jsAlbums'

    initialize: ->
        @listenTo @model, 'albumsLoaded', @render
        @listenTo @model, 'albumDeselected', @render
        @listenTo @model, 'albumSelected', @renderTitle
        @listenTo @model, 'albumSelectStart', @unrender

    render: ->
        albums = @model.toJSON()
        loaders = []

        @$el.empty()

        _.each albums, (album)=>
            loader = new $.Deferred()
            link = '#albums/' + album.id.replace(/^.*:(\w+)$/, '$1')

            $album = $ """
                <a href="#{link}" class="bPhotoPage__eAlbumsItem jsOpenAlbum" id="#{album.id}">
                    <span class="bPhotoPage__eAlbumsText">
                        #{album.title}
                        <span class="bPhotoPage__eAlbumsTextCount">(#{album.imageCount})</span>
                    </span>
                </a>
            """

            $album.addClass 'mHidden'

            img = new Image()
            img.className = 'bPhotoPage__eAlbumsImg'
            img.alt = ''
            img.onload = ->
                w = @width
                $album.prepend img
                $album
                .css 'max-width': w
                .removeClass 'mHidden'

                loader.resolve()

            img.src = album.img.M.href

            @$el.append $album
            loaders.push loader

        $.when.apply $, loaders
        .then ->
            fotki.$preloader.hide()

        for i in [0...5]
            @$el.append '<div class="bPhotoPage__eAlbumsItem mEmpty"></div>'

    renderTitle: ->
        album = @model.selected
        if album?
            @$el.html "<span class=\"bPhotoPage__eAlbum\"><a href=\"#albums\" class=\"bPhotoPage__eAlbumLink jsCloseAlbum\">Альбомы</a> &rarr; <span class=\"bPhotoPage__eAlbumTitle\">#{album.get('title')}</span></span>"

    unrender: ->
        @$el.empty()


fotki.views.album = Backbone.View.extend
    el: '.jsPhotos'

    addModel: (model)->
        @model = model
        @listenTo @model, 'albumSelected', @open
        @listenTo @model, 'albumDeselected', @close
        @open()

    removeModel: ->
        @stopListening @model, 'albumSelected'
        @stopListening @model, 'albumDeselected'
        @model = null
        @close()

    open: ->
        @render()

    close: ->
        @unrender()

    render: (fast)->
        if @model?
            photos = @model.get('collection').toJSON()
            album  = @model.id
            loaders = []

            @unrender()

            _.each photos, (photo)=>
                loader = new $.Deferred()
                img = new Image()
                img.id = photo.id
                img.alt = photo.img.orig.href
                img.className = "bPhotoPage__ePhotosImg"

                link = $("<a href=\"#{photo.img.orig.href}\" data-gallery=\"#{album}\" data-gallery-id=\"#{photo.id}\"></a>")
                .addClass('bPhotoPage__ePhotosLink jsFotka jsGallery')

                link.html(img).addClass unless fast then 'mHidden'

                img.onload = ->
                    loader.resolve()

                img.src = photo.img.L.href

                loaders.push loader
                @$el.append link

            $.when.apply $, loaders
            .then =>
                @$el.find('.jsFotka').each (i, el)->
                    fotki.$preloader.hide()

                    _.delay ->
                        $(el).removeClass 'mHidden'
                    , (700/loaders.length)*i

    unrender: ->
        @$el.empty()

fotki.models.router = Backbone.Router.extend
    routes:
        "": "albumsList"
        "albums": "albumsList"
        "albums/:id": "photosList"
        "albums/:id/:photo": "photosGallery"

    photosList: (album)->
        model = fotki.app.find (model)->
            exp = new RegExp(':'+album+'$')
            return model.id.match(exp)?

        console.log 'ss', fotki.app.selected
        fotki.$preloader.show() unless fotki.app.selected
        @stopListening fotki.app, 'albumSelected'

        if model?
            fotki.app.select model
            window.gallery?.close()
            delete window.gallery

        else
            @albumsList()

    photosGallery: (album, photo)->
        model = fotki.app.find (model)->
            exp = new RegExp(':'+album+'$')
            return model.id.match(exp)?

        @stopListening fotki.app, 'albumSelected'

        gal = ->
            $el = $('.jsGallery').closest "[data-gallery-id$=\"#{photo}\"]"
            return unless $el.length > 0

            if window.gallery and window.gallery.name.match new RegExp(':'+album+'$')
                window.gallery.setCurrent $el
                window.gallery.updateImage()

            else
                window.gallery?.destroy silent: true
                window.gallery = new Gallery $el

        if fotki.app.selected
            gal()
            return

        fotki.$preloader.show()

        if model?
            @listenTo fotki.app, 'albumSelected', gal

            fotki.app.select model

        else
            @albumsList()


    albumsList: ->
        window.gallery?.close()
        delete window.gallery

        fotki.$preloader.show()
        @stopListening fotki.app, 'albumSelected'

        fotki.app.trigger 'albumsLoaded'
        fotki.app.deselect()


$ ->
    fotki.$preloader = $('.jsPreloader')

    fotki.app = new fotki.models.albums()
    fotki.app.fetch().done ->
        fotki.router = new fotki.models.router()
        Backbone.history.start()

        $(window).bind 'change.gallery', (e, ga, id)->
            album = fotki.app.selected.id.replace(/^.*:(\w+)$/, '$1')
            photo = id.replace(/^.*:(\w+)$/, '$1')

            fotki.router.navigate "albums/#{album}/#{photo}", trigger: false, replace: false

        $(window).bind 'close.gallery', (e, ga)->
            album = fotki.app.selected.id.replace(/^.*:(\w+)$/, '$1')

            fotki.router.navigate "albums/#{album}", trigger: false, replace: false

            delete window.gallery

