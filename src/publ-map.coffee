class publMap
    constructor: ->
        @loadLinks().done =>
            link = @findCurrentLink()
            console.log link
            @render link if link?

    loadLinks: ->
        loader = $.Deferred()
        $.ajax
            url: '/static/other/backstreets-places.json'
            dataType: 'json'
            success: (data)=>
                @backstreets = data.backstreets
                loader.resolve()

        return loader

    findCurrentLink: ->
        link = null
        if @backstreets
            for backstreet in @backstreets
                if backstreet.link is window.location.pathname
                    link = backstreet
                    break

        return link

    render: (link)->
        if $('.jsOpenPublMap').length is 0
            $('.jsPublMap').append "<a class=\"bIcons__eMap mGeo jsOpenPublMap\" href=\"#\"><span class=\"bIcons__eMapLink\">На карте</span></a>"

        @openMapCallback = $.proxy ->
            @openMap link
        , @

        $('.jsOpenPublMap').bind 'click', @openMapCallback

    openMap: (link)->
        if $('#publMap:visible').length is 0
            $('.bIcons__eMap').removeClass('mGeo').addClass('mClose')
            $('.jsPublMap .bIcons__eMapLink').text "Закрыть карту"

            unless @mapInited
                @initMap link

            else
                $('#publMap').show(500)

        else
            $('#publMap').hide(500)

            $('.bIcons__eMap').removeClass('mClose').addClass('mGeo')
            $('.jsPublMap .bIcons__eMapLink').text "На карте"

    initMap: (backstreet)->
        $('.jsPublMap').append "<div id=\"publMap\" class=\"bPubl__eCaptionInbox\"></div>"

        window.backstreetsMap = backstreetsMap = new ymaps.Map "publMap",
            center: backstreet.coordinates
            zoom: 13
            type: "yandex#map"
            controls: ['zoomControl', 'routeEditor', 'geolocationControl', 'fullscreenControl', 'rulerControl']

        typeSelector = new ymaps.control.TypeSelector ['yandex#map', 'yandex#satellite', 'yandex#hybrid', 'yandex#publicMap']
        backstreetsMap.controls.add typeSelector

        searchControl = new ymaps.control.SearchControl options: {size: 'small'}
        backstreetsMap.controls.add searchControl

        backstreetsMap.geoObjects.add new ymaps.GeoObject(
            geometry:
                type: "Point"
                coordinates: backstreet.coordinates

            properties:
                balloonContentHeader: backstreet.name

        , {preset: "islands#dotIcon", iconColor: '#3b5998'})

        @mapInited = true


ymaps.ready ->
    window.pMap = new publMap()
