(function() {
  window.slider = (function() {
    function slider($slider) {
      this.$slider = $slider;
      this.$figures = this.$slider.find('.jsSliderImg');
      this.length = this.$figures.length;
      this.currentFigure = 0;
      this.addControls();
      this.hideFigures();
      this.$slider.addClass('mSliderActive');
    }

    slider.prototype.addControls = function() {
      this.$slider.append('<span class="bSlider__eArrowLeft"></span>');
      this.$slider.append('<span class="bSlider__eArrowRight"></span>');
      this.$slider.append("<span class=\"bSlider__ePages\">" + (this.currentFigure + 1) + "/" + this.length + "</span>");
      $('.bSlider__eArrowLeft', this.$slider).bind('click', $.proxy(this.goLeft, this));
      $('.bSlider__eArrowRight', this.$slider).bind('click', $.proxy(this.goRight, this));
      return this.updateUIState();
    };

    slider.prototype.hideFigures = function() {
      this.$figures.addClass('mState_hidden');
      return this.$figures.eq(0).removeClass('mState_hidden');
    };

    slider.prototype.updateUIState = function() {
      if (this.currentFigure === 0) {
        $('.bSlider__eArrowLeft', this.$slider).addClass('mDisabled');
      } else {
        $('.bSlider__eArrowLeft', this.$slider).removeClass('mDisabled');
      }
      if (this.currentFigure + 1 >= this.length) {
        $('.bSlider__eArrowRight', this.$slider).addClass('mDisabled');
      } else {
        $('.bSlider__eArrowRight', this.$slider).removeClass('mDisabled');
      }
      return $('.bSlider__ePages', this.$slider).text((this.currentFigure + 1) + '/' + this.length);
    };

    slider.prototype.goLeft = function() {
      if (this.currentFigure !== 0) {
        this.$figures.eq(this.currentFigure).addClass('mState_hidden');
        this.currentFigure--;
        this.$figures.eq(this.currentFigure).removeClass('mState_hidden');
        return this.updateUIState();
      }
    };

    slider.prototype.goRight = function() {
      if (!(this.currentFigure + 1 >= this.length)) {
        this.$figures.eq(this.currentFigure).addClass('mState_hidden');
        this.currentFigure++;
        this.$figures.eq(this.currentFigure).removeClass('mState_hidden');
        return this.updateUIState();
      }
    };

    return slider;

  })();

  $(function() {
    return $('.jsSlider').each(function(imgArray) {
      var imgSlider;
      return imgSlider = new slider($(this));
    });
  });

}).call(this);
