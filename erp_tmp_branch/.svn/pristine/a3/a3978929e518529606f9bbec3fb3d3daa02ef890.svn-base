<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>我的商品-待返还</title>
<meta name="decorator" content="base" />
<meta charset="utf-8" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/style.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/sfskin_blue.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/styleGoods.css" />
<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/laypage/1.2/laypage.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.js" ></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/> 
</head>
<body class="">
	<div class="sfpagebg bk-gray">
		<div class="page-orderWait goodsPage">
			<div class="tabBar cl mb-10">
				<sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_COMPANYGOODSSTOCK_TAB" html='<a class="btn-tabBar " href="${ctx}/goods/siteself/WholeCompanySite">公司库存</a> '></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_ENIGNEERGOODSSTOCK_TAB" html='	<a class="btn-tabBar " href="${ctx}/goods/siteself/WholeEmployeSite">工程师库存</a>'></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_WAITRETURN_TAB" html='	<a class="btn-tabBar current" href="${ctx}/goods/usedRecord/waitReturn">待返还<sup id="tab_c1">0</sup></a>'></sfTags:pagePermission> 
				
				<p class="f-r btnWrap ">
					<a href="javascript:search();" class="sfbtn sfbtn-opt "><i class="sficon sficon-search"></i>查询</a>
					<a href="javascript:reset();" class="sfbtn sfbtn-opt"><i class="sficon sficon-reset"></i>重置</a>
				</p>
			</div>
			<div class="bk-gray pt-10 pb-5">
				<form id="searchForm">
					<input type="hidden" name="pageNo1" id="pageNo1" value="1"> 
					<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }"> 
					<input type="hidden" name="pageSize" id="pageSize" value="${page.pageSize }">
					<table class="table table-search">
						<tr>
							<th style="width: 76px;" class="text-r">商品编号：</th>
							<td>
								<input type="text" class="input-text" name="number" value="${map.number }" />
							</td>
							<th style="width: 76px;" class="text-r" >商品名称：</th>
							<td>
								<input type="text" class="input-text" value="${map.name }"  name="name"/>
							</td>
							<th style="width: 76px;" class="text-r">商品型号：</th>
							<td>
								<input type="text" class="input-text" name="model" value="${map.model }" />
							</td>
							<th style="width: 76px;" class="text-r">申请人：</th>
							<td>
								<span class="f-l w-140  readonly" >
									<select class="select w-140" name="applyName" id="applyName">
										<option value="">请选择</option>
										<c:forEach items="${employes }" var="ep">
											<option value="${ep.columns.name }" <c:if test="${ep.columns.name == map.applyName }">selected="selected"</c:if>>${ep.columns.name }</option>
										</c:forEach>
									</select>
								</span>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="pt-10 pb-5 cl btnsWrap">
				<div class="f-r">
					<sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_WAITRETURN_EXPORTS_BTN" html='<a onclick="return exports()" class="sfbtn sfbtn-opt2"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission> 
				</div>
			</div>
			<div id="goodsTableHead">
				<table class="table table-bg text-c">
					<thead>
						<tr>
							<th class="w-500 text-c">商品信息</th>
							<th class="w-150 text-c">返还数量  </th>
							<th class="w-150 text-c">申请人</th>
							<th class="w-150 text-c">申请时间</th>
							<th class="w-150 text-c">操作</th>
						</tr>
					</thead>
				</table>
			</div>
			<div class="mb-10" id="goodsTableWrap">
				<table class="table table-bg text-c goodsTable">
					<c:forEach items="${page.list }" var="lt1">
						<tr class="bb">
							<td class="text-l w-500">
								<div class="imgTD" style="cursor: pointer;" onclick="showDetail('${lt1.columns.good_id}','${lt1.columns.good_name}')">
									<img src="${commonStaticImgPath}${lt1.columns.firstIcon}" class="goosImg" />
									<div class=" f-l lh-22 ">
										<p class="f-13 c-005aab">${lt1.columns.good_name }</p>
										<div class="cl">
											<p class="f-l c-666 pr-20">商品类别：${lt1.columns.good_category }</p>
											<p class="f-l c-666">商品编号：${lt1.columns.good_number }</p>
										</div>
										<div class="c-666">商品型号：${lt1.columns.good_model }  </div>
									</div>
								</div>
							</td>
							<td class="w-150 ">${lt1.columns.used_num }${lt1.columns.unit }</td>
							<td class="w-150 "> ${lt1.columns.employe_name } </td>
							<td class="w-150 ">${lt1.columns.used_time }</td>
							<td class="w-150 ">
								<p>
									<sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_WAITRETURN_CONFIRMOUTSTOCKS_BTN" html='<a class="c-0383dc" onclick="return inStockDetail(\'${lt1.columns.id}\',\'${lt1.columns.good_name}\',\'${lt1.columns.used_num}\',\'${lt1.columns.good_id}\')"><i class="oState state-qrrk"></i>确认入库</a>'></sfTags:pagePermission> 
								</p>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div class="cl">
				<div class="pagination">${page}</div>
			</div>
		</div>
	</div>
<script type="text/javascript" src="${ctxPlugin}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script> 
<script type="text/javascript">
	
	$(function(){
        var pageSize=${page.pageSize};
        $('.pagination .select').val(pageSize);
		$.post("${ctx}/goods/usedRecord/allCount",function(result){
			$("#tab_c1").text(result);
		})
		$("select[name='applyName']").select2();
		$(".selection").css("width","140px");
		$('.dropdown-sin-2').dropdown({
	        input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
	        choice: function() {
	        }
	    });
		tableHeight();
	})
	
	window.onresize = function(){
		tableHeight();
	}
	
	function tableHeight(){
		var tHeight = $('.sfpagebg').height()-230;
		var tableHeight = $('#goodsTableWrap .goodsTable').height();
		$('#goodsTableWrap').css({
			'max-height':tHeight+'px',
			'overflow':'auto',
		});
		if(tableHeight > tHeight){
			$('#goodsTableHead').css({'padding-right':'17px'});
		}
	}
	
	var rkMark=false;
	function inStockDetail(id,name,amount,goodId){
		if(rkMark){
			return;
		}
		$('body').popup({
			level:'3',
			type:2,
			content:"确定将"+name+"*"+amount+"入库?",
			fnConfirm:function(){
				rkMark=true;
				$.ajax({
					type:"post",
					url:"${ctx}/goods/usedRecord/confirmInStocks",
					data:{id:id,amount:amount,goodId:goodId},
					success:function(result){
						if(result.code=="421"){
							layer.msg("该商品不存在！");
							return;
						}else if(result.code=="200"){
							layer.msg("入库成功！");
							window.location.reload();
							return;
						}else if(result.code=="422"){
							layer.msg("入库信息有误，商品历史领取数量小于返还数量！");
							return;
						} if(result.code=="423"){
							layer.msg("返还数量要求大于0！");
							return;
						}else if(result.code=="424"){
							layer.msg("商品使用记录信息有误，此商品可能已返还！");
							return;
						}else{
							layer.msg("入库失败，出现未知错误，请联系管理员！");
							return;
						}
					},
					complete:function(){
						rkMark=false;
					}
				})
			}
		})
	}
	
	function isBlank(val) {
		if(val==null || $.trim(val)=='' || val == undefined) {
			return true;
		}
		return false;
	}

	//条件查询
	function search() {
		$('#pageNo').val('1');
		window.location.href="${ctx}/goods/usedRecord/waitReturn?map="+$("#searchForm").serialize();
		return;
	}
	
	//分页信息，点击查询
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		window.location.href="${ctx}/goods/usedRecord/waitReturn?map="+$("#searchForm").serialize();
		return;
	}
	
	//重置
	function reset(){
		$("input[name='name']").val('');
		$("input[name='number']").val('');
		$("input[name='model']").val('');
		$("#applyName").select2('val', '请选择');
	}
	
	//导出
	 function exports(){
			var idArr='${page.count}';
			var content="共"+idArr+"条数据，本次允许导出前10000条，确定继续导出吗？";
			if(idArr>10000){
				$('body').popup({
					level:3,
					title:"导出",
					content:content,
					 fnConfirm :function(){
						 location.href="${ctx}/goods/usedRecord/export?formPath=/a/goods/usedRecord/waitReturn&&maps="+$("#searchForm").serialize();
					 }
			
				});
			}else{
				 location.href="${ctx}/goods/usedRecord/export?formPath=/a/goods/usedRecord/waitReturn&&maps="+$("#searchForm").serialize();
				
			}
		
		}
	
	//商品详情
	 function showDetail(id,name){
		var href="${ctx}/goods/siteself/showDetail?id="+id+"&jp=s3";
		updateOrCreate(name,href);
	 }
	
	 function updateOrCreate(name,href){
	     var bStop = false;
	     var bStopIndex = 1;
	     var show_navLi = $('#min_title_list li',window.top.document);
	     show_navLi.each(function () {
	         $(this).removeClass('active');
	         if ($(this).find('span').text() ==$.trim(name)) {
	             bStopIndex = show_navLi.index($(this));
	             bStop = true;
	         }
	     });
	     if (!bStop) {
	         creatIframe(href, name);
	     } else {
	         show_navLi.eq(bStopIndex).addClass('active');
	         $('#iframe_box .show_iframe',window.top.document).hide().eq(bStopIndex).show().find('iframe').attr({'src': href,});
	     }
	 }
</script> 
</body>
</html>