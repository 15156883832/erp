// 阻止默认事件
document.addEventListener('touchstart', function(ev){
	ev.preventDefault();
});
function unbindTransitionEnd($obj){
	$obj.unbind('transitionend').unbind('WebkitTransitionEnd');
}


$(function(){
	$('#audioWrap').on('touchend', function(){
		audioPlay();
	})
	
	// 一些iphohe必须在微信Weixin JSAPI的WeixinJSBridgeReady才能生效 
	document.addEventListener("WeixinJSBridgeReady", function () {
		var audio = document.getElementById("audio"); 
	 	audio.play();
	})
	
	turnPage1();
	
})
var iSrc1 = 'http://player.youku.com/embed/XMzMzMjY4NTQzMg==';
var iSrc2 = 'http://player.youku.com/embed/XMzMzMjY4NzY1Ng==';

//  背景音乐的播放
function audioPlay(){
	var isPlay = $('#audioWrap').hasClass('audioPlay');
	var audio = document.getElementById("audio"); 
	if(isPlay){ // 如果当前正在播放
		$('#audioWrap').removeClass('audioPlay');
		audio.pause();
	}else{ // 如果当前正在暂停
		$('#audioWrap').addClass('audioPlay');
		audio.play();
	}
}

// 从第一页翻到第二页
function turnPage1(){
	var startY = endY = disY = 0;
	var isDown = false;
	$('#sfpage1').on('touchstart', function(ev){
		var ev = ev.originalEvent.changedTouches[0];
		startY = ev.clientY;
	});
	$('#sfpage1').on('touchend', function(ev){
		var ev = ev.originalEvent.changedTouches[0];
		endY = ev.clientY;
		disY = endY - startY;
		if(Math.abs(disY) > 30 ){
			isDown = disY < 0 ? true : false;
			if(isDown){
				$('#sfpage1').removeClass('sfpageShow');
				$('#sfpage2').addClass('sfpageShow');
				$('#sfpage2').on('transitionend webkitTransitionend',function(){
					$('#caseWrap2').addClass('caseWrapShow');
					$('#sfpage2 .mapContent .text1').css({
						'left':'0'
					});
					$('#sfpage2 .mapContent .text2').css({
						'right':'0'
					});
					$('#caseWrap2').on('transitionend webkitTransitionend',function(){
						turnPage2();
						unbindTransitionEnd($('#caseWrap2'));
					});	
					unbindTransitionEnd($('#sfpage2'));
				});				
			}
		}
	})
}

// 在第二页上翻动
function turnPage2(){
	var startY = endY = disY = 0;
	var isDown = false;
	$('#sfpage2').on('touchstart', function(ev){
		var ev = ev.originalEvent.changedTouches[0];
		startY = ev.clientY;
	});
	$('#sfpage2').on('touchend', function(ev){
		var ev = ev.originalEvent.changedTouches[0];
		endY = ev.clientY;
		disY = endY - startY;
		if(Math.abs(disY) > 30 ){
			isDown = disY < 0 ? true : false;
			
			if(isDown){ //翻到第三页
				$('#sfpage2').removeClass('sfpageShow');
				$('#sfpage3').addClass('sfpageShow');
				$('#sfpage3 .caseWrap').each(function(index){
					$(this).css({
						'transition':"1s "+index*200+"ms",
						'-webkit-transition':"1s "+index*200+"ms",
						'left':'0'
					});
				})
				$('#sfpage3 .caseWrap').last().on('transitionend WebkitTransitionEnd', function(){
					$('#sfpage2 .mapContent .text1').css({
					'left':' -7.4rem'
					});
					$('#sfpage2 .mapContent .text2').css({
						'right':'-6.4rem'
					});
					$('#caseWrap2').removeClass('caseWrapShow');
					turnPage3();
					unbindTransitionEnd($(this));
				});
				
			}else{ //翻回第一页
				$('#caseWrap2').removeClass('caseWrapShow');
				$('#sfpage2 .mapContent .text1').css({
					'left':' -7.4rem'
				});
				$('#sfpage2 .mapContent .text2').css({
					'right':'-6.4rem'
				});
				$('#caseWrap2').on('transitionend WebkitTransitionEnd',function(){
					$('#sfpage2').removeClass('sfpageShow');
					$('#sfpage1').addClass('sfpageShow');
					$('#sfpage1').on('animationend webkitAnimationEnd',function(){
						turnPage1();
						unbindTransitionEnd($('#sfpage1'));
					})
					unbindTransitionEnd($('#caseWrap2'));
				});	
			}
		}
	})
}

