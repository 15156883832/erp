<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>工单录入</title>
<meta name="decorator" content="base"/>

<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select2.min.css"/> 
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.cityselect.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
<style>

	/* WebKit browsers */
	input::-webkit-input-placeholder {
		color: #777;
	}
	/* Mozilla Firefox 4 to 18 */
	input:-moz-placeholder {
		color: #777;
		opacity: 1;
	}
	/* Mozilla Firefox 19+ */
	input::-moz-placeholder {
		color: #777;
		opacity: 1;
	}
	/* Internet Explorer 10+ */
	input:-ms-input-placeholder {
		color: #777;
	}
</style>

<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
</head>

<body>


<!-- 待派工工单下和服务中工单下 -->
<div class="popupBox msgText msgTextdefined" style="height:470px;" >
	<h2 class="popupHead">
		发送短信
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer" style="height:430px;overflow:auto;">
		<input hidden="hidden" id="sign">
		<input hidden="hidden" id="siteMsgNums">
		<div class="popupMain pd-20" id="msgWrapdef" >
			<div class="tabBarP ">
				<a href="javascript:;" class="tabswitch current">模板发送</a>
				<a href="javascript:;" class="tabswitch ">编辑发送</a>
			</div>
			<div class="tabCon">
				<div class="pos-r pl-70 pr-80 mt-10">
					<label class="lb w-70 text-r">选择模板：</label>
					<span class="select-box w-160">
						<select class="select radius h-26" id="select-msgmodedef" name="selectModel" onchange="selectMsgMoulddef(this)">
							<option value="zzdx">增值产品</option>
							<c:forEach items="${definedmodel}" var="def">
								<option value="${def.columns.id }">${def.columns.name }(自定义)</option>
							</c:forEach>
						</select>
					</span>
				</div>
				<div class=" defmsgmould">
					<div class="pos-r pl-70 pr-80 mt-10 ">
						<span class="lb w-70 text-c">发送内容：</span>
						<div class="bk-gray pd-10 defmsgcontent">
							<span class="lb w-70 text-c">发送内容：<span class="c-0383dc">（模板一）</span></span>
							<div class="bk-gray pd-10">
								尊敬的<input type="text" class="msg-input" id="custNameTS" value="${order.customerName }"  onkeyup="inputWidth(this)" />您好，
								您的<input type="text" class="msg-input" id="ywTS" value="${order.serviceType }"  onkeyup="inputWidth(this)"/>业务，我司已受理，
								指派<input type="text" class="msg-input" id="emNameMobileTS" value="${msg1 }" onkeyup="inputWidth(this)"/>为您服务，
								<input type="text" class="msg-input" id="mode1TS" value="注意用电安全请点击${oneHref}" >，详情咨询上门工程师。
								【<input type="text" class="msg-input" value="${serviceName }" id="sign10TS" onkeyup="inputWidth(this)"/>服务】
							</div>	
						</div>
						<div id="defsendModel">	</div>
					</div>
				</div>
			</div>
			<div class="tabCon">
				<p class="c-f55025 f-12 lh-30">
					注：自定义文字内容需要人工审核，等待时间较长
				</p>
				<div class="pr-80 pos-r">
					<div class="bk-gray" >
						<textarea class="textarea radius" placeholder="请输入短信内容" id="contentdef" style="border-width: 0; height: 60px;"></textarea>
						<div class="h-26">
							<p class="f-r">【<input type="text" class="msg-input"  value="${serviceName }" id="signdef" onkeyup="inputWidth(this)"/>服务】</p>
						</div>
					</div>
					<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg  " onclick="defsendMsgConfirm()">发送</a>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="popupBox msgText msgTextQuren" >
	<h2 class="popupHead">
		短信确认
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pd-20" >
			<div class="lh-26">
				<div>您确定给<span id="peoples" style="color: #999;" class="f-14"></span>发送</div>
				<div style="min-height:100px; text-indent:2em;color: #999;" id="sendContent" ></div> 
			</div>
			<div class="text-c mt-25 " id="clickSend">
				
			</div>
		</div>
	</div>
