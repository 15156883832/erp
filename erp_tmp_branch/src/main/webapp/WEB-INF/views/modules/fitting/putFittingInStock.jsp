<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>备件库存管理-修改备件</title>
	<meta name="decorator" content="base"/>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
	<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
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
			background:none;
			color:#22a0e6;
			padding:0;

		}
		/* .spimg1{ border:none;} */
		.spimg1 .webuploader-pick{
			width:134px;
			height:134px;
		}
		.spimg2 .webuploader-pick{
			width:80px;
			height:80px;
		}

		.webuploader-pick img{
			width:100%;
			height:100%;
			position:absolute;
			left:0;
			top:0;
		}
	</style>
</head>
<body>
<!-- 修改备件 -->
<div class="popupBox addbjbox" style="width: 835px;">
	<h2 class="popupHead">
		确认入库
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<form id="tf" action="" method="post">
		<div class="popupContainer pos-r">
			<div class="popupMain">
				<div class="cl mb-10">
					<label class="f-l w-80"><em class="mark"></em>条码：</label>
					<input type="text" class="input-text w-160 readonly f-l" readonly="readonly" id="fittingCode" value="${fa.fittingCode}"/>
					<label class="f-l w-100"><em class="mark"></em>名称：</label>
					<input type="text w-160" class="input-text w-160 readonly f-l" readonly="readonly" id="fittingName" value="${fitting == null ? fa.fittingName : fitting.name }"/>
					<label class="f-l w-100"><em class="mark"></em>型号：</label>
					<input type="text w-160" class="input-text w-160 readonly f-l" readonly="readonly" value="${fitting == null ? fa.fittingVersion : fitting.version }"/>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-80"><em class="mark"></em>计划数量：</label>
					<input type="text" class="input-text w-160  f-l readonly" readonly="readonly" id="planNum" value="${empty applyPlan.planNum ? fa.fittingApplyNum:applyPlan.planNum}"/>
					<%--<label class="f-l w-100"><em class="mark"></em>计划来源：</label>
					<input type="text w-160" class="input-text w-160  f-l readonly" readonly="readonly" value="${applyPlan.source eq 0 ? '自购':'厂家'}"/>--%>
					<label class="f-l w-100"><em class="mark"></em>计划时间：</label>
					<input type="text" name="planTime" id="planTime" value="<fmt:formatDate value="${applyPlan.planTime}" pattern="yyyy-MM-dd"/>" class="input-text f-l w-160 readonly" readonly="readonly">
					<label class="f-l w-100"><em class="mark"></em>计划申请人：</label>
					<input type="text" name="planTime"   class="input-text f-l w-160 readonly" readonly="readonly" value="${applyPlan.planApplicant}">
				</div>
				<div class="cl mb-10">
					<label class="f-l w-80"> 备注：</label>
					<textarea class="textarea h-50 " style="width: 680px;" id="planMarks">${applyPlan.marks}</textarea>
				</div>
				<div class="cl mb-10">

				</div>
				<div class="text-c ">
					<input type="hidden" id="applyPlanId" value="${applyPlan.id}"/>
					<input type="hidden" id="id" value="${fa.id}"/>
					<input type="hidden" id="fittingId" value="${fa.fittingId}"/>
					<a href="javascript:doPutInStock();" class="sfbtn sfbtn-opt3 w-70 ">确认入库</a>
					<a href="javascript:close();" class="sfbtn sfbtn-opt w-70 ">取消</a>
				</div>
			</div>
		</div>
	</form>
</div>
<script type="text/javascript">
    //点击取消，关闭弹窗
    function close() {
        $.closeDiv($(".addbjbox"));
    }

    $(function () {
        $(".addbjbox").popup();
    });

    /*入库*/
    var putInStock=false;
    function doPutInStock(){
        if(putInStock){
            return;
        }
        var applyId=$("#id").val();
        var fittingId=$("#fittingId").val();
        var fittingName=$("#fittingName").val();
        var fittingCode=$("#fittingCode").val();
        var applyPlanId=$("#applyPlanId").val();
        var planNum=$("#planNum").val();
        var planMarks=$("#planMarks").val();

        if(isBlank(fittingId) && isBlank(fittingCode)){
            layer.msg("该备件不存在,无法入库！");
            return;
		}

        var content = "您确认"+fittingName+"("+fittingCode+")入库*"+planNum+"吗？";
        $('body').popup({
            level:3,
            type:2,
            title:"入库",
            content:content,
            fnConfirm :function(){
                putInStock=true;
                $.ajax({
                    type: "POST",
                    url: "${ctx}/fitting/stock/putInStock",
                    data: {
                        fittingId: fittingId,
                        applyPlanId:applyPlanId,
                        planNum:planNum,
                        fittingCode:fittingCode,
                        planMarks:planMarks
                    },
                    dataType: "text",
                    success: function (data) {
                        if(data=="203"){
                            layer.msg("该备件不存在，无法入库！");
						}else{
                            parent.layer.msg("入库成功！");
                            parent.search();
                            close();
                        }
                    },
                    complete:function(){
                        putInStock=false;
                    }
                });
            }
        });
    }


    function isBlank(val) {
        return (val == null || val == '' || val == undefined);
    }

</script>
</body>
</html>