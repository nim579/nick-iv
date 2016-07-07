class Gallery
    elements: null
    length: 0
    current:
        index: 0
        el: null
        description: null

    $el: null

    events:
        "click .jsNext": "next"
        "click .jsPrev": "prev"
        "click .jsClose": "close"
        "click .jsFullscreen": "toggleFullscreen"

        "touchstart": "_tStart"
        "touchmove":  "_tMove"
        "touchend":   "_tEnd"

    constructor: (element)->
        @cid = _.uniqueId 'gallery'
        $el = $ element

        @_thNext = _.throttle _.bind(@next, @), 100
        @_thPrev = _.throttle _.bind(@prev, @), 100
        @_controlsShown = true

        if gallery = $el.data 'gallery'
            @name = gallery
            elements = $(".jsGallery").closest "[data-gallery=\"#{gallery}\"]"

        else
            elements = $ ".jsGallery"

        @elements = elements
        @length = elements.length
        @setCurrent $el

        @render()
        @delegateDoc 'keyup', @_keys
        @delegateDoc 'mousemove', _.throttle _.bind(@_move, @), 10

    _keys: (e)->
        switch e.keyCode
            when 27
                setTimeout =>
                    @exit()
                , 10

            when 39 then @_thNext()
            when 37 then @_thPrev()

    next: (slow)->
        index = @current.index
        if @length > 1 and index + 1 < @length
            $el = @elements.eq index + 1

            @setCurrent $el
            @updateImage(slow)

    prev: (slow)->
        index = @current.index
        if @length > 1 and index - 1 >= 0
            $el = @elements.eq index - 1

            @setCurrent $el
            @updateImage(slow)

    exit: ->
        if @_isFullscreen()
            @close()

    toggleFullscreen: ->
        container = @$el[0]
        return unless @_isFullscreenSupport()

        if @_isFullscreen()
            if container.requestFullscreen
                container.requestFullscreen()

            else if container.msRequestFullscreen
                container.msRequestFullscreen()

            else if container.mozRequestFullScreen
                container.mozRequestFullScreen()

            else if container.webkitRequestFullscreen
                container.webkitRequestFullscreen()

            @$el.find('.jsFullscreen').addClass 'mInFullscreen'

        else
            if document.exitFullscreen
                document.exitFullscreen()

            else if document.msExitFullscreen
                document.msExitFullscreen()

            else if document.mozCancelFullScreen
                document.mozCancelFullScreen()

            else if document.webkitExitFullscreen
                document.webkitExitFullscreen()

            @$el.find('.jsFullscreen').removeClass 'mInFullscreen'

    _move: ->
        clearTimeout @_moveTO
        @$el.removeClass 'mInShow'
        @$el.find('.jsC').removeClass 'mHidden'
        @_controlsShown = true

        @_moveTO = setTimeout =>
            @$el.addClass 'mInShow'
            @$el.find('.jsC').addClass 'mHidden'
            @_controlsShown = false
        , 3000

    _tStart: (e)->
        e.preventDefault()
        e.stopPropagation()

        pos =
            x: event.changedTouches[0].pageX
            y: event.changedTouches[0].pageY

        @_tStartPos = x: pos.x, y: pos.y
        @_tStartT = new Date()

    _tMove: (e)->
        e.preventDefault()
        e.stopPropagation()

        pos =
            x: event.changedTouches[0].pageX
            y: event.changedTouches[0].pageY

        w = @$el.width()
        h = @$el.width()

        dX = pos.x - @_tStartPos.x
        dY = pos.y - @_tStartPos.y
        dY = 0 if @_tMoveTo in ['left', 'right']
        dX = 0 if @_tMoveTo in ['up', 'down']

        if Math.abs(dX) > Math.abs(dY) then dY = 0 else dX = 0

        @_tMoveTo = 'up'    if not @_tMoveTo and dY < 0
        @_tMoveTo = 'down'  if not @_tMoveTo and dY > 0
        @_tMoveTo = 'left'  if not @_tMoveTo and dX < 0
        @_tMoveTo = 'right' if not @_tMoveTo and dX > 0

        progress = 1
        progress = (w - Math.abs(dX)) / w if progress >= 1
        progress = (h - Math.abs(dY)) / h if progress >= 1
        progress = 0 if progress < 0

        @$el.find('.jsImage')
        .addClass 'mInTouch'
        .css
            'transform': "translate(#{dX}px, #{dY}px)"
            'opacity': progress

        @_move() if @_controlsShown

    _tEnd: (e)->
        e.preventDefault()
        e.stopPropagation()

        pos =
            x: event.changedTouches[0].pageX
            y: event.changedTouches[0].pageY

        w = @$el.width()
        h = @$el.width()

        dX = pos.x - @_tStartPos.x
        dY = pos.y - @_tStartPos.y
        aX = Math.abs pos.x - @_tStartPos.x
        aY = Math.abs pos.y - @_tStartPos.y

        # Tap
        if pos.x is @_tStartPos.x and pos.y is @_tStartPos.y and new Date() - @_tStartT < 500
            @_move()
            $(e.target).trigger 'click' if @_controlsShown

        if ((aX > 20 or aY > 20) and new Date() - @_tStartT < 250) or (aX > w/2 or aY > h/2)
            @next(true)  if @_tMoveTo is 'left'
            @prev(true)  if @_tMoveTo is 'right'
            @close() if @_tMoveTo is 'down'

        @$el.find('.jsImage')
        .removeClass 'mInTouch'
        .css
            'transform': "translate(0, 0)"
            'opacity': 1

        @_tStartPos = {}
        @_tStartT   = null
        @_tMoveTo   = null

    setCurrent: ($el)->
        @current.el = $el
        @current.index = @elements.index $el

        caption = $el.parent('figure').find('figcaption')

        if caption.length > 0
            @current.caption = caption.html()

    updateImage: (slow)->
        data = @_getData()

        template = _.template """
            <% if(caption){ %>
                <span class="bGallery__eControlsCaption"><%= caption %></span>
            <% } %>
            <% if(length > 1){ %>
                <span class="bGallery__eControlsCounter"><%= current %> из <%= length %></span>
            <% } %>
        """

        if @_image
            @_image.onload = ->

        @$el.find('.jsControls').html template data
        @$el.find('.jsPreloader').show()

        index = @current.index
        @$el.find('.jsPrev').removeClass 'mDisabled'
        @$el.find('.jsNext').removeClass 'mDisabled'

        if @length <= 1
            @$el.find('.jsPrev').addClass 'mDisabled'
            @$el.find('.jsNext').addClass 'mDisabled'

        if @length > 1 and index == @length - 1
            @$el.find('.jsNext').addClass 'mDisabled'

        if @length > 1 and index == 0
            @$el.find('.jsPrev').addClass 'mDisabled'

        $img = @$el.find('.jsImage')
        $img.removeClass('mVisible').addClass 'mHidden'

        image = $ "<img class=\"bGallery__eImage jsImage\">"
        image[0].onload = =>
            $img.remove()
            @$el.find('.jsContent').append image
            @$el.find('.jsPreloader').hide()

            unless slow
                image.addClass 'mVisible'

            else
                setTimeout ->
                    image.addClass 'mVisible'
                , 100

        @_image = image[0]
        image.attr 'src', data.url

        @_move() if @_controlsShown
        $(window).trigger 'change.gallery', [@, data.id]

    render: ->
        template = _.template """
            <div class="bGallery">
                <div class="bGallery__eContent jsContent">
                    <div class="bGallery__ePreloader jsPreloader"></div>
                </div>
                <div class="bGallery__ePrev jsPrev jsC"></div>
                <div class="bGallery__eNext jsNext jsC"></div>
                <div class="bGallery__eControls jsC">
                    <div class="bGallery__eControlsBlock jsControls"></div>
                </div>
                <% if(fullscreen){ %>
                    <div class="bGallery__eFullscreen jsFullscreen jsC"></div>
                <% } %>
                <div class="bGallery__eClose jsClose jsC"></div>
            </div>
        """

        data = @_getData()
        data.fullscreen = @_isFullscreenSupport()
        @$el = $ template data

        $('body')
        .css 'padding-right': @_measureScrollbar()
        .addClass 'mFixed'
        .append @$el

        setTimeout =>
            @$el.addClass 'mVisible'
        , 100

        @updateImage()
        @delegateEvents()
        @_move()

        $(window).trigger 'open.gallery', [@, @name or @cid, data.id]

    _getData: ->
        id:  @current.el.data 'galleryId'
        url: @current.el.attr('href')
        length: @length
        current: 1 + @current.index
        caption: @current.caption

    close: ->
        @onTransitionEnd @$el, =>
            @destroy()
        , =>
            @$el.removeClass 'mVisible'

    destroy: (prop)->
        @undelegateEvents()

        $('body')
        .removeClass 'mFixed'
        .css 'padding-right': 0

        $(window).trigger 'close.gallery', @ unless prop?.silent
        @$el.remove()

    delegateDoc: (eventName, listener)->
        $(document).on eventName + '.delegateEvents' + @cid, _.bind(listener, @)
        return @

    delegateEvents: ->
        events = _.result(@, 'events')

        for ev of events
            method = events[ev]
            method = @[method] unless _.isFunction method
            continue unless method
            match = ev.match /^(\S+)\s*(.*)$/
            @delegate match[1], match[2], _.bind(method, @)

        return @

    delegate: (eventName, selector, listener)->
        @$el.on eventName + '.delegateEvents' + @cid, selector, listener

    undelegateEvents: ->
        $(document).off '.delegateEvents' + @cid
        @$el.off '.delegateEvents' + @cid if @$el

        return @

    _measureScrollbar: ->
        fullWindowWidth = window.innerWidth

        # workaround для IE8 у которого нет window.innerWidth
        unless fullWindowWidth
          documentElementRect = document.documentElement.getBoundingClientRect()
          fullWindowWidth = documentElementRect.right - Math.abs(documentElementRect.left)

        # Определяем есть ли сейчас скроллбар
        unless document.body.clientWidth < fullWindowWidth
            return 0

        # Если есть, ищем его ширину и сохраняем
        scrollDiv = $ '<div></div>'
        scrollDiv.css
            "position": "absolute"
            "top": "-9999px"
            "width": "50px"
            "height": "50px"
            "overflow": "scroll"

        $('body').append scrollDiv
        scrollbarWidth = scrollDiv[0].offsetWidth - scrollDiv[0].clientWidth
        scrollDiv.remove()

        return scrollbarWidth or 0

    onTransitionEnd: ($el, callback, transition)->
        if @_getTransitionEnd() and $el.length > 0
            $el.one @_getTransitionEnd(), -> callback()

            transition()

        else
            transition()
            callback()

    _getTransitionEnd: ->
        el = document.createElement('bootstrap')

        transEndEventNames =
            WebkitTransition: 'webkitTransitionEnd'
            MozTransition:    'transitionend'
            OTransition:      'oTransitionEnd otransitionend'
            transition:       'transitionend'

        for name of transEndEventNames
            return transEndEventNames[name] if el.style[name]?

        return false

    _isFullscreenSupport: ->
        return document.fullscreenEnabled or document.webkitFullscreenEnabled or document.mozFullScreenEnabled or document.webkitFullscreenEnabled

    _isFullscreen: ->
        return !document.fullscreenElement and !document.mozFullScreenElement and !document.webkitFullscreenElement and !document.msFullscreenElement


$ ->
    window.gallery = null

    $(document).on 'click', '.jsGallery', (e)->
        e.preventDefault()

        window.gallery.close() if window.gallery?
        window.gallery = new Gallery e.currentTarget

        return false