function turnPage3(){
	var startY = endY = disY = 0;
	var isDown = false;
	
	$('#sfpage3').on('touchstart', function(ev){
		var ev = ev.originalEvent.changedTouches[0];
		startY = ev.clientY;
	});
	$('#sfpage3').on('touchend', function(ev){
		var ev = ev.originalEvent.changedTouches[0];
		endY = ev.clientY;
		disY = endY - startY;
		if(Math.abs(disY) > 30 ){
			isDown = disY < 0 ? true : false;
			var caseSize = $('#sfpage3 .caseWrap').length;
			if(isDown){ //翻到第4页
				$('#sfpage3').removeClass('sfpageShow');
				$('#sfpage4').addClass('sfpageShow');
				$('#sfpage4 .videoWrapBox').css({'left':'0'})
				$('#sfpage4 .textBg').css({'right':'0'})
				$('#sfpage4').on('transitionend WebkitTransitionEnd', function(){
					turnPage4();
					unbindTransitionEnd($('#sfpage4 '));
				});
			}else{ //翻回第2页
				$('#sfpage3 .caseWrap').each(function(index){
					$(this).css({
						'transition':"0.7s "+(caseSize-1-index)*100+"ms",
						'-webkit-transition':"0.7s "+(caseSize-1-index)*100+"ms",
						'left':'-10rem'
					});
				})
				$('#sfpage3 .caseWrap').first().on('transitionend WebkitTransitionEnd', function(){
					$('#sfpage3').removeClass('sfpageShow');
					$('#sfpage2').addClass('sfpageShow');
					$('#sfpage2 .mapContent .text1').css({
						'left':' -0rem'
					});
					$('#sfpage2 .mapContent .text2').css({
						'right':'-0rem'
					});
					$('#caseWrap2').addClass('caseWrapShow');
					$('#caseWrap2').on('transitionend WebkitTransitionEnd', function(){
						turnPage2();
						unbindTransitionEnd($('#caseWrap2'));
					});
					unbindTransitionEnd($(this));
				});
			}
		}
	})
}

