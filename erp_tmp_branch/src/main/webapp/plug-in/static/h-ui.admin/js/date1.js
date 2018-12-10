;(function ($) {
	$.fn.calendar = function(options){
		$this = $(this);
		var obj = this;
		var settings = $.extend({
			itemDate:null,
		},options);
		var oDate = new Date();
    	var dayNum = 0;
    	var oYear = oDate.getFullYear();
    	var oMonth = oDate.getMonth() + 1;
   	 	var oDay = oDate.getDate();

    	var currentYear = oDate.getFullYear();
    	var currentMonth = oDate.getMonth() + 1;
    	var currentDay = oDate.getDate();
    	
    	//生成主体框架
	   	$this.append('<div class="data-header"><div class="prev-mon f-l"></div><div class="next-mon f-r"></div><div class="current-mon"><span class="year"></span>年<span class="month"></span>月</div></div>');
	   	$this.append('<table cellpadding="0" cellspacing="0"><thead><th>一</th><th>二</th><th>三</th><th>四</th><th>五</th><th>六</th><th>日</th></thead><tbody></tbody></table>');
	   	dayNum = $.judgeMonth(oMonth, oYear);
	    //生成td
	    for (var i = 0; i < 7; i++) {
	        var oTbody = $this.find("tbody");
	        for (var i = 0; i < 6; i++) {
	            var oTr = document.createElement('tr');
	            for (var j = 0; j < 7; j++) {
	                var oTd = document.createElement('td');
	                var html ='<p class="text"></p><p class="sign"></p><p class="note"></p>';
	                $(oTd).append(html);
	                $(oTr).append(oTd);
	            }
	            $(oTbody).append(oTr);
	        }
	        $this.find("table").append(oTbody);
		}
	   	
	   	//插入日期
	    function showDate(year, month) {
	    	$this.find('td').unbind("click");
	        $(".year").text(oYear);
	        $(".month").text(oMonth);
	
	        //设置当月第一天的星期数
	        var aTd = $this.find('td');
	        $(aTd).find('p').text('');
	        $(aTd).find('p.note').removeClass("noteBg");
	      	$(aTd).removeClass('this-month').removeClass("current");
	      	
	      	aTd.click(function(e){
	      		var dateVal = $(this).attr("data-date");
	      		var ce = settings.clickEvent;
	      		if($.isFunction(ce)){
	      			settings.clickEvent.call(ce, dateVal);
	      		}
	      	});
	       
	        oDate.setFullYear(year);
	        oDate.setMonth(month - 1);
	        oDate.setDate(1);
	        switch (oDate.getDay()) {
	            case 0:
	                for (var i = 0; i < dayNum; i++) {
	                	$(aTd).eq(i + 6).addClass('this-month').attr({'data-date':year+'-'+month+'-'+(i+1)});
	                    $(aTd).eq(i + 6).find('p.text').text(i + 1);
	                }
	                break;
	            case 1:
	                for (var i = 0; i < dayNum; i++) {
	                	$(aTd).eq(i).addClass('this-month').attr({'data-date':year+'-'+month+'-'+(i+1)});
	                    $(aTd).eq(i).find('p.text').text(i + 1);
	                }
	                break;
	            case 2:
	                for (var i = 0; i < dayNum; i++) {
	                	$(aTd).eq(i + 1).addClass('this-month').attr({'data-date':year+'-'+month+'-'+(i+1)});
	                    $(aTd).eq(i + 1).find('p.text').text(i + 1);
	                }
	                break;
	            case 3:
	                for (var i = 0; i < dayNum; i++) {
	                	$(aTd).eq(i + 2).addClass('this-month').attr({'data-date':year+'-'+month+'-'+(i+1)});
	                    $(aTd).eq(i + 2).find('p.text').text(i + 1);
	                }
	                break;
	            case 4:
	                for (var i = 0; i < dayNum; i++) {
	                	$(aTd).eq(i + 3).addClass('this-month').attr({'data-date':year+'-'+month+'-'+(i+1)});
	                    $(aTd).eq(i + 3).find('p.text').text(i + 1);
	                }
	                break;
	            case 5:
	                for (var i = 0; i < dayNum; i++) {
	                	$(aTd).eq(i + 4).addClass('this-month').attr({'data-date':year+'-'+month+'-'+(i+1)});
	                    $(aTd).eq(i + 4).find('p.text').text(i + 1);
	                }
	                break;
	            case 6:
	                for (var i = 0; i < dayNum; i++) {
	                	$(aTd).eq(i + 5).addClass('this-month').attr({'data-date':year+'-'+month+'-'+(i+1)});
	                    $(aTd).eq(i + 5).find('p.text').text(i + 1);
	                }
	                break;
	        }
	        
	        /*function showCalendarEvent(idx){
	        	var obj;
	        	$("td[class='this-month']").each(function(){
	        		if($(this).find("p[class='noteBg']")){
	        			console.log($(this));
	        			return $(this);
	        		}
	        	});
	        }*/
	        
	        /*$this.find('.added-event').each(function(i){
	        	$(this).attr('data-id',i);
	        	$this.find('.this-month[data-date="' + $(this).attr('data-date') + '"]').find('p.note').addClass('noteBg').html('待');
	        });*/
	        
	        $(".added-event").remove();
	        for(var i = 0; i < settings.dateItems.length; i++){
	         	var dateVal = settings.dateItems[i].date;
	         	$this.append('<div data-id="'+i+'" class="added-event" data-date="'+dateVal+'" data-time="" data-title=""></div>');
	         //	$this.find('.this-month[data-date="' + dateVal + '"]').find('p.sign').addClass('signRed');
	        	$this.find('.this-month[data-date="' + dateVal + '"]').find('p.note').addClass('noteDai');
	         }
	        
	    }
	    
	    showDate(oDate.getFullYear(), oDate.getMonth() + 1);//初始化日期
	    
	    function showEvent(idx){
        	var obj;
        	$("td[class='this-month']").each(function(){
        		if($(this).find("p[class='noteBg']")){
        			console.log($(this));
        			return $(this);
        		}
        	});
        }
	    
	    /*$("p[class~='noteBg'").bind("click", ".data-con", function(){
	    	console.log($(this).parent().find("p[class='text']").text());
	    });*/
        //红色对勾添加
        function addRedGou() {
            var dataIndex=$('.text');
            for(var i=0;i<dataIndex.length;i++){
                var dateHtml=$(dataIndex[i]).html();
                var date=$(dataIndex[i]);
                date.next().removeClass('signRed');
                date.next().next().removeClass('noteDai')
                if(dateHtml!=''){
                   /* date.next().addClass('signRed');
                    date.next().next().addClass('noteDai')*/
                    // date.next().css("background","url(static/h-ui.admin/images/redGou.png) no-repeat center center");
                    // date.next().next().css("backgroundImage","url(static/h-ui.admin/images/wait.png)")
                }
            }
        }
	    //下一月
	    $(".next-mon").on("click", function() {
	        ++oMonth;
	        if (oMonth > 12) {
	            oMonth = 1;
	            ++oYear;
	            $(".year").text(oYear);
	        }
	        $(".month").text(oMonth);
	        dayNum =  $.judgeMonth(oMonth, oYear);
	        showDate(oYear, oMonth);
	
	
	        if (oYear >= currentYear) {
	            if (oMonth >= currentMonth) {
	                $this.find('td').removeClass("disable");
	            }
	            if (oYear == currentYear && oMonth == currentMonth) {
	                for (var i = 0; i < $this.find('td').length; i++) {
	                    if ($this.find('td').eq(i).find('p.text').text() == currentDay) {
	                        $this.find('td').eq(i).addClass("current");
	                    }
	                    if ($this.find('td').eq(i).find('p.text').text() < currentDay) {
	                        $this.find('td').eq(i).addClass("disable");
	                    }
	                }
	            }
	        }
            addRedGou()
	        if($.isFunction(settings.nextMon)){
				settings.nextMon.call();
			}
	    });
	    //上一月
	    $(".prev-mon").on("click", function() {
	        --oMonth;
	        if (oMonth < 1) {
	            oMonth = 12;
	            --oYear;
	            $(".year").text(oYear);
	        }
	        $(".month").text(oMonth);
	        dayNum =  $.judgeMonth(oMonth, oYear);
	        showDate(oYear, oMonth);
			if (oYear == currentYear) {
	            if (oMonth < currentMonth) {
	                $this.find('td').addClass("disable");
	            }
				if (oMonth == currentMonth) {
	                for (var i = 0; i < $this.find('td').length; i++) {
	                    if ($this.find('td').eq(i).find('p.text').text() == currentDay) {
	                        $this.find('td').eq(i).addClass("current");
	                    }
	                    if ($this.find('td').eq(i).find('p.text').text() < currentDay) {
	                        $this.find('td').eq(i).addClass("disable");
	                    }
	                }
	            }
	        }
            addRedGou()
			if($.isFunction(settings.preMon)){
				settings.preMon.call();
			}
	    });
		
		//当前日期样式
	    function showStyle(currentYear, currentMonth) {
	        var aTd = $this.find('td');
	        for (var i = 0; i < $(aTd).length; i++) {
	            if (currentYear == $(".year").text() && currentMonth == $(".month").text()) {
	                if ($(aTd).eq(i).find('p.text').text() == oDay) {
	                    $(aTd).eq(i).addClass("current");
	                }
	            }
	            if (currentYear == $(".year").text() && currentMonth >= $(".month").text()) {
	                if ($(aTd).eq(i).find('p.text').text() < oDay) {
	                    $(aTd).eq(i).addClass("disable");
	                }
	            }
	        }
	    }
	    showStyle(oDate.getFullYear(), oDate.getMonth() + 1);
	    return {
	        reload: function (data){
	        	$(".added-event").remove();
	        	$("p.note").removeClass("noteDai").html("")
				//$("p.note").attr("style","").html("");
		        for(var i = 0; i < data.dateItems.length; i++){
		        	var dateVal = data.dateItems[i].date;
		        	$appendDiv = $('<div data-id="'+i+'" class="added-event" data-date="'+dateVal+'" data-time="" data-title=""></div>');
		        	$this.append($appendDiv);
		        //	$this.find('.this-month[data-date="' + dateVal + '"]').find('p.sign').addClass('signRed');
		        	$this.find('.this-month[data-date="' + dateVal + '"]').find('p.note').addClass('noteDai');
		        }
	        }
	    };
	}
	
	$.extend({
		isLeapYear: function(year){	//判断是否润年  
			if (year % 4 == 0 && year % 100 != 0) {
                return true;
            }
            else {
                if (year % 400 == 0) {
                    return true;
                }
                else {
                    return false;
                }
	        }
	    },
	    
	    judgeMonth: function(oMonth, oYear){
	    	//判断月份的天数
		    if (oMonth == 1 || oMonth == 3 || oMonth == 5 || oMonth == 7 || oMonth == 8 || oMonth == 10 || oMonth == 12) {
		        dayNum = 31;
		    }
		    else if (oMonth == 4 || oMonth == 6 || oMonth == 9 || oMonth == 11) {
		        dayNum = 30;
		    }
		    else if (oMonth == 2 && $.isLeapYear(oYear)) {
		        dayNum = 29;
		    }
		    else {
		        dayNum = 28;
		    }
		    return dayNum;
	    }
	});
}(jQuery))