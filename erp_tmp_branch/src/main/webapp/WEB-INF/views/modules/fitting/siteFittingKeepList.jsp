<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html> 	
  <head>
    <title>收入明细</title>
    <meta name="decorator" content="base"/>
	  <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/>
	  <script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
	  <script type="text/javascript" src="${ctxPlugin}/lib/select/zh-CN.js"></script>
	  <style type="text/css">
		  #select2-applicant-container{
			  line-height: 26px;
		  }
	  </style>
  </head>
  
  <body>
  <div class="sfpagebg bk-gray">
	<div class="sfpage table-header-settable">
	<div class="page-orderWait">
	
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
			<sfTags:pagePermission authFlag="FITTINGMGM_OUTINFITDETAIL_COMPANYDETAIL_TAB" html='<a class="btn-tabBar current" href="${ctx}/fitting/siteFittingKeep/list">公司明细</a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="FITTINGMGM_OUTINFITDETAIL_ENIGEERDETAIL_TAB" html='<a class="btn-tabBar"  href="${ctx}/fitting/empFittingKeep/list">工程师明细</a>'></sfTags:pagePermission>
			<p class="f-r btnWrap">
				<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:;" onclick="reset()" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
		<div class="tabCon">
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<div class="bk-gray pt-10 pb-5">
					<table class="table table-search">
						<tr>
							<th style="width: 76px;" class="text-r">备件条码：</th>
							<td>
								<input type="text" class="input-text" name= "fitting_code"/>
							</td>
							<th style="width: 76px;" class="text-r">备件名称：</th>
							<td>
								<input type="text" class="input-text" name = "fitting_name"/>
							</td>
							<th style="width: 76px;" class="text-r">明细类别：</th>
							<td>
								<select class="select" name="mxtype" style="width: 140px;"><!--   类型：0领取，1工单使用  2零售，3返还  4调拨 -->
										<option value="">请选择</option>
										<option value="0">入库</option>
										<option value="1">出库</option>
										<option value="2">归还</option>
										<option value="3">库存调整</option>
										<option value="4">网点零售</option>
										<option value="6">新件返厂</option>
										<option value="7">出库至二级网点</option>
										<option value="8">中心网点申请</option>
										<option value="5">删除</option>
									</select>
							</td>
							<th style="width: 76px;" class="text-r">申请人：</th>
							<td>
								<%--<input type="text" class="input-text" name = "applicant"/>--%>
								<span class="w-140 f-l">
				    			<select class="select " multiline="true" name="applicant" id="applicant">
								</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">备件来源：</th>
							<td>
								<span class="select-box">
									<select class="select" name="supplier">
										<option value="">请选择</option>
										<option value="厂家">厂家</option>
										<option value="自购">自购</option>
									</select>
								</span>
							</td>
						</tr>
						<tr>
							<th style="width: 76px;" class="text-r">备件品牌：</th>
							<td>
								<input type="text" class="input-text" name = "brand"/>
							</td>
							
							<th style="width: 76px;" class="text-r">适用品类：</th>
							<td>
								<select class="select" name="suit_category" style="width: 140px;">
									<option value="">请选择</option>
									<c:forEach var="category" items="${listR}">
										<option value="${category.columns.name}">${category.columns.name}</option>
									</c:forEach>
								</select>
							</td>
							<th style="width: 76px;" class="text-r">出入库时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'createTimeMax\')||\'%y-%M-%d\'}'})" id="createTimeMin" name="createTimeMin" value="" class="input-text Wdate w-140">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'createTimeMin\')}',maxDate:'%y-%M-%d'})" id="createTimeMax" name="createTimeMax" value="" class="input-text Wdate w-140">
							</td>
						</tr>
					</table>
				</div>
				<div class="pt-10 pb-5 cl">
				<div class="f-r">
					<a href="javascript:;" class="sfbtn sfbtn-opt2 reloadPageBtn"><i class="sficon sficon-reload"></i>刷新</a>
					<sfTags:pagePermission authFlag="FITTINGMGM_OUTINFITDETAIL_COMPANYDETAIL_EXPORT_BTN" html='<a  onclick="return exports()" class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
				</div>
								
			</div>
				<div>
					<table id="table-waitdispatch" class="table"></table>
					<!-- pagination -->
					<div class="cl pt-10">
						
						<div class="f-r">
							<div class="pagination"></div>
						</div>
					</div>
					<!-- pagination -->
				</div>
			</form>
		</div>
	</div>
