;(function ($) {
		$.fn.popup = function(options){
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
			
			var $parentFrame = $('#Hui-article-box',parent.document);
			var openZindex = $('#Hui-aside', parent.document).css('z-index');
			
			var $shadeBg = $('<div id="shadeBg" class="shadeBg" style="z-index:"'+(openZindex+2)+'></div>')
			$(document.body).append($shadeBg);
			$parentFrame.css({'z-index': openZindex+2});
			
			return $(this).each(function(){
				var $this = $(this); //  == $dialog
				
				var $content = $($this.find('div.popupContainer')[0]);
				var $main = $($this.find('div.popupMain')[0]);
				$main.css({
					'max-height': maxHeight,
					'overflow-y':'auto'
				});
				
				var $close = $($this.find('.closePopup')[0]);
				$close.bind('click', function(ev){
					ev.stopPropagation();
					$shadeBg.hide()
					$this.hide();
					$parentFrame.css({'z-index': (openZindex-2)});
				});
				
				var x_left = (getClientSize().width - parseInt($this.outerWidth()))/2,
					y_top = (getClientSize().height - parseInt($this.outerHeight()))/2;
				$this.css({
					'left':x_left+'px',
					'top':y_top+'px'
				})
				$this.show();
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
