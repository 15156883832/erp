<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta name="decorator" content="base"/>
<title>批量结算</title>
</head>
<body>

<div class="popupBox  orderSettle">
	<h2 class="popupHead">
		批量结算
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r pb-60">
		<div class="popupMain" >
			<div class="pcontent pl-15 pt-10"><div class="w-830">
				<h3 class="modelHead mb-10">收入</h3>
				<div class="cl mb-10">
					<label class="w-100 text-r f-l">厂家结算费：</label>
					<div class="priceWrap w-100 f-l">
						<input type="text" class="input-text" id="ffee" maxlength="6"/>
						<span class="unit">元</span>
					</div>
				</div>
				<h3 class="modelHead mb-10">支出</h3>
				<!--
				<div class="cl mb-10">
					<label class="w-100 text-r f-l"><span class="c-005aab va-t">工程师结算费</span>：</label>
					<div class="priceWrap w-100 f-l readonly">
						<input type="text" class="input-text" readonly="readonly" value="" id="empCost"/>
						<span class="unit">元</span>
					</div>
				</div>
				-->
				<div class="retractWrap">
					<div class="bk-blue-dotted pt-10 mb-10 sdefinedbox retractBox" id="sdefinedbox1">
						<div class="cl mb-10">
							<label class="w-100 text-r f-l">服务结算方案：</label>
							<span class="select-box w-210 f-l">
								<select class="select" name="fwjsfa" id="smethod">
									<option value="0">平台默认结算方案</option>
									<c:forEach items="${tmpls}" var="tmpl">
										<option value="${tmpl.index}">${tmpl.name}</option>
									</c:forEach>
								</select>
							</span>
							<!-- <span class="c-0383dc f-l lh-26 ml-10"><i class="sficon sficon-whjsfa mr-5"></i>维护结算方案</span> -->
						</div>
						<div class="sdefined sdefined0">
							<div class="cl mt-10">
								<div class="f-l mb-10 pjsbox">
									<label class="w-100 text-r f-l">服务费结算：</label>
									<select class="select w-100 f-l mr-10" id="sel1" onchange="changeUnit(this)">
										<option value="1">固定金额</option>
										<option value="2">比例提成</option>
									</select>
									<div class="priceWrap w-70 f-l jsbox jsbox1">
										<input type="text" id="fixedsfee" class="input-text" maxlength="6"/>
										<span class="unit">元</span>
									</div>
									<div class="f-l hide jsbox2 jsbox">
										<div class="priceWrap w-70 f-l mr-10">
											<input type="text" id="scaledspercent" class="input-text" maxlength="6"/>
											<span class="unit">%</span>
										</div>
										<!--
										<div class="priceWrap w-70 f-l readonly">
											<input type="text" class="input-text readonly" readonly="readonly" unselectable="on"  />
											<span class="unit">元</span>
										</div>
										-->
									</div>
								</div>
								<div class="f-l mb-10 pjsbox">
									<label class="w-100 text-r f-l">辅材费结算：</label>
									<select class="select w-100 f-l mr-10" id="sel2" onchange="changeUnit(this)">
										<option value="1">固定金额</option>
										<option value="2">比例提成</option>
									</select>
									<div class="priceWrap w-150 f-l jsbox jsbox1">
										<input type="text" class="input-text" maxlength="6" id="fixedafee"/>
										<span class="unit">元</span>
									</div>
									<div class="f-l hide jsbox jsbox2">
										<div class="priceWrap w-70 f-l mr-10">
											<input type="text" class="input-text" maxlength="6" id="scaledapercent"/>
											<span class="unit">%</span>
										</div>
										<!--
										<div class="priceWrap w-70 f-l readonly">
											<input type="text" class="input-text readonly" readonly="readonly" unselectable="on"  />
											<span class="unit">元</span>
										</div>
										-->
									</div>
								</div>
								<div class="f-l mb-10 pjsbox">
									<label class="w-100 text-r f-l">延保费结算：</label>
									<select class="select w-100 f-l mr-10" id="sel3" onchange="changeUnit(this)">
										<option value="1">固定金额</option>
										<option value="2">比例提成</option>
									</select>
									<div class="priceWrap w-70 f-l jsbox jsbox1">
										<input type="text" class="input-text" maxlength="6" id="fixedyfee"/>
										<span class="unit">元</span>
									</div>
									<div class="f-l hide jsbox jsbox2">
										<div class="priceWrap w-70 f-l mr-10">
											<input type="text" class="input-text" maxlength="6" id="scaledypercent"/>
											<span class="unit">%</span>
										</div>
										<!--
										<div class="priceWrap w-70 f-l readonly">
											<input type="text" class="input-text readonly" readonly="readonly" unselectable="on"  />
											<span class="unit">元</span>
										</div>
										-->
									</div>
								</div>
								<div class="f-l mb-10 pjsbox">
									<label class="w-100 text-r f-l">其他结算：</label>
									<div class="priceWrap w-100 f-l">
										<input type="text" class="input-text" maxlength="6" id="otherfee"/>
										<span class="unit">元</span>
									</div>
								</div>
							</div>
						</div>
						<c:forEach items="${tmpls}" var="tmpl">
							<div class="sdefined sdefined${tmpl.index} cl hide">
								<c:forEach items="${tmpl.items}" var="item">
									<div class="f-l mb-10 ">
										<!-- 自定义的结算方案名称不能超过7个字（不包含冒号） -->
										<label class="w-100 text-r f-l flabel">${item.name}：</label>
										<div class="priceWrap w-100 f-l">
											<input type="text" class="input-text ppp ${item.proportion ? 'vsp' : ''}" value="${item.cost}" onkeyup="calcOverall();"/>
											<input type="hidden" name="itemId" class="sid" value="${item.id}">
											<input type="hidden" name="basetype" class="basetype" value="${item.type}">
											<span class="unit">${item.proportion ? '%' : '元'}</span>
										</div>
									</div>
								</c:forEach>
							</div>
						</c:forEach>
					</div>
				</div>


				<div class="cl mb-10">
					<label class="w-100 text-r f-l "><em class="mark">*</em><span class="c-005aab va-t">结算归属日期</span>：</label>
					<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'bxdatemax\')||\'%y-%M-%d\'}'})" id="bxdatemax" name="bxdatemax" value="" class="input-text Wdate w-140 f-l mustfill" readonly>
				</div>
				<div class="pos-r pl-90 ml-10">
					<label class="w-90 text-r lb">备注：</label>
					<input type="text" class="input-text" id="memo"/>
				</div>

			</div></div>
		</div>
		<div class="text-c btnWrap">
			<a href="#" class="sfbtn sfbtn-opt3 w-70 mr-5" id="saveBtn">保存</a>
			<a href="javascript:closeBatchForm();" class="sfbtn sfbtn-opt w-70 ">取消</a>
		</div>
	</div>