</div>

</div>
</div>
  
<div class="popupBox w-320 vipPromptBox">
	<h2 class="popupHead">
		提示
	</h2>
	<div class="popupContainer">
		<div class="popupMain text-c pt-30 pb-20">
			<div class="">
				<i class="iconType iconType2"></i>
				<strong class="f-16">VIP会员功能</strong>
			</div>
			<p class="c-666 lh-26">
				抱歉，此功能需要<span class="c-bb3906">开通VIP会员</span>后才能使用！
			</p>
			<div class="text-c mt-30">
				<%-- <a  href="#" onclick="jumpToVIP();return false;" class="sfbtn sfbtn-opt3 w-100">开通VIP会员</a>--%>
				<span class="sfbtn sfbtn-opt3 w-100" onclick="jumpToVIP();">开通VIP会员</span>
			</div>
		</div>
	</div>
</div>
   
<script type="text/javascript">
var sfGrid;
var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部

$(function(){
	$.post("${ctx}/goods/sitePlatformGoods/distinct",function(result){
		if(result=="showPopup"){
			
			$(".vipPromptBox").popup();
			$('#Hui-article-box',window.top.document).css({'z-index':'9'});
		}
	});
	$.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
	$.tabfold("#moresearch",".moreCondition",1,"click");
	initSfGrid();
	initApplyerSelect();
	$("#applicant").next('span').find('.selection').css("width", "140");
});

//初始化jqGrid表格，传递的参数按照说明
function initSfGrid(){
	sfGrid = $("#table-waitdispatch").sfGrid({
		
		url : '${ctx}/fitting/siteFittingKeep/getSiteFitKeepList',
		sfHeader: defaultHeader,
		sfSortColumns: sortHeader,
		multiselect : false,
		rownumbers : true,
		gridComplete : function() {
			_order_comm.gridNum();
		}
		//shrinkToFit:true
		
	});
}

function initApplyerSelect(){
    $("#applicant").select2({
        ajax: {
            type: 'post',
            url: '${ctx}/fitting/siteFittingKeep/getApplicants',
            dataType: 'json',
            delay: 250,
            data: function (params) {
                return {
                    q: params.term, // search term 请求参数
                    page: params.page
                };
            },
            processResults: function (data, params) {
                params.page = params.page || 1;
                var itemList = [];//当数据对象不是{id:0,text:'ANTS'}这种形式的时候，可以使用类似此方法创建新的数组对象
                for (var i = 0; i < data.list.length; i++) {
                    var name = data.list[i].columns.name;
                    var status=data.list[i].columns.status;
                    var str=name;
                    if(status=='3'){
                        str+="【离职】";
					}
                    itemList.push({id: name, text: str});
                }
                return {
                    results: itemList,//itemList
                    pagination: {
                        more: (params.page * 10) < data.total_count
                    }
                };
            },
            cache: false
        },
        placeholder: '请输入搜索',//默认文字提示
        language: "zh-CN",
        tags: false,//允许手动添加
        //allowClear: true,//允许清空
        escapeMarkup: function (markup) {
            return markup;
        }, // 自定义格式化防止xss注入
        minimumInputLength: 1,//最少输入多少个字符后开始查询
        formatResult: function formatRepo(repo) {
            return repo.text;
        }, // 函数用来渲染结果
        formatSelection: function formatRepoSelection(repo) {
            return repo.text;
        } // 函数用于呈现当前的选择
    });
}

/* function fmtOper(rowData){
		//return "<span><a href=${ctx}/order/orderType/form?id="+rowData.id+">修改</a></span><span><a href=${ctx}/order/orderType/delete?id="+rowData.id+">删除</a></span>";
		return "<span><a href=${ctx}/order/proLimit/form?id="+rowData.id+">修改</a></span><span><a href=${ctx}/order/proLimit/delete?id="+rowData.id+">删除</a></span>";
} */
function fmtFitType(rowDate){
	
 	if(rowDate.type==1){
		return "<span>配件</span>";
	}else if(rowDate.type==2){
		return "<span>耗材</span>";
	}else{
		return "<span>其它</span>";
	} 
	
}

