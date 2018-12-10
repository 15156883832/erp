<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>工单录入</title>
<meta name="decorator" content="base"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
<style type="text/css">
/* .webuploader-pick{
	background:#fff;
	padding:0;
	color: #0e8ee7;
} */
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
<!-- 审核申请 -->
<div class="popupBox shsqbox" >
	<h2 class="popupHead">
		审核申请
		<a href="javascript:;" class="sficon closePopup" id="topOne"></a>
	</h2>
	<div class="popupContainer pb-40">
		<div class="popupMain pos-r">
			<div class="pcontent">
			<div class="cl mb-5">
				<label class="f-l">&#12288;二级网点：</label>
				<input type="text" class="input-text w-140 readonly f-l"  readonly="readonly" value="${siteName }" />
				<label class="f-l">&#12288;申请人：</label>
				<input type="text" class="input-text w-140 readonly f-l"  readonly="readonly" value="${fa.applicantName }" />
				<label class="f-l w-90">申请时间：</label>
				<input type="text" class="input-text w-140 readonly f-l" readonly="readonly" value="<fmt:formatDate value='${fa.createTime }' pattern='yyyy-MM-dd HH:mm:ss'/>"/>
			</div>
			<h3 class="modelHead mb-10">
				备件信息
			</h3>
			<div class="cl mb-10">
				<div class="f-l w-400">
					<div class="f-l mb-10">
						<label class="f-l">备件条码：</label>
						<input type="hidden" value="${fa.id }" id="id"/>
						<input type="hidden" value="${fa.applyFittingId }" id="fittingId"/>
						<input type="text" class="input-text w-130 f-l readonly" value="${fa.applyFittingCode }" readonly="readonly"  id="fittingCode"/>
						<input type="hidden" value="${fa.applyFittingCode }" id="fittingCode1"/>
						<label class="w-90 f-l">备件名称：</label>
						<input type="text" class="input-text w-110 f-l readonly" readonly="readonly" value="${fa.applyFittingName }" id="fittingName"/>
					</div>

					<div class="f-l mb-10">
						<label class="f-l">备件型号：</label>
						<input type="text" class="input-text w-130 f-l readonly" readonly="readonly" value="${fa.applyFittingVersion}" id="fittingVersion"/>
						<label class="w-90 f-l">适用品类：</label>
						<input type="text" class="input-text w-110 f-l readonly" readonly="readonly" value="${fa.suitCategory }" id="suitCategory"/>
					</div>
					<div class="f-l mb-10">
						<label class="f-l">家电型号：</label>
						<div class=" w-130 f-l readonly">
							<input type="text" class="input-text readonly" readonly="readonly" value="${fa.suitMode }" />
						</div>
						<label class="w-90 f-l">申请数量：</label>
						<div class="priceWrap w-110 f-l readonly">
							<input type="text" class="input-text readonly" readonly="readonly" value="${fa.applyFittingNum }" />
							<span class="unit">件</span>
						</div>
					</div>
					<div class="f-l mb-10">
						<label class="f-l">当前库存：</label>
						<div class="priceWrap w-130 f-l readonly">
							<input type="text" class="input-text readonly" readonly="readonly" value="${ft.columns.warning }" id="fittingWarning"/>
							<span class="unit">件</span>
						</div>
						<label class="w-90 f-l">审核数量：</label>
						<div class="priceWrap w-110 f-l">
							<input type="text" class="input-text"  id="fittingAuditNum" value="${fa.auditFittingNum == null ? fa.applyFittingNum : fa.auditFittingNum  }"/>
							<span class="unit">件</span>
						</div>
					</div>
					<div class="f-l mb-10">
						<label class="f-l">返还旧件：</label>
						<select class="select w-130" id="oldFittingFlag">
							<c:choose>
								<c:when test="${fa.oldFittingFlag eq '0' }">
									<option value="">请选择</option>
									<option value="0" selected="selected">无需返还</option>
									<option value="1">需要返还</option>
								</c:when>
								<c:when test="${fa.oldFittingFlag eq '1' }">
									<option value="">请选择</option>
									<option value="0">无需返还</option>
									<option value="1" selected="selected">需要返还</option>
								</c:when>
								<c:otherwise>
									<option value="">请选择</option>
									<option value="0">无需返还</option>
									<option value="1">需要返还</option>
								</c:otherwise>
							</c:choose>
						</select>

					</div>
					<div class="f-l mb-10">
						<label class="f-l">申请备注：</label>
						<input type="text" class="input-text f-l readonly w-330 " readonly="readonly"   id="" value="${fa.applicantFeedback}" title=""/>
					</div>
					<div class="f-l">
						<label class="f-l">审核备注：</label>
						<textarea class="input-text w-330 f-l h-50" id="auditMarks" name="employeFeedback">${fa.auditMarks}</textarea>
						<%--<input type="text" class="input-text f-l  w-330 h-50"   id="auditMarks" value="${fa.auditMarks}" title=""/>--%>
					</div>
				</div>
				<div class="f-r mb-10 w-260 " id="spimg1">
					<label class="f-l">图片：</label>
					<div class="f-l" style="width:220px">
						<c:forEach items="${ftImg}" var="item">
							<c:if test="${item != null && item != ''}">
								<div class="imgbox f-l mr-10 mb-10 spimg1">
									<img src="${commonStaticImgPath}${item}" />
								</div>
							</c:if>
						</c:forEach>
					</div>
					<c:if test="${fa.applyFittingImg == null || fa.applyFittingImg ==''}">
						<div class="f-l" style="width:220px">
							<div class="imgbox f-l mr-10 mb-10 ">
								<img src="${ctxPlugin}/static/h-ui.admin/images/img-default.png" />
							</div>
						</div>
					</c:if>
				</div>
			</div>
			
			<%-- <div class="sqfkbox pt-10">
				<div class="h-50 bk-gray ">
					<p class="notetxt c-666">暂无申请反馈内容，如需反馈请点击申请反馈按钮</p>
					<c:forEach var="pros" items="${fns:getFittingProcess(fa.message)}">
					<c:set value="${pros.name }" var="name"></c:set>
							<p>
								<span class="time">${pros.time}</span>
								<span> ${pros.name}</span>
								<span> ：${pros.content}</span>
							</p>
				    </c:forEach>
				    <input type="hidden" value="${name}" id="nametest" />
				</div>

			</div> --%>
		</div>
		</div>
		<div class="text-c btnWrap ">
			<a href="javascript:adoptFittingApply();" class="sfbtn sfbtn-opt3 w-70 mr-5">通过</a>
			<a href="javascript:refuseFittingApply1();" class="sfbtn sfbtn-opt w-70 mr-5">拒绝</a>
			<a href="javascript:savezjfd();" class="sfbtn sfbtn-opt w-70">保存</a>
		</div>

	</div>
