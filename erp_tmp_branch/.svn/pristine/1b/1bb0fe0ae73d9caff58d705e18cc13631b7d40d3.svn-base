$(function(){
	footerPos();
	initCopyRight();
})

window.onresize = function(){
	footerPos();
	initCopyRight();
}
// 根据页面大小动态设置底部位置
function footerPos(){
	var winHeight = $(window).height();
	var sectionHeight = $('#jdxhSection').height();
	if( winHeight - sectionHeight >= 360 ){
		$('#jdxhFooter').css({ 'position':'fixed'})
	}else{
		$('#jdxhFooter').css({ 'position':''});
	}
}

// 返回顶部
$('#btnGoTop').on('click', function(){
	$('body,html').animate({scrollTop:0},500);
})
$('.btnHover').hover(function(){
	$(this).next('.hoverCont').show();
},function(){
	$(this).next('.hoverCont').hide();
});


// 底部版权信息位置
function initCopyRight(){
	var pageHeight = $(window).height();
	
	if( pageHeight < 710){
		$('body').height('710px');
		$('#copyright').css({ 'bottom':'5px' });
	}else{
		$('body').height('auto');
		$('#copyright').css({ 'bottom':'50px' });
	}
}

// 选项卡切换
!function($) {
	$.Huitab = function(tabBar, tabCon, class_name, tabEvent, i) {
		var $tab_menu = $(tabBar);
		// 初始化操作
		$tab_menu.removeClass(class_name);
		$(tabBar).eq(i).addClass(class_name);
		$(tabCon).hide();
		$(tabCon).eq(i).show();

		$tab_menu.on(tabEvent,
		function() {
			$tab_menu.removeClass(class_name);
			$(this).addClass(class_name);
			var index = $tab_menu.index(this);
			$(tabCon).hide();
			$(tabCon).eq(index).show();
		});
	}
} (window.jQuery);
