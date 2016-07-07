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
    id: 'albums'
    events:
        "click .jsOpenAlbum": "openAlbum"
        "click .jsCloseAlbum": "closeAlbum"

    initialize: ->
        @$el = $('#'+@id)
        @el = @$el[0]

        @listenTo @model, 'albumsLoaded', @render
        @listenTo @model, 'albumDeselected', @render
        @listenTo @model, 'albumSelected', @renderTitle

    render: ->
        albums = @model.toJSON()
        @$el.empty()

        for album in albums
            maxWidth = (150*album.img.S.width)/album.img.S.height
            link = '#albums/' + album.id.replace(/^.*:(\w+)$/, '$1')

            $albumCode = $ "<div class=\"bPhotoPage__eAlbumsItem jsOpenAlbum\" id=\"#{album.id}\" style=\"max-width: #{maxWidth}px\">" +
                "<a href=\"#{link}\" class=\"mNoline jsCover\"></a>" +
                "<span class=\"bPhotoPage__eAlbumsText\"><a href=\"#{link}\">#{album.title}</a></span>" +
                "</div>"

            $albumCode.addClass 'mHidden'
            onload = (anbumEl)->
                return ->
                    anbumEl.removeClass 'mHidden'

            img = new Image()
            img.className = 'bPhotoPage__eAlbumsImg'
            img.alt = ''
            img.onload = onload $albumCode
            img.src = album.img.M.href
            $albumCode.find('.jsCover').html img
            @$el.append $albumCode
            @$el.append ' '

        albumsHTML = []
        for i in [0..6]
            albumsHTML.push '<div class=\"bPhotoPage__eAlbumsItem mEmpty\"></div>'

        @$el.append albumsHTML.join(' ')

    renderTitle: ->
        album = @model.selected
        if album?
            @$el.html "<span class=\"bPhotoPage__eAlbum\"><a href=\"#albums\" class=\"bPhotoPage__eAlbumLink jsCloseAlbum\">Альбомы</a> &rarr; <span class=\"bPhotoPage__eAlbumTitle\">#{album.get('title')}</span></span>"

    openAlbum: (e)->
        albumId = $(e.currentTarget).attr('id')
        @model.select @model.get albumId
        fotki.router.navigate 'albums/' + albumId.replace(/^.*:(\w+)$/, '$1')

        return false

    closeAlbum: ->
        @model.deselect()
        fotki.router.navigate 'albums'

        return false

fotki.views.album = Backbone.View.extend
    id: 'photos'
    initialize: ->
        @$el = $('#'+@id)
        @el = @$el[0]
        @columnWidth = $('.bPhotoPage__eHiddenPhoto').outerWidth(true)
        @columnsCount = Math.floor @$el.width() / @columnWidth

        @resize = _.debounce =>
            @columnWidth = $('.bPhotoPage__eHiddenPhoto').outerWidth(true)
            newColumnsCount = Math.floor @$el.width() / @columnWidth

            if newColumnsCount isnt @columnsCount
                @columnsCount = newColumnsCount
                @render true

        , 200

        $(window).bind 'resize', _.bind(@resize, @)

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

            groupedPhotos = _.values _.groupBy photos, (photo, i)=>
                return i%@columnsCount

            renderData = []
            for group in groupedPhotos
                $column = $('<div></div>').addClass('bPhotoPage__eColumn').css {'min-width': @columnWidth, width: 100/@columnsCount+'%'}
                renderData.push $column

                for photo in group
                    img = new Image()
                    img.src = photo.img.M.href
                    img.id = photo.id
                    img.alt = photo.img.orig.href
                    img.className = "bPhotoPage__ePhotosImg"

                    link = $("<a href=\"#{photo.img.orig.href}\" data-gallery=\"#{album}\" data-gallery-id=\"#{photo.id}\"></a>")
                    .addClass('bPhotoPage__ePhotosLink jsFotka jsGallery')

                    link.html(img).addClass unless fast then 'mHidden'

                    onload = (linkEl)->
                        return ->
                            linkEl.removeClass 'mHidden'

                    img.onload = onload(link)
                    $column.append link

            @$el.html renderData

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

        if model?
            @listenTo fotki.app, 'albumSelected', gal

            fotki.app.select model

        else
            @albumsList()


    albumsList: ->
        window.gallery?.close()
        delete window.gallery

        @stopListening fotki.app, 'albumSelected'

        fotki.app.trigger 'albumsLoaded'
        fotki.app.deselect()


$ ->
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