</div>

<!-- 拒绝 -->
<div class="popupBox shfkbox shfkboxjj">
	<h2 class="popupHead">
		拒绝
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pd-20">
			<textarea class="textarea" placeholder="请输入拒绝理由" id="reason"></textarea>
			<div class="text-c mt-25">
				<a href="javascript:refuseFittingApply();" class="sfbtn sfbtn-opt3 w-70 mr-5">发送</a>
				<a href="javascript:closeDivApp1();" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
			</div>
			
		</div>
	</div>
</div>

<script type="text/javascript" src="${ctxPlugin}/lib/layer/2.4/layer.js"></script>
<script type="text/javascript">
	var ck = /^\d+(\.\d+)?$/;
	var exit="ok";

	function closeDivApp(){
		$.closeDiv($('.shfkboxfk'));	
	}
	function closeDivApp1(){
		$.closeDiv($('.shfkboxjj'));	
	}
	$(function(){
		$.Huitab("#detialWd .tabBarP .tabswitch","#detialWd .tabCon","current","click","0");
		$.Huitab("#serveFb .tabBarP .tabswitch","#serveFb .tabCon","current","click","0");
		$.Huitab("#fbSettle .tabBarP .tabswitch","#fbSettle .tabCon","current","click","0");
		
		$('.shsqbox').popup({fixedHeight:false});
		
		$('#fittingAuditNum').blur(function () {
			var fittiNum = $("#fittingAuditNum").val();
			var ficount = $("#fittingWarning").val();
			if (isBlank(fittiNum)) {
				layer.msg("请输入审核数量");
			} else if(ck.test(fittiNum)){
			    if(parseFloat(fittiNum)>parseFloat(ficount)){
			    	layer.msg("库存数量不足");
			    }
			}else{
				layer.msg("申请数量大于0");
			}
		});
		
		//检验条码是否存在并带出相应的信息
		$('#fittingCode').change(function () {
			var code = $("#fittingCode").val();
			if (!isBlank(code)) {
				$.ajax({
					type: "POST",
					url: "${ctx}/fitting/getfitting",
					data: {code:code},
					dataType: "json",
					success: function (data) {
						var obj = eval('data');
						if (obj.co == '1') {
							$("#fittingId").val(obj.record.columns.id);
							$("#suitCategory").val(obj.record.columns.suit_category);
							$("#oldFittingFlag").val(obj.record.columns.refund_old_flag);
							$("#fittingVersion").val(obj.record.columns.version);
							$("#fittingName").val(obj.record.columns.name);
							
							maxpj = parseFloat(obj.record.columns.warning);
							if (maxpj <= 0) {
								layer.msg('该配件已无库存');
								$("#fittingWarning").val(0);
							}else{
								$("#fittingWarning").val(obj.record.columns.warning);
							}
						} else {
						    // 配件条码不存在的时候，领导决定不清空已经有的信息。
							layer.msg("该条码配件不存在");
							exit = "no";
						}
					}
				});
			} else {
				layer.msg("请输入配件条码");
			}
		});
		
		// 如果申请反馈内容不为空则隐藏提示文字
		var name = $("#nametest").val();
		if(!isBlank(name)){
			$(".notetxt").hide();
		}
		
		var codename = '${fa.applyFittingCode }';
		checkExistsByFittingCode(codename);
	});

    function checkExistsByFittingCode(code) {
        if (!isBlank(code) && $("#fittingId").val().length == 0) {
            $.ajax({
                type: "POST",
                url: "${ctx}/fitting/getfitting",
                data: {code: code},
                dataType: "json",
                success: function (data) {
                    var obj = eval('data');
                    if (obj.co == '1') {
                    } else {
                        $("#fittingWarning").val("");
                    }
                }
            });
        }
    }

    $("#topOne").on("click",function(){
		parent.search();
	});
	
	function isBlank(val) {
		if(val==null || val=='' || val == undefined) {
			return true;
		}
		return false;
	}
	var adpoting = false;
    function savezjfd() {
        if (adpoting) {
            return;
        }
        var id = $("#id").val();
        var auditMarks = $("#auditMarks").val();//审核备注
        var oldFittingFlag = $("#oldFittingFlag").val();//返还旧件
        var fittingAuditNum = $("#fittingAuditNum").val();//审核数量
        var exits = exit;
        if (!ck.test(fittingAuditNum)) {
            layer.msg("审核数量格式错误!");
            return;
        } else {
            adpoting = true;
            $.ajax({
                type: "POST",
                url: "${ctx}/fitting/fittingOuterApply/updateFittingOuterApply",
                data: {
                    id: id,
                    fittingAuditNum: fittingAuditNum,
                    oldFittingFlag: oldFittingFlag,
                    auditMarks: auditMarks
                },
                success: function (result) {
                	if(result=="ok"){
                		layer.msg("保存成功！");
                        setTimeout(function () {
                            window.parent.search();
                        }, 300);
                        setTimeout(function () {
                            $.closeDiv($('.shsqbox'))
                        }, 500);
                	}else{
                		layer.msg("保存失败，请检查！");
                	}
                    return;
                },
                complete: function () {
                    adpoting = false;
                }
            });
        }
    }
	
	//通过申请
	var adpotin = false;
	function adoptFittingApply() {
		if (adpotin) {
			return;
		}
		var auditMarks = $("#auditMarks").val();
		var id = $("#id").val();
		var fittingAuditNum = $("#fittingAuditNum").val();
		var oldFittingFlag = $("#oldFittingFlag").val();
		var fittingWarning = $("#fittingWarning").val();
		var fitId = '${ft.columns.id}';
		if(isBlank(fitId)){
			layer.msg("您尚未添加条码为"+'${fa.applyFittingCode }'+"的备件!");
			return;
		}
		if (!ck.test(fittingAuditNum)) {
			layer.msg("审核数量格式错误!");
			return;
		} else if (parseFloat(fittingAuditNum) <= 0) {
			layer.msg("审核数量必须大于0!");
			return;
		} else if (isBlank(fittingWarning)) {
			if (parseFloat(fittingAuditNum) > 0) {
				layer.msg("库存数量不足!");
				return;
			}
		} else if (parseFloat(fittingAuditNum) > parseFloat(fittingWarning)) {
			layer.msg("库存数量不足!");
			return;
		} else {
			adpotin = true;
			$.ajax({
				type: "POST",
				url: "${ctx}/fitting/fittingOuterApply/adoptFittingOuterApply",
				data: {
					id: id,
					fittingAuditNum: fittingAuditNum,
					oldFittingFlag: oldFittingFlag,
					auditMarks: auditMarks
				},
				success: function (result) {
					var code = result;
					if ('200' == code) {
						layer.msg("申请成功！");
						setTimeout(function(){
							parent.search();
							$.closeAllDiv();
						},300);
					} else if('420' == code) {
						layer.msg("备件不存在！");
					} else if('421' == code) {
						layer.msg("备件库存不足！");
					}else if('422' == code) {
						layer.msg("备件申请信息有误，备件已通过或已拒绝！");
					}else{
						layer.msg("申请审核失败");
					}
				},
				complete: function () {
					adpotin = false;
				}
			});
		}
	}
	
	function refuseFittingApply1(){
		$('.shfkboxjj').popup({level:2});
	}
	
	//拒绝通过备件申请
	var adpoti1 = false;
	function refuseFittingApply(){
		var auditMarks = $("#auditMarks").val();
		var reason = $("#reason").val();
		if($.trim(reason)=="" || reason==null){
			layer.msg("请填写拒绝理由！");
		}else{
			 if(adpoti1) {
			        return;
		        }
			 adpoti1 = true;
			var id = $("#id").val();
			//需要加二级提示
			$.ajax({
				type:"POST",
				url:"${ctx}/fitting/fittingOuterApply/refuseFittingOuterApply",
				data:{
					id:id,
					reason:reason,
					auditMarks:auditMarks
					},
				success:function(result){
					if(result=="420"){
						layer.msg("备件申请信息有误，备件已通过或已拒绝！");
					}else if(result=="200"){
						layer.msg("拒绝成功！");
						setTimeout(function(){
							parent.search();
							parent.initNumber();
							$.closeAllDiv();
						},300);
					}else{
						layer.msg("拒绝失败，请检查！");
					}
					return;
				},
	            complete: function() {
	                adpoti1 = false;
	            }
			});
		}
	}
	
	function messageApply(){
		var message = $("#message").val();
		var id = $("#id").val();
		if(isBlank($.trim(message))){
			layer.msg("请输入反馈内容！");
		}else{
			$.ajax({
				type:"POST",
				url:"${ctx}/fitting/fittingApply/messageApply",
				data:{
					id:id,
					message:message
					},
				success:function(result){
					//关闭弹出框操作	
					layer.msg("反馈发送成功！");
					$.closeDiv($('.shfkboxfk'));
					$('#Hui-article-box',window.top.document).css({'z-index':'9'});
					location.href="${ctx}/fitting/fittingApply/form?id="+id;
				}
			});
		}
	}

	 $('#spimg1').imgShow();

</script> 
</body>
</html>