init = ->
    myMap = new ymaps.Map "YMapsID",
        center: [55.743502, 37.614752]
        zoom: 10
        type: "yandex#map"
        controls: ['zoomControl', 'routeEditor', 'geolocationControl', 'fullscreenControl', 'rulerControl']
        # behaviors: ["default"]

    typeSelector = new ymaps.control.TypeSelector ['yandex#map', 'yandex#satellite', 'yandex#hybrid', 'yandex#publicMap']
    myMap.controls.add typeSelector

    searchControl = new ymaps.control.SearchControl options: {size: 'small'}
    myMap.controls.add searchControl

    randomX = 37396571 + Math.floor Math.random() * (37830531 - 37396571 + 1)
    randomY = 55587353 + Math.floor Math.random() * (55901860 - 55587353 + 1)

    myMap.geoObjects.add new ymaps.GeoObject(
        geometry: 
        	type: "Point"
        	coordinates: [randomY / 1000000, randomX / 1000000]

        properties:
            balloonContentHeader: 'Здесь пока ничего нет',
            balloonContentBody: 'Однако, вы&nbsp;можете <a href="mailto:mz@nim579.ru">поспособствовать</a> добавлению этого места в&nbsp;&laquo;Московские Закоулки&raquo;'

    , {preset: "islands#icon", iconColor: '#a5260a'})


    myMap.geoObjects.add(new ymaps.GeoObject({
        geometry: {type: "Point", coordinates: [55.777029, 37.445168]},
        properties: {
            balloonContentHeader: '<a href="/moscow-backstreets/zhivopisnyj-bridge.html">Живописный мост</a>',
            balloonContentBody: 'Этот мост стал визитной карточкой города',
            balloonContentFooter: 'заготовка статьи'
        }
    },
    {preset: "islands#dotIcon", iconColor: '#3b5998'}))
    
    myMap.geoObjects.add(new ymaps.GeoObject({
        geometry: {type: "Point", coordinates: [55.731521, 37.654318]},
        properties: {
            balloonContentHeader: '<a href="http://nim579.ru/blog/2012-07-02-92">Новоспасский пруд и монастырь</a>',
            balloonContentBody: 'Нет никакого пафоса и толп людей. Всё для отдыха.',
            balloonContentFooter: 'старая версия статьи'
        }
    },
    {preset: "islands#dotIcon", iconColor: '#3b5998'}))

    myMap.geoObjects.add(new ymaps.GeoObject({
        geometry: {type: "Point", coordinates: [55.691631, 37.786242]},
        properties: {
            balloonContentHeader: '<a href="http://nim579.ru/blog/2012-05-07-89">Кузьминки</a>',
            balloonContentBody: 'Попасть в парк можно пешком от станции метро Волжская (выход прямо в парк).',
            balloonContentFooter: 'старая версия статьи'
        }
    },
    {preset: "islands#dotIcon", iconColor: '#3b5998'}))

    myMap.geoObjects.add(new ymaps.GeoObject({
        geometry: {type: "Point", coordinates: [55.69357, 37.673976]},
        properties: {
            balloonContentHeader: '<a href="http://nim579.ru/blog/2012-05-06-88">Нагатинская пойма</a>',
            balloonContentBody: 'В глубине парка — дебри.',
            balloonContentFooter: 'старая версия статьи'
        }
    },
    {preset: "islands#dotIcon", iconColor: '#3b5998'}))

    myMap.geoObjects.add(new ymaps.GeoObject({
        geometry: {type: "Point", coordinates: [55.780071, 37.426231]},
        properties: {
            balloonContentHeader: '<a href="/moscow-backstreets/serebryany-bor.html">Серебряный бор</a>',
            balloonContentBody: 'На этом острове, на западе Москвы, каждый сможет найти себе занятие для отдыха.'
        }
    },
    {preset: "islands#dotIcon", iconColor: '#3b5998'}))

    myMap.geoObjects.add(new ymaps.GeoObject({
        geometry: {type: "Point", coordinates: [55.83643, 37.437813]},
        properties: {
            balloonContentHeader: '<a href="http://nim579.ru/blog/2012-01-19-73">Деривационный канал</a>',
            balloonContentBody: 'А рядышком расположился стенд для испытания реактивных двигателей Миг-29.',
            balloonContentFooter: 'старая версия статьи'
        }
    },
    {preset: "islands#dotIcon", iconColor: '#3b5998'}))

    myMap.geoObjects.add(new ymaps.GeoObject({
        geometry: {type: "Point", coordinates: [55.724266, 37.593659]},
        properties: {
            balloonContentHeader: '<a href="http://nim579.ru/blog/2009-11-28-38">Набережная Нескучного сада</a>',
            balloonContentBody: 'Набережная сада, пожалуй лучшее место в Москве.',
            # balloonContentFooter: 'старая версия статьи'
        }
    },
    {preset: "islands#dotIcon", iconColor: '#3b5998'}))

    myMap.geoObjects.add(new ymaps.GeoObject({
        geometry: {type: "Point", coordinates: [55.797341, 37.429851]},
        properties: {
            balloonContentHeader: '<a href="http://nim579.ru/blog/2009-07-29-33">Строгинская пойма</a>',
            balloonContentBody: 'Летом там проводят водные соревнования, плавают на лодках и занимаются виндсерфингом.',
            balloonContentFooter: 'старая версия статьи'
        }
    },
    {preset: "islands#dotIcon", iconColor: '#3b5998'}))

    myMap.geoObjects.add(new ymaps.GeoObject({
        geometry: {type: "Point", coordinates: [55.86258, 37.490209]},
        properties: {
            balloonContentHeader: '<a href="http://nim579.ru/blog/2009-06-09-31">Ховринская заброшенная больница</a>',
            balloonContentBody: 'В настоящее время ХЗБ представляет собой унылое зрелище.',
            balloonContentFooter: 'старая версия статьи'
        }
    },
    {preset: "islands#dotIcon", iconColor: '#3b5998'}))

    myMap.geoObjects.add(new ymaps.GeoObject({
        geometry: {type: "Point", coordinates: [55.792453, 37.533778]},
        properties: {
            balloonContentHeader: '<a href="http://nim579.ru/blog/2009-06-09-30">Ходынское поле</a>',
            balloonContentBody: 'На Ходынском поле когда-то умерло очень много народа.',
            balloonContentFooter: 'старая версия статьи'
        }
    },
    {preset: "islands#dotIcon", iconColor: '#3b5998'}))

    myMap.geoObjects.add(new ymaps.GeoObject({
        geometry: {type: "Point", coordinates: [55.792453, 37.533778]},
        properties: {
            balloonContentHeader: '<a href="http://nim579.ru/blog/2009-06-09-30">Ходынское поле</a>',
            balloonContentBody: 'На Ходынском поле когда-то умерло очень много народа.',
            balloonContentFooter: 'старая версия статьи'
        }
    },
    {preset: "islands#dotIcon", iconColor: '#3b5998'}))

    myMap.geoObjects.add(new ymaps.GeoObject({
        geometry: {type: "Point", coordinates: [55.66733, 37.478495]},
        properties: {
            balloonContentHeader: '<a href="http://nim579.ru/blog/2009-06-05-27">Синий Зуб</a>',
            balloonContentBody: 'Попасть на территорию можно между стоянкой и забором.',
            balloonContentFooter: 'старая версия статьи'
        }
    },
    {preset: "islands#dotIcon", iconColor: '#3b5998'}))

    myMap.geoObjects.add(new ymaps.GeoObject({
        geometry: {type: "Point", coordinates: [55.710337, 37.559254]},
        properties: {
            balloonContentHeader: '<a href="http://nim579.ru/blog/2009-06-05-26">Метромост на Воробьевых горах</a>',
            balloonContentBody: 'Место на крыше метро облюбовали трейсеры, неформалы и прочая молодежь.',
            balloonContentFooter: 'старая версия статьи'
        }
    },
    {preset: "islands#dotIcon", iconColor: '#3b5998'}))

    myMap.geoObjects.add(new ymaps.GeoObject({
        geometry: {type: "Point", coordinates: [55.769155, 37.706883]},
        properties: {
            balloonContentHeader: '<a href="http://nim579.ru/blog/2009-06-05-25">Введенское кладбище</a>',
            balloonContentBody: 'Очень хорошо бывать там осенью и зимой.',
            balloonContentFooter: 'старая версия статьи'
        }
    },
    {preset: "islands#dotIcon", iconColor: '#3b5998'}))

    myMap.geoObjects.add(new ymaps.GeoObject({
        geometry: {type: "Point", coordinates: [55.714713, 37.467554]},
        properties: {
            balloonContentHeader: '<a href="http://nim579.ru/blog/2009-06-04-23">Долина реки Сетунь</a>',
            balloonContentBody: 'Весной пойма Сетуни заливается водой, которая заполняет не только русло, но и старицу.',
            balloonContentFooter: 'старая версия статьи'
        }
    },
    {preset: "islands#dotIcon", iconColor: '#3b5998'}))

    myMap.geoObjects.add(new ymaps.GeoObject({
        geometry: {type: "Point", coordinates: [55.714713, 37.467554]},
        properties: {
            balloonContentHeader: '<a href="http://nim579.ru/blog/2009-06-04-23">Долина реки Сетунь</a>',
            balloonContentBody: 'Весной пойма Сетуни заливается водой, которая заполняет не только русло, но и старицу.',
            balloonContentFooter: 'старая версия статьи'
        }
    },
    {preset: "islands#dotIcon", iconColor: '#3b5998'}))

    myMap.geoObjects.add(new ymaps.GeoObject({
        geometry: {type: "Point", coordinates: [55.681311, 37.503621]},
        properties: {
            balloonContentHeader: '<a href="http://nim579.ru/blog/2009-06-04-22">Парк имени 50-летия Октября</a>',
            balloonContentBody: 'Парк не отличается большими размерами.',
            balloonContentFooter: 'старая версия статьи'
        }
    },
    {preset: "islands#dotIcon", iconColor: '#3b5998'}))

    myMap.geoObjects.add(new ymaps.GeoObject({
        geometry: {type: "Point", coordinates: [55.788926, 37.694959]},
        properties: {
            balloonContentHeader: '<a href="http://nim579.ru/blog/2009-06-04-21">Заброшенные инфекционные корпуса</a>',
            balloonContentBody: 'Там есть 3 корпуса. Один практически не различим с землей.',
            balloonContentFooter: 'старая версия статьи'
        }
    },
    {preset: "islands#dotIcon", iconColor: '#3b5998'}))

    myMap.geoObjects.add(new ymaps.GeoObject({
        geometry: {type: "Point", coordinates: [55.793278, 37.552624]},
        properties: {
            balloonContentHeader: '<a href="http://nim579.ru/blog/2009-06-04-20">Петровский путевой дворец</a>',
            balloonContentBody: 'Дворец был отреставрирован, ему возвращён его прежний статус.',
            balloonContentFooter: 'старая версия статьи'
        }
    },
    {preset: "islands#dotIcon", iconColor: '#3b5998'}))

    myMap.geoObjects.add(new ymaps.GeoObject({
        geometry: {type: "Point", coordinates: [55.762318, 37.451007]},
        properties: {
            balloonContentHeader: '<a href="http://nim579.ru/blog/2009-06-04-18">Татаровское озеро</a>',
            balloonContentBody: 'К сожалению берег облагорожен только со стороны гольф-клуба и поселка.',
            balloonContentFooter: 'старая версия статьи'
        }
    },
    {preset: "islands#dotIcon", iconColor: '#3b5998'}))

ymaps.ready init