<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
	<meta name="decorator" content="base"/>
<title>系统设置-短信发送设置</title>
</head>
<body>
	<div class="sfpagebg bk-gray pd-10"><div class="sfpage">
		<div class="tabBar cl mb-10">
			<sfTags:pagePermission authFlag="SMSMGM_SIGN_CREATETEMP_TAB" html='<a class="btn-tabBar current" href="${ctx}/order/smstempletSet/headlist">短信模板设置</a>'/>
			<sfTags:pagePermission authFlag="SMSMGM_SIGN_SEND_TAB" html='<a class="btn-tabBar " href="${ctx}/order/commonsetting/getShortmessage">短信发送设置</a>'/>
		</div>
		<div class="cl mt-20">
			<div class="f-l" style="width: 700px;">
				<div class="">
					<label class="w-100 text-r f-l">联系电话：</label>
					<input type="text" class="input-text w-200 f-l readonly" disabled id="smsPhone" value="${site.columns.sms_phone }"/>
					<span class="f-l xiuMobBtn">
						<a href="javascript:updateMobile();" class="sfbtn sfbtn-opt3 w-70  ml-10">修改</a>
					</span>
					<span class="f-l hide detailMobBtn">
						<a class="sfbtn sfbtn-opt3 w-70 ml-10" href="javascript:saveSign();">保存</a>
						<a href="javascript:cancelUpMob();" class="sfbtn sfbtn-opt3 w-70 ml-10">取消</a>
					</span>
				</div>
				<div class="f-l mt-15" style="line-height: 25px">
					<label class=" w-100 text-r f-l">短信签名：</label>
					<input type="text" disabled class="input-text w-200 f-l readonly" id="smsSign"  value="${signInfo.columns.name }"/>
					<span class="f-l xiuBtn">
						<a href="javascript:xiugaiBtn();" class="sfbtn sfbtn-opt3 w-70 f-l ml-10">修改</a>
						<span class="yellow f-l ml-10 ${signInfo.columns.reviewsms_status eq 0 ?'':'hide'}">待第三方短信运营公司审核</span>
						<span class="green f-l ml-10 ${signInfo.columns.reviewsms_status eq 1 ? '':'hide'}">已生效</span>
						<span class="red f-l ml-10 ${signInfo.columns.reviewsms_status eq 2 ? '':'hide'}">审核未通过</span>
					</span>
					<span class="f-l hide detailBtn">
						<a href="javascript:baocun();" class="sfbtn sfbtn-opt3 w-70  ml-10">提交</a>
						<a href="javascript:cancelsub();" class="sfbtn sfbtn-opt3 w-70 ml-10">取消</a>
						<span class="dxTip c-f00 ml-15" style="line-height: 16px;">重新提交后需等待第三方短信运营公司审核通过后才可正常使用。</span>
					</span>
				</div>
			</div>
			<div class="f-r msgNote_">
				<div class="bk-blue-dotted msgNoteBox f-r mr-50" >
					<div class="pos-r pl-60 ">
						<label class="lb">示例：</label>
						<div class="lh-18">
							<span class="c-888 va-t pr-5 ">某女士</span>您好，您的
							<span class="c-888 va-t pr-5 ">空调安装</span>业务
							<span class="c-888 va-t pr-5">某某某服务部</span>已受理，
							<span class="c-888 va-t pr-5 ">张三（13805510551）</span>将为您提供服务，请保持电话畅通，监督电话：
							<span class="c-f55025 va-t pr-5 " id="smsPhoneSame">${site.columns.sms_phone }</span>。
							【<span class="c-f55025 va-t pr-5 pl-5">${signInfo.columns.name}</span>】
						</div>
					</div>
				</div>
			</div>
		</div>
		<p>
			<span class="ml-40 mt-10 mb-10" >
				<a class="fs-12 c-fe0101">
					<img class="mr-5" src="${ctxImg}/plug-in/static/h-ui.admin/images/tip___.png" alt="" style="margin-bottom:3px;display: inline-block;width: 18px;height:18px;vertical-align: middle">使用模板发送短信时需要先设置短信签名并提交给第三方短信运营公司审核，最多可输入8个汉字</a>
			</span>
		</p>
		<div class="mb-10 cl">
			<div class="f-l">
				<a id="btn-add" onclick="openadd()" class="sfbtn sfbtn-opt"><i class="sficon sficon-add"></i>新增模板</a>
			</div>
		</div>
		<form id="searchForm">
			<input type="hidden" name="page" id="pageNo" value="1">
			<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
		</form>
		<div class="">
			<table id="table-waitdispatch" class="table"></table>
			<!-- pagination -->
			<div class="cl pt-10">
				<div class="f-r">
					<div class="pagination"></div>
				</div>
			</div>
			<!-- pagination -->
		</div>
	</div></div>

	<div class="popupBox addMsgModule ">
		<h2 class="popupHead">
			新增短信模板
			<a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer ">
			<div class="popupMain pt-25 pb-20 pr-20" >
				<div class="pos-r pl-80 mb-10">
					<input type="hidden" id="smsid"/>
					<input type="hidden" id="tid"/>
					<input type="hidden" id="createBy"/>
					<input type="hidden" id="createType"/>
					<input type="hidden" id="faildreason"/>
					<label class="w-80 pos">模板名称：</label>
					<input type="text" class="input-text" placeholder="请输入短信模板名称" id="temname"/>
				</div>
				<div class="pos-r pl-80 mb-10">
					<label class="w-80 pos">模板内容：</label>
					<div class="textareaWrap bk-gray">
						<textarea class="textarea2" id="msgTextarea"></textarea>
						<div class="pt-15 cl msgModuleText">
							<span class="f-l ml-10 mr-10 mb-10 c-005aab bg-e7eff5 w-100 text-c lh-26 cPointer" data-text="@1">用户姓名 | @1</span>
							<span class="f-l ml-10 mr-10 mb-10 c-005aab bg-e7eff5 w-100 text-c lh-26 cPointer" data-text="@2">家电品牌 | @2</span>
							<span class="f-l ml-10 mr-10 mb-10 c-005aab bg-e7eff5 w-100 text-c lh-26 cPointer" data-text="@3">家电品类 | @3</span>
							<span class="f-l ml-10 mr-10 mb-10 c-005aab bg-e7eff5 w-100 text-c lh-26 cPointer" data-text="@4">服务类型 | @4</span>
							<span class="f-l ml-10 mr-10 mb-10 c-005aab bg-e7eff5 w-100 text-c lh-26 cPointer" data-text="@5">服务方式 | @5</span>
							<span class="f-l ml-10 mr-10 mb-10 c-005aab bg-e7eff5 w-100 text-c lh-26 cPointer" data-text="@6">工程师姓名 | @6</span>
							<span class="f-l ml-10 mr-10 mb-10 c-005aab bg-e7eff5 w-100 text-c lh-26 cPointer" data-text="@7">工程师电话 | @7</span>
							<span class="f-l ml-10 mr-10 mb-10 c-005aab bg-e7eff5 w-100 text-c lh-26 cPointer" data-text="@8">联系电话 | @8</span>
						</div>
						<p class="c-fe0101 pl-10  pb-10 ">如果短信模板内容是工单中信息，请点击上面系统变量标签加入编辑区域</p>
						<p class="c-fe0101 pl-10  pb-10 ">注意：请勿在内容中添加短信签名</p>
					</div>
				</div>
				<p class="pl-80">示例：<span class="c-888">@1 您好，您报修的 @2 @3 @4 工单服务已完成，请对本次服务进行评价，谢谢！@8 </span></p>
				<div class="text-c pt-30">
					<a href="javascript:save();" class="sfbtn sfbtn-opt3 w-70 mr-5">保存</a>
					<a href="javascript:guanbi();" class="sfbtn sfbtn-opt w-70 ">关闭</a>
				</div>
			</div>
		</div>
	</div>
