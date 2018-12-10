;(function(win) {
	var _order_comms = {};
	win._order_comm = _order_comms;
	
	//序号
    _order_comms.gridNum = function (x) {
    	var tableid = '#table-waitdispatch';
		if (typeof x !== 'undefined') {
			tableid = x;
		}
        var twp = $(tableid);
        var jqlabels = $(".ui-jqgrid-labels");
        var jqrownums = $(".jqgrid-rownum");
        jqlabels.find("th:first").text("序号");
        jqlabels.find("th:first").css("width", "40px");
        $(".ui-jqgrid-btable").find("td:first").css("width", "40px");
        jqrownums.css("width", "40px");
        var sfMark = "0";
        twp.find("tr").find("td:first").each(function (index, item) {
            var textVal = $(this).text();
            if (textVal.length > 3) {
                sfMark = "1";
            }
            if (textVal.length > 5) {
                sfMark = "2";
            }
            if (textVal.length > 7) {
                sfMark = "3";
            }
            if (textVal.length > 9) {
                sfMark = "4";
            }
            if (textVal.length > 11) {
                sfMark = "5";
            }
        });

        if (sfMark === "1") {
            jqlabels.find("th:first").css("width", "50px");
            twp.find("td:first").css("width", "50px");
            jqrownums.css("width", "50px");
        }
        if (sfMark === "2") {
            jqlabels.find("th:first").css("width", "60px");
            twp.find("td:first").css("width", "60px");
            jqrownums.css("width", "60px");
        }
        if (sfMark === "3") {
            jqlabels.find("th:first").css("width", "75px");
            twp.find("td:first").css("width", "75px");
            jqrownums.css("width", "75px");
        }
        if (sfMark === "4") {
            jqlabels.find("th:first").css("width", "90px");
            twp.find("td:first").css("width", "90px");
            jqrownums.css("width", "90px");
        }
        if (sfMark === "5") {
            jqlabels.find("th:first").css("width", "105px");
            twp.find("td:first").css("width", "105px");
            jqrownums.css("width", "105px");
        }
    };
	
	
})(window);

function showOrderJieSuanDan(obj,number){
    var str="";
    $.ajax({
        url:"${ctx}/order/orderSettlement/showJsMsg",
        data:{number:number},
        dataType:'json',
        async:false,
        success:function(result){
            if(result.code=="200"){
                $("#"+obj).empty();
                var tabs = result.data.repairOrderTab;//表头项
                var detail = result.data.repairOrderDetail;//结算信息

                if(tabs.length > 0){
                    var html = "<caption>工单结算信息</caption>"+"<thead>" +"<tr>" +"<th class='w-80'>序号</th>" ;
                    var str1 = "";
                    for(var i=0;i < tabs.length;i++){
                        str1 += "<th class='w-150'>"+tabs[i].columns.name+"</th>" ;
                    }
                    str = html + str1 + "</tr>" + "</thead>";
                }
                if(detail.length > 0){
                    var htmls = "";
                    for(var i=0;i<detail.length;i++){
                        htmls += "<tr><td class='w-80'>"+(i+1)+"</td>";
                        for(var j=0;j<detail[i].length;j++){
                            htmls += "<td class='w-150'>"+detail[i][j].columns.value+"</td>";
                        }
                        htmls += "</tr>";
                    }
                    str +=htmls;

                }

                if (!isBlank(result.data.noPassResource)) {
                    var ht = '<textarea style="width: 770px;height: 60px" class="textarea readonly" readonly>' + result.data.noPassResource + '</textarea>';
                    $("#settlementInfo").html("<label class='lb lb1'>不通过原因：</label>");
                    $("#settlementInfo").append(ht);
                }
                $("#"+obj).append(str);
                return;
            }else if(result.code=="201"){
                layer.msg(result.msg);
                return;
            }
        }

    });
}

function slowlyLoading(){
    layer.msg('<span id="temp-ld-span" style="">数据加载中,请耐心等待...</span>', {time:60000});
    setTimeout(function(){$("#temp-ld-span").text("数据分析中,请耐心等待...")}, 5000);
    setTimeout(function(){$("#temp-ld-span").text("数据输出结果中,请耐心等等...")}, 10000);
}
