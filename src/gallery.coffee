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

    constructor: (element)->
        @cid = _.uniqueId 'gallery'
        $el = $ element

        @_thNext = _.throttle _.bind(@next, @), 100
        @_thPrev = _.throttle _.bind(@prev, @), 100

        if gallery = $el.data 'gallery'
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

    next: ->
        index = @current.index
        if @length > 1 and index + 1 < @length
            $el = @elements.eq index + 1

            @setCurrent $el
            @updateImage()

    prev: ->
        index = @current.index
        if @length > 1 and index - 1 >= 0
            $el = @elements.eq index - 1

            @setCurrent $el
            @updateImage()

    exit: ->
        if !document.fullscreenElement and !document.mozFullScreenElement and !document.webkitFullscreenElement and !document.msFullscreenElement
            @close()

    toggleFullscreen: ->
        container = @$el[0]

        if !document.fullscreenElement and !document.mozFullScreenElement and !document.webkitFullscreenElement and !document.msFullscreenElement
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

        @_moveTO = setTimeout =>
            @$el.addClass 'mInShow'
            @$el.find('.jsC').addClass 'mHidden'
        , 3000

    setCurrent: ($el)->
        @current.el = $el
        @current.index = @elements.index $el

        caption = $el.parent('figure').find('figcaption')

        if caption.length > 0
            @current.caption = caption.html()

    updateImage: ->
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
        $img.removeClass 'mVisible'

        image = $ "<img class=\"bGallery__eImage jsImage\">"
        image[0].onload = =>
            $img.remove()
            @$el.find('.jsContent').append image
            image.addClass 'mVisible'

        @_image = image[0]
        image.attr 'src', data.url

    render: ->
        template = _.template """
            <div class="bGallery">
                <div class="bGallery__eContent jsContent">
                    <div class="bGallery__ePreloader"></div>
                </div>
                <div class="bGallery__ePrev jsPrev jsC"></div>
                <div class="bGallery__eNext jsNext jsC"></div>
                <div class="bGallery__eControls jsC">
                    <div class="bGallery__eControlsBlock jsControls"></div>
                </div>
                <div class="bGallery__eFullscreen jsFullscreen jsC"></div>
                <div class="bGallery__eClose jsClose jsC"></div>
            </div>
        """

        data = @_getData()
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

    _getData: ->
        url: @current.el.attr('href')
        length: @length
        current: 1 + @current.index
        caption: @current.caption

    close: ->
        @onTransitionEnd @$el, =>
            @destroy()
        , =>
            @$el.removeClass 'mVisible'

    destroy: ->
        @undelegateEvents()

        $('body')
        .removeClass 'mFixed'
        .css 'padding-right': 0

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


$ ->
    window.gallery = null

    $(document).on 'click', '.jsGallery', (e)->
        e.preventDefault()

        gallery.destroy() if gallery?
        gallery = new Gallery e.currentTarget

        return false