</div>

<script type="text/javascript">

function closeBatchForm(){
	$.closeDiv($(".orderSettle"));
	parent.layer.close(parent.layer.getFrameIndex(window.name));
}
	// {id: 'xx', label: 'xx', value: 20, p: true} id为结算项目的id, label为结算项目的名称，value为结算项的值，p表示是否为比例。
	// 如果是平台默认结算方案，那么id为空。
	var sItems = [];
	var formPosted = false;

	$(function () {
		$('.orderSettle').popup({level: 2, fixedHeight: false});
		$("#bxdatemax").css({'background-color': '#dbf5fd','border':'1px solid #5ebdfb'});
		$('.closePopup').bind('click', function () {
			parent.closeBatchForm();
		});
		factoryFee = $("#ffee");
		sel1 = $("#sel1");
		sel2 = $("#sel2");
		sel3 = $("#sel3");
		fixedSfeeE = $("#fixedsfee");
		fixedAfeeE = $("#fixedafee");
		fixedYfeeE = $("#fixedyfee");
		scaledSE = $("#scaledspercent");
		scaledAE = $("#scaledapercent");
		scaledYE = $("#scaledypercent");
        otherFeeE = $("#otherfee");
        jiesuanDate = $('#bxdatemax');
        
        $("#saveBtn").bind('click', function() {
        	saveBatch();
        });
	});

	$('select[name="fwjsfa"]').on('change', function () {
		var index = $(this).find("option:selected").val();
		$(this).closest('.sdefinedbox').find('.sdefined').hide();
		$('.sdefined').hide();
		$(this).closest('.sdefinedbox').find('.sdefined' + index).show();
	});

	function changeUnit(obj) {
		var oIndex = $(obj).find('option:selected').val();
		$(obj).closest('.pjsbox').find('.jsbox').hide();
		$(obj).closest('.pjsbox').find('.jsbox' + oIndex).show();
	}

	function validateNumber(el, msg) {
		var val = $.trim(el.val());
		if (val && !/^(\-)?\d+(.\d{1,2})?$/.test(val)) {
			layer.msg(msg);
			return false;
		}
		return true;
	}

	function validateProportion(el, msg) {
		var val = $.trim(el.val());
		if (val && !/^\d+(\.\d{1,2})?$/.test(val)) {
			layer.msg(msg);
			return false;
		}
		return true;
	}

	function validateForm() {
		var smethodEl = $("#smethod");
		var smethod = smethodEl.val();
		var activeSMethodContainer = $('.sdefined' + smethod);

        if (!validateNumber(factoryFee, "厂家结算费：数据格式不正确（至多两位小数）")) {
            return false;
        }

		if ('0' == smethod) {
			if(sel1.val() == '1') {
				if(!validateNumber(fixedSfeeE, "服务费：数据格式不正确（至多两位小数）")) {
					return false;
				}
			} else if(!validateProportion(scaledSE, "服务费：比例格式不正确")){
				return false;
			}
			if(sel2.val() == '1') {
				if(!validateNumber(fixedAfeeE, "辅材费：数据格式不正确（至多两位小数）")) {
					return false;
				}
			} else if(!validateProportion(scaledAE, "辅材费：比例格式不正确")){
				return false;
			}
			if(sel3.val() == '1') {
				if(!validateNumber(fixedYfeeE, "延保费：数据格式不正确（至多两位小数）")) {
					return false;
				}
			} else if(!validateProportion(scaledYE, "延保费：比例格式不正确")){
				return false;
			}
            if (!validateNumber(otherFeeE, "其他结算费：数据格式不正确（至多两位小数）")) {
                return false;
            }

		} else {
            var valid = true;
			$("input.ppp", activeSMethodContainer).each(function () {
				var _this = $(this);
                var itemLabel = $(this).parent().prev("label").text();
				if(_this.hasClass("vsp")) {
					if(!validateProportion(_this, itemLabel+'比例格式不正确')) {
					    valid = false;
						return false;
					}
				} else {
                    if(!validateNumber(_this, itemLabel+'数据格式不正确（至多两位小数）')) {
                        valid = false;
                        return false;
                    }
				}
			});
            if (!valid) {
                return false;
            }
		}

		var hasAtLeastOneJiesuanItem = false;
        $("input:visible", activeSMethodContainer).each(function() {
            var val = $.trim($(this).val());
            if(val) {
                hasAtLeastOneJiesuanItem = true;
                return false;
            }
        });
        if(!hasAtLeastOneJiesuanItem) {
            layer.msg("请至少填写一个结算项");
            return false;
        }

        if(!jiesuanDate.val()) {
            layer.msg("请选择结算日期");
            return false;
        }
		return true;
	}

	function saveBatch() {
		if(formPosted) {
			return false;
		}

		var smethodEl = $("#smethod");
		var smethod = smethodEl.val();
		var activeSMethodContainer = $('.sdefined' + smethod);
        if (!validateForm()) {
            return false;
        }
        sItems = [];

        if ('0' == smethod) {
            if(sel1.val() == '1') {
                sItems.push({id: '', label: '服务费结算', value: $.trim(fixedSfeeE.val()), p: false});
            } else {
                sItems.push({id: '', label: '服务费结算', value: $.trim(scaledSE.val()), p: true, type: '1'});
            }
            if(sel2.val() == '1') {
                sItems.push({id: '', label: '辅材费结算', value: $.trim(fixedAfeeE.val()), p: false});
            } else {
                sItems.push({id: '', label: '辅材费结算', value: $.trim(scaledAE.val()), p: true, type: '2'});
            }
            if(sel3.val() == '1') {
                sItems.push({id: '', label: '延保费结算', value: $.trim(fixedYfeeE.val()), p: false});
            } else {
                sItems.push({id: '', label: '延保费结算', value: $.trim(scaledYE.val()), p: true, type: '3'});
            }
            sItems.push({id: '', label: '其他结算费', value: $.trim(otherFeeE.val()), p: false});
        } else {
            var valid = true;
            $("input.ppp", activeSMethodContainer).each(function () {
                var _this = $(this);
                var itemLabel = $(this).parent().prev("label").text();
                var type = $(this).siblings(".basetype").val();

                if (_this.hasClass("vsp")) { // 表明是比例
                    sItems.push({id: _this.next("input").val(), label: itemLabel, value: $.trim(_this.val()), p: true, type: type});
                } else {
                    sItems.push({id: _this.next("input").val(), label: itemLabel, value: $.trim(_this.val()), p: false});
                }
            });
        }

        formPosted = true;
        var data = {
            sItems: sItems,
            sMethod: $("#smethod").children("option").filter(":selected").text(),
            orderIds: '${orderIds}',
			settlementDate: $("#bxdatemax").val(),
			factoryFee: factoryFee.val(),
			memo: $("#memo").val()
        };
        $.ajax({
            url: "${ctx}/order/settlement/batchSave",
            type: 'POST',
            data: JSON.stringify(data),
            contentType: "application/json; charset=utf-8",
            success: function (data) {
            	if("200"==data.code){
            		var p = window.parent;
                    parent.search();
    				$.closeDiv($(".orderSettle"));
    				p.layer.closeAll();
            	}else if(data.code=="422"){
					layer.msg("没有对应的服务工程师！");
					return false;
				}else if(data.code=="421"){
					layer.msg("该工单已经结算，请勿重复结算。");
				}else if(data.code=="430") {
	                layer.msg("编号为"+data.errMsg+"的工单请回访后再进行结算！");
	                return;
	            }else if(data.code=="431") {
	                layer.msg("编号为"+data.errMsg+"的工单交款金额和实收金额不一致，请确认一致后再进行结算！");
	                return;
	            }else if(data.code=="432") {
	                layer.msg("编号为"+data.errMsg+"的工单请回访后再进行结算！");
	                return;
	            }else if(data.code=="433") {
	                layer.msg("编号为"+data.errMsg+"的工单交款金额和实收金额不一致，请确认一致后再进行结算！");
	                return;
	            } else{
					layer.msg("检验失败，请检查！");
					return false;
				}
            	
            },
            error: function() {
//                formPosted = false;
            }
        });
	}

</script>
</body>
</html>