</div>
<input type="hidden" id="customerMobile" value="${order.customerMobile }"/>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript">
var definedContentCd="";
var definedContentTz="";
var limitCount=0;
var mark="";
var orderMsgId="";
var orderMsgMobile="";
var isCheck="";
var customerPrice="";
$(function(){
	var ctt = "尊敬的@，您的@业务，我司已受理，指派@为您服务，@，详情咨询上门工程师。【@服务】";
	$("#defsendModel").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1TS(9,7,\''+ctt+'\',1)" >发送</a>');
	if($.trim('${order.customerMobile}')!=null && $.trim('${order.customerMobile}')!="" ){
		orderMsgMobile=$.trim('${order.customerMobile}');
	}
	orderMsgId='${order.id}';
	
	$.post("${ctx}/order/remainMsgNum",{},function(result){
		$("#sign").val(result.columns.sms_sign);//签名
		$("#siteMsgNums").val(result.columns.sms_available_amount);//服务商剩余可发送短信总数
	});


    $('#bjNavBox .tabswitch').each(function(i){
    	$(this).on('click', function(){
    		 $('#bjNavBox .tabswitch').removeClass('current');
    		 $(this).addClass('current');
    		 $('#bjNavBox2 .caption_lb').hide().eq(i).show();
    		 $('#bjNavBox2 .sfbtn').hide().eq(i).show();
        });
    });
    
});


function closeAll(){
	$.closeAllDiv();
}

</script>

