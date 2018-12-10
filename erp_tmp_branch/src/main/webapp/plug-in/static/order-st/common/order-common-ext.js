;
/*
 * function imageMouseOverPreview(target, fs, fh){ target.hover(function(){ if
 * (typeof fs == 'function') { fs.call(this); } },function(){ if (typeof fh ==
 * 'function') { fh.call(this); } }); }
 */

(function($) {
	$.fn.hoverDelay = function(options) {
		var defaults = {
			hoverDuring : 200,
			outDuring : 200,
			hoverEvent : function() {
				$.noop();
			},
			outEvent : function() {
				$.noop();
			}
		};
		var sets = $.extend(defaults, options || {});
		var hoverTimer = null;
		var outTimer = null;
		return $(this).each(function() {
			$(this).hover(function() {
				clearTimeout(outTimer);
				hoverTimer = setTimeout(sets.hoverEvent, sets.hoverDuring);
			}, function() {
				clearTimeout(hoverTimer);
				outTimer = setTimeout(sets.outEvent, sets.outDuring);
			});
		});
	};
})(jQuery);

