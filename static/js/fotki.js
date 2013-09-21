var photoData
$.getJSON(
    'http://api-fotki.yandex.ru/api/users/nim579/album/200981/photos/?format=json&callback=?',
    function(data){
        photoData = new tablePics(data, {columnWidth: $('.bPhotoPage__eHiddenPhoto').outerWidth(true), el: '#photos'});
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
            loader[loader.length-1].className = "bPhotoPage__ePhotosImg";
            loader[loader.length-1].onload = function(){
                var orig = this.alt;
                this.alt = "";
                _this.append($('<a href="' + orig + '">'+this.outerHTML+'</a>').addClass('bPhotoPage__ePhotosLink jsFotka'))
            }
        }
    }

    tablePics.prototype.setColumns = function($el) {
        var columns = Math.floor(this.options.wrapWidth/this.options.columnWidth);
        var colArr = [];
        for(var i = 0; i<columns; i++){
            colArr.push($('<div></div>').addClass('bPhotoPage__eColumn').css({'min-width': this.options.columnWidth, width: 100/columns+'%'}));
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
        if(this.options.wrapWidth != $('.bPhotoPage__eHiddenPhoto').outerWidth(true)){
            this.options.columnWidth = $('.bPhotoPage__eHiddenPhoto').outerWidth(true);
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
        $('.jsFotka').live('click', function(e){
            e.preventDefault();
            var $el = $('<div class="bHighlight__eContainer"><div class="bHighlight__eWrapper"><img src="/static/b/bIcons/preloader.gif" alt=""></div><div class="bHighlight__eClose">×</div></div>');
            if(!$('body').find('bHighlight__eContainer')[0]){
                $el.appendTo('body');
            }
            $('body').addClass('bHighlight');
            _this.highlightOpen(this)
            $('.bHighlight__eClose, .bHighlight__eWrapper').bind('click', function(){
                _this.highlightClose();
            })
        });
    }

    tablePics.prototype.highlightOpen = function(link){
        var img = new Image();
        img.src = $(link).attr('href');
        img.alt = "Fullsize image";
        img.onload = function(){
            $('.bHighlight__eWrapper').html(this);
        }
    }
    tablePics.prototype.highlightClose = function(link){
        $('.bHighlight__eClose, .bHighlight__eWrapper').unbind('click');
        $('.bHighlight__eContainer').remove();
        $('body').removeClass('bHighlight');
    }


    return tablePics;

})();