<script type="text/javascript">
var ck = /^\d+(\.\d+)?$/;
	$(function(){
		$('.msgTextdefined').popup({fixedHeight:false});
		$.Huitab("#msgWrapdef .tabBarP .tabswitch","#msgWrapdef .tabCon","current","click","0");
		$("input.sfbtn.sfbtn-opt3").click(function(){
			$(".lb.lb1").removeClass("readonly");
		});
		
		$(".closePopup").click(function(){
			closeAll();
		});
		
	});



		function isBlank(val) {
			if(val==null || val=='' || val == undefined) {
				return true;
					}
			return false;
		}
	

	function getoff(){
		window.location.reload();
	}
	


	//下拉框切换自定义模板
	function selectMsgMoulddef(obj){
	    var id = $('#select-msgmodedef option:selected') .val();
	    if(id=="zzdx"){
	    	$.ajax({
				type:"POST",
				url:"${ctx }/order/getTag",
				data:{tag:'7'},
				success:function(result){
					if(result==null ||result==''){
						layer.msg("信息有误！");
						return;
					}
			    	$(".defmsgcontent").empty();
			    	$(".defmsgcontent").append(
			    			'<span class="lb w-70 text-c">发送内容：<span class="c-0383dc">（模板一）</span></span>'+
							'<div class="bk-gray pd-10">'+
								'尊敬的<input type="text" class="msg-input" id="custNameTS" value="${order.customerName }"  onkeyup="inputWidth(this)" />您好，'+
								'您的<input type="text" class="msg-input" id="ywTS" value="${order.serviceType }"  onkeyup="inputWidth(this)"/>业务，我司已受理，'+
								'指派<input type="text" class="msg-input"  value="${msg1 }" id="emNameMobileTS" onkeyup="inputWidth(this)"/>为您服务，'+
								'<input type="text" class="msg-input" id="mode1TS" value="注意用电安全请点击${oneHref}"  >，详情咨询上门工程师。'+
								'【<input type="text" class="msg-input" value="${serviceName }" id="sign10TS" onkeyup="inputWidth(this)"/>服务】'+
							'</div>');
					$("#defsendModel").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1TS(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',1)" >发送</a>');
					return;
				}
	    	})
	    	
	    }else{
		    $.ajax({
		        type:"POST",
		        url:"${ctx }/order/getsmsbyid",
		        data:{id:id},
		        success:function(result) {
		            if (result != "" || result != null) {
		                $(".defmsgcontent").empty();
		                var newcontent=result.columns.content;
		                while(newcontent.indexOf('@1') >= 0){
		                    newcontent = newcontent.replace("@1","<input type='text' class='msg-input' value='${order.customerName }' onkeyup='inputWidth(this)' id='defcustomerName'/>");
		                }
		                while(newcontent.indexOf('@2') >= 0){
		                    newcontent = newcontent.replace("@2","<input type='text' class='msg-input' value='${order.applianceBrand }' onkeyup='inputWidth(this)' id='defapplianceBrand'/>");
		                }
		                while(newcontent.indexOf('@3') >= 0){
		                    newcontent = newcontent.replace("@3","<input type='text' class='msg-input' value='${order.applianceCategory }' onkeyup='inputWidth(this)' id='defapplianceCategory'/>");
		                }
		                while(newcontent.indexOf('@4') >= 0){
		                    newcontent = newcontent.replace("@4","<input type='text' class='msg-input' value='${order.serviceType }' onkeyup='inputWidth(this)' id='defserviceType'/>");
		                }
		                while(newcontent.indexOf('@5') >= 0){
		                    if('${order.serviceMode }'=='1'){
		                        newcontent = newcontent.replace("@5","<input type='text' class='msg-input' value='上门' onkeyup='inputWidth(this)' id='defserviceMode'/>");
		                    }else if('${order.serviceMode }'=='2'){
		                        newcontent = newcontent.replace("@5","<input type='text' class='msg-input' value='拉修' onkeyup='inputWidth(this)' id='defserviceMode'/>");
		                    }else{
		                        newcontent = newcontent.replace("@5","<input type='text' class='msg-input' value='' onkeyup='inputWidth(this)' id='defserviceMode'/>");
		                    }
		                }
		                while(newcontent.indexOf('@6') >= 0){
		                    newcontent = newcontent.replace("@6","<input type='text' class='msg-input' value='${msg2Names}' onkeyup='inputWidth(this)' id='defmsg2Names'/>");
		                }
		                while(newcontent.indexOf('@7') >= 0){
		                    newcontent = newcontent.replace("@7","<input type='text' class='msg-input' value='${msg2Mobiles }' onkeyup='inputWidth(this)' id='defmsg2Mobiles'/>");
		                }
		                while(newcontent.indexOf('@8') >= 0){
		                    newcontent = newcontent.replace("@8","<input type='text' class='msg-input' value='${jdPhone }' onkeyup='inputWidth(this)' id='defjdPhone'/>");
		                }
		                $(".defmsgcontent").append(newcontent);
		                $("#defsendModel").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModeldef(\''+result.columns.id+'\',\''+result.columns.tag+'\',\''+result.columns.content+'\')" >发送</a>');
		                //$.setPos($(".msgTextdefined"))
		            }else{
		
		            }
		        }
		    })
	    }

	}
	
	var afl = false;
	function sendModel1(id,tag,content,mode){
		$("#clickSend").empty();
		if(afl) {
		    return;
	    }
		var siteMsgNums = $("#siteMsgNums").val();//服务商已购还有短信数
		var custName = $("#custName").val();
		var mode1 = $("#mode1").val();
		var mode2 = $("#mode2").val();
		var mode3 = $("#mode3").val();
		var mode4 = $("#mode4").val();
		var yw = $("#yw").val();
		var siteName = $("#siteName").val();
		var jdMobile = $("#jdMobile").val();
		var goodsTime = $("#goodsTime").val();
		var pjArea = $("#pjArea").val();
		var pjMobile = $("#pjMobile").val();
		var emName = $("#emName").val();//工程师集合
		var emMobile = $("#emMobile").val();//电话集合
		var proTime = $("#proTime").val();
		var promiseLimit = $("#promiseLimit").val();
		var siteMobile = $("#siteMobile").val();
		var custNameMobile = $("#custNameMobile").val();
		var customerMobile = $("#customerMobile").val();//用户联系方式
		var sign = $("#sign").val();
		if($.trim(emName)=="" || emName==null){
			layer.msg("工单中没有维护的服务工程师，请先到运营管理下的员工信息管理页面维护！");
			return ;
		}
		var emNameMobile = $("#emNameMobile").val();//工程师、加电话集合
		// 查询出"@"的所有位置
        var path_1 = content.indexOf("@");// 第一个位置
        var path_2 = path_1 + content.substring(path_1 + 1).indexOf("@") + 1;// 第二个位置
        var path_3 = path_2 + content.substring(path_2 + 1).indexOf("@") + 1;// 第三个位置
        var path_4 = path_3 + content.substring(path_3 + 1).indexOf("@") + 1;// 第四个位置
        var path_5 = path_4 + content.substring(path_4 + 1).indexOf("@") + 1;// 第四个位置
        var path_6 = path_5 + content.substring(path_5 + 1).indexOf("@") + 1;// 第四个位置
        var s_temp;
		if(id==2){//模板一
			if($.trim($("#sign1").val())=="" || $("#sign1").val()==null){
				layer.msg("短信签名不能为空！");
				$("#sign1").focus();
				return;
			}
			if($.trim($("#sign1").val()).length>6){
				layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
				$("#sign1").focus();
				return;
			}
			sign=$.trim($("#sign1").val());
			s_temp = content.substring(0, path_1) + custName
            + content.substring(path_1 + 1, path_2) + yw
            + content.substring(path_2 + 1, path_3) + siteName
            + content.substring(path_3 + 1, path_4) + emNameMobile
            + content.substring(path_4 + 1, path_5) + jdMobile
            + content.substring(path_5 + 1, path_6) + sign
            + content.substring(path_6 + 1);
			
		}else if(id==3){//模板二
			if($.trim($("#sign2").val())=="" || $("#sign2").val()==null){
				layer.msg("短信签名不能为空！");
				$("#sign2").focus();
				return;
			}
			if($.trim($("#sign2").val()).length>6){
				layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
				$("#sign2").focus();
				return;
			}
			sign=$.trim($("#sign2").val());
			s_temp = content.substring(0, path_1) + custNameMobile 
            + content.substring(path_1 + 1, path_2) + emName
            + content.substring(path_2 + 1, path_3) + emMobile
            + content.substring(path_3 + 1, path_4) + sign
            + content.substring(path_4 + 1);
			
		}else if(id==4){//无法接通
			if($.trim($("#sign3").val())=="" || $("#sign3").val()==null){
				layer.msg("短信签名不能为空！");
				$("#sign3").focus();
				return;
			}
			if($.trim($("#sign3").val()).length>6){
				layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
				$("#sign3").focus();
				return;
			}
			sign=$.trim($("#sign3").val());
			s_temp = content.substring(0, path_1) + siteMobile
            + content.substring(path_1 + 1, path_2) + emNameMobile
            + content.substring(path_2 + 1, path_3) + sign
            + content.substring(path_3 + 1);
			
		}else if(id==12){//配件无法接通
			/* if(mark=="no"){
			layer.msg("工单中没有维护的服务工程师，请先到运营管理下的员工信息管理页面维护！");
			return;
		} */
		if($.trim(pjMobile)=="" || pjMobile==null){
			layer.msg("联系电话不能为空！");
			$("#pjMobile").focus();
			return;
		}
		if($.trim($("#sign20").val())=="" || $("#sign20").val()==null){
			layer.msg("短信签名不能为空！");
			$("#sign20").focus();
			return;
		}
		if($.trim($("#sign20").val()).length>6){
			layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
			$("#sign20").focus();
			return;
		}
		sign=$.trim($("#sign20").val());
		s_temp = content.substring(0, path_1) + goodsTime
        + content.substring(path_1 + 1, path_2) + pjArea
        + content.substring(path_2 + 1, path_3) + pjMobile
        + content.substring(path_3 + 1, path_4) + sign
        + content.substring(path_4 + 1);
	}else if(id==5){//改约
			if($.trim($("#sign4").val())=="" || $("#sign4").val()==null){
				layer.msg("短信签名不能为空！");
				$("#sign4").focus();
				return;
			}
			if($.trim($("#sign4").val()).length>6){
				layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
				$("#sign4").focus();
				return;
			}
			sign=$.trim($("#sign4").val());
			s_temp = content.substring(0, path_1) + custName
            + content.substring(path_1 + 1, path_2) + proTime
            + content.substring(path_2 + 1, path_3) + promiseLimit
            + content.substring(path_3 + 1, path_4) + emNameMobile
            + content.substring(path_4 + 1, path_5) + jdMobile
            + content.substring(path_5 + 1, path_6) + sign
            + content.substring(path_6 + 1);
		}else if(id==6){//缺件
			if($.trim($("#sign5").val())=="" || $("#sign5").val()==null){
				layer.msg("短信签名不能为空！");
				$("#sign5").focus();
				return;
			}
			if($.trim($("#sign5").val()).length>6){
				layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
				$("#sign5").focus();
				return;
			}
			sign=$.trim($("#sign5").val());
			s_temp = content.substring(0, path_1) + custName
            + content.substring(path_1 + 1, path_2) + emNameMobile
            + content.substring(path_2 + 1, path_3) + jdMobile
            + content.substring(path_3 + 1, path_4) + sign
            + content.substring(path_4 + 1);
		}else if(id==9){
			if(mode=="1"){
				if($.trim($("#sign10").val())=="" || $("#sign10").val()==null){
					layer.msg("短信签名不能为空！");
					$("#sign10").focus();
					return;
				}
				if($.trim($("#sign10").val()).length>6){
					layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
					$("#sign10").focus();
					return;
				}
				sign=$.trim($("#sign10").val());
				s_temp = content.substring(0, path_1) + custName
	            + content.substring(path_1 + 1, path_2) + yw
	            + content.substring(path_2 + 1, path_3) + emNameMobile
	            + content.substring(path_3 + 1, path_4) + mode1
	            + content.substring(path_4 + 1, path_5) + sign
	            + content.substring(path_5 + 1);
			}else if(mode=="2"){
				if($.trim($("#sign11").val())=="" || $("#sign11").val()==null){
					layer.msg("短信签名不能为空！");
					$("#sign11").focus();
					return;
				}
				if($.trim($("#sign11").val()).length>6){
					layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
					$("#sign11").focus();
					return;
				}
				sign=$.trim($("#sign11").val());
				s_temp = content.substring(0, path_1) + custName
	            + content.substring(path_1 + 1, path_2) + yw
	            + content.substring(path_2 + 1, path_3) + emNameMobile
	            + content.substring(path_3 + 1, path_4) + mode2
	            + content.substring(path_4 + 1, path_5) + sign
	            + content.substring(path_5 + 1);
			}else{
				if($.trim($("#sign12").val())=="" || $("#sign12").val()==null){
					layer.msg("短信签名不能为空！");
					$("#sign12").focus();
					return;
				}
				if($.trim($("#sign12").val()).length>6){
					layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
					$("#sign12").focus();
					return;
				}
				sign=$.trim($("#sign12").val());
				s_temp = content.substring(0, path_1) + custName
	            + content.substring(path_1 + 1, path_2) + yw
	            + content.substring(path_2 + 1, path_3) + emNameMobile 
	            + content.substring(path_3 + 1, path_4) + mode3+mode4
	            + content.substring(path_4 + 1, path_5) + sign
	            + content.substring(path_5 + 1);
			}
		}
		if($.trim(customerMobile).length==11 && $.trim(customerMobile).substring(0,1)=="1"){
			afl = true;
			$.ajax({//check短信为几条，并对比看服务商已购买短信够不够发送
				type:"POST",
				//traditional:true,
				url:"${ctx }/order/msgNumbers", 
				data:{content:s_temp,
					sign:sign},
				success:function(result){
					if(parseInt(result)>parseInt(siteMsgNums)){//发送短信数大于购买数
						layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
					}else{
						$("#peoples").html('${order.customerName}');
						$("#sendContent").text("“"+s_temp+"”？");
						$("#clickSend").append('<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70  " onclick="sendConfirmMsgModel(\''+id+'\',\''+sign+'\',\''+s_temp+'\',\''+tag+'\',\''+orderMsgId+'\',\''+customerMobile+'\')" >确定</a>&nbsp;&nbsp;'+
								'<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="cancelQuren" onclick="cancelQueren()">取消</a>');
						$(".msgTextQuren").popup({level:5,closeSelfOnly:true});
					}
				},
	            complete: function() {
	                afl = false;
	            }
			})
		}else if($.trim(customerMobile)==""){
			layer.msg("请填写用户的手机号码！");
		}else{
			layer.msg("用户的手机号码格式不正确，请重新填写！");
		}
	}
	
	var aflModel=false;
	function sendConfirmMsgModel(id,sign,s_temp,tag,orderMsgId,customerMobile){
		if(aflModel) {
		    return;
	    }
		aflModel=true;
		$.ajax({
			type:"POST",
			url:"${ctx }/order/fwzSendmsgModel",
			data:{temId:id,
				sign:sign,
				content:s_temp,
				extno:tag,
				orderId:orderMsgId,
				customerMobile:customerMobile
				},
			success:function(result){
				if(result=="ok"){
					window.top.layer.msg("发送成功!");
//					$.closeDiv($(".msgText1"));
//					window.location.reload();
					$.closeAllDiv();
				}else if(result=="noMessage"){
					layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
					return;
				}else{
					layer.msg("发送失败，请稍后重试!");
				}
			},
            complete: function() {
            	aflModel = false;
            }
		})
	}
	
	function inputWidth(obj){
		var textValue = obj.value,
			textLength = textValue.length,
			charCode = -1;
		var charLen = textValue.replace(/[^\x00-\xff]/g,"**").length;

		var minWidth = charLen*7 >10?charLen*7 : 10;
		minWidth = minWidth>448?448:minWidth;
		$(obj).css({'width':minWidth + 'px'});
	}
	
	var afs1= false;
	function sendMsgConfirm(){
		$("#clickSend").empty();
		if(afs1) {
		    return;
	    }
		afs1 = true;
		var siteMsgNums = $("#siteMsgNums").val();//服务商已购还有短信数
		var sign = $("#sign").val();
		var customerMobile = $("#customerMobile").val();//用户联系方式
		if($.trim($("#sign6").val())=="" || $("#sign").val()==null){
			layer.msg("短信签名不能为空！");
			$("#sign6").focus();
			return;
		}
		if($.trim($("#sign6").val()).length>6){
			layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
			$("#sign6").focus();
			return;
		}
		sign=$.trim($("#sign6").val());
		var content = $.trim($("#content").val());
		if(content=="" ){
			layer.msg("自定义发送短信内容不能为空");
			$("#content").focus();
			return;
		}
		if($.trim(customerMobile).length==11 && $.trim(customerMobile).substring(0,1)=="1"){
			//自定义模板
			
			$.ajax({//check短信为几条，并对比看服务商已购买短信够不够发送
				type:"POST",
				url:"${ctx }/order/msgNumbers",
				data:{content:content,
					sign:sign},
				success:function(result){
					if(parseInt(result)>parseInt(siteMsgNums)){//发送短信数大于购买数
						layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
					}else{
						$("#peoples").html('${order.customerName}');
						$("#sendContent").text("“"+$("#content").val()+"”？");
						definedContentTz=content;
						$("#clickSend").append('<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70  " onclick="sendMsg(\''+sign+'\',\''+orderMsgMobile+'\',\''+orderMsgId+'\')" >确定</a>&nbsp;&nbsp;'+
								'<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="cancelQuren" onclick="cancelQueren()">取消</a>');
						$(".msgTextQuren").popup({level:5,closeSelfOnly:true});
					}
				},
				complete: function() {
					afs1 = false;
				}
			});
		}else if($.trim(customerMobile)==""){
			layer.msg("请填写用户的手机号码！");
		}else{
			layer.msg("用户的手机号码格式不正确，请重新填写！");
		} 
	}
	
	var afs= false;
	function sendMsg(sign,orderMsgMobile,orderMsgId){
		if(afs) {
		    return;
	    }
		afs = true;
		$.ajax({
			type:"POST",
			url:"${ctx }/order/fwzSendmsg",
			data:{content:definedContentTz,
				sign:sign,
				orderMsgMobile:orderMsgMobile,
				orderMsgId:orderMsgId
			},
			success:function(result){
				if(result=="ok"){
					window.top.layer.msg("发送成功!");
					$.closeAllDiv();
//					window.location.reload();
				}else if(result=="noMessage"){
					layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
					return;
				}else{
					layer.msg("发送失败，请稍后重试!");
				}
			},
			complete: function() {
				afs = false;
			}
		});
				
	}
	
	
	function cancelQueren(){
		$.closeDiv($(".msgTextQuren"),true);
	}
	
	
	
	//////
