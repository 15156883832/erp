;(function($){
    $.fn.imgShow = function(options){
        var $this = $(this);
        var settings = $.extend({
            hasIframe : false,  // 是否需要对iframe所在的section进行升级

        }, options);  //创建一个新对象，保留对象的默认值。


        var aImgs = $this.find('img');
        var imgLength = aImgs.length;
        var isFirst = true;
        var initAngle = 0; // 图片初始化角度
        var now = 0;
        var flag=true; // width>height

        aImgs.each(function(index){
            $(this).on('click', function(ev){
                ev.stopPropagation();
                if(isFirst){
                    creatImgWrap();
                    isFirst = false;
                }
                creatImg(index);
                now = index;
            })
        })


        function creatImg(index){
            $('#tagImg').remove();
            var newImg = $('<img id="tagImg" class="pimg" />');
            $('#tagImgBg').append(newImg);
            newImg.attr({'src':aImgs.eq(index).attr('src')});
            newImg.css({'transform':'rotate(0deg)'});
            initAngle = 0;

            imgSize();

            var nImg = document.getElementById('tagImg');
            var nImgWrap = document.getElementById('tagImgBg');

            // 鼠标滚轮滚动放缩
            fnWheel(nImgWrap,function (down,oEvent){

                var oldWidth=nImg.offsetWidth;
                var oldHeight=nImg.offsetHeight;

                var oldLeft=tagImg.offsetLeft;
                var oldTop=tagImg.offsetTop;

                if (down){
                    nImg.style.width=nImg.offsetWidth*0.9+"px";
                    nImg.style.height=nImg.offsetHeight*0.9+"px";
                }else{
                    nImg.style.width=nImg.offsetWidth*1.1+"px";
                    nImg.style.height=nImg.offsetHeight*1.1+"px";

                }
                var newWidth=nImg.offsetWidth;
                var newHeight=nImg.offsetHeight;

                nImg.style.left=oldLeft- parseInt((newWidth-oldWidth)/2) +"px";
                nImg.style.top=oldTop- parseInt((newHeight-oldHeight)/2)+"px";

            });

            var dragging = false;
            var iX, iY;
            $("#tagImg").mousedown(function(e) {
                dragging = true;
                iX = e.clientX - this.offsetLeft;
                iY = e.clientY - this.offsetTop;
                this.setCapture && this.setCapture();
                return false;
            });
            document.onmousemove = function(e) {
                if (dragging) {
                    var e = e || window.event;
                    var oX = e.clientX - iX;
                    var oY = e.clientY - iY;
                    $("#tagImg").css({
                        "left":oX + "px",
                        "top":oY + "px"
                    });
                    return false;
                }
            };
            $(document).mouseup(function(e) {
                dragging = false;
                nImg.releaseCapture && nImg.releaseCapture();
                e.cancelBubble = true;
            })

        }

        function imgSize(){

            var newImg = $('#tagImg');
            var imgWidth = newImg.width();
            imgHeight = newImg.height(),
                wrapWidth = $('#tagImgBg').outerWidth(),
                wrapHeight = $('#tagImgBg').outerHeight();
            if(imgWidth>imgHeight){
                flag=true;
                if(imgWidth>wrapWidth){
                    newImg.width(wrapWidth);
                    newImg.height($('#tagImg').height());
                }
            }else{
                flag=false;
                if(imgHeight > wrapHeight){
                    newImg.height(wrapHeight);
                    newImg.width($('#tagImg').width());
                }
            }
            var oLeft = (wrapWidth - newImg.width())/2,
                oTop = (wrapHeight - newImg.height())/2;
            newImg.css({
                'left': oLeft + 'px',
                'top':oTop + 'px',
            })
        }


        function creatImgWrap(){
            var tagWrapBg = $('<div class="tagWrapBg2"></div>'+
                '<div class="tagWrapBg">'+
                '<div class="tagWrap" id="tagWrap">'+
                '<a class="btn-closeWrap icon-showImg" id="closeWrap"></a>'+
                '<div class="tagImgBg" id="tagImgBg">'+

                '</div>'+
                '<div class="btnsWrap">'+
                '<a href="javascript:;" class="icon-showImg btn-changeImg btn-prevImg" title="上一张" ></a>'+
                '<a href="javascript:;" class="icon-showImg btn-changeImg btn-nextImg" title="下一张"></a>'+
                '<a href="javascript:;" class="icon-showImg btn-turnLeft" id="btn-turnLeft" title="逆时针旋转90°"></a>'+
                '<a href="javascript:;" class="icon-showImg btn-turnRight" id="btn-turnRight" title="顺时针旋转90°"></a>'+
                '</div>'+
                '</div>'+
                '</div>');

            $('body').append(tagWrapBg);
            containerSize();
            positionSet($('#tagWrap'));

            window.onresize = function(){
                containerSize();
                positionSet($('#tagWrap'));
                imgSize();
            }
            if( settings.hasIframe){
                $('#Hui-article-box',window.top.document).css({'z-index':'10000'});
            }
            if(imgLength>1){
                $('.btn-changeImg').show();
            }
            $('#closeWrap').on('click', function(){
                $('.tagWrapBg').remove();
                $('.tagWrapBg2').remove();
                if( settings.hasIframe){
                    $('#Hui-article-box',window.top.document).css({'z-index':'9'});
                }
                isFirst = true;
                initAngle = 0;
                now=0;
                flag = true;
            })
            $('#btn-turnLeft').on('click', function(){
                turnRotate( $(this),false);
            })
            $('#btn-turnRight').on('click', function(){
                turnRotate( $(this),true);
            });

            $('.btn-prevImg').on('click', function(){
                now = (now--)<0?(imgLength-1):(now);
                creatImg(now);
            });
            $('.btn-nextImg').on('click', function(){
                now = (now++)>=(imgLength-1)?0:(now)
                creatImg(now);
            });
        }
        function turnRotate(obj,sign){
            var plus = sign?90:-90;
            initAngle += plus;
            var newImg = $('#tagImg');

            newImg.rotate({
                animateTo:initAngle,
            });
        }

        function containerSize(){
            var winWidth = $(window).width();
            if(winWidth>=1920){
                $('#tagImgBg').css({
                    'width':'714px',
                    'height':'714px',
                });

            }else if(winWidth<1920 && winWidth>=1600){
                $('#tagImgBg').css({
                    'width':'614px',
                    'height':'614px',
                });
            }else if(winWidth<1600){
                $('#tagImgBg').css({
                    'width':'514px',
                    'height':'514px',

                });
            }
        }

        function positionSet(obj){
            var max_left = parseInt($(window).width()) - parseInt(obj.outerWidth()),
                max_top = parseInt($(window).height()) - parseInt(obj.outerHeight());

            var x_left = ($(window).width() - parseInt(obj.outerWidth()))/2,
                y_top = ($(window).height() - parseInt(obj.outerHeight()))/2;
            if(x_left<0){
                x_left = 0;
            }else if( x_left > max_left){
                x_left = max_left;
            }
            if(y_top<0){
                y_top = 0;
            }else if( y_top > max_top){
                y_top = max_top;
            }
            obj.css({
                'left':x_left+'px',
                'top':y_top+'px',
            })
        }


        function fnWheel(obj,fncc){
            obj.onmousewheel = fn;
            if(obj.addEventListener){
                obj.addEventListener('DOMMouseScroll',fn,false);
            }
            function fn(ev){
                var oEvent = ev || window.event;
                var down = true;

                if(oEvent.wheelDelta){
                    down = oEvent.wheelDelta<0
                }else{
                    down = oEvent.detail > 0
                }
                if(fncc){
                    fncc.call(this,down,oEvent);
                }

                if(oEvent.preventDefault){
                    oEvent.preventDefault();
                }
                return false;
            }
        }

    }

}(jQuery))
