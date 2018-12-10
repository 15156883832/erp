;(function ($) {
		$.fn.dragging = function(options){
			// options是html中调用popUp()函数时传递过来的参数（json形式）
			var settings = $.extend({}, options);  //创建一个新对象，保留对象的默认值。
			var width = Math.max(getClientSize().width, getScrollSize().width)+"px"; // 文档的最大宽度
			var height = Math.max(getClientSize().height, getScrollSize().height)+"px"; // 文档的最大高度
			
			var bodyHeight = Math.min(getClientSize().height, getScrollSize().height);
			var dValue = 0;
			if( bodyHeight >= 800){
				dValue = 300;
			}else if(bodyHeight >=500){
				dValue = 200;
			}else{
				dValue = 120;
			}
			var maxHeight = bodyHeight - dValue;		
			
			return $(this).each(function(){
				var $this = $(this); //  == $dialog
				var $content = $($this.find('div.curmask-main')[0]);
				$content.css({
					'max-height': maxHeight,
					'overflow-y':'auto'
				});
				
				var $close = $($this.find('a.btn-closemask')[0]);
				$close.bind('click', function(){
					$this.hide();
				});
				
				var $head = $($(this).find('h2')[0]);
				var _x, _y, max_left, max_top;
				max_left = parseInt(Math.min(getClientSize().width, getScrollSize().width)) - parseInt($this.outerWidth());
				var newZindex = 1;
				var _move = false;
				$head.bind('mousedown',function(ev){
					_move = true;
					$this.setCapture && $this.setCapture();
					$head.css("cursor", "move");
					// 在小屏幕下有偏差 考虑一下滚动条的情况
					_x = ev.pageX - parseInt($this.offset().left);
					_y = ev.pageY - parseInt($this.offset().top);
					max_top = parseInt(Math.min(getClientSize().height, getScrollSize().height)) - parseInt($this.outerHeight());
					newZindex = $this.css('z-index');
					$this.css({'z-index':newZindex++});
					return false;
				});
				
				$(document).bind('mousemove',function(ev){
					if(_move){
						var sLeft = getScrollPos().left;
						var sTop = getScrollPos().top;
					
						var x = ev.pageX - _x ;
						var y = ev.pageY - _y ;
						if(x<0){
							x = 0;
						}else if( x>max_left){
							x = max_left;
						}
						if(y<0){
							y = 0;
						}else if( y>max_top){
							y = max_top;
						}
						
						$this.css({
							'margin-left':'0',
							'left':x,
							'top':y,
						});
						return false;
					}
				});
				
				$(document).bind('mouseup',function(ev){
					_move = false;
					$this.releaseCapture && $this.releaseCapture();
					ev.cancelBubble = true;
				});
				if($(window.parent.document)){
					$(window.parent.document).bind('mouseup',function(ev){
						_move = false;
						$this.releaseCapture && $this.releaseCapture();
						ev.cancelBubble = true;
					});
				}
			});
		}

	// 获取窗口可视范围高度/宽度
	function getClientSize(){
		var clientSize = {};
		if(document.body.clientHeight && document.documentElement.clientHeight){
			clientSize.height = (document.body.clientHeight < document.documentElement.clientHeight)?document.body.clientHeight : document.documentElement.clientHeight;
			clientSize.width = (document.body.clientWidth < document.documentElement.clientWidth)?document.body.clientWidth : document.documentElement.clientWidth;
		}else{
			clientSize.height = (document.body.clientHeight > document.documentElement.clientHeight)?document.body.clientHeight : document.documentElement.clientHeight;
			clientSize.width = (document.body.clientWidth > document.documentElement.clientWidth)?document.body.clientWidth : document.documentElement.clientWidth;
		}
		return clientSize;
	}
	
	// 获取窗口滚动条高度
	function getScrollPos(){
		var scroll = {};
		if(document.documentElement && document.documentElement.scrollTop){
			scroll.top = document.documentElement.scrollTop;
			scroll.left = document.documentElement.scrollLeft;
		}else{
			scroll.top = document.body.scrollTop;
			scroll.left = document.body.scrollLeft;
		}
		return scroll;
	}
	
	//获取文档实际内容高度
	function getScrollSize(){
		var scrollSize = {};
		scrollSize.height = Math.max(document.body.scrollHeight, document.documentElement.scrollHeight);
		scrollSize.width =Math.max(document.body.scrollWidth, document.documentElement.scrollWidth);
		return scrollSize;
	}
		
}(jQuery))
