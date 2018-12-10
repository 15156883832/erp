<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>我的商品-工程师库存</title>
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
				<%-- <sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_COMPANYGOODSSTOCK_TAB" html='<a class="btn-tabBar " href="${ctx}/goods/siteself/WholeCompanySite">公司库存</a> '></sfTags:pagePermission> --%>
				<sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_EMPLOYEGIVESTOCKS_TAB" html='	<a class="btn-tabBar current " href="${ctx}/goods/siteself/WholeEmployeSite">工程师领取库存</a>'></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_EMPLOYEGIVESTOCKSRECORD_TAB" html='<a class="btn-tabBar " href="${ctx}/goods/siteGoodsKeep/empList">领取库存明细</a> '></sfTags:pagePermission>
				<%-- <sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_WAITRETURN_TAB" html='	<a class="btn-tabBar " href="${ctx}/goods/usedRecord/waitReturn">待返还<sup id="tab_c1">0</sup></a>'></sfTags:pagePermission>  --%>
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
							<th style="width: 76px;" class="text-r">服务工程师：</th>
							<td>
								<span class="f-l w-140  readonly" >
									<select class="select  w-140" id="employs" name="employeName">
										<option value="">请选择</option>
										<c:forEach items="${fns:getEmloyeList(siteId) }" var="emp">
											<option value="${emp.columns.id }" <c:if test="${emp.columns.id==map.employeName }">selected="selected"</c:if>>${emp.columns.name }</option>
										</c:forEach>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">商品编号：</th>
							<td>
								<input type="text" class="input-text" name= "number" value="${map.number }" />
							</td>
							<th style="width: 76px;" class="text-r">商品名称：</th>
							<td>
								<input type="text" class="input-text" name = "name" value="${map.name }" />
							</td>
							<th style="width: 76px;" class="text-r">商品类别：</th>
							<td>
								<span class="f-l w-140  readonly" >
									<select class="select w-140" name="suitCategory" id="suitCategory">
										<option value="">请选择</option>
										<c:forEach var ="cg" items="${categoryList}">
											<option value="${cg.columns.name }" <c:if test="${cg.columns.name==map.suitCategory }">selected="selected"</c:if>>${cg.columns.name }</option>
										</c:forEach>
									</select>
								</span>
							</td>
							
						</tr>
					</table>
				</form>
			</div>
			<div class="pt-10 pb-5 cl btnsWrap">
				<div class="f-l">
					<sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_EMPLOYEGIVESTOCKS_RETURNTOSITE_BTN" html='<a href="javascript:showFH();" class="sfbtn sfbtn-opt" id="xzhelp"><i class="sficon sficon-fc"></i>返还</a>'></sfTags:pagePermission>
				</div>
				<div class="f-r">
					<sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_EMPLOYEGIVESTOCKS_EXPORTS_BTN" html='<a onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
				</div>
			</div>
			<div id="goodsTableHead">
				<table class="table-bg">
					<thead>
						<tr>
							<th class="w-40"></th>
							<th class=" text-c">商品信息</th>
							<th class="w-150 text-c">服务工程师  </th>
							<th class="w-150 text-c">库存 / 单位  </th>
							<th class="w-150 text-c">入库价（元）</th>
							<th class="w-150 text-c">工程师价格（元）</th>
							<th class="w-150 text-c">零售价格（元）</th>
						</tr>
					</thead>
				</table>
			</div>
			<div class="mb-10" id="goodsTableWrap">
				<table class="table-bg text-c goodsTable">
					<c:forEach items="${page.list }" var="lt1">
						<tr class="bb">
							<td class="w-40">
								<span class="radiobox selectOne"> 
									<input type="radio" name="lsId" value="${lt1.columns.id}" name="" />
									<input value="${lt1.columns.stocks }" name="lsStocks" hidden="hidden" />
									<%-- <input value="${lt1.columns.sell_flag }" name="lsSellFlag" hidden="hidden" /> --%>
								</span>
							</td>
							<td class="text-l " style="cursor: pointer;" onclick="showDetail('${lt1.columns.good_id}','${lt1.columns.goodsName}')">
								<div class="imgTD">
									<img src="${commonStaticImgPath}${lt1.columns.firstIcon }" class="goosImg" />
									<div class=" f-l lh-22 ">
										<p class="f-13 c-005aab">${lt1.columns.goodsName }</p>
										<div class="cl">
											<p class="f-l c-666 pr-30">商品类别：${lt1.columns.category }</p>
										</div>
										<div class="cl">
											<p class="f-l c-666">商品编号：${lt1.columns.goodsNumber }</p>
										</div>
										<div class="c-666">商品型号：${lt1.columns.goodsModel }  </div>
									</div>
								</div>
							</td>
							<td class="w-150">${lt1.columns.empName }</td>
							<td class="w-150" >${lt1.columns.stocks }/${lt1.columns.unit }</td>
							<td class="w-150" >${lt1.columns.site_price }</td>
							<td class="w-150" >${lt1.columns.employe_price }</td>
							<td class="w-150" >${lt1.columns.customer_price }</td>
						</tr>	
					</c:forEach>
				</table>
			</div>
			<div class="cl">
				<div class="pagination">${page}</div>
			</div>
		</div>
	</div>
	
	<!-- 领用登记 -->