<script>
    var sfGrid;
    var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
    var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
    $(function(){
        $.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
        $.tabfold("#moresearch",".moreCondition",1,"click");
        initSfGrid();
    });

    //初始化jqGrid表格，传递的参数按照说明
    function initSfGrid(){
        sfGrid = $("#table-waitdispatch").sfGrid({
            url : '${ctx}/order/smstempletSet/getsmslist',
            sfHeader: defaultHeader,
            sfSortColumns: sortHeader,
            multiselect: false,
            shrinkToFit: true,
            rownumbers : true,
            gridComplete:function(){
                _order_comm.gridNum();
            },
            loadComplete:function(){
                $('.ui-jqgrid-bdiv').css('max-height','calc(100vh - 310px)')
            }
        });
    }

    function updateMobile(){
        $(".xiuMobBtn").addClass("hide");
        $(".detailMobBtn").removeClass("hide");
        $("#smsPhone").removeClass("readonly");
        $("#smsPhone").attr("disabled", false);
	}
    function cancelUpMob(){
        $(".xiuMobBtn").removeClass("hide");
        $(".detailMobBtn").addClass("hide");
        $("#smsPhone").addClass("readonly");
        $("#smsPhone").attr("disabled", true);
	}

    window.onload=function (ev) {
        $('.ui-jqgrid-bdiv').css('max-height','calc(100vh - 310px)')
    }
    $('.msgModuleText').on('click','span',function(){
        var msgTextarea = document.getElementById('msgTextarea');
        insertAtCursor(msgTextarea,$(this).attr('data-text'));
    })

    function search(){
        var pageSize = $("#pageSize").val();
        if ($.trim(pageSize) == '' || pageSize == null) {
            $("#pageSize").val(20);
        }
        $("#table-waitdispatch").sfGridSearch($("#searchForm").serializeJson());
    }

    function insertAtCursor(myField, myValue) {
        if (document.selection){
            myField.focus();
            sel= document.selection.createRange();
            sel.text = myValue;
            sel.select();
            //  console.log(sel.text);
        }else if (myField.selectionStart || myField.selectionStart == '0') {
            var startPos = myField.selectionStart;
            var endPos = myField.selectionEnd;
            // save scrollTop before insert
            var restoreTop = myField.scrollTop;
            myField.value = myField.value.substring(0, startPos) + myValue + myField.value.substring(endPos, myField.value.length);
            if (restoreTop > 0){
                myField.scrollTop = restoreTop;
            }
            myField.focus();
            myField.selectionStart = startPos + myValue.length;
            myField.selectionEnd  = startPos + myValue.length;
            //  console.log(2);
        } else {
            myField.value += myValue;
            myField.focus();
            //   console.log(3);
        }
    }

    function fmtOper(rowData){
        var html = "";
        if (rowData.reviewsms_status != '1') {
            html += "<span><a class='c-0383dc' onclick=editOne('"+rowData.id+"') ><i class='sficon sficon-edit'></i>修改</a></span>&nbsp;&nbsp;&nbsp;";
        }
        html += "<span><a class='c-0383dc' onclick=delOne('"+rowData.id+"') ><i class='sficon sficon-del'></i>删除</a></span>";
        return html;
    }

    function statusOper(rowData){
        if(rowData.reviewsms_status=='0'){
            return "<span>待审核</span>";
        }else if(rowData.reviewsms_status=='1'){
            return "<span>已生效</span>";
        }else{
            return "<span>审核未通过</span>";
        }
    }

    function createtimefmt(rowDate) {
        if (rowDate.create_time != null) {
            var timenew = rowDate.create_time.substring(0, 16);
            return "<span>" + timenew + "</span>";
        } else {
            return "<span></span>";
        }
    }
    function contentOper(rowData){
        var newcontent = rowData.content;
        while(newcontent.indexOf('@1') >= 0){
            newcontent = newcontent.replace("@1","<span class='c-0383dc'>#用户姓名#</span>");
        }
        while(newcontent.indexOf('@2') >= 0){
            newcontent = newcontent.replace("@2","<span class='c-0383dc'>#家电服务#</span>");
        }
        while(newcontent.indexOf('@3') >= 0){
            newcontent = newcontent.replace("@3","<span class='c-0383dc'>#家电品类#</span>");
        }
        while(newcontent.indexOf('@4') >= 0){
            newcontent = newcontent.replace("@4","<span class='c-0383dc'>#服务类型#</span>");
        }
        while(newcontent.indexOf('@5') >= 0){
            newcontent = newcontent.replace("@5","<span class='c-0383dc'>#服务方式#</span>");
        }
        while(newcontent.indexOf('@6') >= 0){
            newcontent = newcontent.replace("@6","<span class='c-0383dc'>#工程师姓名#</span>");
        }
        while(newcontent.indexOf('@7') >= 0){
            newcontent = newcontent.replace("@7","<span class='c-0383dc'>#工程师电话#</span>");
        }
        while(newcontent.indexOf('@8') >= 0) {
            newcontent = newcontent.replace("@8", "<span class='c-0383dc'>#联系电话#</span>");
        }
        return "<span>"+newcontent+"</span>";
    }

    function openadd(){//打开添加弹出框
        $("#temname").val("");
        $("#msgTextarea").val("");
        $('.addMsgModule').popup();
    }

    var saveflag = false;
    function save(){
        if(saveflag){
            return
        }
        var id = $("#smsid").val();
        var number=$("#tid").val();
        var name = $("#temname").val();
        var content = $("#msgTextarea").val();
        var regex = /\[|\]|【|】/g;

        if(name==""||name==null){
            layer.msg("请填写模板名称");
            return
        }
        if(content==""||content==null){
            layer.msg("请填写模板内容");
            return;
        }
        if(content.match(regex)){
            layer.msg("短信中不能包含中括号");
            return;
        }

        saveflag=true;
        $.ajax({
            type:'POST',
            url:"${ctx}/order/smstempletSet/saveSms",
            data:{
                "id":id,
                "name":name,
                "content":content,
                "number":number
            },
            success:function(data){
                if(data.code=="201"){
                    window.top.layer.msg("模板名称已存在");
                    $("#temname").focus;
                    saveflag=false;
                    return;
                }
                if(data.code=="203"){
                    window.top.layer.msg(data.msg);
                    saveflag=false;
                    return;
				}
                if(data.code=="ok1"){
                    window.top.layer.msg("添加成功");
                    window.location.reload(true);
                    $.closeDiv($(".addMsgModule"));
                }else if(data=="faild"){
                    layer.msg("添加失败请稍后重试或待审核通过重试");
                    return;
                } else if(data.code=="ok2"){
                    window.top.layer.msg("修改成功");
                    window.location.reload(true);
                    $.closeDiv($(".addMsgModule"));
                }else{
                    window.top.layer.msg("操作失败请稍后重试");
                    return;
                }
                $("#smsid").val("");
                $("#temname").val("");
                $("#msgTextarea").val("");
                $("#tid").val("");
                $("#createBy").val("");
                $("#createType").val("");
                $("#faildreason").val("");
                saveflag=false;
            },
            error:function(){
                layer.alert("系统繁忙!");
                return;
            }
        })
    }

    function delOne(id){
        $.ajax({
            type:'POST',
            url:"${ctx}/order/smstempletSet/delete",
            data:{
                "id":id,
            },
            success:function(data){
                if(data=="ok"){
                    window.top.layer.msg("删除成功");
                    window.location.reload(true);
                }else{
                    window.top.layer.msg("删除失败");
                    return;
                }
            },
            error:function(){
                window.top.layer.alert("系统繁忙!");
                return;
            }
        })
    }

    function editOne(id) {
        $.ajax({
            type:'POST',
            url:"${ctx}/order/smstempletSet/getByid",
            data:{
                "id":id,
            },
            success:function(data){
                if(data!=null){
                    var contents = data.columns.content;
                    var newcontents = contents.replace("【"+'${siteSign.columns.sms_sign}'+"】","");
                    $("#smsid").val(data.columns.id);
                    $("#temname").val(data.columns.name);
                    $("#msgTextarea").val(newcontents);
                    $("#tid").val(data.columns.number);
                    $("#createBy").val(data.columns.create_by);
                    $("#createType").val(data.columns.create_type);
                    $("#faildreason").val(data.columns.failed_reason);
                    $('.addMsgModule').popup();
                }else{
                    layer.msg("操作失败请稍后重试");
                    return;
                }
            },
            error:function(){
                layer.alert("系统繁忙!");
                return;
            }
        })
    }

    function guanbi() {
        $.closeDiv($('.addMsgModule'));
    }

    /*------------------------手机号-----签名----------------------------------*/
	//修改手机号
    var norepeatSubSign = false;
    function saveSign() {
        if(norepeatSubSign) {
            return;
        }
        var smsPhone=$("#smsPhone").val();
        if(isBlank(smsPhone)){
            layer.msg("请输入联系方式！");
            return;
		}
        var pattern = /^[0-9\-]{6,20}$/;
        if(!smsPhone.match(pattern)){
            layer.msg("联系方式格式不正确");
            $("#smsPhone").focus();
            return;
        }
        norepeatSubSign = true;
        $.ajax({
            type:'POST',
            url:'${ctx}/order/smsSignSet/updatePhone',
            dataType:'json',
            data:{"smsPhone":smsPhone},
            success:function(result){
                if(result){
                    layer.msg("保存成功");
                    window.location.reload(true);
                }else{
                    layer.msg("保存失败");
                    return;
                }
            },
			complete:function(){
                norepeatSubSign = false;
			}
        })

    }
    //修改签名
    var norepeatS = false;
    function baocun(){
        if(norepeatS){
            return;
		}
        norepeatS = true;
        var smsSign=$("#smsSign").val();
        //var pattern = /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$|(^(1[0-9])\d{9}$)/;
        if(!(smsSign.match(/[\u4e00-\u9fa5]/)&&smsSign.length<=8)){
            layer.msg("签名最多只能输入8个中文");
            $("#smsSign").focus();
            return;
        }

        $.ajax({
            type:'POST',
            url:'${ctx}/order/smsSignSet/smsSignUpdate',
            dataType:'json',
            data:{"smsSign":smsSign},
            success:function(result){
                if(result.code=="0"){
                    window.top.layer.msg("保存成功");
                    window.location.reload(true);
                }else{
                    window.top.layer.msg(result.msg);
                }
            },
            complete:function(){
                norepeatS = false;
            }
        })
    }

    function xiugaiBtn() {
        $("#smsSign").removeClass("readonly");
        $("#smsSign").attr("disabled", false);

        $(".xiuBtn").addClass("hide");
        $(".detailBtn").removeClass("hide");
    }
    function cancelsub(){
        $("#smsSign").addClass("readonly");
        $("#smsSign").attr("disabled", true);
        $(".xiuBtn").removeClass("hide");
        $(".detailBtn").addClass("hide");
	}
    
    function isBlank(val) {
        if(val==null || val=='' || val == undefined) {
            return true;
        }
        return false;
    }
</script>

</body>
</html>