class window.slider
    constructor: ($slider)->
        @$slider = $slider
        @$figures = @$slider.find('.jsSliderImg')
        @length = @$figures.length

        @currentFigure = 0

        @addControls()
        @hideFigures()

        @$slider.addClass 'mSliderActive'

    addControls: ->
        @$slider.append '<span class="bSlider__eArrowLeft"></span>'
        @$slider.append '<span class="bSlider__eArrowRight"></span>'
        @$slider.append "<span class=\"bSlider__ePages\">#{@currentFigure + 1}/#{@length}</span>"

        $('.bSlider__eArrowLeft', @$slider).bind 'click', $.proxy(@goLeft, @)
        $('.bSlider__eArrowRight', @$slider).bind 'click', $.proxy(@goRight, @)

        @updateUIState()

    hideFigures: ->
        @$figures.addClass('mState_hidden')
        @$figures.eq(0).removeClass('mState_hidden')

    updateUIState: ->
        if @currentFigure is 0
            $('.bSlider__eArrowLeft', @$slider).addClass 'mDisabled'

        else
            $('.bSlider__eArrowLeft', @$slider).removeClass 'mDisabled'

        if @currentFigure + 1 >= @length
            $('.bSlider__eArrowRight', @$slider).addClass 'mDisabled'

        else
            $('.bSlider__eArrowRight', @$slider).removeClass 'mDisabled'

        $('.bSlider__ePages', @$slider).text (@currentFigure + 1) + '/' + @length

    goLeft: ->
        unless @currentFigure is 0
            @$figures.eq(@currentFigure).addClass 'mState_hidden'
            @currentFigure--
            @$figures.eq(@currentFigure).removeClass 'mState_hidden'

            @updateUIState()

    goRight: ->
        unless @currentFigure + 1 >= @length
            @$figures.eq(@currentFigure).addClass 'mState_hidden'
            @currentFigure++
            @$figures.eq(@currentFigure).removeClass 'mState_hidden'

            @updateUIState()



$ ->
    $('.jsSlider').each (imgArray)->
        imgSlider = new slider $(@)