var defafl=false;
function sendModeldef(id,tag,content){
    $("#clickSend").empty();
    if(defafl) {
        return;
    }
    var customerMobile = $("#customerMobile").val();//用户联系方式
    var siteMsgNums = $("#siteMsgNums").val();//服务商已购还有短信数
    var custName = $("#defcustomerName").val();
    var applianceBrand = $("#defapplianceBrand").val();
    var applianceCategory = $("#defapplianceCategory").val();
    var  serviceType =$("#defserviceType").val();
    var  serviceMode =$("#defserviceMode").val();
    var defempName=$("#defmsg2Names").val();
    var defempMobile=$("#defmsg2Mobiles").val();
    var smsmobile=$("#defjdPhone").val();
    var defsign ='${serviceName }';
    while(content.indexOf('@1') >= 0){
        content = content.replace("@1",custName);
    }
    while(content.indexOf('@2') >= 0){
        content = content.replace("@2",applianceBrand);
    }
    while(content.indexOf('@3') >= 0){
        content = content.replace("@3",applianceCategory);
    }
    while(content.indexOf('@4') >= 0){
        content = content.replace("@4",serviceType);
    }
    while(content.indexOf('@5') >= 0){
        content = content.replace("@5",serviceMode);
    }
    while(content.indexOf('@6') >= 0){
        content = content.replace("@6",defempName);
    }
    while(content.indexOf('@7') >= 0){
        content = content.replace("@7",defempMobile);
    }
    while(content.indexOf('@8') >= 0){
        content = content.replace("@8",smsmobile);
    }
    var newdefcontent=content;
    var s_temp;
    if($.trim(defsign)=="" || defsign==null){
        layer.msg("短信签名不能为空！");
        return;
    }
    if($.trim(defsign).length>6){
        layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
        return;
    }
    var sign=defsign;
    s_temp =newdefcontent;

    if($.trim(customerMobile).length==11 && $.trim(customerMobile).substring(0,1)=="1"){
        defafl = true;
        $.ajax({//check短信为几条，并对比看服务商已购买短信够不够发送
            type:"POST",
            //traditional:true,
            url:"${ctx }/order/msgNumbers",
            data:{content:s_temp,
                sign:sign},
            success:function(result){
                if(parseInt(result)>parseInt(siteMsgNums)){//发送短信数大于购买数
                    layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
                }else{
                    $("#peoples").html('${order.customerName}');
                    $("#sendContent").text("“"+s_temp+"”？");
                    $("#clickSend").append('<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70  " onclick="sendConfirmMsgModel(\''+id+'\',\''+sign+'\',\''+s_temp+'\',\''+tag+'\',\''+orderMsgId+'\',\''+customerMobile+'\')" >确定</a>&nbsp;&nbsp;'+
                        '<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="cancelQuren" onclick="cancelQueren()">取消</a>');
                    $(".msgTextQuren").popup({level:5,closeSelfOnly:true});
                }
            },
            complete: function() {
                defafl = false;
            }
        })
    }else if($.trim(customerMobile)==""){
        layer.msg("请填写用户的手机号码！");
    }else{
        layer.msg("用户的手机号码格式不正确，请重新填写！");
    }
}