function fmtFitMx(rowDate){
	var fi = rowDate.ktype;
	var f1="";
	var f2="";
	var f3="";
	if(fi=="0"){
		f1="入库";
		f2="+";
		return "<span class='w-70 text-l'><li class='sficon sficon-rk_mx'></li>"+f1+"</span>";
	}else if(fi=="1"){
		f1="出库";
		f2="-";
		return "<span class='w-70 text-l'><li class='sficon sficon-ck'></li>"+f1+"</span>";
	}else if(fi=="2"){
		f1="归还";
		f2="+";
		return "<span class='w-70 text-l'><li class='sficon sficon-gh_mx'></li>"+f1+"</span>";
	}else if(fi=="5"){
		f1="删除";
		return "<span class='w-70 text-l'><li class='sficon sficon-delete1'></li>"+f1+"</span>";
	}else if(fi=="6"){
        f1="新件返厂";
        return "<span class='w-70 text-l'><li class='sficon sficon-fc'></li>"+f1+"</span>";
	}else if(fi=="4"){
		f1="网点零售";
        return "<span class='w-70 text-l'><li class='sficon sficon-ls'></li>"+f1+"</span>";
	}else if(fi=="8"){
        return "<span class='w-70 text-l'><i class='sficon1 sficon-zxbjsq'></i>中心备件申请</span>";
    }else if(fi=="7"){
        return "<span class='w-70 text-l'><li class='sficon sficon-ck'></li>出库至二级网点</span>";
    }else if(fi=="9"){
        return "<span class='w-70 text-l'><li class='sficon sficon-rk_mx'></li>厂家到货</span>";
    }else{
		f1="库存调整";
		f2="";
		return "<span class='w-70 text-l'><li class='sficon sficon-tzkc'></li>"+f1+"</span>";
	}

	return "<span class='w-70 text-l'><li class='sficon sficon-ck'></li>"+f1+"</span>";
	
}

function reset(){
    $("#applicant").empty();
    $("#select2-fittingName-container").empty();
}

function fmtFitAm(rowDate){
	var fm=rowDate.amount;
 	var fi = rowDate.ktype;
	var f2="";
	var f1="";
	if(fi=="0"){
		f2="+";
	}else if(fi=="1"){
		f2="-";
	}else if(fi=="2"){
		f2="+";
	}else if(fi=="5"){
		f2="-";
		f1="删除";
	}else if(fi=="6"){
	    f2="-";
	}else if(fi=="4"){
	    f2="-";
	}else if(fi=="7"){
	    f2="-";
	}else if(fi=="8"){
	    f2="+";
	}else{
		f1="库存调整";
	} 
	if(f1=='库存调整'&&parseInt(fm)>0){
		f2="+";
	}
	return "<span >"+f2+fm+"</span>";
}
function search(){
	var pageSize = $("#pageSize").val();
	if($.trim(pageSize)=='' || pageSize==null){
		$("#pageSize").val(20);
	}
    $("#table-waitdispatch").sfGridSearch({
        postData: $("#searchForm").serializeJson()
    });
}
function exports(){
	var idArr=$("#table-waitdispatch").jqGrid('getGridParam','records')
	var content="共"+idArr+"条数据，本次允许导出前10000条，确定继续导出吗？";
	if(idArr>10000){
		$('body').popup({
			level:3,
			title:"导出",
			content:content,
			 fnConfirm :function(){
				 location.href="${ctx}/fitting/siteFittingKeep/export?formPath=/a/fitting/siteFittingKeep/list&&maps="+$("#searchForm").serialize();
			 }
	
		});
		
	}else{
		 location.href="${ctx}/fitting/siteFittingKeep/export?formPath=/a/fitting/siteFittingKeep/list&&maps="+$("#searchForm").serialize();
	}

}


function jumpToVIP(){
	layer.open({
		type : 2,
		content:'${ctx}/goods/sitePlatformGoods/jumpVIP',
		title:false,
		area: ['100%','100%'],
		closeBtn:0,
		shade:0,
		anim:-1 
	});
}
</script>
  </body>
</html>
