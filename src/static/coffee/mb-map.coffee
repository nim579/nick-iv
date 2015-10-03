init = ->
    window.backstreetsMap = backstreetsMap = new ymaps.Map "YMapsID",
        center: [55.743502, 37.614752]
        zoom: 10
        type: "yandex#map"
        controls: ['zoomControl', 'routeEditor', 'geolocationControl', 'fullscreenControl', 'rulerControl']

    typeSelector = new ymaps.control.TypeSelector ['yandex#map', 'yandex#satellite', 'yandex#hybrid', 'yandex#publicMap']
    backstreetsMap.controls.add typeSelector

    searchControl = new ymaps.control.SearchControl options: {size: 'small'}
    backstreetsMap.controls.add searchControl

    randomX = 37396571 + Math.floor Math.random() * (37830531 - 37396571 + 1)
    randomY = 55587353 + Math.floor Math.random() * (55901860 - 55587353 + 1)

    backstreetsMap.geoObjects.add new ymaps.GeoObject(
        geometry: 
        	type: "Point"
        	coordinates: [randomY / 1000000, randomX / 1000000]

        properties:
            balloonContentHeader: 'Здесь пока ничего нет',
            balloonContentBody: 'Однако, вы&nbsp;можете <a href="mailto:backstreets@nick-iv.me">поспособствовать</a> добавлению этого места в&nbsp;&laquo;Московские Закоулки&raquo;'

    , {preset: "islands#icon", iconColor: '#a5260a'})


    $.ajax
        url: '/static/js/backstreets-places.json'
        dataType: 'json'
        success: (data)->
            backstreets = data.backstreets
            for backstreet in backstreets
                backstreetsMap.geoObjects.add new ymaps.GeoObject(
                    geometry:
                        type: "Point"
                        coordinates: backstreet.coordinates

                    properties:
                        balloonContentHeader: "<a href=\"#{backstreet.link}\">#{backstreet.name}</a>",
                        balloonContentBody: backstreet.description or null,
                        balloonContentFooter: backstreet.note or null

                , {preset: "islands#dotIcon", iconColor: '#3b5998'})

ymaps.ready init