/////////
var defafs1 = false;
function defsendMsgConfirm(){
    $("#clickSend").empty();
    if(defafs1) {
        return;
    }

    var siteMsgNums = $("#siteMsgNums").val();//服务商已购还有短信数
    var sign = $("#sign").val();
    var customerMobile = $("#customerMobile").val();//用户联系方式
    if($.trim($("#signdef").val())=="" || $("#sign").val()==null){
        layer.msg("短信签名不能为空！");
        $("#signdef").focus();
        return;
    }
    if($.trim($("#signdef").val()).length>6){
        layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
        $("#signdef").focus();
        return;
    }
    sign=$.trim($("#signdef").val());
    var content = $.trim($("#contentdef").val());
    if(content=="" ){
        layer.msg("自定义发送短信内容不能为空");
        $("#content").focus();
        return;
    }
    if($.trim(customerMobile).length==11 && $.trim(customerMobile).substring(0,1)=="1"){
        //自定义模板
        defafs1 = true;
        $.ajax({//check短信为几条，并对比看服务商已购买短信够不够发送
            type:"POST",
            url:"${ctx }/order/msgNumbers",
            data:{content:content,
                sign:sign},
            success:function(result){
                if(parseInt(result)>parseInt(siteMsgNums)){//发送短信数大于购买数
                    layer.msg("剩余可发送短信条数不足，请先购买后再发送！");
                }else{
                    $("#peoples").html('${order.customerName}');
                    $("#sendContent").text("“"+$("#contentdef").val()+"”？");
                    definedContentTz=content;
                    $("#clickSend").append('<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70  " onclick="sendMsg(\''+sign+'\',\''+customerMobile+'\',\''+orderMsgId+'\')" >确定</a>&nbsp;&nbsp;'+
                        '<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="cancelQuren" onclick="cancelQueren()">取消</a>');
                    $(".msgTextQuren").popup({level:5,closeSelfOnly:true});
                }
            },
            complete: function() {
                defafs1 = false;
            }
        });
    }else if($.trim(customerMobile)==""){
        layer.msg("请填写用户的手机号码！");
    }else{
        layer.msg("用户的手机号码格式不正确，请重新填写！");
    }
}

