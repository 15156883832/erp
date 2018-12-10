<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>我的商品-公司库存</title>
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
<style type="text/css">
 	.webuploader-pick{
		background:none;
		color:#22a0e6;
		width:90px;
		padding:0;
		height:20px;
	}
	.webuploader-pick img{
		width:90px;
		height:20px;
		position:absolute;
		left:0;
		top:0;
	}
	.SelectBG{
		background-color:#ffe6e2;
	}
	.dropdown-clear-all{
	line-height: 22px
}
	.ceshistyle_label{
		padding-right:10px;
		position:relative;
	}
	.ceshistyle_label:before{
		content:'：';
		position:absolute;
		right:0;
		top:0;
		width:10px;
		text-align:center;
		line-height:26px;
	}
	
	.dropdown-option[disabled] {
	    color: #000000;
	    background-color: #fff;
	    cursor: default;
	    text-decoration: none;
	    font-weight:bold;
	    background-color:#ddd
	}
	
</style>
<title>公司库存</title>
</head>
<body class="">
	<div class="sfpagebg bk-gray">
		<div class="page-orderWait goodsPage">
			
			<%-- <input type="hidden" name="rows" id="pageSize" value="${page.pageSize}"> --%>
			<div class="tabBar cl mb-10">
				<sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_COMPANYGOODSSTOCK_TAB" html='<a class="btn-tabBar current" href="${ctx}/goods/siteself/WholeCompanySite">公司库存</a> '></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_COMPANYGOODSSTOCKDETAILRECORD_TAB" html='<a class="btn-tabBar " href="${ctx}/goods/siteGoodsKeep/list">出入库记录</a> '></sfTags:pagePermission>
				<%-- <sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_ENIGNEERGOODSSTOCK_TAB" html='	<a class="btn-tabBar " href="${ctx}/goods/siteself/WholeEmployeSite">工程师库存</a>'></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_WAITRETURN_TAB" html='	<a class="btn-tabBar " href="${ctx}/goods/usedRecord/waitReturn">待返还<sup id="tab_c1">0</sup></a>'></sfTags:pagePermission> --%> 
				
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
							<th style="width: 76px;" class="text-r">商品名称：</th>
							<td>
								<input type="text" class="input-text" value="${map.name }"  name="name"/>
							</td>
							<th style="width: 76px;" class="text-r">商品类别：</th>
							<td>
								<span class="f-l w-140  readonly" > 
									<select class="select w-140" name="category" id="searchCategory">
										<option value="">请选择</option>
										<c:forEach var ="cg" items="${categoryList}">
											<option value="${cg.columns.name }" <c:if test="${map.category == cg.columns.name }">selected="selected"</c:if>>${cg.columns.name }</option>
										</c:forEach>
									</select> 
								</span>
							</td>
							<th style="width: 76px;" class="text-r">商品来源：</th>
							<td>
								<select class="select w-140" name="source">
									<option value="">请选择</option>
									<option value="1" <c:if test="${map.source == '1' }">selected="selected"</c:if>>自营</option>
									<option value="2" <c:if test="${map.source == '2' }">selected="selected"</c:if>>平台</option>
								</select>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="pt-10 pb-5 cl btnsWrap">
				<div class="f-l">
					<sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_COMPANYGOODSSTOCK_ADD_BTN" html='<a href="javascript:showXZ();" class="sfbtn sfbtn-opt" id="xzhelp"><i class="sficon sficon-add"></i>新增</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_COMPANYGOODSSTOCK_INPUT_BTN" html='<a href="javascript:showRuKu();" class="sfbtn sfbtn-opt"><i class="sficon sficon-sdrk"></i>入库</a> '></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_COMPANYGOODSSTOCK_SELL_BTN" html='<a href="javascript:showLS();" class="sfbtn sfbtn-opt"><i class="sficon sficon-ls"></i>零售</a> '></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_COMPANYGOODSSTOCK_COLLARRECORD_BTN" html='<a href="javascript:showLYDJ();" class="sfbtn sfbtn-opt"><i class="sficon sficon-useSign"></i>工程师领用</a> '></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_COMPANYGOODSSTOCK_BUYGOODSEMPLOYE_BTN" html='<a href="javascript:showLYDJgm();" class="sfbtn sfbtn-opt"><i class="sficon sficon-gcszg"></i>工程师自购</a> '></sfTags:pagePermission>
				</div>
				<div class="f-r">
					<sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_COMPANYGOODSSTOCK_EXPORT_BTN" html='<a onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
				</div>
			</div>
			<div id="goodsTableHead">
				<table class="table table-bg text-c ">
					<thead>
						<tr>
							<th class="w-40"></th>
							<th class="w-300 text-c">商品信息</th>
							<th class="w-80 text-c">是否上架</th>
							<th class="w-80 text-c">库存 / 单位</th>
							<th class="w-80 text-c">商品来源</th>
							<th class="w-100 text-c">入库价格（元）</th>
							<th class="w-110 text-c">工程师价格（元）</th>
							<th class="w-100 text-c">零售价格（元）</th>
							<th class="w-80 text-c">折扣价（元）</th>
							<th class="w-80 text-c">操作</th>
						</tr>
					</thead>
				</table>
			</div>
			<div class="mb-10" id="goodsTableWrap">
				<table class="table table-bg text-c goodsTable">
					<tbody id="detailList">
						<c:forEach items="${page.list }" var="lt1">
							<tr class="bb" id="siteGoodsList">
								<td class="w-40">
									<%-- <span class="radiobox selectOne"> 
										<input type="radio" name="lsId" value="${lt1.columns.id}" name="" />
										<input value="${lt1.columns.stocks }" name="lsStocks" hidden="hidden" />
										<input value="${lt1.columns.sell_flag }" name="lsSellFlag" hidden="hidden" />
									</span> --%>
									<span class="label-cbox selectOne">
										<input type="radio" name="lsId" value="${lt1.columns.id}" name="" />
										<input value="${lt1.columns.stocks }" name="lsStocks" hidden="hidden" />
										<input value="${lt1.columns.sell_flag }" name="lsSellFlag" hidden="hidden" />
										<input value="${lt1.columns.brand }" name="specialBrand" hidden="hidden" />
									</span>
								</td>
								<td class="w-300 text-l" style="cursor: pointer;" onclick="showDetail('${lt1.columns.id}','${lt1.columns.name}')">
									<div class="imgTD">
										<img src="${commonStaticImgPath}${lt1.columns.firstIcon}"
											class="goosImg" />
										<div class=" f-l lh-22 ">
											<p class="f-13 c-005aab">${lt1.columns.name }</p>
											
											<p class="c-666">商品类别：${lt1.columns.category }</p>
											<p class="c-666">商品编号：${lt1.columns.number }</p>
											
											<div class="c-666">商品型号：${lt1.columns.model }</div>
										</div>
									</div>
								</td>
								<td class="w-80">
									<c:if test="${lt1.columns.sell_flag eq 1 }"><span class="goodslevel goodslevel_1">已上架</span></c:if>
									<c:if test="${lt1.columns.sell_flag eq 2 }"><span class="goodslevel goodslevel_2">已下架</span></c:if>
								</td>
								<td class="w-80">${lt1.columns.stocks }${lt1.columns.unit }</td>
								<td class="w-80">
									<c:if test="${lt1.columns.source eq 1 }">自营</c:if>
								    <c:if test="${lt1.columns.source eq 2 }">平台</c:if>
								</td>
								<td class="w-100">${lt1.columns.site_price }</td>
								<td class="w-110">${lt1.columns.employe_price }</td>
								<td class="w-100"><span class="c-cc0000">${lt1.columns.customer_price }</span></td>
								<td class="w-80">${lt1.columns.rebate_price }</td>
								<td class="w-80">
									<p>
										<c:if test="${lt1.columns.sell_flag eq 1 }">
											<sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_COMPANYGOODSSTOCK_OFFSALE_BTN" html='<a class="c-0383dc" onclick="xiajia(\'${lt1.columns.id }\',\'${lt1.columns.name}\')"><i class="sficon sficon-xj"></i>下架</a>'></sfTags:pagePermission>
										</c:if>
										<c:if test="${lt1.columns.sell_flag eq 2 }">
											<sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_COMPANYGOODSSTOCK_UPGOODS_BTN" html='<a class="c-0383dc"  onclick="shangjia(\'${lt1.columns.id }\',\'${lt1.columns.name}\')"><i class="sficon sficon-sj"></i>上架</a>'></sfTags:pagePermission>
										</c:if>
									</p>
									<p>
										<sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_COMPANYGOODSSTOCK_EDITE_BTN" html='<a class="c-0383dc" onclick="bianji(\'${lt1.columns.id}\',\'${lt1.columns.name}\')"><i class="sficon sficon-edit"></i>编辑</a>'></sfTags:pagePermission>
									</p>
									<p>
										<sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_COMPANYGOODSSTOCK_DELETE_BTN" html='<a class="c-0383dc" onclick="shanchu(\'${lt1.columns.id}\',\'${lt1.columns.sell_flag }\',\'${lt1.columns.name }\')"><i class="sficon sficon-del"></i>删除</a>'></sfTags:pagePermission>
									</p>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="cl">
				<div class="pagination">${page}</div>
			</div>
			
		</div>
	</div>

	
<!-- 零售 -->
<div class="popupBox lingshou ">
	<h2 class="popupHead">
		零售
		<a href="javascript:closeLsDiv();"  class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="pcontent">
			<div class="popupMain pl-15 pt-15 pb-15">
				<div class="mb-15">
					<table class="table table-bg table-border table-bordered table-sdrk text-c" style="table-layout: auto;">
						<thead>
							<tr>
								<th class="w-100">商品图片</th>
								<th class="w-100" >商品编号</th>
								<th class="w-130" >商品名称</th>
								<th class="w-100" >商品品牌</th>
								<th class="w-110" >商品型号</th>
								<th class="w-100" >商品类别</th>
								<th class="w-100" >库存/单位</th>
								<th class="w-100" >零售价格</th>
							</tr>
						</thead>
						<tr>
							<td>
								<img src="" class="goosImg" id="img-view" />
							</td>
							<td id="gNumber">SF11018329 </td>
							<td id="gName"> 浩泽净水器</td>
							<td id="gBrand">浩泽  </td>
							<td id="gModel">JZY-A2B3(XD)</td>
							<td id="gCategory">净水器</td>
							<td id="gUnit">9台</td>
							<td id="gCustomerPrice">2920元</td>
						</tr>
					</table>
				</div>
				
				<div class="bg-e8f2fa pt-25 pr-15 pb-20 laceBorder">
					<div class="cl mb-10">
						<label class="f-l w-90"><em class="mark">*</em>用户姓名：</label>
						<input type="text" class="input-text w-140 f-l bg-fff" maxlength="10" name="userName" id="lsCustomerName" />
						<label class="f-l w-100"><em class="mark">*</em>联系方式：</label>
						<input type="text" class="input-text w-140 f-l bg-fff" maxlength="20" name="mobile" id="lsCustomerMobile" />
						<label class="f-l w-90">详细地址：</label>
						<input type="text" class="input-text w-330 f-l bg-fff" name="address" id="lsCustomerAddress" />
					</div>
					<!-- <div class="cl">
						
					</div> -->
				</div>
				<p class="pt-10 pb-10 lh-20 f-14 c-fe0101" id="deduType">该商品是按固定金额提成的</p>
				<div class="cl mb-10">
					<label class="f-l w-80"><em class="mark">*</em>零售数量：</label>
					<div class="priceWrap f-l w-140">
						<input type="text" class="input-text" name="lsNum" id="lsNum"/>
						<span class="unit" id="lsdanwei">个</span>
					</div>
					<input type="text" class="input-text" hidden="hidden" name="lsPrice" />
					<label class="f-l w-100"><em class="mark">*</em>实收价格：</label>
					<div class="priceWrap f-l w-140">
						<input type="text" class="input-text" name="ssPrice" id="ssPrice" />
						<input type="text" class="input-text " hidden="hidden" id="commissionsRemarks" name="commissionsRemarks" />
						<input type="text" class="input-text " hidden="hidden" id="oldCommissionsRemarks" name="commissionsRemarks" />
						<span class="unit">元</span>
					</div>
					<label class="f-l w-100"><em class="mark">*</em>销售人员：</label>
					<span id="intHtml" class="f-l " >
						<span class="f-l w-330 dropdown-sin-2 readonly" >
							 <select class="select-box w-120 readonly"  id="xiaoName"  multiple="multiple" name="xiaoName"  style="width:140px">
							 	<option  disabled class="check">网点人员</option>
							 	<c:if test="${rd1 ne null }">
									<c:forEach items="${rd1 }" var="rd1">
										<option value="${rd1.columns.uId }">${rd1.columns.name }</option>
									</c:forEach>
								</c:if> 
								<option disabled class="check">服务工程师</option>
								<c:if test="${rd2 ne null }">
									<c:forEach items="${rd2 }" var="rd2">
										<option value="${rd2.columns.uId }">${rd2.columns.name }</option>
									</c:forEach>
								</c:if> 
							 </select>
						</span> 
					</span>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-80">提成金额：</label>
					<div class="priceWrap f-l w-140 readonly">
						<input type="text" class="input-text readonly" readonly="readonly" id="stichengPrice11" name="stichengPrice" />
						<span class="unit">元</span>
					</div>
				</div>
				<div class="bg-e8f2fa pt-15 pb-5 cl mb-15 ">
					<label class="w-70 f-l">提成明细：</label>
					<div class="f-l w-600" id="xsEmployes">
						<!-- <div class="f-l mb-10 mr-15">
							<label class="nameTag w-90 f-l" title="张启明张启明">张启明</label>
							<div class="priceWrap f-l bg-fff w-80">
								<input type="text" class="input-text" />
								<span class="unit">元</span>
							</div>
						</div>
						<div class="f-l mb-10 mr-15">
							<label class="nameTag w-90 f-l" title="张启明张启明">张启明</label>
							<div class="priceWrap f-l bg-fff w-80">
								<input type="text" class="input-text" />
								<span class="unit">元</span>
							</div>
						</div> -->
					</div>
				</div>
				<div class="text-c mt-20">
					<input type="hidden" name="lgoodId"/><!-- 商品id -->
					<input type="hidden" name="lprice"/><!-- 零售价格 -->
					<input type="hidden" name="lnum"/><!-- 库存数量 -->
					<input type="hidden" name="tichengType"/><!-- 提成方式 -->
					<input type="hidden" name="tichengPrice"/><!-- 提成方式 -->
					<input type="hidden" name="tichengJiShu"/><!-- 提成基数 -->
					<input type="hidden" name="tichengXiShu"/><!-- 提成系数 -->
					<input type="hidden" name="ruKuPrice"/><!-- 入库价格-->
					<input type="hidden" name="empPrice"/><!-- 工程师价格 -->
					<input type="hidden" name="rebatePrice"/><!-- 折扣价-->
					<input type="hidden" name="lsource"/><!-- 商品来源-->
				</div>
				<div class="text-c ">
					<a href="javascript:doLS();" class="sfbtn sfbtn-opt3 w-70 mr-5">保存</a>
					<a href="javascript:closeLS();" id="quxiaoLsCancel" class="sfbtn sfbtn-opt w-70">取消</a>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- 领用登记 -->
<div class="popupBox lydji ">
	<h2 class="popupHead">
		工程师领用
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
				<label class="f-l w-58"><em class="mark">*</em>工程师：</label>
				<span class="f-l w-140 ">
					<select class="select w-140" name="employeName" id="searchOrgId">
						<option value="">请选择</option>
						<c:forEach items="${fns:getEmloyeList(siteId) }" var="emp">
							<option value="${emp.columns.id }">${emp.columns.name }</option>
						</c:forEach>
					</select>
				</span>
				<label class="f-l w-90"><em class="mark">*</em>领用数量：</label>
				<div class="priceWrap f-l w-140">
					<input type="text" class="input-text" name="cNum" id="cNum" />
					<span class="unit" id="ckNumDw">台</span>
				</div>
				<!-- <label class="f-l w-120">交款金额：</label>
				<div class="priceWrap f-l w-140">
					<input type="text" class="input-text" name="jkjeMoney" id="jkjeMoney" />
					<span class="unit">元</span>
				</div> -->
			</div>
				<input type="hidden" name="goodId"/>
				<input type="hidden" name="num"/><!-- 库存数量 -->		
			<div class="text-c pt-10">
				<a href="javascript:doChuKu();" class="sfbtn sfbtn-opt3 w-70 mr-5">保存</a>
				<a href="javascript:closeCKDiv();" class="sfbtn sfbtn-opt w-70">取消</a>
			</div>
		</div>
	</div>
</div>
<!-- 自购登记 -->
<div class="popupBox lydjigm ">
	<h2 class="popupHead">
		自购
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
							<th class="w-100">工程师价格</th>
						</tr>
					</thead>
					<tr>
						<td>
							<img src="" id="lyImggm" class="goosImg"/>
						</td>
						<td id="lyNumbergm">SF11018329 </td>
						<td id="lyNamegm">浩泽净水器</td>
						<td id="lyBrandgm">浩泽  </td>
						<td id="lyModelgm">JZY-A2B3(XD)</td>
						<td id="lyCategorygm">净水器</td>
						<td id="lyUnitgm">9台</td>
						<td id="lyCustomerPrice">100元</td>
					</tr>
				</table>
			</div>
			
			<div class="cl mb-20">
				<label class="f-l w-58"><em class="mark">*</em>工程师：</label>
				<span class="f-l w-140 ">
					<select class="select w-140" name="employeNamegm" id="searchOrgIdgm">
						<option value="">请选择</option>
						<c:forEach items="${fns:getEmloyeList(siteId) }" var="emp">
							<option value="${emp.columns.id }">${emp.columns.name }</option>
						</c:forEach>
					</select>
				</span>
				<label class="f-l w-120"><em class="mark">*</em>零售数量：</label>
				<div class="priceWrap f-l w-140">
					<input type="text" class="input-text" name="cNumgm" id="cNumgm" />
					<span class="unit" id="ckNumDwgm">台</span>
				</div>
				<label class="f-l w-120"><em class="mark">*</em>交款金额：</label>
				<div class="priceWrap f-l w-140">
					<input type="text" class="input-text" name="jkjeMoneygm" id="jkjeMoneygm" />
					<span class="unit">元</span>
				</div>
			</div>
				<input type="hidden" name="goodIdgm"/>
				<input type="hidden" name="numgm"/><!-- 库存数量 -->		
			<div class="text-c pt-10">
				<a href="javascript:doChuKugm();" class="sfbtn sfbtn-opt3 w-70 mr-5">保存</a>
				<a href="javascript:closeCKDivgm();" class="sfbtn sfbtn-opt w-70">取消</a>
			</div>
		</div>
	</div>
</div>


<!-- 入库 -->
<div class="popupBox ruku ">
	<h2 class="popupHead">
		入库
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pt-15">
		<div class="popupMain pl-15 pr-15 pb-15 pt-30">
			<div class="mb-20">
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
							<img src="" id="rkImg" class="goosImg"/>
						</td>
						<td id="rkNumber">SF11018329 </td>
						<td id="rkName"> 浩泽净水器</td>
						<td id="rkBrand">浩泽  </td>
						<td id="rkModel">JZY-A2B3(XD)</td>
						<td id="rkCategory">净水器</td>
						<td id="rkUnit">9台</td>
					</tr>
				</table>
			</div>
			
			<div class="cl mb-20">
				<label class="f-l w-80"><em class="mark">*</em>入库数量：</label>
				<input type="text" class="input-text f-l w-140" name="rNum" id="rNum"/>
				<label class="f-l w-80"><em class="mark">*</em>入库价格：</label>
				<div class="priceWrap f-l w-140">
					<input type="text" class="input-text" name="rPrice" id="rPrice"/>
					<span class="unit" id="yuan">元</span>
				</div>
			</div>
				<input type="hidden" name="rgoodId"/>			
			<div class="text-c pt-10">
				<a href="javascript:doRuKu();" class="sfbtn sfbtn-opt3 w-70 mr-5">保存</a>
				<a href="javascript:closeDiv();" class="sfbtn sfbtn-opt w-70">取消</a>
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

<script type="text/javascript" src="${ctxPlugin}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script> 
<script type="text/javascript">
var lingshouways = "0";
	$(function(){
        var pageSize=${page.pageSize};
        $('.pagination .select').val(pageSize);
		//loadSiteGoodsList();
		$.post("${ctx}/goods/usedRecord/allCount",function(result){
			$("#tab_c1").text(result);
		})
		
		$('.goodsTable').on('click','.radiobox', function(){
			var isSelected = $(this).hasClass('radiobox-selected');
			if(!isSelected){
				$(this).closest('.goodsTable').find('.radiobox').removeClass('radiobox-selected');
				$(this).closest('.goodsTable').find('input[type="radio"]').prop({'checked':'false'});
				$(this).addClass('radiobox-selected');
				$(this).find('input[type="radio"]').prop({'checked':'true'});
			}
		});
		$('#detailList .label-cbox').on('click', function(){
			var flag = $(this).hasClass('label-cbox-selected');
			if(flag){
				$(this).removeClass('label-cbox-selected');
			}else{
				$(this).addClass('label-cbox-selected');
			}
		})
		
		tableHeight();
		
		$("select[name='category']").select2();
		$("select[name='employeName']").select2();
		$("select[name='employeNamegm']").select2();
		$(".selection").css("width","140px");
		
		a = $('.dropdown-sin-2').dropdown({
	        input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
	        choice: function() {
	        }
	    });
		
		$("#lsNum").change(function(){
			var nums = $("#lsNum").val();
		})
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
	
	//条件查询
	function search() {
		$('#pageNo').val('1');
		window.location.href="${ctx}/goods/siteself/WholeCompanySite?map="+$("#searchForm").serialize();
		return;
	}
	
	//分页信息，点击查询
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		window.location.href="${ctx}/goods/siteself/WholeCompanySite?map="+$("#searchForm").serialize();
		return;
	}
	
	//重置
	function reset(){
		$("input[name='name']").val('');
		$("input[name='number']").val('');
		$("#searchCategory").select2('val', '请选择');
		$("select[name='source']").val('');
	}
	
	function isBlank(val) {
		if (val == null || $.trim(val) == '' || val == undefined) {
			return true;
		}
		return false;
	}
	
	//下架
	function xiajia(id,name) {
		var content = "您确定要将商品"+name+"下架吗？";
		$('body').popup({
			level:3,
			title:"商品下架",
			content:content,
			 fnConfirm :function() {
			$.ajax({
				type : "POST",
				url : "${ctx}/goods/siteself/doXJ",
				data : {
					"id" : id
				},
				success : function(data) {
					if (data == "ok") {
						layer.msg('下架成功!');
						reloadGrid();
					} else {
						layer.msg('下架失败!');
					}
				}
			});
			 },
			 fnCancel:function (){
					
				}
		});

	}
	//上架
	function shangjia(id,name) {
		var content = "您确定要将商品"+name+"上架吗？";
		$('body').popup({
			level:3,
			title:"商品上架",
			content:content,
			 fnConfirm :function() {
			$.ajax({
				type : "POST",
				url : "${ctx}/goods/siteself/doSJ",
				data : {
					"id" : id
				},
				success : function(data) {
					if (data == "ok") {
						layer.msg('上架成功!');
						reloadGrid();
					} else {
						layer.msg('上架失败!');
					}
					return;
				}
			});
			 },
			 fnCancel:function (){
					
				}
		});
	}
	
	//删除
	var delMark=false;
	function shanchu(id,flag,name) {
		if(flag=="1"){
			layer.msg('该商品已上架，不可删除！！！');
		}else{
			var content = "您确认要将商品"+name+"删除吗？";
			$('body').popup({
				level:3,
				title:"商品删除",
				content:content,
				 fnConfirm :function(){
				 if(delMark){
					 return;
				 }
				 delMark=true;
				$.ajax({
					type : "POST",
					url : "${ctx}/goods/siteself/doSC",
					data : {
						"id" : id
					},
					success : function(data) {
						if (data == "ok") {
							layer.msg('删除成功!');
							reloadGrid()
						} else if(data == "daiShou"){
							layer.msg('该商品有待收款的订单，无法删除!');
						}else if(data == "daiChu"){
							layer.msg('该商品有待出库的订单，无法删除!');
						}else if(data == "421"){
							layer.msg('商品信息有误，无法删除!');
						}
						delMark=false;
						return;
					}
				});
				 },
				 fnCancel:function (){
						
					}
			});
		}
	}
	
	function reloadGrid(){
		window.location.href="${ctx}/goods/siteself/WholeCompanySite?map="+$("#searchForm").serialize();
	}
	
	//新增商品
	function showXZ(){
		$.ajax({
			type:"post",
			url:"${ctx}/goods/siteself/checkIfAllowAddGoods",
			data:{},
			success:function(data){
				if(data=='hidePop'){
					var href="${ctx}/goods/siteself/toAddSiteSelfGoods";
					updateOrCreate("新增商品",href);
				}else if(data=='showPop'){
					$(".vipPromptBox").popup();
					$('#Hui-article-box',window.top.document).css({'z-index':'9'});
				}else{
					layer.msg("解析错误，请检查！");
				}
			}
		})
	}
	
	//编辑商品
	function bianji(id,name){
		var href="${ctx}/goods/siteself/toEditSiteSelfGoods?id="+id+"&jp=s1";
		updateOrCreate(name,href);
	} 
	
	 function exports(){
		 var idArr = '${page.count}';
		var content="共"+idArr+"条数据，本次允许导出前10000条，确定继续导出吗？";
		if(idArr>10000){
			$('body').popup({
				level:3,
				title:"导出",
				content:content,
				 fnConfirm :function(){
					 location.href="${ctx}/goods/siteself/export?formPath=/a/goods/siteself/WholeCompanySite&&maps="+$("#searchForm").serialize();
				 }
		
			});
		}else{
			 location.href="${ctx}/goods/siteself/export?formPath=/a/goods/siteself/WholeCompanySite&&maps="+$("#searchForm").serialize();
		}
	}
	 
	 //商品详情
	 function showDetail(id,name){
		var href="${ctx}/goods/siteself/showDetail?id="+id+"&jp=s1";
		updateOrCreate(name,href);
	 }
	 
	//显示零售弹窗信息
	function showLS() {
		var id = getSelectedIds().ids;
		if(isBlank(id)){
			layer.msg("请选择数据！");
			return;
		};
		var special = getSelectedIds().special;
		if(special=="2" && id.split(",").length > 1){
			layer.msg("浩泽商品暂不支持和其它商品一起零售！");
			return;
		}
		var stocks = getSelectedIds().stocks;
		var sellFlag = getSelectedIds().sellFlag;
		var lsMark1 = "1";
		var lsMark2 = "1";
		for(var m=0;m<stocks.split(",").length;m++){
			var vals = stocks.split(",")[m];
			if(parseFloat(vals)<=parseFloat(0)){//无库存
				layer.msg("存在库存不足的商品！")
				lsMark1 = "2";
				return;
			}
		}
		if(lsMark1=='2'){
			return;
		}
		for(var n=0;n<sellFlag.split(",").length;n++){
			if(sellFlag.split(",")[n]=='2'){
				layer.msg("已下架的商品不能零售！");
				lsMark2 = "2";
				return;
			}
		}
		if(lsMark2=='2'){
			return;
		}
		layer.open({
			type : 2,
			content:"${ctx}/goods/siteselfOrder/toGoodsSalePage?id="+id,
			title:false,
			area: ['100%','100%'],
			closeBtn:0,
			shade:0,
			fadeIn:0,
			anim:-1
		});
		/* $.ajax({
			type:"POST",
			url : "${ctx}/goods/siteself/showSelfSale",
			data : {id : id},
			datatype:"json",
			success : function(data) {
				var result = data.gss;
				var salesSet = data.salesSet;
				$(".lingshou").find("input").val("");
				 if(result.columns.deduct_type == "1"){//固定金额提成
                 	$("#deduType").text("该商品是按固定金额提成的");
                 }else{//利润比例提成
                 	var msg="该商品是按利润比列提成的（利润 = 实收金额 - 入库价格）";
                     if(salesSet!=null && $.trim(salesSet)!= ""){
                     	tclrWays = salesSet.columns.set_value; //商品利润设置
                     	if(salesSet.columns.set_value=='2'){
                     		msg="该商品是按利润比列提成的（利润 = 实收金额 - 工程师价格）";
                     	}
                     	if(salesSet.columns.set_value=='3'){
                     		msg="该商品是按利润比列提成的（利润 = 实收金额）";
                     	}
                     }
                 	$("#deduType").text(msg);
                 	lingshouways = "1";
                 	//$("#lrWays").show();
                }
				$("#lsdanwei").text(result.columns.unit);
				$("#gCustomerPrice").text(result.columns.customer_price+"元");
				$("#gNumber").text(result.columns.number);
				$("#gName").text(result.columns.name);
				$("#gBrand").text(result.columns.brand);
				$("#gCategory").text(result.columns.category);
				$("#gModel").text(result.columns.model);
				$("#gUnit").text(result.columns.stocks+result.columns.unit);
				if(!isBlank(result.columns.icon)){
					$("#img-view").attr("src","${commonStaticImgPath}"+result.columns.icon.split(',')[0]+"");
				}
				
				$(".lingshou").find("input[name='lnum']").val(result.columns.stocks);
				$(".lingshou").find("input[name='lgoodId']").val(result.columns.id);
				$(".lingshou").find("input[name='lprice']").val(result.columns.customer_price);//零售价格
				$(".lingshou").find("input[name='tichengType']").val(result.columns.deduct_type);//提成方式
				$(".lingshou").find("input[name='tichengPrice']").val(result.columns.normal_deduct_amount);//常规提成金额
				$(".lingshou").find("input[name='tichengJiShu']").val(result.columns.ratio_deduct_radix);//提成比例基数
				$(".lingshou").find("input[name='tichengXiShu']").val(result.columns.ratio_deduct_val);//提成比例系数
				$(".lingshou").find("input[name='ruKuPrice']").val(result.columns.site_price);//入库价格
				$(".lingshou").find("input[name='empPrice']").val(result.columns.employe_price);//工程师价格
				$(".lingshou").find("input[name='rebatePrice']").val(result.columns.rebate_price);//折扣价
				$(".lingshou").find("input[name='lsource']").val(result.columns.source);//商品来源
				$(".lingshou").find("input[name='lsource']").val(result.columns.source);//商品来源icon
				
				$('.dropdown-sin-2').bind('click', function(){ 
					chagesSty();
				})
				$('.lingshou').popup();
			}
		}) */
	}
	
	function chagesSty(){
		var xName = $('#xiaoName').val();
		if($.trim(xName) != "" && xName != null && xName != undefined ){
		    var nameArr = $("#intHtml").find(".dropdown-display").attr("title").split(',');
		    var html = '';
		    var tije = $("#stichengPrice11").val();//总的提成金额
		    var dgtije = (tije/xName.length).toFixed(2);//单个工程师提成金额
		    for(var i=0;i<xName.length;i++){
		    	html+='<div class="f-l mb-10 mr-15 ceshistyle">'+
				    	'<label class="nameTag w-90 f-l ceshistyle_label" title="'+ nameArr[i] +'">'+nameArr[i]+'</label>'+
				    	'<div class="priceWrap f-l bg-fff w-80">'+
						'<input type="text" class="input-text " name="oneTch" value="'+dgtije+'" />'+
						'<span class="unit">元</span>'+
			    		'</div>'+
	    		'</div>'
		    }
	    }
		$("#xsEmployes").empty();
	    $("#xsEmployes").append(html);
	    $(".ceshistyle input[name='oneTch']").blur(function(){
			var allOneTch = 0;
			var oneTch = '';
			var everyMark = "0";
			$("input[name='oneTch']").each(function(index,el){
				var elValue = $(el).val();
				if($.trim(elValue)=="" || elValue==undefined ){
					elValue=0;
				}
				if(!checkMoney(elValue)){
					everyMark = "1";
					return;
				}
				allOneTch=parseFloat(allOneTch)+parseFloat(elValue);
				if(oneTch==''){
					oneTch=elValue;
				}else{
					oneTch=oneTch+","+elValue;
				}
			})
			if(everyMark=="1"){
				layer.msg("工程师提成金额要求大于等于0且最多只能够有两位小数");
				return;
			}
			$("#stichengPrice11").val(allOneTch.toFixed(2));
		})
		$(".ceshistyle input[name='oneTch']").change(function(){
			var allOneTch = 0;
			var oneTch = '';
			var everyMark = "0";
			$("input[name='oneTch']").each(function(index,el){
				var elValue = $(el).val();
				if($.trim(elValue)=="" || elValue==undefined ){
					elValue=0;
				}
				if(!checkMoney(elValue)){
					everyMark = "1";
					return;
				}
				allOneTch=parseFloat(allOneTch)+parseFloat(elValue);
				if(oneTch==''){
					oneTch=elValue;
				}else{
					oneTch=oneTch+","+elValue;
				}
			})
			if(everyMark=="1"){
				//layer.msg("工程师提成金额要求大于等于0且最多只能够有两位小数");
				return;
			}
			$("#commissionsRemarks").val("手动调整工程师提成金额， 本次提成："+allOneTch.toFixed(2)+"元");
			//alert($("#commissionsRemarks").val());
		})
	}
	
	function closeLS(){
		$.closeDiv($(".lingshou"));
		 cshEmpname();
	}
	
	function isInteger(num) {
		var parnt = /^[1-9]\d*(\.\d+)?$/;
        if(!parnt.exec(num)){
            return false;    
        }
        return true;
    }
	
	function checkMoney(mny){
		var reg = /^[1-9]{1}\d*(.\d{1,2})?$|^0.\d{1,2}$/;
		if(parseFloat(mny) == parseFloat(0)){
			return true;
		}else{
			if(reg.test(mny)){
				return true;
			}
		}
		return false;
	}
	
	//计算零售总价及提成金额
	$("input[name='lsNum']").blur(function(){
		 var num=$("input[name='lsNum']").val();//零售数量
		 var tichengType=$("input[name='tichengType']").val();//提成方式
		  if(!isInteger(num)){
			 layer.msg("零售数量要求大于0"); 
			 $("input[name='lsNum']").val('');
			 $("input[name='lsNum']").focus();
			 $("input[name='lsPrice']").val('0');
			 $("input[name='stichengPrice']").val('0');
			 if(tichengType=="2"){
				 $("#ssPrice").val('0');
			 }
			 $(".ceshistyle input[name='oneTch']").each(function (i,n){
		    		$(this).attr('value','0');
		    	}); 
			 return;
		  }
		  var lingshou=$("input[name='lprice']").val();//零售价格
		  var kunum=$("input[name='lnum']").val();//库存数量
		  
		  var tichengPrice=$("input[name='tichengPrice']").val();//提成金额
		  var tichengJiShu=$("input[name='tichengJiShu']").val();//提成比例基数
		  var tichengXiShu=$("input[name='tichengXiShu']").val();//提成比例系数
		  var ruKuPrice=$("input[name='ruKuPrice']").val();//入库价格
		  var empPrice=$("input[name='empPrice']").val();//工程师价格
		  if($.trim(empPrice)=='' || empPrice==null){
			  empPrice=0;
		  }
		  var rebatePrice=$("input[name='rebatePrice']").val();//折扣价
		  var lsource=$("input[name='lsource']").val();//商品来源
		 
		  if(lsource=="1" && parseInt(num)>parseInt(kunum)){
			  layer.msg('库存数量不足！！');
			  return;
		  }else{
			  var zong=lingshou*num;
			  if(rebatePrice!=0.00){
				  zong=rebatePrice*num;
			  }
			  $("input[name='lsPrice']").val(zong);
			 // if(lingshouways=="1"){
			  $("#ssPrice").val(zong);
			  //}
		  }
		  var empTCPrice=0;
		  if(tichengType==1){//常规提成
			  empTCPrice=tichengPrice*num;
			  $("input[name='stichengPrice']").val(empTCPrice);
		  }else if(tichengType==2){//按比例提成
			  var ssje = $("#ssPrice").val();//实收金额
			  var lrje = (ssje-ruKuPrice*num)*tichengXiShu*0.01;
			  var sassionMarks ="比例提成（(实收金额-入库价格)*比列系数*0.01），本次提成："+"("+ssje+"-"+ruKuPrice+"*"+num+")*"+tichengXiShu+"*0.01="+lrje.toFixed(2)+"元";
			  if(tclrWays=="2"){
				  lrje = (ssje-empPrice*num)*tichengXiShu*0.01;
				  sassionMarks = "比例提成（(实收金额-工程师价格)*比列系数*0.01），本次提成："+"("+ssje+"-"+empPrice+"*"+num+")*"+tichengXiShu+"*0.01="+lrje.toFixed(2)+"元";
			  }
			  if(tclrWays=="3"){
				  lrje = (ssje)*tichengXiShu*0.01;
				  sassionMarks = "比例提成（实收金额*比列系数*0.01），本次提成："+ssje+"*"+tichengXiShu+"*0.01="+lrje.toFixed(2)+"元";
			  }
			  $("input[name='stichengPrice']").val(lrje.toFixed(2));
			 // $("#commissionsRemarks").val(sassionMarks);
			  $("#oldCommissionsRemarks").val(sassionMarks);
		  }
		  if(parseFloat(num) > parseFloat(0)){
			  chagesSty();
		  }
	});
	
	
	$("input[name='ssPrice']").blur(function(){
		var ssje = $("#ssPrice").val();
		if($.trim(ssje)=="" || ssje==null){
			layer.msg("实收价格不能为空");
			return;
		}
		if(parseFloat(ssje) == parseFloat(0)){
			
		}else{
			if(!checkMoney(ssje)){
				layer.msg("实收价格要求大于等于0且最多只能够有两位小数");
				return;
			}
		}
		if(lingshouways=="0"){
			return;
		}
		var num=$("input[name='lsNum']").val();//零售数量
		var ruKuPrice=$("input[name='ruKuPrice']").val();//入库价格
		var empPrice=$("input[name='empPrice']").val();//工程师价格
	    if($.trim(empPrice)=='' || empPrice==null){
		    empPrice=0;
	    }
		var tichengXiShu=$("input[name='tichengXiShu']").val();//提成比例系数
		
	    var lrje = (ssje-ruKuPrice*num)*tichengXiShu*0.01;
		var sassionMarks ="比例提成（(实收金额-入库价格)*比列系数*0.01），本次提成："+"("+ssje+"-"+ruKuPrice+"*"+num+")*"+tichengXiShu+"*0.01="+lrje.toFixed(2)+"元";
	    if(tclrWays=="2"){
			  lrje = (ssje-empPrice*num)*tichengXiShu*0.01;
			  sassionMarks = "比例提成（(实收金额-工程师价格)*比列系数*0.01），本次提成："+"("+ssje+"-"+empPrice+"*"+num+")*"+tichengXiShu+"*0.01="+lrje.toFixed(2)+"元";
		  }
	    if(tclrWays=="3"){
			  lrje = (ssje)*tichengXiShu*0.01;
			  sassionMarks = "比例提成（实收金额*比列系数*0.01），本次提成："+ssje+"*"+tichengXiShu+"*0.01="+lrje.toFixed(2)+"元";
		}
	    $("input[name='stichengPrice']").val(lrje.toFixed(2));	
	  //  $("#commissionsRemarks").val(sassionMarks);
	    $("#oldCommissionsRemarks").val(sassionMarks);
	    var tcArr = $(".ceshistyle input[name='oneTch']").val();
	    var leng = $(".ceshistyle input[name='oneTch']").length;
	    var oneTch = (lrje/leng).toFixed(2);
	    $(".ceshistyle input[name='oneTch']").each(function (i,n){
    		$(this).attr('value',oneTch);
    	}); 
	})
	
	function cshEmpname(){
		$("#xsEmployes").empty();
		var html='<span class="f-l  w-370 dropdown-sin-2" >'+
					 '<select class="select-box w-120"  id="xiaoName" multiple="multiple" name="xiaoName"  style="width:140px">'+
					 '<option disabled>网点人员</option>'+
					 '<c:if test="${rd1 ne null }">'+
						'<c:forEach items="${rd1 }" var="rd1">'+
							'<option value="${rd1.columns.uId }">${rd1.columns.name }</option>'+
						'</c:forEach>'+
					 '</c:if>'+
					 '<option disabled>服务工程师</option>'+
					 '<c:if test="${rd2 ne null }">'+
						'<c:forEach items="${rd2 }" var="rd2">'+
							'<option value="${rd2.columns.uId }">${rd2.columns.name }</option>'+
						'</c:forEach>'+
					 '</c:if>'+
					'</select>'+
				'</span>';
		$("#intHtml").html(html);
		$('.dropdown-sin-2').dropdown({
	        input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
	    }); 
	}
	
	//零售操作
	var adpoting = false;
	function doLS(){
		var everyTch = "";
		var tcArr = $(".ceshistyle input[name='oneTch']");
		if(adpoting) {
		    return;
	    }
		var stichengPrice11 = $("input[name='stichengPrice']").val();//提成金额
		var id=$("input[name='lgoodId']").val();
		var userName=$("input[name='userName']").val();
		var mobile=$("input[name='mobile']").val();
		var address=$("input[name='address']").val();
		var lsNum=$("input[name='lsNum']").val();//零售数量
		var lsPrice=$("input[name='lsPrice']").val();//零售总价格
		var xiaoName=$('#xiaoName').val();
		var tichengPrice=$("input[name='stichengPrice']").val();//提成金额
		var lsource=$("input[name='lsource']").val();//商品来源
		var lnum=$("input[name='lnum']").val();//库存数量
		var ssPrice=$("input[name='ssPrice']").val();//实收金额
		var newMark = $("#commissionsRemarks").val();//修改工程师提成金额之后的情况
		var oldMark = $("#oldCommissionsRemarks").val();//理论的算法
		var finalMsg = oldMark;
		if(!isBlank(newMark)){
			finalMsg = "实际上提成方式为："+newMark+"；理论上提成方式为："+oldMark;
		}
		if(isBlank(userName)){
			layer.msg("请输入用户姓名！");
			$("input[name='userName']").focus();
			return;
		}
		if(isBlank(mobile)){
			layer.msg("请输入联系方式！");
			$("input[name='mobile']").focus();
			return;
		}
		/* if(isBlank(address)){
			layer.msg("请输入详细地址！");
			$("input[name='address']").focus();
			return;
		} */
		if(isBlank(lsNum)){
			layer.msg("请输入零售数量！");
			$("#lsNum").focus();
			return;
		}else if(lsource=="1" &&  parseFloat(lsNum)>parseFloat(lnum)){
			layer.msg("该商品库存数量不足！！！请重新输入数量");
			$("#lsNum").focus();
			return;
		}else if(isBlank(xiaoName)){
			layer.msg("请输入销售人员姓名！");
			return;
		}
		var ssje = $("#ssPrice").val();
		if($.trim(ssje)=="" || ssje==null){
			layer.msg("实收价格不能为空");
			return;
		}
		if(parseFloat(ssje) == parseFloat(0)){
			
		}else{
			if(!checkMoney(ssje)){
				layer.msg("实收价格要求大于等于0且最多只能够有两位小数");
				return;
			}
		}
	 	var allEveryTch = 0;
	 	var everyMark  = "0";
		tcArr.each(function(index,el){
			var elValue = $(el).val();
			if($.trim(elValue)=="" || elValue==undefined ){
				elValue=0;
			}
			if(!checkMoney(elValue)){
				everyMark = "1";
				return;
			}
			if(everyTch==""){
				everyTch=elValue;
			}else{
				everyTch=everyTch+","+elValue;
			}
			allEveryTch = parseFloat(allEveryTch)+parseFloat(elValue);
		})
		if(everyMark=="1"){
			layer.msg("工程师提成金额要求大于等于0且最多只能够有两位小数");
			return;
		}
		if(parseFloat(allEveryTch) > parseFloat(tichengPrice)){
			layer.msg("工程师的提成金额总和不得大于订单的提成金额！");
			return ;
		} 
	     adpoting = true;
		 $.ajax({
				type:"POST",
				url : "${ctx}/goods/siteself/doLS",
				data : {
					id : id,
					userName:userName,
					mobile:mobile,
					address:address,
					lsNum:lsNum,
					lsPrice:lsPrice,
					xiaoName:xiaoName,
					tichengPrice:tichengPrice,
					stocks:lnum,
					source:lsource,
					everyTch:everyTch,
					ssPrice:ssPrice,
					commissionsRemarks:finalMsg
				},
				success : function(data) {
					 if(data=="ok"){
						 layer.msg('零售成功！！');
						 $.closeDiv($(".lingshou"));
						 cshEmpname();
						 reloadGrid();
						 return;
					 }else if(data=="full"){
					     layer.msg("该商品库存数量不足！");
					     return;
					 }else if(data=="420"){
					     layer.msg("商品信息有误！");
					     return;
					 }else{
						 layer.msg('零售失败！！');
						 return;
					 }
				},
		        complete: function() {
		            adpoting = false;
		        }
		});   
	}
	
	//显示领用登记信息
	function showLYDJ() {
		var id = getSelectedIds().ids;
		if(isBlank(id)){
			layer.msg("请选择数据！");
			return;
		};
		if(id.split(',').length > 1){
			layer.msg("领取时只能单个商品操作！");
			return;
		}
		if(getSelectedIds().special=='2'){
			layer.msg("浩泽商品暂不支持工程师领取和自购！");
			return;
		}
		var stocks = getSelectedIds().stocks;
		if(parseFloat(stocks)<=parseFloat(0)){//无库存
			layer.msg("该商品库存数量不足！")
			return;
		}
		$.ajax({
			type:"POST",
			url : "${ctx}/goods/siteself/showLYDJ",
			data : {id : id},
			datatype:"json",
			success : function(result) {
				$("#lyNumber").text(result.columns.number);
				$("#lyName").text(result.columns.name);
				$("#lyBrand").text(result.columns.brand);
				$("#lyCategory").text(result.columns.category);
				$("#lyModel").text(result.columns.model);
				$("#ckNumDw").text(result.columns.unit);
				$("#lyUnit").text(result.columns.stocks+result.columns.unit);
				if(!isBlank(result.columns.icon)){
					$("#lyImg").attr("src","${commonStaticImgPath}"+result.columns.icon.split(',')[0]);
				}
				$(".lydji").find("input[name='num']").val(result.columns.stocks);
				$(".lydji").find("input[name='goodId']").val(result.columns.id);
				$(".lydji").popup();
			}
		})
	}
	
	//显示工程师自购信息
	function showLYDJgm() {
		var id = getSelectedIds().ids;
		if(isBlank(id)){
			layer.msg("请选择数据！");
			return;
		};
		if(id.split(',').length > 1){
			layer.msg("自购时只能单个商品操作！");
			return;
		}
		if(getSelectedIds().special=='2'){
			layer.msg("浩泽商品暂不支持工程师领取和自购！");
			return;
		}
		var stocks = getSelectedIds().stocks;
		if(parseFloat(stocks)<=parseFloat(0)){//无库存
			layer.msg("该商品库存数量不足！")
			return;
		}
		$.ajax({
			type:"POST",
			url : "${ctx}/goods/siteself/showLYDJ",
			data : {id : id},
			datatype:"json",
			success : function(result) {
				$("#lyNumbergm").text(result.columns.number);
				$("#lyCustomerPrice").text(result.columns.employe_price+"元");
				$("#lyNamegm").text(result.columns.name);
				$("#lyBrandgm").text(result.columns.brand);
				$("#lyCategorygm").text(result.columns.category);
				$("#lyModelgm").text(result.columns.model);
				$("#ckNumDwgm").text(result.columns.unit);
				$("#lyUnitgm").text(result.columns.stocks+result.columns.unit);
				if(!isBlank(result.columns.icon)){
					$("#lyImggm").attr("src","${commonStaticImgPath}"+result.columns.icon.split(',')[0]);
				}
				$(".lydjigm").find("input[name='numgm']").val(result.columns.stocks);
				$(".lydjigm").find("input[name='goodIdgm']").val(result.columns.id);
				$(".lydjigm").popup();
			}
		})
	}
	
	function closeCKDiv(){
		 $.closeDiv($(".lydji"));
		 cshLy();
	}
	
	function closeCKDivgm(){
		 $.closeDiv($(".lydjigm"));
		 cshLygm();
	}
	
	function cshLy(){
		$("input[name='jkjeMoney']").val('');
		$("input[name='cNum']").val('');
		$("#searchOrgId").val(''); 
		$("#select2-searchOrgId-container").text('请选择');
	}
	
	function cshLygm(){
		$("input[name='jkjeMoneygm']").val('');
		$("input[name='cNumgm']").val('');
		$("#searchOrgIdgm").val(''); 
		$("#select2-searchOrgId-container").text('请选择');
	}
	
	//确认出库
	var adpotin = false;
	function doChuKu(){
		 if(adpotin) {
		    return;
	     }
		 var id=$("input[name='goodId']").val();//商品id
		 var num=$("input[name='num']").val();//库存数量
		 var cnum=$("input[name='cNum']").val();//出库数量
		 var empId=$("select[name='employeName']").val();
		 var jkMoney=$("input[name='jkjeMoney']").val();//交款金额
		 if(isBlank(cnum)){
			 layer.msg('请输入领用数量！！');
			 $("#cNum").focus();
			 return;
		 }else if(cnum<=0){
			 layer.msg('领用数量必须大于0,请重新填写！！');
			 $("#cNum").focus();
			 return;
		 }else if(parseFloat(cnum)>parseFloat(num)){
			 layer.msg('库存数量不足,请重新输入！！');
			 $("#cNum").focus();
			 return;
		 }else  if(isBlank(empId)){
			 layer.msg('请选择工程师！！');
			 return;
		 }
		 if(!isBlank(jkMoney)){
			 if(!checkMoney(jkMoney)){
				 layer.msg("交款金额格式不正确");
				 $("input[name='jkjeMoney']").focus();
				 return;
			 }
		 }
		 adpotin = true;
		 $.ajax({
				type:"POST",
				url : "${ctx}/goods/siteself/doChuKu",
				data : {
					id : id,cnum:cnum,empId:empId,num:num,jkMoney:jkMoney
				},
				success : function(data) {
					 if(data=="ok"){
						 layer.msg('领用成功！！');
						 $.closeDiv($(".lydji"));
						 cshLy();
						 reloadGrid();
						 return;
					 }else if(data=="full"){
					     layer.msg("该商品库存数量不足！");
					     return;
					 }else if(data=="noStocks"){
						 layer.msg('库存数量不足,请重新填写！！');
						 return;
					 }else if(data=="420"){
						 layer.msg('商品信息有误！！');
						 return;
					 }else{
						 layer.msg('领用失败！！');
						 return;
					 }
				},
		        complete: function() {
		            adpotin = false;
		        }
			});
	}
	
	//确认自购出库
	var adpotingm = false;
	function doChuKugm(){
		 if(adpotingm) {
		    return;
	     }
		 var id=$("input[name='goodIdgm']").val();//商品id
		 var num=$("input[name='numgm']").val();//库存数量
		 var cnum=$("input[name='cNumgm']").val();//出库数量
		 var empId=$("select[name='employeNamegm']").val();
		 var jkMoney=$("input[name='jkjeMoneygm']").val();//交款金额
		 if(isBlank(cnum)){
			 layer.msg('请输零售数量！！');
			 $("#cNumgm").focus();
			 return;
		 }else if(cnum<=0){
			 layer.msg('零售数量必须大于0,请重新填写！！');
			 $("#cNumgm").focus();
			 return;
		 }else if(parseFloat(cnum)>parseFloat(num)){
			 layer.msg('库存数量不足,请重新输入！！');
			 $("#cNumgm").focus();
			 return;
		 }else  if(isBlank(empId)){
			 layer.msg('请选择工程师！！');
			 return;
		 }
		 if(!isBlank(jkMoney)){
			 if(!checkMoney(jkMoney)){
				 layer.msg("实收金额格式不正确");
				 $("input[name='jkjeMoneygm']").focus();
				 return;
			 }
		 }else{
			 layer.msg("实收金额格式不正确");
			 $("input[name='jkjeMoneygm']").focus();
			 return;
		 }
		 adpotingm = true;
		 $.ajax({
				type:"POST",
				url : "${ctx}/goods/siteself/doChuKugm",
				data : {
					id : id,cnum:cnum,empId:empId,num:num,jkMoney:jkMoney
				},
				success : function(data) {
					 if(data=="ok"){
						 layer.msg('自购成功！！');
						 $.closeDiv($(".lydji"));
						 cshLygm();
						 reloadGrid();
						 return;
					 }else if(data=="full"){
					     layer.msg("该商品库存数量不足！");
					     return;
					 }else if(data=="noStocks"){
						 layer.msg('库存数量不足,请重新填写！！');
						 return;
					 }else if(data=="420"){
						 layer.msg('商品信息有误！！');
						 return;
					 }else{
						 layer.msg('自购失败！！');
						 return;
					 }
				},
		        complete: function() {
		            adpotingm = false;
		        }
			});
	}
	
	$("input[name='cNum']").blur(function(){
        var num=$("input[name='num']").val();//库存数量
        if(parseFloat($(this).val())>parseFloat(num)){
            layer.msg('库存数量不足,请重新输入！！');
            $(this).val("").focus();
        }
	})
	
	//显示入库弹窗
	function showRuKu() {
		var id = getSelectedIds().ids;
		if(isBlank(id)){
			layer.msg("请选择数据！");
			return;
		};
		if(id.split(',').length > 1){
			layer.msg("入库时只能单个商品操作！");
			return;
		}
		$.ajax({
			type:"POST",
			url : "${ctx}/goods/siteself/showLYDJ",
			data : {id:id},
			datatype:"json",
			success : function(result){
				var allow = result.columns.allowEdit;
				if("ok"==allow){
					layer.msg("该产品只能通过平台订单入库！");
					return;
				}
				$("#rkNumber").text(result.columns.number);
				$("#rkName").text(result.columns.name);
                $("#rPrice").val(result.columns.site_price);
				$("#rkBrand").text(result.columns.brand);
				$("#rkCategory").text(result.columns.category);
				$("#rkModel").text(result.columns.Model);
				$("#rkUnit").text(result.columns.stocks+result.columns.unit);
				if(!isBlank(result.columns.icon)){
					$("#rkImg").attr("src","${commonStaticImgPath}"+result.columns.icon.split(',')[0]);
				}
				$(".ruku").find("input[name='rgoodId']").val(result.columns.id);
				$('.ruku').popup();
			}
		});
	}
	
	//入库动作
	var adpoti = false;
	function doRuKu(){
		 if(adpoti) {
			    return;
		     }
		 var id=$("input[name='rgoodId']").val();//商品id
		 var num=$.trim($("input[name='rNum']").val());//
        var rPrice=$.trim($("input[name='rPrice']").val());//
		 if(isBlank(num)){
			 layer.msg("请输入入库数量！");
			 $("#rNum").focus();
			 return;
		 }else if(num<=0){
			 layer.msg("入库数量必须大于零！");
			 $("#rNum").focus();
			 return;
		 }else if(isBlank(rPrice)){
             layer.msg("请输入入库价格！");
             $("#rPrice").focus();
             return;
		 } else if(parseFloat(rPrice) <= parseFloat(0)){
             layer.msg("入库价格必须大于零！");
             $("#rPrice").focus();
             return;
         }else{
			 adpoti = true;
			 $.ajax({
					type:"POST",
					url : "${ctx}/goods/siteself/doRuKu",
					data : {
						id : id,num:num,rPrice:rPrice
					},
					success : function(data) {
						 if(data=="ok"){
							 layer.msg('入库成功！');
							 $.closeDiv($(".ruku"));
							 reloadGrid();
							 return;
						 }else if(data=="420"){
							 layer.msg('入库失败，商品信息有误，请检查！');
							 return;
						 }else if(data=="421"){
							 layer.msg('入库失败，入库数量要求大于0！');
							 return;
						 }else{
							 layer.msg('入库失败！');
							 return;
						 }
					},
			        complete: function() {
			            adpoti = false;
			        }
				});
		 }
	}
	
	function closeDiv(){
		$.closeDiv($(".ruku"));
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
	
	function closeLsDiv(){
		closeLS();
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
	
	function getSelectedIds(){
		var data = {};
	    var ids = "";
	    var stocks = "";
	    var sellFlag = "";
	    var special = "1";
		$('#detailList .label-cbox').each(function(el,idx){
			var flag = $(this).hasClass('label-cbox-selected');
			if(flag){
				var specialBrand = $(this).find("input[name='specialBrand']").val();
				if(specialBrand=='浩泽'){
					special = "2";
				}
				if(isBlank(ids)){
					ids = $(this).find("input[name='lsId']").val();
					stocks = $(this).find("input[name='lsStocks']").val();
					sellFlag = $(this).find("input[name='lsSellFlag']").val();
				}else{
					ids += ","+ $(this).find("input[name='lsId']").val();
					stocks += ","+ $(this).find("input[name='lsStocks']").val();
					sellFlag += ","+ $(this).find("input[name='lsSellFlag']").val();
				}
			}
		})
		data.ids = ids;
		data.stocks = stocks;
		data.sellFlag = sellFlag;
		data.special = special;
		return data;
	}
</script> 
</body>
</html>