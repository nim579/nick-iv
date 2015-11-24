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
        @selected = model
        if model?
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

        albumsHTML = []
        for album in albums
            maxWidth = (150*album.img.S.width)/album.img.S.height
            link = '#albums/' + album.id.replace(/^.*:(\w+)$/, '$1')
            albumsHTML.push "<div class=\"bPhotoPage__eAlbumsItem jsOpenAlbum\" id=\"#{album.id}\" style=\"max-width: #{maxWidth}px\">" +
                "<a href=\"#{link}\" class=\"mNoline\"><img class=\"bPhotoPage__eAlbumsImg\" src=\"#{album.img.M.href}\" alt=\"\"></a>" +
                "<span class=\"bPhotoPage__eAlbumsText\"><a href=\"#{link}\">#{album.title}</a></span>" +
                "</div>"

        for i in [0..6]
            albumsHTML.push '<div class=\"bPhotoPage__eAlbumsItem mEmpty\"></div>'

        @$el.html albumsHTML.join(' ')

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
                @render()

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

    render: ->
        if @model?
            photos = @model.get('collection').toJSON()

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

                    link = $("<a href=\"#{photo.img.orig.href}\"></a>").addClass('bPhotoPage__ePhotosLink jsFotka')
                    link.html(img.outerHTML).hide()

                    onload = (linkEl)->
                        return ->
                            linkEl.show()

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

    photosList: (album)->
        model = fotki.app.find (model)->
            exp = new RegExp(':'+album+'$')
            return model.id.match(exp)?

        if model?
            fotki.app.select model
        else
            @albumsList()

    albumsList: ->
        fotki.app.trigger 'albumsLoaded'
        fotki.app.deselect()


$ ->
    fotki.app = new fotki.models.albums()
    fotki.app.fetch().done ->
        fotki.router = new fotki.models.router()
        Backbone.history.start()