<div class="popupBox lydji ">
	<h2 class="popupHead">
		领用库存返还
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pt-15">
		
		<div class="popupMain pl-15 pr-15 pb-15 pt-30">
			<div class="mb-15">
				<table class="table table-bg table-border table-bordered table-sdrk text-c" style="table-layout: auto;">
					<thead>
						<tr>
							<th class="w-100">商品图片</th>
							<th class="w-100">商品编号</th>
							<th class="w-130">商品名称</th>
							<th class="w-100">商品品牌</th>
							<th class="w-110">商品型号</th>
							<th class="w-100">商品类别</th>
							<th class="w-100">库存/单位</th>
						</tr>
					</thead>
					<tr>
						<td>
							<img src="" id="lyImg" class="goosImg"/>
						</td>
						<td id="lyNumber">SF11018329 </td>
						<td id="lyName">浩泽净水器</td>
						<td id="lyBrand">浩泽  </td>
						<td id="lyModel">JZY-A2B3(XD)</td>
						<td id="lyCategory">净水器</td>
						<td id="lyUnit">9台</td>
					</tr>
				</table>
			</div>
			
			<div class="cl mb-20">
				<label class="f-l w-100">服务工程师：</label>
				<div class="priceWrap f-l w-140 readonly">
					<input type="text" class="input-text readonly" readonly="readonly" name="employefh" id="employefh" />
				</div>
				<label class="f-l w-90"><em class="mark">*</em>返还数量：</label>
				<div class="priceWrap f-l w-140">
					<input type="text" class="input-text" name="cNum" id="cNum" />
					<span class="unit" id="ckNumDw">台</span>
				</div>
			</div>
				<input type="hidden" name="goodId"/>
				<input type="hidden" name="empOwnId" id="empOwnId"/>
				<input type="hidden" id="hideStocks"/><!-- 库存数量 -->		
			<div class="text-c pt-10">
				<a href="javascript:doReturn();" class="sfbtn sfbtn-opt3 w-70 mr-5">保存</a>
				<a href="javascript:closeCKDiv();" class="sfbtn sfbtn-opt w-70">取消</a>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="${ctxPlugin}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script> 
