var photoData
$.getJSON(
    'http://api-fotki.yandex.ru/api/users/nim579/album/200981/photos/?format=json&callback=?',
    function(data){
        photoData = new tablePics(data, {columnWidth: $('.hiddenPhoto').outerWidth(true), el: '#photos'});
    }
).fail(
    function(){
        console.log('err', arguments)
    }
);


var tablePics = (function() {

    function tablePics() {
        this.options = arguments[1];
        this.data = arguments[0];
        this.options.wrapWidth = $(this.options.el).width();
        this.entries = [];
        $(window).bind('resize', $.proxy(this.resize, this));
        this.setColumns();
        this.eachData();
        this.binder();
    }

    tablePics.prototype.eachData = function() {
        var loader = []
        this.entrys = []
        _this = this;
        for(var i in this.data.entries){
            var entry = this.data.entries[i];
            loader.push(new Image())
            loader[loader.length-1].src = entry.img.M.href
            loader[loader.length-1].id = entry.id
            loader[loader.length-1].alt = entry.img.orig.href
            loader[loader.length-1].onload = function(){
                var orig = this.alt;
                this.alt = "";
                _this.append($('<a href="' + orig + '">'+this.outerHTML+'</a>').addClass('fotka'))
            }
        }
    }

    tablePics.prototype.setColumns = function($el) {
        var columns = Math.floor(this.options.wrapWidth/this.options.columnWidth);
        var colArr = [];
        for(var i = 0; i<columns; i++){
            colArr.push($('<div></div>').addClass('col').css({'min-width': this.options.columnWidth, width: 100/columns+'%'}));
        }
        this.colArr = colArr;
    }

    tablePics.prototype.append = function($el) {
        this.entries.push($el);
        this.colArr[(this.entries.length-1)%this.colArr.length].append($el);
        $(this.options.el).html(this.colArr);
    };

    tablePics.prototype.resize = function() {
        this.options.wrapWidth = $(this.options.el).width();
        if(this.options.wrapWidth != $('.hiddenPhoto').outerWidth(true)){
            this.options.columnWidth = $('.hiddenPhoto').outerWidth(true);
        }
        var newColumns = Math.floor(this.options.wrapWidth/this.options.columnWidth);
        if(this.colArr.length != newColumns){
            this.setColumns();
            for(var i = 0; i<this.entries.length; i++){
                $entry = this.entries[i];
                this.colArr[i%this.colArr.length].append($entry);
            }
            $(this.options.el).html(this.colArr);
        }
    }

    tablePics.prototype.binder = function(){
        _this = this;
        $('.fotka').live('click', function(e){
            e.preventDefault();
            var $el = $('<div class="highlight_container"><div class="highlight_wrap"><img src="/static/preloader.gif" alt=""></div><div class="highlight_close">×</div></div>');
            if(!$('body').find('highlight_container')[0]){
                $el.appendTo('body');
            }
            $('body').addClass('highlight');
            _this.highlightOpen(this)
            $('.highlight_close, .highlight_wrap').bind('click', function(){
                _this.highlightClose();
            })
        });
    }

    tablePics.prototype.highlightOpen = function(link){
        var img = new Image();
        img.src = $(link).attr('href');
        img.alt = "Fullsize image";
        img.onload = function(){
            $('.highlight_wrap').html(this);
        }
    }
    tablePics.prototype.highlightClose = function(link){
        $('.highlight_close, .highlight_wrap').unbind('click');
        $('.highlight_container').remove();
        $('body').removeClass('highlight');
    }


    return tablePics;

})();