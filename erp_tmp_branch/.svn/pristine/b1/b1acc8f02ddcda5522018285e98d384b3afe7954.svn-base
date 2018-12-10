(function($){
	$.fn.carousel = function( options){
		var setting = $.extend({}, options);
		
		return this.each(function(){
			var _this = this;
			var adUl = $('#adlist');
			var bigImg = $('#commodityImg');
			var iNow = iIndex=  0; 
			
			$(adUl).find('li').each(function(){
				var oImg = $(this).children();
				var wLi = $(this).width(),
					hLi = $(this).height(),
					wImg = $(oImg).width(),
					hImg = $(oImg).height();
				
				if((wImg>hImg) &&(wImg>wLi)){
					$(oImg).width(wLi);
					
				}else{
					if(hImg>hLi){
						$(oImg).height(hLi);
					}
				}
				var left = parseInt((wLi - $(oImg).width())/2),
					top = parseInt((hLi - $(oImg).height())/2);
				
				$(this).children().css({
					'left': left+'px',
					'top':top+'px',
				})
			});
			
			var iSize = $(adUl).children().size();
			var len;
			if( iSize >3){
				$(adUl).append($(adUl).children().clone());
				len = $(adUl).children().length/2;
			}else{
				len = iSize;
			}
			
			
			var _h = $(adUl).children().outerHeight(true); 
			$(adUl).css({'height': _h * len});
			
			
			$(adUl).find('li').eq(iIndex).addClass('imgselected');
			$(adUl).find('li').eq(iIndex+len).addClass('imgselected');
			
			showImg();
			
			$(_this).find('#btn_comPrev').on('click', function(){
				if( iSize >3){
					iNow--;
					if(iNow<0){
						iNow = len-1;
					}
					$(adUl).css({'top': -_h * iNow });
				}
			});
			$(_this).find('#btn_comNext').on('click', function(){
				if( iSize >3){
					iNow++;
					if(iNow >= len){
						iNow = 0;
					}
					$(adUl).css({'top': -_h * iNow });
				}
			});
			
			$(adUl).find('li').on('click',function(){
				iIndex = $(this).index()%len;
				
				$(adUl).find('li').removeClass('imgselected');
				$(adUl).find('li').eq(iIndex).addClass('imgselected');
				$(adUl).find('li').eq(iIndex+len).addClass('imgselected');

				$('#commodityImg').remove();
				showImg();
			})
			
			function showImg(){

				var newImg = $('<img id="commodityImg"  />');
				$('#commodityImgWrap').append(newImg);
				src = $(adUl).find('li').eq(iIndex).find('img').attr('src');
				newImg.attr({'src':src});
				
				
				var wLi = $('#commodityImgWrap').width(),
					hLi = $('#commodityImgWrap').height(),
					wImg = $(newImg).width(),
					hImg = $(newImg).height();
				
				if((wImg>hImg) &&(wImg>wLi)){
					$(newImg).width(wLi);
					
				}else{
					if(hImg>hLi){
						$(newImg).height(hLi);
					}
				}
				var left = parseInt((wLi - $(newImg).width())/2),
					top = parseInt((hLi - $(newImg).height())/2);
				
				$(newImg).css({
					'left': left+'px',
					'top':top+'px',
				})
				
			}	
			
	
		});
	}
})(jQuery);
