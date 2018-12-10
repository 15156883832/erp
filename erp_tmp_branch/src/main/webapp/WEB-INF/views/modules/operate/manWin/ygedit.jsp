<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<meta http-equiv="Cache-Control" content="no-siteapp" />

<title>运营管理-添加员工</title>
<meta name="decorator" content="base" />
<link rel="stylesheet" type="text/css"
	href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css" />
<script type="text/javascript"
	src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
<script type="text/javascript"
	src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
	
	<style type="text/css">
		.errorwran{
			display: none;
		}
		.Validform_wrong{
			display: block;
		}
		.Validform_right{
			display: none;
		}
	</style>
	<style type="text/css">
 	.webuploader-pick{
		background:#fff;
		padding:0;
		color: #0e8ee7; 
	} 
	
	/* .spimg1{ border:none;} */
.spimg1 .webuploader-pick{
	width:134px;
	height:134px;
}
</style>
</head>
<body>
	<!-- 添加 -->
	<div class="popupBox staffbox addStaddbox">
		<h2 class="popupHead">
			编辑员工 <a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<form id="tf" action="${ctx}/operate/nonServiceman/doBJ" method="post">
		<div class="popupContainer">
			<div class="popupMain ">
			<input type="hidden" id="empId" name="id" value="${record.columns.id }"/>
			<input type="hidden" name="uId" value="${record.columns.uId }"/>
			<input type="hidden" name="roleName" value="${pre.columns.site_role_name }"/>
				<h3 class="modelHead mb-10">
					<span class="f-l">基本资料 </span> 
					<p id="empTip" class="c-f55025 f-l lh-26 ml-30">默认手机号为工程师登陆app的用户名和密码</p>
				</h3>
				<div class="cl">
					<div class="f-r mr-20">
						<label class="text-r w-80 f-l">头像：</label>
						<c:if test="${empty record.columns.img  || record.columns.img=='null'}">
							<div class="imgbox f-l pos-r spimg1" id="spimg1">
								<img  id="img-view"/>
								<a href="javascript:;" class="btn-uploadimg uploading1" ></a>
								<input class="ignoreSepcial" type="hidden" name="img" id="img-input">
							</div>
							<div style="margin-left: 80px;margin-top: 100px;"  class="up text-c w-100" >
								<a href="javascript:;" class="btn-uploadimg " id="img-picker">上传图片</a>	
							</div>
						</c:if>
						<c:if test="${not empty record.columns.img && record.columns.img != 'null'}">
							<div class="imgbox f-l pos-r spimg1" id="spimg1">
								<img src="${commonStaticImgPath}${record.columns.img}" alt="" id="img-view"/>
								<input class="ignoreSepcial" type="hidden" name="img" id="img-input">
							</div>
							<div style="margin-left: 80px;margin-top: 100px;"  class="up text-c w-100" >
								<a href="javascript:;" class="btn-uploadimg " id="img-picker">重新上传</a>	
							</div>
						</c:if>
					</div>
					
					<div class="f-l" style="width:470px" >
						<div class="f-l w-220">
							<div class="f-l mb-10">
								<label class="f-l w-80 text-r"><em class="mark">*</em>姓名：</label>
								<c:if test="${record.columns.user_type eq '4' }">
								<input type="text" class="input-text f-l w-140  readonly" readonly="readonly" name="name" id="name" datatype="*" nullmsg="请输姓名" value="${record.columns.name }" />
								</c:if>
								<c:if test="${record.columns.user_type eq '3' }">
								<input type="text" class="input-text f-l w-140 mustfill "  name="name" id="name" datatype="*" nullmsg="请输姓名" value="${record.columns.name }" />
								</c:if>
							</div>
							<div class="f-l" >
								<label class="f-l w-80 text-r"><em class="mark">*</em>手机号：</label>
								<input type="text" class="input-text f-l w-140 mustfill" name="mobile" id="mobile" datatype="number" nullmsg="请输入手机号"  value="${record.columns.mobile }"/> 
							</div>
						</div>
						<div class="f-l w-220">
							<div class="f-l mb-10 " id="loginNumWrap">
								<label class="f-l w-80 text-r"><em class="mark">*</em>登陆账号：</label>
								<input type="text" class="input-text f-l w-140 mustfill " name="loginName1" id="loginName1" value="${record.columns.login_name }" datatype="*" nullmsg="请输入登陆账号" />
							</div> 
							<div class="f-l">
								<label class="f-l w-80 text-r">入职时间：</label> 
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'bookdatemax\')||\'%y-%M-%d\'}'})"
									id="bookdatemax" name="bookdatemax" value="${record.columns.hiredate }" class="input-text Wdate w-140 f-l">
							</div>
						</div>
					</div>
					
					
					
					<%-- <div class="f-l mb-10">
						<label class="f-l w-80 text-r"><em class="mark">*</em>姓名：</label>
						<input type="text" class="input-text f-l w-140 " name="name" id="name" datatype="*" nullmsg="请输姓名" value="${record.columns.name }"/>
						<p class="errorwran"></p> 
					</div>
					<div class="f-l">
						<label class="f-l w-80 text-r"><em class="mark">*</em>手机号：</label>
						<input type="text" class="input-text f-l w-140 " name="mobile" id="mobile" datatype="number" nullmsg="请输入手机号"  value="${record.columns.mobile }"/> 
						<label class="f-l w-90 text-r">入职时间：</label> 
						<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'bookdatemax\')||\'%y-%M-%d\'}'})"
							id="bookdatemax" name="bookdatemax" value="${record.columns.hiredate }"
							class="input-text Wdate w-140 f-l" name="hiredate">
					</div>
					<c:if test="${record.columns.user_type eq '4' }">
						<div class="pl-80">
							<p class="c-f55025">默认为app登录账号和密码</p>
						</div>
					</c:if> --%>
					<div class="f-l mb-5 mt-5" style="width:470px" >
						<input type="hidden" name="userType" value="${record.columns.user_type }"/>
						<label class="f-l w-80 text-r"><em class="mark">*</em>岗位：</label>
						<div class="f-l pt-5">
							<c:if test="${record.columns.user_type eq '3' }">
								<label class="f-l mr-10 radiobox radiobox-selected" id="wang">
								<input type="radio" name="job" id="branchStaff" value="1"/>公司人员 </label> 
							</c:if>
							<c:if test="${record.columns.user_type eq '4' }">
								<label class="f-l radiobox radiobox-selected" id="yuan">
								<input type="radio" name="job" id="engineer" value="2"/>服务工程师 </label>
							</c:if>
						</div>
					</div>
					<c:if test="${record.columns.user_type eq '4' }">
						<div class="f-l mb-10" style="width:470px" >
							<label class="f-l w-80" ><em class="mark">*</em>工资系数：</label>
							<input type="text" name="ratio" class="input-text f-l w-140"  id="ratio" value="${ratio }" />
							<em class="mark">工资系数大于0小于或等于1且仅有一位小数</em>
						</div>
						<div class="f-l mb-10" style="width:470px;" id="jsxscome">
						<label class="f-l w-80" >工号：</label>
						<input type="text" name="workNo" class="input-text f-l w-140" id="workNo" value="${record.columns.work_no }" onchange="workNO()"/>
						<label class="f-l w-80" >身份证号：</label>
						<input type="text" name="idCard" class="input-text f-l w-140" id="idCard" value="${record.columns.id_card }" onchange="idCard1()"/>
					</div>
					</c:if>
				</div>
				<div class="cl mb-10 hide" id="addressBox">
					<label class="f-l w-80 text-r">现居住地址：</label> <span
						class="select-box w-90 "> <select class="select"
						id="province" name="province">
							<c:forEach items="${fns:getProvinceList() }" var="pro">
								<c:if test="${pro.columns.ProvinceName eq site.columns.province }">
									<option value="${pro.columns.ProvinceName } " selected="selected">${pro.columns.ProvinceName }</option>
								</c:if>
								<c:if test="${pro.columns.ProvinceName ne site.columns.province }">
									<option value="${pro.columns.ProvinceName }">${pro.columns.ProvinceName }</option>
								</c:if>
							</c:forEach>
					</select>
					</span> <span class="select-box w-90 "> <select class="select"
						id="city" name="city">
							<c:forEach items="${fns:getCityList(site.columns.province) }" var="city">
								<c:if test="${city.columns.CityName eq site.columns.city }">
									<option value="${city.columns.CityName }" selected="selected">${city.columns.CityName }</option>
								</c:if>
								<c:if test="${city.columns.CityName ne site.columns.city }">
									<option value="${city.columns.CityName }">${city.columns.CityName }</option>
								</c:if>
							</c:forEach>
					</select>
					</span> 
					<span class="select-box w-90 "> 
						<select class="select" id="area" name="area">
							<c:forEach items="${fns:getDistrictList(site.columns.city) }" var="area">
								<c:if test="${area.columns.DistrictName eq site.columns.area }">
									<option value="${area.columns.DistrictName }" selected="selected">${area.columns.DistrictName }</option>
								</c:if>
								<c:if test="${area.columns.DistrictName ne site.columns.area }">
									<option value="${area.columns.DistrictName }">${area.columns.DistrictName }</option>
								</c:if>
							</c:forEach>
						</select>
					</span> 
						<input type="text" class="input-text w-260 mustfill " name="address"
						id="customerAddress1" placeholder="详细地址" datatype="*"
						errormsg="格式错误" nullmsg="请输入详细地址" value="${record.columns.address }"/> 
						<!-- <input type="hidden" class="input-text w-260 " name="address"
						id="customerAddress" placeholder="详细地址" datatype="*"
						errormsg="格式错误" nullmsg="请输入详细地址" /> -->
					<p class="errorwran">请输入详细地址</p>
					<input type="hidden" name="customerLnglat"  readonly="true" id="lnglat" />
				</div>

				<c:if test="${record.columns.user_type eq '3' }">
					<div id="authorityBox">
						<h3 class="modelHead mb-10">账号权限</h3>
						<div class="cl mb-10">
							<label class="f-l w-80 text-r"><em class="mark">*</em>用户名：</label>
							<input type="text" class="input-text f-l w-140 mustfill" name="loginName" id="loginName" nullmsg="请输入用户名" value="${record.columns.login_name }"/> 
							<label class="f-l w-90 text-r"><em class="mark">*</em>设置密码：</label> 
							<input type="password" class="input-text f-l w-140 mustfill" name="password" id="password" nullmsg="请设置密码" value="default"/>
						</div>
						<div class="cl mb-10">
							<label class="f-l w-80 text-r"><em class="mark">*</em>角色权限：</label>
							<div class="f-l mt-5">
								<label class="f-l mr-15 label-cbox4 ${fns:checkSiteRoleById('1', relPremission) ? "label-cbox4-selected":""} ">
									<input type="checkbox" name="roleIdList" value="1" ${fns:checkSiteRoleById('1', relPremission) ? "checked='checked'":""} />信息员
								</label> 
								<label class="f-l mr-15 label-cbox4 ${fns:checkSiteRoleById('2', relPremission) ? "label-cbox4-selected":""}">
									<input type="checkbox" name="roleIdList" value="2" ${fns:checkSiteRoleById('2', relPremission) ? "checked='checked'":""}/>配件员 
								</label> 
								<label class="f-l mr-10 label-cbox4 ${fns:checkSiteRoleById('3', relPremission) ? "label-cbox4-selected":""}">
									<input type="checkbox" name="roleIdList" value="3" ${fns:checkSiteRoleById('3', relPremission) ? "checked='checked'":""}/>财务人员
								</label>
								<c:forEach var ="pre" items="${listPremission }">
									<c:if test="${!empty pre and pre.columns.sys_role_id != '1' and pre.columns.sys_role_id != '2' and pre.columns.sys_role_id != '3' }">
										<label class="f-l mr-10 label-cbox4 ${fns:checkSiteRoleById(pre.columns.id, relPremission) ? "label-cbox4-selected":""}">
											<input type="checkbox" name="roleIdList" value="${pre.columns.id}" ${fns:checkSiteRoleById(pre.columns.id, relPremission) ? "checked='checked'":""}/>${pre.columns.site_role_name}
										</label>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</div>
				</c:if>
				<div id="brandCate">
					<div class="tabBarP">
						<a class="tabswitch">授权品类</a>
						<a class="tabswitch">授权品牌</a>
					</div>
					<div class="tabCon pt-10">
						<div class="table-serverbrand cl"  id="categoryList">
							<c:forEach var="cate" items="${cateList }">
								<input type="hidden" id="cateName" value="cateName">
								<a href="javascript:;" class="serveb-label mr-10 f-l mb-5 cs"  onclick="delCate(this)">${cate}</a>
							</c:forEach>
							<div id="cateqz" class="f-l">
								<a href="javascript:;" class="f-l lh-26" onclick="addCate()"><i class="sficon sficon-add3 " ></i>添加</a>
							</div>
						</div>
					</div>
					<div class="tabCon pt-10 ">
						<div  class="table-serverbrand cl" id="brandList">
							<c:forEach items="${brandList}" var="brand" >
								<input type="hidden" id="brandName" value="brandName">
								<a href="javascript:;" class="serveb-label mr-10 f-l mb-5 bs"  onclick="delBrand(this)">${brand}</a>
							</c:forEach>
							<div id="brandqz" class="f-l">
								<a href="javascript:;" class="f-l lh-26" onclick="addBrand()"><i class="sficon sficon-add3 " ></i>添加</a>
							</div>
						</div>
					</div>
				</div>





					<div id="catelist2">
						<h3 class="modelHead mb-10">服务品类</h3>
						<div class="cl">
							<label class="f-l mr-15 mb-10 serveb-label " for="servebrandAll">
								<input type="checkbox" name="servebrand1"  id="servebrandAll" />全部
							</label>
							<c:forEach var="list" items="${listCategory }">
								<label title="${list.columns.name }" style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;" class="f-l mr-15 mb-10 serveb-label ${fns:strInCollection(list.columns.id, selectedCategory) ? "serveb-labelSel":""} ">
									<input type="checkbox"  name="servebrand" value="${list.columns.id }" ${fns:strInCollection(list.columns.id, selectedCategory) ? "checked='checked'":""}/>${list.columns.name }
								</label>
							</c:forEach>
						</div>
					</div>

				</div>
				<input type="hidden" name="cates" readonly="true" id="cates" />
				<input type="hidden" name="brands" readonly="true" id="brands" />
			<input type="hidden" name="catesgcs" readonly="true" id="catesgcs" />
				<div class="text-c mt-20 mb-5">
					<a href="javascript:submitForm();" class="sfbtn sfbtn-opt3 w-70 mr-5" id="Butfitting">保存</a> <a
						href="javascript:closeDiv();" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
				</div>
			</div>

		</div>
		</form>
	</div>

	<div class="popupBox porigin addCate" >
		<h2 class="popupHead">
			新增
			<a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer pos-r">
			<div class="popupMain pd-15">
				<div class="pcontent" id="catebox" >
					<div class="cl mb-10 obox">
						<label class="f-l " ><em class="mark">*</em>家电品类名称：</label>
						<input type="text" class="input-text w-140 f-l  Catename"  name="lab" />
						<a href="javascript:;" class="sficon sficon-reduce2 f-l mt-3 ml-5" onclick="delcates(this)"  style="display: none;" ></a>
						<a href="javascript:;" class="sficon sficon-add2 f-l mt-3 ml-5 " onclick="addcates(this)"></a>
					</div>

				</div>
				<div class="text-c">
					<a class="sfbtn sfbtn-opt3 w-70 mr-5" id="SaveCate">保存</a>
					<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5"  onclick="closesCate()">取消</a>
				</div>
			</div>

		</div>
	</div>


	<div class="popupBox porigin addBrand" >
		<h2 class="popupHead">
			新增
			<a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer pos-r">
			<div class="popupMain pd-15">
				<div class="pcontent" id="brandbox" >
					<div class="cl mb-10 obox">
						<label class="f-l " ><em class="mark">*</em>家电品牌名称：</label>
						<input type="text" class="input-text w-140 f-l  Brandname"  name="lab" />
						<a href="javascript:;" class="sficon sficon-reduce2 f-l mt-3 ml-5" onclick="delbrands(this)"  style="display: none;" ></a>
						<a href="javascript:;" class="sficon sficon-add2 f-l mt-3 ml-5 " onclick="addbrands(this)"></a>
					</div>

				</div>
				<div class="text-c ">
					<a class="sfbtn sfbtn-opt3 w-70 mr-5" id="SaveBrand">保存</a>
					<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5"  onclick="closesBrand()">取消</a>
				</div>
			</div>

		</div>
	</div>
	<div class="loadBg" id="loadBg"></div>
	<script type="text/javascript">
	var curJob = eval('${record.columns.user_type eq 3 ? 1 : 2 }');
	var oldLoginname = '${record.columns.login_name }';
	var oldMobile='${record.columns.mobile }';
	var chwoNo = false;
	var idCardN = false;
    $(function() {
        if('${tabType}'=='1'){
            $("#brandCate").hide();
            $("#catelist2").show();
        }else{
            $("#brandCate").show();
            $("#catelist2").hide();
        }
    });

    //验证工号是否唯一
    function workNO(){
    	var woNo = $("#workNo").val();
    	if(!isBlank(woNo)){
    		$.ajax({
				type:"post",
				url:"${ctx}/operate/nonServiceman/checkWorkNo",
				data:{
					workNo: woNo,
				},
				success:function(data){
					chwoNo = data;
					if(data){
						layer.msg("工号已存在!");
						$("#workNo").focus();
					}
				}
			});
    	}else{
    		chwoNo = false;
    	}
   
    }
    //验证身份证是否唯一
    function idCard1(){
    	var idCardNo = $("#idCard").val();
    	if(!isBlank(idCardNo)){
    		$.ajax({
				type:"post",
				url:"${ctx}/operate/nonServiceman/checkidCard",
				data:{
					idCard: idCardNo,
				},
				success:function(data){
					idCardN = data;
					if(data){
						layer.msg("身份证号已存在!");
					}
				}
			});
    	}else{
    		idCardN = false;
    	}
   
    }
    
    
    function checks(obj){
        if(obj.hasClass("serveb-labelSel")){
            obj.removeClass("serveb-labelSel")
		}else{
            obj.attr("class","serveb-labelSel")
		}
	}
    function delbrands(obj){
        var oParent = $('#brandbox');
        $(obj).parent('div').remove();

        var childLenth = oParent.children().size();
        oParent.children().eq(childLenth-1).find('a.sficon-add2').show();

        if( childLenth == 1){
            oParent.children().eq(0).find('a.sficon-reduce2').hide();
        }
        //addScrollb();
        $.setPos($('.addOrigin'));
    }


    function delcates(obj){
        var oParent = $('#catebox');
        $(obj).parent('div').remove();

        var childLenth = oParent.children().size();
        oParent.children().eq(childLenth-1).find('a.sficon-add2').show();

        if( childLenth == 1){
            oParent.children().eq(0).find('a.sficon-reduce2').hide();
        }
        //addScrollc();
        $.setPos($('.addOrigin'));
    }
    function addScrollc(){
        var oDiv = $('#catebox');
        var aBoxs = $(oDiv).find('.obox');
        if(aBoxs.length>10){
            $(oDiv).parent('.popupMain').css({'overflow':'auto','height':'340px'});
        }else{
            $(oDiv).parent('.popupMain').css({'overflow':'auto','height':'auto'});
        }
    }
    function addCate(){
        $('.addCate').popup({fixedHeight: false,level:2});

    }

    function addBrand(){
        $('.addBrand').popup({fixedHeight: false,level:2});
    }
    function delCate(obj){
        $(obj).remove();
        //$("#cateqz #"+name).remove(this);
    }
    function delBrand(obj){
        $(obj).remove();
        //$("#brandqz #"+name).remove(this);
    }
    function closesCate(){
        $(".Catename").val("");
		$(".addcatebox").remove();
        var oParent = $('#catebox');

        var childLenth = oParent.children().size();
        oParent.children().eq(childLenth-1).find('a.sficon-add2').show();

        if( childLenth == 1){
            oParent.children().eq(0).find('a.sficon-reduce2').hide();
        }
        $.closeDiv($(".addCate"));
    }
    function closesBrand(){
        $(".Brandname").val("");
        $(".addbrandbox").remove();
        var oParent = $('#brandbox');

        var childLenth = oParent.children().size();
        oParent.children().eq(childLenth-1).find('a.sficon-add2').show();

        if( childLenth == 1){
            oParent.children().eq(0).find('a.sficon-reduce2').hide();
        }
        $.closeDiv($(".addBrand"));
    }

    function addcates(obj){
        var oParent = $('#catebox');
        var html = '<div class="cl mb-10 addcatebox obox">'+
            '<label class="f-l "><em class="mark">*</em>家电品类名称：</label>'+
            '<input type="text" class="input-text w-140 f-l Catename" name="lab"  />'+
            '<a href="javascript:;" class="sficon sficon-reduce2 f-l mt-3 ml-5" onclick="delcates(this)" ></a>'+
            '<a href="javascript:;" class="sficon sficon-add2 f-l mt-3 ml-5 " onclick="addcates(this)"></a>'+
            '</div>';
        oParent.append(html);
        $(obj).hide();
        $(obj).prev('a.sficon-reduce2').show();
        addScrollc();
        $.setPos($('.addCate'));
    }

    function addbrands(obj){
        var oParent = $('#brandbox');
        var html = '<div class="cl mb-10 addbrandbox obox">'+
            '<label class="f-l "><em class="mark">*</em>家电品牌名称：</label>'+
            '<input type="text" class="input-text w-140 f-l Brandname" name="lab"  />'+
            '<a href="javascript:;" class="sficon sficon-reduce2 f-l mt-3 ml-5" onclick="delbrands(this)" ></a>'+
            '<a href="javascript:;" class="sficon sficon-add2 f-l mt-3 ml-5 " onclick="addbrands(this)"></a>'+
            '</div>';
        oParent.append(html);
        $(obj).hide();
        $(obj).prev('a.sficon-reduce2').show();
        addScrollb();
        $.setPos($('.addBrand'));
    }

    $("#SaveCate").click(function () {
        var nameArr = [];
        var names = $(".Catename");
        var nameflag = false;
        var repeatname = false;
        names.each(function (indx, el) {
            nameArr[indx] = $.trim($(el).val());
            if (nameArr[indx].length == 0) {
                nameflag = true;
                layer.msg("请填写家电品类名称");
            }
        });
        if ( nameflag) {
            return;
        }
        var s = nameArr.join(",") + ",";
        var nary=nameArr.sort();
        for (var i = 0; i < nameArr.length; i++) {
            if (nary[i]==nary[i+1]){
                repeatname = true;
                layer.msg("名称有重复");
                break;
            }
       /*     if (s.replace(nameArr[i] + ",", "").indexOf(nameArr[i] + ",") > -1) {
                repeatname = true;
                layer.msg("名称有重复");
                break;
            }*/
            if(nameArr[i].indexOf(",")>-1){
                repeatname = true;
                layer.msg(nameArr[i]+"含有非法字符“,”")
				break;
			}
        }
        if (repeatname) {
            return;
        }
        var html="";
        for (var i = 0; i < nameArr.length; i++) {
            html +=' <input type="hidden" id="'+nameArr[i]+'" value="'+nameArr[i]+'">' +
                '<a href="javascript:;" title="'+nameArr[i]+'" style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;"  class="serveb-label mr-10 f-l mb-5 cs"  onclick="delCate(this)">'+nameArr[i]+'</a>'
        }
        $("#cateqz").before(html);
        $(".Catename").val("");
        $(".addcatebox").remove();
        var oParent = $('#catebox');

        var childLenth = oParent.children().size();
        oParent.children().eq(childLenth-1).find('a.sficon-add2').show();

        if( childLenth == 1){
            oParent.children().eq(0).find('a.sficon-reduce2').hide();
        }
        $.closeDiv($(".addCate"));

    });



    $("#SaveBrand").click(function () {
        var nameArr = [];
        var names = $(".Brandname");
        var nameflag = false;
        var repeatname = false;
        names.each(function (indx, el) {
            nameArr[indx] = $.trim($(el).val());
            if (nameArr[indx].length == 0) {
                nameflag = true;
                layer.msg("请填写家电品牌名称");
            }
        });
        if ( nameflag) {
            return;
        }
        var s = nameArr.join(",") + ",";
        var nary=nameArr.sort();
        for (var i = 0; i < nameArr.length; i++) {
            if (nary[i]==nary[i+1]){
                repeatname = true;
                layer.msg("名称有重复");
                break;
            }
            if(nameArr[i].indexOf(",")>-1){
                repeatname = true;
                layer.msg(nameArr[i]+"含有非法字符“,”")
                break;
            }
        }
        if (repeatname) {
            return;
        }
        var html="";
        for (var i = 0; i < nameArr.length; i++) {
            html += ' <input type="hidden" id="'+nameArr[i]+'" value="'+nameArr[i]+'">'+
                '<a href="javascript:;" class="serveb-label mr-10 f-l mb-5 bs" title="'+nameArr[i]+'" style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;"   onclick="delBrand(this)">'+nameArr[i]+'</a>'
        }
        $("#brandqz").before(html);
        $(".Brandname").val("");
        $(".addbrandbox").remove();
        var oParent = $('#brandbox');

        var childLenth = oParent.children().size();
        oParent.children().eq(childLenth-1).find('a.sficon-add2').show();

        if( childLenth == 1){
            oParent.children().eq(0).find('a.sficon-reduce2').hide();
        }
        $.closeDiv($(".addBrand"));

    })
		$(function() {
			$('.addStaddbox').popup();
            $.Huitab("#brandCate .tabBarP .tabswitch","#brandCate .tabCon","current","click","0");
			//$("#categoryList").hide();
			var thumbnailWidth = 130;   //缩略图高度和宽度 （单位是像素），当宽高度是0~1的时候，是按照百分比计算，具体可以看api文档  
			var thumbnailHeight = 130; 
			uploader = WebUploader.create({
			       // 选完文件后，是否自动上传。 
			       auto: true,  
			       swf: '${ctxPlugin}/lib/webuploader/0.1.5/Uploader.swf',  
			       server: '${ctx}/common/uploadFile',		       
			       duplicate:true,
			       fileSingleSizeLimit:1024*1024*5,
			       pick: '#img-picker',  
			       accept: {
			    	    title: 'Images',
			    	    extensions: 'gif,jpg,jpeg,bmp,png',
			    	    mimeTypes: 'image/gif,image/jpg,image/jpeg,image/bmp,image/png'
			       },  
			       method:'POST'
			   }); 
			   uploader.on("error",function (type){
			   		if (type=="Q_TYPE_DENIED"){ 
				   		layer.alert("请上传JPG、PNG格式文件");
				   }else if(type=="F_EXCEED_SIZE"){
					   layer.alert("文件大小不能超过5M"); 
					}
			   });
			   uploader.on('beforeFileQueued', function(file){
				   uploader.reset();
			   });
			   uploader.on( 'uploadSuccess', function( file, response ) {
				   $("#img-view").attr("src",'${commonStaticImgPath}'+response.path);
				   $("#img-input").val(response.path);
				   $(".uploading1").remove();
			   });
			  
			   uploader.on( 'fileQueued', function( file ) {
				   uploader.makeThumb( file, function( error, src ) {
					   if (error) {
						    layer.msg('不能预览');
					   }
				}, thumbnailWidth, thumbnailHeight );
			});


			$("#name").blur(function(){
				var name=$.trim($("#name").val());
				if (!name) {
					return;
				}
				var job=$(".radiobox-selected").children().val();//人员角色（1.网点人员2.服务工程师）
				if(job == '2') {
					$.ajax({
						type:"post",
						url:"${ctx}/operate/nonServiceman/checkEmpName",
						data:{
							empName: name,
							empId: $("#empId").val()
						},
						dataType:"text",
						success:function(data){
							if(data=="fail"){
								layer.msg("服务工程师姓名已存在!");
//								$("#name").focus();
							}
						}
					});
				}
			});

		});
		
		$(function(){
			var job=$(".radiobox-selected").children().val();//人员角色（1.网点人员2.服务工程师）
			if(job == '1'){
				$("#empTip").hide();
				$("#loginNumWrap").addClass('hide');
			}
		})
		function closeDiv(){
			$.closeDiv($(".addStaddbox")); 
		}
		
		function isBlank(val) {
			if (val == null || $.trim(val) == '' || val == undefined) {
				return true;
			}
			return false;
		}
		
		
		function CheckPassWord(password) {//必须为字母加数字且长度不小于8位
			   var str = password;
			   if ((str.length < 4) || (str.length > 16) ) {
			        return false;
			    } 
			   var reg1 = new RegExp(/^[a-zA-Z0-9]{4,16}$/);
			    if (!reg1.test(str)) {
			        return false;
			    }
			}
		
		//
		function submitForm(){
			var ratio = $("#ratio").val();
			var loginName = $("#loginName").val();
			var loginName1 = $("#loginName1").val();
			var mobile=$("#mobile").val();
			var job=$(".radiobox-selected").children().val();//人员角色（1.网点人员2.服务工程师）
			var cates = [];
			var cate1s="";
			$(".serveb-labelSel [name='servebrand']").each(function(index,el){
				cates[index] = $(el).val();
			});
			if(cates.length>0){
				cate1s = cates.join(",");
			}
            if (!isPhoneNo(mobile)) {
                layer.msg("手机号格式不正确");
                return;
            }
			$("#catesgcs").val(cate1s);
			//var result = checkFormSpecialChar2("#tf");
			if(job=="2"){
				if(isBlank(loginName1)){
					layer.msg("请输入登陆账号!");
					$("#loginName1").focus();
					return ;
				}else{
					if(CheckPassWord(loginName1)==false){
						layer.msg("请输入正确的登陆账号!");
						$("#loginName1").focus();
						return ;
					}
				}
				if($.trim(ratio)=="" || ratio==null ){
					layer.msg("工资结算系数不能为空！");
					$("#ratio").focus();
					return;
				}
				if(parseFloat(ratio) <= parseFloat("0") || parseFloat(ratio) > parseFloat("1")){
					layer.msg("工资结算系数要求大于0小于或者等于1！");
					$("#ratio").focus();
					return;
				}
				if(!checkNums(ratio)){
					layer.msg("工资结算系数只能含有一位小数！");
					$("#ratio").focus();
					return;
				}
			}
			/* if(!result){
				layer.msg("输入框包含特殊字符,请重新输入!");
				return ;
			}
			result = validateAddForm(); */
            var catesArr =[];
            var brandArr =[];
            var cates = $(".cs");
            var brands = $(".bs");
            cates.each(function (indx, el) {
                catesArr[indx] = $(el).text();
            });
            brands.each(function (indx, el) {
                brandArr[indx] = $(el).text();
            });
            if(!mm(catesArr)){
                layer.msg("品类名有重复");
                return false;
            }
            if(!mm(brandArr)){
                layer.msg("品牌名有重复");
                return false;
            }
            $("#cates").val(catesArr);
            $("#brands").val(brandArr);
			var postData = $("#tf").serializeJson(); 
			if(curJob == 1){
				if(!(postData.roleIdList != null && postData.roleIdList.length > 0)){
					layer.msg("请选择角色权限!");
					return ;
				}
				chwoNo = false;
				idCardN = false;
			}
            if(chwoNo){
                layer.msg("工号已存在！");
                return ;
            }
            if(idCardN){
                layer.msg("身份证号已存在！");
                return ;
            }
			if(hasSpecialChar($.trim($("#name").val()))){
				layer.msg("姓名中含有特殊字符，请重新输入！");
				$("#name").focus();
				return ;
			}
			
			 if(chwoNo){
                 layer.msg("工号已存在！");
                 $("#workNo").focus();
                 return ;
             }
			
			if(hasSpecialChar($.trim($("#customerAddress1").val()))){
				layer.msg("详细地址中含有特殊字符，请重新输入！");
				$("#customerAddress1").focus();
				return ;
			}
			
			if(job=="1"){
				if(hasSpecialChar($.trim($("#loginName").val()))){
					layer.msg("用户名中含有特殊字符，请重新输入！");
					$("#loginName").focus();
					return ;
				}
				if(hasSpecialChar($.trim($("#password").val()))){
					layer.msg("设置密码中含有特殊字符，请重新输入！");
					$("#password").focus();
					return ;
				}
			}
			
			//if(result){
				$.ajax({
	 				type:"post",
	 				url:"${ctx}/operate/nonServiceman/checkMobile",
	 				data:{
	 					mobile:mobile,job:job,loginName:loginName,oldLoginname:oldLoginname,oldMobile:oldMobile,loginName1:loginName1 
	 				},
	 				dataType:"text",
	 				success:function(data){
	 					if(data=="empUser"){
	 						 layer.msg("该登陆账号已存在!");
	 						 $("#loginName1").focus();
	 						 return;
	 					 }else if(data=="no"){
	 						 layer.msg("该手机号已存在!");
	 						 $("#mobile").focus();
	 						 return;
	 					 }else if(data=="login"){
		 						layer.msg("该用户名已存在!");
		 						$("#loginName").focus();
		 						return;
	 					 }else{
	 						<%--$.post("${ctx}/operate/nonServiceman/doBJ", $("#tf").serializeJson(), function(result){--%>
	 							<%--parent.location.reload();// = "${ctx}/operate/WholeServiceManHeader";--%>
	 							<%--closeDiv();--%>
	 						<%--});--%>
							 $.ajax({
								 url: "${ctx}/operate/nonServiceman/doBJ",
								 data: $("#tf").serializeJson(),
								 type: 'post',
								 success: function(data) {
									 if(data == 'empNameDup') {
										 layer.msg("工程师姓名已存在！");
									 } else {
										// parent.location.reload();
										parent.search();
										parent.layer.msg("修改成功!");
										 closeDiv();
									 }
								 }
							 });
	 					 }
	 				}
	 			});
				
			//}
		}
		
		function validateAddForm(){
			if(isEmptyVal($("#name").val())){
				layer.msg("请输入姓名!");
				$("#name").addClass("mustfill");
				return false;
			}else{$("#name").removeClass("mustfill");}
			if(!isPhoneNo($("#mobile").val())){
				layer.msg("请输入正确的手机号!");
				$("#mobile").addClass("mustfill");
				return false;
			}else{$("#mobile").removeClass("mustfill");}
			if(curJob == 1){
				if(isEmptyVal($("#loginName").val())){
					layer.msg("请输入用户名!");
					$("#loginName").addClass("mustfill");
					return false;
				}else{$("#loginName").removeClass("mustfill");}
				if(isEmptyVal($("#password").val())){
					layer.msg("请输入密码!");
					$("#password").addClass("mustfill");
					return false;
				}else{$("#password").removeClass("mustfill");}
			}
			return true;
		}
		
		window.onload=function(){
			var ty=$("input[name='userType']").val();
			if(ty==4){
				$("#wang").removeClass('radiobox-selected');
				$("#yuan").addClass('radiobox-selected');
				$('#addressBox').show();
				$('#authorityBox').hide();

				
			}else{
				$("#wang").addClass('radiobox-selected');
				$("#yuan").removeClass('radiobox-selected');
				$('#addressBox').hide();
				$('#authorityBox').show();

				
			}
		} 
		
		$('input[name="servebrand"]').click(
				function(ev) {
					if ($(this).is(':checked')) {
						$(this).parent('label').addClass('serveb-labelSel');
					} else {
						$(this).parent('label').removeClass('serveb-labelSel');
					}
					if ($(this).attr('id') == 'servebrandAll') {
						if ($(this).is(':checked')) {
							$('input[name="servebrand1"]').parent('label')
									.addClass('serveb-labelSel');
						} else {
							$('input[name="servebrand1"]').parent('label')
									.removeClass('serveb-labelSel');
						}
					}
				});
		
		$('input[name="servebrand1"]').click(
				function() {
					if ($(this).is(':checked')) {
						$(this).parent('label').addClass('serveb-labelSel');
					} else {
						$(this).parent('label').removeClass('serveb-labelSel');
					}
					if ($(this).attr('id') == 'servebrandAll') {
						if ($(this).is(':checked')) {
							$('input[name="servebrand"]').parent('label')
									.addClass('serveb-labelSel');
						} else {
							$('input[name="servebrand"]').parent('label')
									.removeClass('serveb-labelSel');
						}
					}
				});

		/* $('input[name="sex"]').bind(
				'click',
				function() {
					$('input[name="sex"]').parent('label').removeClass(
							'radiobox-selected');
					$(this).parent('label').addClass('radiobox-selected');
				}) */
		$('input[name="job"]').bind(
				'click',
				function() {
					$('input[name="job"]').parent('label').removeClass(
							'radiobox-selected');
					$(this).parent('label').addClass('radiobox-selected');
					if ($(this).attr('id') == 'branchStaff') {
						$('#addressBox').hide();
						$('#authorityBox').show();
						//$("#categoryList").hide();
						curJob = 1;
					} else {
						$('#addressBox').show();
						$('#authorityBox').hide();
						$("#categoryList").show();
						curJob = 2;
					}
				})

		$('input[name="roleIdList"]').bind('click', function() {
			if ($(this).is(':checked')) {
				$(this).parent('label').addClass('label-cbox4-selected');
			} else {
				$(this).parent('label').removeClass('label-cbox4-selected');
			}
		});

	
		
	// 选择省获取市
	$("#province").change(function(){
	       var province = $("#province").val();
	 		if(!isEmptyVal(province)){
	 			$.ajax({
	 				type:"post",
	 				url:"${ctx}/operate/nonServiceman/getCity",
	 				data:{
	 					province:province
	 				},
	 				dataType:"json",
	 				success:function(data){
	 					var obj = eval(data);
	 					 var length = obj.length;
	 					 if(length<1){
	 						layer.msg("无数据");
	 					 }else{
	 						$("#city").empty();
	 						$("#area").empty();
	 					var HTML = " ";	
	 					for(var i=0; i < length; i++)
	 					{
	 						if(i==0){
	 						HTML += '<option value="'+obj[i].columns.CityName+'" selected="selected">'+obj[i].columns.CityName+'</option>';
	 						}else{
	 						HTML += '<option value="'+obj[i].columns.CityName+'">'+obj[i].columns.CityName+'</option>';
	 						}
	 					}
	 					
	 					$("#city").append(HTML); 
	 					 }
	 				}
	 			});
	 		}
		});
	// 选择市获取区县
	$("#city").blur(function(){
	       var city = $("#city").val();
	 		if(!isEmptyVal(city)){
	 			$.ajax({
	 				type:"post",
	 				url:"${ctx}/operate/nonServiceman/getArea",
	 				data:{
	 					city:city
	 				},
	 				dataType:"json",
	 				success:function(data){
	 					var obj = eval(data);
	 					 var length = obj.length;
	 					 if(length<1){
	 						layer.msg("无数据");
	 					 }else{
	 						
	 						$("#area").empty();
	 					var HTML = " ";	
	 					for(var i=0; i < length; i++)
	 					{
	 						if(i==0){
	 						HTML += '<option value="'+obj[i].columns.DistrictName+'" selected="selected">'+obj[i].columns.DistrictName+'</option>';
	 						}else{
	 						HTML += '<option value="'+obj[i].columns.DistrictName+'" >'+obj[i].columns.DistrictName+'</option>';
	 						}
	 					}
	 					
	 					$("#area").append(HTML); 
	 					 }
	 				}
	 			});
	 		}
		});

	$('#spimg1').imgShow();
	
	function checkFormSpecialChar2(formId){
		var result = true;
		$(formId).find("input[type != 'hidden']").each(function(){
			var val = $(this).val();
			if(!$(this).hasClass("ignoreSepcial") && hasSpecialChar(val)){
				$(this).addClass("mustfill");
				result = false;
			}else{
				$(this).removeClass("mustfill");
			}
		});
		return result;
	}
	
	function checkSpecialChars(val){
		var result = true;alert(!hasSpecialChar(val));
		if(!hasSpecialChar(val)){
			result = false;
		}
	}
	
	function checkNums(num){
		var reg = /^(1|0\.\d{1,1})$/;
		if(num=="1" || num=="1.0"){
			return true;
		}
		if(num=="0.0"){
			return false;
		}
		if(reg.test(num)){
			return true;
		}
		return false;
	}


    function mm(a) {
        var errorflag = true;
        var nary=a.sort();
        for (var i = 0; i < a.length; i++) {
            if (nary[i] == nary[i + 1]) {
                errorflag = false;
                break;
            }
        }
        return errorflag;
    }
    function isPhoneNo(phone) {
        var pattern = /^1\d{10}$/;
        return pattern.test(phone);
    }
	</script>
</body>
</html>