<script type="text/javascript">
	
	$(function(){//返还：GOODSMGM_MYGOODSMGM_EMPLOYEGIVESTOCKS_RETURNTOSITE_BTN
        var pageSize=${page.pageSize};
        $('.pagination .select').val(pageSize);
		$.post("${ctx}/goods/usedRecord/allCount",function(result){
			$("#tab_c1").text(result);
		})
		$("select[name='employeName']").select2();
		$("select[name='suitCategory']").select2();
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
	
	
	function exports(){
		var idArr='${page.count}';
		var content="共"+idArr+"条数据，本次允许导出前10000条，确定继续导出吗？";
		if(idArr>10000){
			$('body').popup({
				level:3,
				title:"导出",
				content:content,
				 fnConfirm :function(){
					 location.href="${ctx}/goods/siteself/exportEmp?formPath=/a/goods/siteself/WholeEmployeSite&&maps="+$("#searchForm").serialize(); 
				 }
		
			});
		}else{
			 location.href="${ctx}/goods/siteself/exportEmp?formPath=/a/goods/siteself/WholeEmployeSite&&maps="+$("#searchForm").serialize(); 
		}

	}

	//条件查询
	function search() {
		$('#pageNo').val('1');
		window.location.href="${ctx}/goods/siteself/WholeEmployeSite?map="+$("#searchForm").serialize();
		return;
	}
	
	//分页信息，点击查询
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		window.location.href="${ctx}/goods/siteself/WholeEmployeSite?map="+$("#searchForm").serialize();
		return;
	}
	
	//重置
	function reset(){
		$("input[name='name']").val('');
		$("input[name='number']").val('');
		$("#employs").select2('val', '请选择');
		$("#suitCategory").select2('val', '请选择');
	}
	
	//商品详情
	 function showDetail(id,name){
		var href="${ctx}/goods/siteself/showDetail?id="+id+"&jp=s2";
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
	 
	 $('.goodsTable').on('click','.radiobox', function(){
		var isSelected = $(this).hasClass('radiobox-selected');
		if(!isSelected){
			$(this).closest('.goodsTable').find('.radiobox').removeClass('radiobox-selected');
			$(this).closest('.goodsTable').find('input[type="radio"]').prop({'checked':'false'});
			$(this).addClass('radiobox-selected');
			$(this).find('input[type="radio"]').prop({'checked':'true'});
		}
	})
	
	//显示f返还弹出框信息
	function showFH() {
		var ifselt = $(".radiobox-selected");
		if(!$(".selectOne").hasClass("radiobox-selected")){
			layer.msg("请选择数据！");
			return;
		};
		var id = $(".radiobox-selected").find("input[name='lsId']").val();
		var stocks = $(".radiobox-selected").find("input[name='lsStocks']").val();
		$.ajax({
			type:"POST",
			url : "${ctx}/goods/siteself/queryEmpGoodsStocks",
			data : {id : id},
			datatype:"json",
			success : function(result) {
				if(isBlank(result.columns.gId)){
					layer.msg("商品信息有误！");
					return ;
				} 
				$("#employefh").val(result.columns.empName);
				$("#lyNumber").text(result.columns.good_number);
				$("#lyName").text(result.columns.gName);
				$("#lyBrand").text(result.columns.gBrand);
				$("#lyCategory").text(result.columns.gCategory);
				$("#lyModel").text(result.columns.gModel);
				$("#ckNumDw").text(result.columns.gUnit);
				$("#hideStocks").val(result.columns.stocks);
				$("#empOwnId").val(result.columns.id);
				$("#lyUnit").text(result.columns.stocks+result.columns.gUnit);
				if(!isBlank(result.columns.gIcon)){
					$("#lyImg").attr("src","${commonStaticImgPath}"+result.columns.gIcon.split(',')[0]);
				}
				$(".lydji").find("input[name='goodId']").val(result.columns.gId);
				$(".lydji").popup();
			}
		})  
	}
	 
	 function isBlank(val) {
			if (val == null || $.trim(val) == '' || val == undefined) {
				return true;
			}
			return false;
		}
	 
	 //返还操作
	 var rtMark = false;
	 function doReturn(){
		 if(rtMark){
			 return;
		 }
		 var nums = $("#cNum").val();
		 if(isBlank(nums)){
			 layer.msg("请填写返还数量！");
			 $("#cNum").focus();
			 return;
		 }
		 if(parseFloat(nums) > parseFloat(0) ){
			 if(parseFloat(nums) > parseFloat($("#hideStocks").val())){
				 layer.msg("返还数量不能大于工程师领取库存数量！");
				 return;
			 }
			 rtMark = true;
			 $.ajax({
				 type:"post",
				 url:"${ctx}/goods/siteself/doReturnGoods",
				 data:{id:$("#empOwnId").val(),nums:nums},
				 success:function(result){
					 rtMark = false;
				 	if(result=="421"){//工程师商品基本信息有误
				 		layer.msg("商品信息有误，请检查后在进行返还操作！");
				 		return;
				 	}
				 	if(result=="422"){
				 		layer.msg("工程师领取商品的库存数不足，请刷新后在进行返还操作！");
				 		return;
				 	}
				 	if(result=="423"){//公司库存无此商品
				 		layer.msg("商品信息有误，请检查后在进行返还操作！");
				 		return;
				 	}
				 	
				 	if(result=="200"){
				 		parent.layer.msg("返还成功！");
				 		search();
				 		return;
				 	}else{
				 		layer.msg("返还失败，请检查！");
				 		return ;
				 	}
					 
				 }
			 })
		 }else{
			 layer.msg("返还数量输入有误！");
			 $("#cNum").focus();
			 return;
		 }
	 }
	 
	 function closeCKDiv(){
		 $.closeDiv($(".lydji"));
	}
</script> 
</body>
</html>