var aflTS = false;
function sendModel1TS(id,tag,content,mode){
    $("#clickSend").empty();
    if(aflTS) {
        return;
    }
    var siteMsgNums = $("#siteMsgNums").val();//服务商已购还有短信数
    var custName = $("#custNameTS").val();
    var yw = $("#ywTS").val();
    var emNameMobile = $("#emNameMobileTS").val();//工程师、加电话集合
    var mode1 = $("#mode1TS").val();
    var sign=$.trim($("#sign10TS").val());
    var customerMobile = $("#customerMobile").val();
    if($.trim(emNameMobile)=="" || emNameMobile==null){
        layer.msg("工单中没有维护的服务工程师，请先到运营管理下的员工信息管理页面维护！");
        return ;
    }
    
    // 查询出"@"的所有位置
    var path_1 = content.indexOf("@");// 第一个位置
    var path_2 = path_1 + content.substring(path_1 + 1).indexOf("@") + 1;// 第二个位置
    var path_3 = path_2 + content.substring(path_2 + 1).indexOf("@") + 1;// 第三个位置
    var path_4 = path_3 + content.substring(path_3 + 1).indexOf("@") + 1;// 第四个位置
    var path_5 = path_4 + content.substring(path_4 + 1).indexOf("@") + 1;// 第四个位置
    var path_6 = path_5 + content.substring(path_5 + 1).indexOf("@") + 1;// 第四个位置
    var s_temp;
    if($.trim(sign)=="" || sign==null){
        layer.msg("短信签名不能为空！");
        $("#sign10TS").focus();
        return;
    }
    if($.trim($("#sign10TS").val()).length>6){
        layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
        $("#sign10TS").focus();
        return;
    }
    
    s_temp = content.substring(0, path_1) + custName
        + content.substring(path_1 + 1, path_2) + yw
        + content.substring(path_2 + 1, path_3) + emNameMobile
        + content.substring(path_3 + 1, path_4) + mode1
        + content.substring(path_4 + 1, path_5) + sign
        + content.substring(path_5 + 1);
       
    if($.trim(customerMobile).length==11 && $.trim(customerMobile).substring(0,1)=="1"){
    	aflTS = true;
        $.ajax({//check短信为几条，并对比看服务商已购买短信够不够发送
            type:"POST",
            //traditional:true,
            url:"${ctx }/order/msgNumbers",
            data:{content:s_temp,
                sign:sign},
            success:function(result){
                if(parseInt(result)>parseInt(siteMsgNums)){//发送短信数大于购买数
                    layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
                }else{
                    $("#peoples").html('${order.customerName}');
                    $("#sendContent").text("“"+s_temp+"”？");
                    $("#clickSend").append('<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70  " onclick="sendConfirmMsgModel(\''+id+'\',\''+sign+'\',\''+s_temp+'\',\''+tag+'\',\''+orderMsgId+'\',\''+customerMobile+'\')" >确定</a>&nbsp;&nbsp;'+
                        '<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="cancelQuren" onclick="cancelQueren()">取消</a>');
                    $(".msgTextQuren").popup({level:5,closeSelfOnly:true});
                }
            },
            complete: function() {
            	aflTS = false;
            }
        })
    }else if($.trim(customerMobile)==""){
        layer.msg("请填写用户的手机号码！");
    }else{
        layer.msg("用户的手机号码格式不正确，请重新填写！");
    }
}

</script> 
</body>
</html>