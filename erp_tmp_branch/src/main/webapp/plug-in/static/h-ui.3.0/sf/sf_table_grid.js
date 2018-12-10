(function($){
	
	var methods = {
        init: function (options) {
            // this
        },
        show: function () {
            // is
        },
        hide: function () {
            // good
        },
        update: function (content) {
            // !!!
        },
        initHead: function(options){
        	var obj = options.sfHeader, 
        		st = options.sfSortColumns;
        	if(st == undefined || st == null){
        		st = "";
        	}
        	var stArr = st.split(",");
        	var stLen = stArr.length;
        	var len = obj.length;
        	var dest = [];
        	var hidArr = [];
        	for(var i = 0; i < len; i++){
        		var item = obj[i];
        		if(!(item.sortable || item.sortale == "true")){
        			item.sortable = false;
        		}
        		if(item.hidden || item.hidden == "true"){
        			obj[i].hidden = true;
        			hidArr.push(item);
        		}
        	}
        	if(stLen > 1){
        		for(var j = 0; j < stLen; j++){
            		var stVal = stArr[j];
            		for(var i = 0; i < len; i++){
            			var item = obj[i];
            			//if(item.name.indexOf(stVal) != -1){
            			if(item.name == stVal){
            				dest.push(item);
            				break;
            			}
            		}
            	}
        		dest = $.merge(dest, hidArr);
        	}else{
        		dest = obj;
        	}
        	return dest;
        }
        
        
    };
	
    $.fn.sfGrid = function(options){
    	var tableWidth = $('.sfpagebg').width() -30;
    	var tableHeight;
		/*var tableHeight = $('.sfpagebg').height()-$('.tabBar').outerHeight(true)-$('.table-search').outerHeight(true) -$('.pagination').outerHeight(true)-170;*/
    	var ordertjbox =0;
		if($('.ordertjbox').length>0){
			ordertjbox = $('.ordertjbox').outerHeight(true);
		}
        if($('.sfpagebg .tableBtns').length>0){
            tableHeight = $('.sfpagebg').height()-$('.tabBar').outerHeight(true)-$('.table-search').parent().outerHeight(true)-$('.sfpagebg .tableBtns').outerHeight(true)-ordertjbox-100;
		}else{
        	if($('.cautionWrapO').length >0){
				tableHeight= $('.sfpagebg').height()-$('.tabBar').outerHeight(true)-$('.table-search').parent().outerHeight(true)-$('.cautionWrapO').outerHeight(true)-ordertjbox -165;

			}else{
				tableHeight = $('.sfpagebg').height()-$('.tabBar').outerHeight(true)-$('.table-search').parent().outerHeight(true)-ordertjbox -145;
			}
        }

    	var selector = this.selector;
        var defaults = {
			datatype : "json",
			//width:document.body.clientWidth-30,
			width:tableWidth,
			height:tableHeight,
			rowNum : 20,
			//rowList : [ 10, 20, 30 ],
			pager : '#grid-pager',
			autowidth:true,
			
			shrinkToFit: false,
			multiselect: true,
			colModel : methods.initHead(options),
			mtype : "post",
		    jsonReader : {
		    	root:"rows",
		    	page: "page",
		    	total: "total",
		    	records: "records",
		    	repeatitems: false
		    },
			emptyrecords: "暂无记录",
			loadtext: "加载中...",
			sortorder : "desc",
			pagerpos : 'center',
			pgtext : "第 {0} 页,共 {1} 页",
			//caption : "JSON 实例",
			viewrecords: true,
			recordtext : "记录 {0}-{1} , 总记录数 {2}",//显示记录数的格式
			onPaging:function(pageBtn){
		    },loadComplete : function(data) {
                $(".pagination").empty().html(data.pagination+"<span id='cur-jq-selector' style='display:none;'>"+selector+"</span>");
                $(".page-sel").find("select").val($("#pageSize").val());
                $("#jump_page_input").val($("#pageNo").val());
            }
		};

		var defaultLoadComplete = defaults.loadComplete;
		var userLoadComplete = options.loadComplete;
        options = $.extend(defaults,options);
		options.loadComplete = function(data) {
			defaultLoadComplete.call(this, data);
			if (userLoadComplete) {
				userLoadComplete.call(this, data);
			}
		};
        return $(this).jqGrid(options).jqGrid('setFrozenColumns');
    }
})(jQuery);