function turnPage4(){
	$('#sfpage3 .caseWrap').css({'left':'-10rem'});
	var startY = endY = disY = 0;
	var isDown = false;
	$('#sfpage4').on('touchstart', function(ev){
		var ev = ev.originalEvent.changedTouches[0];
		startY = ev.clientY;
	});
	$('#sfpage4').on('touchend', function(ev){
		var ev = ev.originalEvent.changedTouches[0];
		endY = ev.clientY;
		disY = endY - startY;
		if(Math.abs(disY) > 30 ){
			isDown = disY < 0 ? true : false;
			var caseSize = $('#sfpage3 .caseWrap').length;
			
			if(isDown){ //翻到第5页
				$('#sfpage4').removeClass('sfpageShow');
				$('#sfpage5').addClass('sfpageShow');
				$('#sfpage4 iframe').attr({'src':$('#sfpage4 iframe').attr('src')});
				$('#sfpage5 .caseBox').each(function(index){
					$(this).css({
						'transition':"1s "+index*200+"ms",
						'-webkit-transition':"1s "+index*200+"ms",
						'left':'0'
					});
				})
				$('#sfpage5 .caseBox').last().on('transitionend WebkitTransitionEnd', function(){
					turnPage5();
					unbindTransitionEnd($(this));
				});
			}else{ //翻回第3页
				$('#sfpage4 .videoWrapBox').css({'left':'-10rem'});
				$('#sfpage4 .textBg').css({'right':'-10rem'});
				$('#sfpage4 .textBg').on('transitionend WebkitTransitionEnd', function(){
					$('#sfpage4').removeClass('sfpageShow');
					$('#sfpage3').addClass('sfpageShow');
					$('#sfpage4 iframe').attr({'src':$('#sfpage4 iframe').attr('src')});
					$('#sfpage3 .caseWrap').each(function(index){
						$(this).css({
							'transition':"1s "+index*200+"ms",
							'-webkit-transition':"1s "+index*200+"ms",
							'left':'0'
						});
					})
					$('#sfpage3 .caseWrap').last().on('transitionend WebkitTransitionEnd', function(){
						$('#sfpage4 iframe').attr({'src':''});
						turnPage3();
						unbindTransitionEnd($(this));
					});
					unbindTransitionEnd($(this));
				})
				
			}
		}
	})
}
function turnPage5(){
	$('#sfpage4 .videoWrapBox').css({'left':'-10rem'})
	$('#sfpage4 .textBg').css({'right':'-10rem'});
	var startY = endY = disY = 0;
	var isDown = false;
	var caseSize = $('#sfpage5 .caseBox').length;
	$('#sfpage5').on('touchstart', function(ev){
		var ev = ev.originalEvent.changedTouches[0];
		startY = ev.clientY;
	});
	$('#sfpage5').on('touchend', function(ev){
		var ev = ev.originalEvent.changedTouches[0];
		endY = ev.clientY;
		disY = endY - startY;
		if(Math.abs(disY) > 30 ){
			isDown = disY < 0 ? true : false;
			if(isDown){ //翻到第6页
				$('#sfpage5').removeClass('sfpageShow');
				$('#sfpage6').addClass('sfpageShow');
				$('#sfpage6 .noteList li').each(function(index){
					$(this).css({
						'transition':"1s "+(index)*100+"ms",
						'-webkit-transition':"1s "+(index)*100+"ms",
						'left':'0rem'
					});
				});
				$('#sfpage6 .noteList li').last().on('transitionend WebkitTransitionEnd',function(){
					turnPage6();
					unbindTransitionEnd($(this));
				})
			}else{ //翻回第4页
				
				$('#sfpage5 .caseBox').each(function(index){
					$(this).css({
						'transition':"0.7s "+(caseSize-1-index)*100+"ms",
						'-webkit-transition':"0.7s "+(caseSize-1-index)*100+"ms",
						'left':'-10rem'
					});
				});
				$('#sfpage5 .caseBox').first().on('transitionend WebkitTransitionEnd', function(){
					$('#sfpage5').removeClass('sfpageShow');
					$('#sfpage4').addClass('sfpageShow');
					$('#sfpage4 .videoWrapBox').css({'left':'0rem'})
					$('#sfpage4 .textBg').css({'right':'0rem'});
					$('#sfpage4').on('transitionend WebkitTransitionEnd', function(){
						turnPage4();
						unbindTransitionEnd($('#sfpage4'));
					})	
						unbindTransitionEnd($(this));
				});
			}
		}
	})
}
function turnPage6(){
	$('#sfpage5 .caseBox').css({'left':'-10rem'});
	
	var startY = endY = disY = 0;
	var isDown = false;
	$('#sfpage6').on('touchstart', function(ev){
		var ev = ev.originalEvent.changedTouches[0];
		startY = ev.clientY;
		
	});
	$('#sfpage6').on('touchend', function(ev){
		var ev = ev.originalEvent.changedTouches[0];
		endY = ev.clientY;
		disY = endY - startY;
		if(Math.abs(disY) > 30 ){
			isDown = disY < 0 ? true : false;
			if(isDown){ //翻到第7页
				$('#sfpage7 iframe').attr({'src':iSrc2});
				$('#sfpage6').removeClass('sfpageShow');
				$('#sfpage7').addClass('sfpageShow');
				$('#sfpage7 .videoWrapBox').css({'left':'0'})
				$('#sfpage7 .textBg').css({'right':'0'})
				$('#sfpage7').on('transitionend WebkitTransitionEnd', function(){
					turnPage7();
					unbindTransitionEnd($('#sfpage7'));
				});
			}else{ //翻回第5页
				var caseSize = $('#sfpage6 .noteList li').length;
				
				$('#sfpage6 .noteList li').each(function(index){
					$(this).css({
						'transition':"0.7s "+(caseSize-1-index)*100+"ms",
						'-webkit-transition':"0.7s "+(caseSize-1-index)*100+"ms",
						'left':'-10rem'
					});
				});
				
				$('#sfpage6 .noteList li').first().on('transitionend WebkitTransitionEnd', function(){
					$('#sfpage6').removeClass('sfpageShow');
					$('#sfpage5').addClass('sfpageShow');
					
					$('#sfpage5 .caseBox').each(function(index){
						$(this).css({
							'transition':"1s "+(index)*100+"ms",
							'-webkit-transition':"0.7s "+(index)*100+"ms",
							'left':'0rem'
						});
					})
					$('#sfpage5 .caseBox').last().on('transitionend WebkitTransitionEnd', function(){
						turnPage5();
						unbindTransitionEnd($(this));
					});
					unbindTransitionEnd($(this));
				})
				
				
			}
		}
	})
}
function turnPage7(){
	$('#sfpage6 .noteList li').css({'left':'-10rem'});
	var startY = endY = disY = 0;
	var isDown = false;
	$('#sfpage7').on('touchstart', function(ev){
		var ev = ev.originalEvent.changedTouches[0];
		startY = ev.clientY;
		
	});
	$('#sfpage7').on('touchend', function(ev){
		var ev = ev.originalEvent.changedTouches[0];
		endY = ev.clientY;
		disY = endY - startY;
		if(Math.abs(disY) > 30 ){
			isDown = disY < 0 ? true : false;
			if(isDown){ //翻到第8页
				$('#sfpage7').removeClass('sfpageShow');
				$('#sfpage8').addClass('sfpageShow');
				$('#sfpage7 iframe').attr({'src':$('#sfpage7 iframe').attr('src')});
				$('#sfpage8 .ldbh1').css({'left':'0rem'});
				$('#sfpage8 .ldbh2').css({'right':'0rem'});
				
				$('#sfpage8 .ldbh2').on('transitionend WebkitTransitionEnd', function(){
					turnPage8();
					unbindTransitionEnd($('#sfpage8 .ldbh2'));
				});
			}else{ //翻回第6页
								
				$('#sfpage7 .videoWrapBox').css({
					'-webkit-transition':'all 1s ease',
					'transition':'all 1s ease',
					'left':'-10rem'
				});
				$('#sfpage7 .textBg').css({
					'-webkit-transition':'all 1s ease',
					'transition':'all 1s ease',
					'right':'-10rem'
				});
				$('#sfpage7 .videoWrapBox').on('transitionend WebkitTransitionEnd', function(){
					$('#sfpage7').removeClass('sfpageShow');
					$('#sfpage6').addClass('sfpageShow');
					$('#sfpage7 iframe').attr({'src':$('#sfpage7 iframe').attr('src')});
					$('#sfpage6 .noteList li').each(function(index){
						$(this).css({
							'transition':"1s "+(index)*100+"ms",
							'-webkit-transition':"1s "+(index)*100+"ms",
							'left':'0rem',
						});
					});
					$('#sfpage6 .noteList li').last().on('transitionend WebkitTransitionEnd',function(){
						$('#sfpage7 iframe').attr({'src':''});
						turnPage6();
						unbindTransitionEnd($(this));
					})
					unbindTransitionEnd($('#sfpage7 .videoWrapBox'));
				})
				
				
			}
		}
	})
}
function turnPage8(){
	$('#sfpage7 .videoWrapBox').css({'left':'-10rem'});
	$('#sfpage7 .textBg').css({'right':'-10rem'});
	var startY = endY = disY = 0;
	var isDown = false;
	$('#sfpage8').on('touchstart', function(ev){
		var ev = ev.originalEvent.changedTouches[0];
		startY = ev.clientY;
		
	});
	$('#sfpage8').on('touchend', function(ev){
		var ev = ev.originalEvent.changedTouches[0];
		endY = ev.clientY;
		disY = endY - startY;
		if(Math.abs(disY) > 30 ){
			isDown = disY < 0 ? true : false;
			if(isDown){ //翻到第9页
				$('#sfpage8').removeClass('sfpageShow');
				$('#sfpage9').addClass('sfpageShow');
				
				$('#sfpage9 .numList li').each(function(index){
					$(this).css({
						'transition':"1s "+(index)*100+"ms",
						'-webkit-transition':"1s "+(index)*100+"ms",
						'left':'0rem'
					});
				})
				$('#sfpage9 .numList li').last().on('transitionend WebkitTransitionEnd', function(){
					$('#btn_nextPage').hide();
					turnPage9();
					unbindTransitionEnd($(this));
				});
				
			}else{ //翻回第7页
				$('#sfpage7 iframe').attr({'src':iSrc2});
				$('#sfpage8 .ldbh1').css({'left':'-10rem'});
				$('#sfpage8 .ldbh2').css({'right':'-10rem'});
				$('#sfpage8 .ldbh2').on('transitionend WebkitTransitionEnd', function(){
					$('#sfpage7 .videoWrapBox').css({'left':'0rem'});
					$('#sfpage7 .textBg').css({'right':'0rem'});
					$('#sfpage7 .videoWrapBox').on('transitionend WebkitTransitionEnd', function(){
						$('#sfpage8').removeClass('sfpageShow');
						$('#sfpage7').addClass('sfpageShow');
						turnPage7();
						unbindTransitionEnd($('#sfpage7 .videoWrapBox'));
					})
					unbindTransitionEnd($('#sfpage8 .ldbh2'));
				})
				

			}
		}
	})
}
function turnPage9(){
	$('#sfpage8 .ldbh1').css({'left':'-10rem'});
	$('#sfpage8 .ldbh2').css({'right':'-10rem'});
	var caseSize = $('#sfpage9 .numList li').length;
	var startY = endY = disY = 0;
	var isDown = false;
	$('#sfpage9').on('touchstart', function(ev){
		var ev = ev.originalEvent.changedTouches[0];
		startY = ev.clientY;
		
	});
	$('#sfpage9').on('touchend', function(ev){
		var ev = ev.originalEvent.changedTouches[0];
		endY = ev.clientY;
		disY = endY - startY;
		
		if(Math.abs(disY) > 30 ){
			isDown = disY < 0 ? true : false;
			if( !isDown){ //翻到第8页
				$('#sfpage9 .numList li').each(function(index){
					$(this).css({
						'transition':"0.7s "+(caseSize-1-index)*100+"ms",
						'-webkit-transition':"0.7s "+(caseSize-1-index)*100+"ms",
						'left':'-10rem'
					});
				})
				$('#sfpage9 .numList li').first().on('transitionend WebkitTransitionEnd', function(){
					$('#sfpage9').removeClass('sfpageShow');
					$('#sfpage8').addClass('sfpageShow');
					$('#sfpage8 .ldbh1').css({'left':'0rem'});
					$('#sfpage8 .ldbh2').css({'right':'0rem'});
					$('#sfpage8 .ldbh2').on('transitionend WebkitTransitionEnd', function(){
						$('#btn_nextPage').show();
						turnPage8();
						unbindTransitionEnd($(this));
					})
					unbindTransitionEnd($(this));
				});
			}
		}
	})
}