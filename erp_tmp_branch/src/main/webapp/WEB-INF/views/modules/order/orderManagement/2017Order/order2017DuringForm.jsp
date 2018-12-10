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
    <script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/orderConnectionGoods.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>


    <script type="text/javascript" src="${ctxPlugin}/lib/lodop/LodopFuncs.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/lodop/base64.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/lodop/printdesign.js"></script>
    <style>
        .webuploader-pick{
            background:none;
            color:#22a0e6;
            width:80px;
            padding:0;
            height:80px;
        }
        .webuploader-pick img{
            width:100px;
            height:100px;
            position:absolute;
            left:0;
            top:0;
        }

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

    <script type="text/javascript" src="${ctxPlugin}/lib/jquery.dateformat.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/select2.full.min.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
</head>

<body>
<!-- 回访结算工单-工单详情 -->
<div class="popupBox odWrap orderdetailVb">
    <h2 class="popupHead">
        工单详情
        <a href="#" class="sficon closePopup" id="cloZongDiv"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain pos-r" >
            <div class="pcontent">
                <input type="hidden" name="page" id="pageNo" value="1">
                <input type="hidden" name="rows" id="pageSize" value="1">
                <div id="detialWd">
                    <div class="tabBarP" style="overflow: visible;">
                        <a href="javascript:;" class="tabswitch current">基本信息</a>
                        <a href="javascript:;" class="tabswitch ">过程信息</a>
                        <c:if test="${count != 0 }">
                            <a  class="tooltipLink f-r" onclick="changeStyle('${order.number}')"  >
                                <i class="sficon sficon-note"></i>已发送<span class="va-t">${count }</span>条短信
                            </a>
                        </c:if>
                        <c:if test="${order.printTimes != 0 }">
                            <a  class="tooltipLink f-r" >
                                <i class="sficon sficon-print"></i>已打印<span class="va-t">${order.printTimes }</span>次
                            </a>
                        </c:if>
                        <c:if test="${order.bdImgs ne null }">
                            <a class="f-r c-f55025 underline f-14 mr-40" id="btn_showImg">查看微信报单图片</a>
                            <div class="hide" id="wxImgList">
                                <c:forEach items="${bdImgs }" var="lts">
                                    <img alt="" src="${commonStaticImgPath}${lts}">
                                </c:forEach>
                            </div>
                        </c:if>
                    </div>
                    <form id="updateOrder" method="post" action="${ctx}/order/orderDispatch/update">
                        <div class="tabCon">
                            <div class="cl mb-10 mt-10">
                                <input type="hidden" name="id" value="${order.id}">
                                <div class="f-l ">
                                    <label class="w-100 f-l">工单编号：</label>
                                    <input type="text" class="input-text w-160 readonly dischange" readonly="readonly" name="number" value="${order.number }"/>
                                </div>
                                <div class="f-l pos-r pl-100">
                                    <label class="lb w-100 "><em class="mark"></em>服务类型：</label>
                                    <select id="serviceType" disabled="disabled" name="serviceType" class="select w-120 readonly">
                                        <c:forEach items="${fns:getServiceTypeWithDefault(order.serviceType) }" var="serm">
                                            <c:if test="${order.serviceType eq serm.columns.name }">
                                                <option value="${serm.columns.name }" selected="selected" >${serm.columns.name }</option>
                                            </c:if>

                                            <c:if test="${order.serviceType ne  serm.columns.name }">
                                                <option value="${serm.columns.name }">${serm.columns.name }</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                    <input type="text" class="input-text w-120 readonly hide" disabled="disabled" name="serviceType" value="${order.serviceType}"/>
                                </div>
                                <div class="f-l pos-r pl-80">
                                    <label class="lb w-80"><em class="mark"></em>服务方式：</label>
                                    <select id="serviceMode"  disabled="disabled" name="serviceMode" class="select w-120 readonly">
                                        <c:forEach items="${fns:getServiceModeWithDefault(order.serviceMode) }" var="serm">
                                            <c:if test="${order.serviceMode eq serm.columns.name }">
                                                <option value="${serm.columns.name }" selected="selected" >${serm.columns.name }</option>
                                            </c:if>

                                            <c:if test="${order.serviceMode ne  serm.columns.name }">
                                                <option value="${serm.columns.name }">${serm.columns.name }</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="f-l pos-r pl-80">
                                    <label class="lb w-80"><c:if test="${mustfill.columns.origin}"><em class="mark"></em></c:if>信息来源：</label>
                                    <select id="origin" name="origin"  disabled="disabled" class="select w-120 readonly hide">
                                        <c:choose>
                                            <c:when test="${fn:contains(listoriginlist,order.origin)}">

                                                <option value="">请选择</option>
                                                <c:forEach items="${listorigin}" var="serm">
                                                    <c:if test="${order.origin eq serm.columns.name }">
                                                        <option value="${serm.columns.name }" selected="selected" >${serm.columns.name }</option>
                                                    </c:if>

                                                    <c:if test="${order.origin ne  serm.columns.name }">
                                                        <option value="${serm.columns.name }">${serm.columns.name }</option>
                                                    </c:if>
                                                </c:forEach>

                                            </c:when>

                                            <c:otherwise>
                                                <option value="">请选择</option>
                                                <option value="${order.origin}" selected="selected">${order.origin }</option>
                                                <c:forEach items="${listorigin}" var="serm">
                                                    <option value="${serm.columns.name }">${serm.columns.name }</option>
                                                </c:forEach>

                                            </c:otherwise>

                                        </c:choose>
                                    </select>
                                </div>
                                <c:if test="${order.recordAccount=='1' }">
                                    <a class="f-l c-0383dc lh-26 pl-5" id="btn_More" onclick="showMore(this)">展开</a>
                                </c:if>
                            </div>
                            <div class="cl mb-10 hide" id="moreConWrap">
                                <div class="f-l ">
                                    <label class="w-100 f-l"><em class="mark"></em>厂家工单编号：</label>
                                    <input type="text" id="factoryNumber" class="input-text w-160 readonly " maxlength="32" readonly="readonly" name="factoryNumber" value="${order.factoryNumber }"/>
                                </div>
                            </div>
                            <div class="line"></div>
                            <div class="cl mt-10">
                                <div class="f-l pos-r pl-100">
                                    <label class="lb w-100"><em class="mark"></em>用户姓名：</label>
                                    <input type="text" id="customerName" class="input-text w-160 readonly" readonly="readonly" name="customerName"  value="${order.customerName }"/>
                                    <input type="hidden" class="input-text w-160" id="sign"   value=""/>
                                    <input type="hidden" class="input-text w-160"  id="siteMsgNums" value=""/>
                                </div>
                                <div class="f-l pos-r pl-100">
								<span class="lb w-100" id="mobileType">
									<%--<span class="f-r pr-5">:</span>
									<select class="select lb-sel f-r readonly" style="width:75px" disabled="disabled" id="mobileOrtel">
										<option value="1" <c:if test="${order.customerMobile.length() eq 11 }">selected="selected"</c:if> >手机号码</option>
										<option value="2" <c:if test="${order.customerMobile.length() ne 11 }">selected="selected"</c:if> >固定电话</option>
									</select>--%>
									<%--<em class="mark f-r">*</em>--%>
									<label class="lb w-100 text-r">联系方式1：</label>
								</span>
                                    <input type="text" id="customerMobile" class="input-text w-120 readonly" readonly="readonly" name="customerMobile" value="${order.customerMobile }"/>
                                </div>
                                <div class="f-l pos-r pl-80">
                                    <label class="lb w-80">联系方式2：</label>
                                    <input type="text" id ="customerTelephone" class="input-text w-120 readonly" readonly="readonly" name="customerTelephone"  value="${order.customerTelephone }"/>
                                </div>
                                <div class="f-l pos-r pl-80">
                                    <label class="lb w-80">联系方式3：</label>
                                    <input type="text" id="customerTelephone2" class="input-text w-120 readonly" readonly="readonly" name="customerTelephone2" value="${order.customerTelephone2 }"/>
                                </div>
                            </div>
                            <div class="cl mt-10 mb-10" >
                                <div class="pos-r pl-100" id="pcd">
                                    <label class="lb w-100"><em class="mark"></em>详细地址：</label>
                                    <%--<span class="select-box w-90 f-l mr-10 mustfill " id="showProvince" style="display:none">
									<select class="prov select" id="province"></select>
								</span>
								<span class="select-box w-90 f-l mr-10 mustfill" id="showCity" style="display:none">
			                    	<select class="city select" id="city" disabled="disabled"></select>
								</span>
								<span class="select-box w-90 f-l mr-10 mustfill" id="showArea" style="display:none">
			                    <select class="dist select" id="area" disabled="disabled"></select>
								</span>--%>
                                    <input type="text" class="input-text w-380 f-l readonly" readonly="readonly" id="customerAddress1" name="customerAddress1" value="${order.customerAddress }" autocomplete="off"/>
                                    <input type="hidden" id="customerAddress" name="customerAddress" value="${order.customerAddress}"/>
                                    <input type="hidden" id="lnglat" name="customerLnglat" value="${order.customerLnglat }"/>
                                </div>
                            </div>
                            <div class="line"></div>
                            <div class="cl mt-10" id="styleMark">
                                <div class="f-l pos-r pl-100">
                                    <label class="lb w-100"><em class="mark"></em>家电品牌：</label>
                                    <select  disabled="disabled"  class="select w-160 readonly " name="applianceBrand" id="applianceBrand" datatype="*" nullmsg="请选择品类！">

                                        <c:choose>
                                            <c:when test="${fn:contains(brandlist,order.applianceBrand)}">
                                                <option value="">请选择</option>
                                                <c:forEach items="${brand}" var="ba" varStatus="cast">
                                                    <c:if test="${order.applianceBrand eq ba.value  }">
                                                        <option value="${ba.key }" selected="selected">${ba.value }</option>
                                                    </c:if>
                                                    <c:if test="${order.applianceBrand ne ba.value }">
                                                        <option value="${ba.key }">${ba.value }</option>
                                                    </c:if>
                                                </c:forEach>
                                            </c:when>


                                            <c:otherwise>
                                                <option value="">请选择</option>
                                                <option value="${order.applianceBrand}" selected="selected">${order.applianceBrand}</option>
                                                <c:forEach items="${brand}" var="ba" varStatus="cast">
                                                    <option value="${ba.key }">${ba.value }</option>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>

                                    </select>
                                    <input type="text" id="applanceBrandMirror" class="input-text w-160 readonly hide" readonly="readonly" value="${order.applianceBrand }"/>
                                </div>
                                <div class="f-l pos-r pl-100">
                                    <label class="lb w-100"><em class="mark"></em>家电品类：</label>
                                    <select class="select w-120 readonly" name="applianceCategory" id="applianceCategory" datatype="*" nullmsg="请选择品类！"  disabled="disabled">

                                        <c:choose>
                                            <c:when test="${fn:contains(catelist,order.applianceCategory)}">
                                                <option value="">请选择</option>

                                                <c:forEach items="${category}" var="cad" varStatus="cast1">
                                                    <c:if test="${order.applianceCategory eq cad.columns.name  }">
                                                        <option value="${cad.columns.name }" selected="selected">${cad.columns.name}</option>
                                                    </c:if>

                                                    <c:if test="${order.applianceCategory ne cad.columns.name }">
                                                        <option value="${cad.columns.name }">${cad.columns.name }</option>
                                                    </c:if>
                                                </c:forEach>
                                            </c:when>


                                            <c:otherwise>
                                                <option value="">请选择</option>
                                                <option value="${order.applianceCategory}" selected="selected">${order.applianceCategory}</option>
                                                <c:forEach items="${category}" var="cad" varStatus="cast1">
                                                    <option value="${cad.columns.name }">${cad.columns.name }</option>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>

                                    </select>
                                </div>
                                <div class="f-l pos-r pl-80">
                                    <label class="lb w-80"><c:if test="${mustfill.columns.promiseTime}"><em class="mark"></em></c:if>预约日期：</label>
                                    <input id="promiseTime" type="text" onfocus="WdatePicker({minDate: '%y-%M-%d' })" class="input-text w-120 readonly" disabled="disabled" name="promiseTime" value="<fmt:formatDate value='${order.promiseTime }' pattern='yyyy-MM-dd'/>"/>
                                </div>
                                <div class="f-l pos-r pl-80">
                                    <label class="lb w-80"><c:if test="${mustfill.columns.promiseLimit}"><em class="mark"></em></c:if>时间要求：</label>
                                    <select id="promiseLimit" class="select w-120 readonly" name="promiseLimit"  disabled="disabled">
                                        <option value="">请选择</option>
                                        <c:forEach items="${proLimitList}" var="serm">
                                            <c:if test="${order.promiseLimit eq serm }">
                                                <option value="${serm }" selected="selected" >${serm }</option>
                                            </c:if>

                                            <c:if test="${order.promiseLimit ne  serm }">
                                                <option value="${serm }">${serm }</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="cl mt-10">
                                <div class="f-l pos-r pl-100 h-50">
                                    <label class="lb w-100"><c:if test="${mustfill.columns.customerFeedback}"><em class="mark"></em></c:if>服务描述：</label>
                                    <textarea type="text" class="input-text w-380 h-50 readonly" readonly="readonly" id="customerFeedback" name="customerFeedback">${order.customerFeedback}</textarea>
                                </div>
                                <div class="f-l pos-r pl-80 h-50">
                                    <label class="lb w-80"><c:if test="${mustfill.columns.remarks}"><em class="mark"></em></c:if>备注：</label>
                                    <textarea type="text" class="input-text h-50 w-320 readonly" readonly="readonly" id="remarks" name="remarks" >${order.remarks}</textarea>
                                </div>
                            </div>


                            <div class="cl mt-10">
                                <div class="f-l pos-r pl-100">
                                    <label class="lb w-100"><c:if test="${mustfill.columns.applianceModel}"><em class="mark"></em></c:if>产品型号：</label>
                                    <input type="text" class="input-text w-160 readonly" readonly="readonly" id="applianceModel" name="applianceModel" value="${order.applianceModel}"/>
                                    <input type="text" class="input-text w-160 readonly hide" hidden="hidden" id="count1" disabled="disabled" name="count1" value="${count1 }"/>
                                </div>
                                <div class="f-l pos-r pl-100">
                                    <label class="lb w-100 text-r"><c:if test="${mustfill.columns.applianceNum}"><em class="mark"></em></c:if>产品数量：</label>
                                    <input type="text" class="input-text w-120 readonly" readonly="readonly" id="applianceNum" name="applianceNum" value="${order.applianceNum }"/>
                                </div>
                                <div class="f-l pos-r pl-80 wrapss">
                                    <label class="lb w-80"><c:if test="${mustfill.columns.applianceBarcode}"><em class="mark"></em></c:if>内机条码：</label>
                                    <input type="text" style="width:180px;" class="input-text  readonly" readonly="readonly" id="applianceBarcode" name="applianceBarcode" value="${order.applianceBarcode}" title="${order.applianceBarcode}"/>
                                    <span class="weishu1" hidden="hidden">
									( <span id="incodeNum">0</span>位 )
								</span>
                                    <span class="ml-2 code1" hidden="hidden">
									<a href="javascript:showQRCode('${order.siteId }','1');" class="sficon sficon-scancode"></a>
								</span>
                                    <span class="va-t underline c-fe0101 codeConnectShow cPointer " preData="${order.applianceBarcode}"  id="codeInshow"></span >
                                </div>

                            </div>
                            <div class="cl mt-10">
                                <div class="f-l pos-r pl-100">
                                    <label class="lb w-100"><c:if test="${mustfill.columns.applianceBuyTime}"><em class="mark"></em></c:if>购买日期：</label>
                                    <input id="buyDate" type="text" onfocus="WdatePicker({maxDate: '%y-%M-%d' })" class="input-text w-160 readonly" disabled="disabled"  name="applianceBuyTime" value="<fmt:formatDate value='${order.applianceBuyTime }' pattern='yyyy-MM-dd'/>"/>
                                </div>
                                <div class="f-l pos-r pl-100">
                                    <c:choose>
                                        <c:when test="${not empty malllist}">
                                            <label class="lb w-100"><c:if test="${mustfill.columns.pleaseReferMall}"><em class="mark">*</em></c:if>购机商场：</label>
                                            <span class="w-120">
									<select class="select ${mustfill.columns.pleaseReferMall?'mustfill':''} readonly" disabled="diabled"  id="pleaseReferMall"  multiline="false" name="pleaseReferMall" style="width:100%;height:25px" panelMaxHeight="300px" <c:if test="${mustfill.columns.pleaseReferMall}">datatype="*" nullmsg="请选择购机商场"</c:if>>
										<option value="">请选择</option>
										<c:forEach items="${malllist }" var="mall">
                                            <option value="${mall.columns.mall_name } " ${order.pleaseReferMall eq mall.columns.mall_name ?'selected':''}>${mall.columns.mall_name }</option>
                                        </c:forEach>
									</select>
								</span>
                                        </c:when>
                                        <c:otherwise>
                                            <label class="lb w-100"><c:if test="${mustfill.columns.pleaseReferMall}"><em class="mark">*</em></c:if>购机商场：</label>
                                            <input type="text" value="${order.pleaseReferMall}" name="pleaseReferMall" class="input-text w-120 ${mustfill.columns.pleaseReferMall?'mustfill':''} readonly" readonly="readonly" <c:if test="${mustfill.columns.pleaseReferMall}">datatype="*" nullmsg="请输入购机商场"</c:if>>
                                        </c:otherwise>
                                    </c:choose>


                                    <%--<label class="lb w-100 "><c:if test="${mustfill.columns.pleaseReferMall}"><em class="mark"></em></c:if>购机商场：</label>
								<input type="text" id="pleaseReferMall" name="pleaseReferMall" class="input-text w-120 readonly" readonly="readonly" value="${order.pleaseReferMall}">--%>
                                </div>
                                <div class="f-l pos-r pl-80 wrapss">
                                    <label class="w-80 pos "><c:if test="${mustfill.columns.applianceMachineCode}"><em class="mark"></em></c:if>外机条码：</label>
                                    <input type="text" style="width:180px;" class="input-text  readonly" readonly="readonly" id="applianceMachineCode" name="applianceMachineCode" value="${order.applianceMachineCode}" title="${order.applianceMachineCode}"/>
                                    <span class="ml-2 mr-2 weishu2" hidden="hidden">
									( <span id="outcodeNum">0</span>位 )
								</span>
                                    <span class="ml-2 mr-2 code2"  hidden="hidden">
									<a href="javascript:showQRCode('${order.siteId }','2');" class="sficon sficon-scancode"></a>
								</span>
                                    <span class="va-t underline c-fe0101 codeConnectShow cPointer" preData="${order.applianceMachineCode}"  id="codeOutshow"></span>
                                </div>


                            </div>
                            <div class="mt-10 cl mb-10">
                                <div class="f-l ">
                                    <label class="f-l w-100"><c:if test="${mustfill.columns.warrantyType}"><em class="mark"></em></c:if>保修类型：</label>
                                    <select class="select  w-160 readonly " name="warrantyType"  disabled="disabled" id="warrantyType">
                                        <option value="">请选择</option>
                                        <c:if test="${order.warrantyType eq '1' }">
                                            <option value="1" selected = "selected">保内</option>
                                            <option value="2">保外</option>
                                        </c:if>
                                        <c:if test="${order.warrantyType eq '2' }">
                                            <option value="1">保内</option>
                                            <option value="2" selected = "selected">保外</option>
                                        </c:if>
                                        <c:if test="${order.warrantyType ne '1' && order.warrantyType ne '2'}">
                                            <option value="1">保内</option>
                                            <option value="2">保外</option>
                                        </c:if>
                                    </select>
                                </div>
                                <div class="f-l pos-r pl-100">
                                    <label class="w-100 pos"><c:if test="${mustfill.columns.level}"><em class="mark"></em></c:if>重要程度：</label>
                                    <select class="select w-120 readonly" name="level" id="level"  disabled="disabled">
                                        <option value="">请选择</option>
                                        <option value="1" <c:if test="${order.level eq '1' }">selected="selected"</c:if>>紧急</option>
                                        <option value="2" <c:if test="${order.level eq '2' }">selected="selected"</c:if>>一般</option>
                                    </select>
                                </div>
                                <div class="f-l">
                                    <label class="f-l w-80">报修时间：</label>
                                    <input type="text" class="input-text w-130 readonly dischange" readonly="readonly" name="repairTime" value="<fmt:formatDate value='${order.repairTime }' pattern='yyyy-MM-dd HH:mm:ss'/>"/>
                                </div>
                                <div class="f-l pos-r pl-80">
                                    <label class="pos w-80">登记人：</label>
                                    <input type="text" class="input-text w-110 readonly dischange" readonly="readonly" name="messengerName" value="${order.xm}"/>
                                </div>
                            </div>
                            <%-- <div class="lh-20 pl-25 f-14">
							<div  id="codeShow">
								<i class="sficon sficon-note"></i>
								<span class="codeIn">该内机条码<span class="va-t underline c-fe0101 codeConnectShow cPointer" preData="${order.applianceBarcode}" style="cursor:hand;" id="codeInshow"></span>记录<span class="douhao">，</span></span>
								<span class="codeOut">该外机条码<span class="va-t underline c-fe0101 codeConnectShow cPointer" preData="${order.applianceMachineCode}" style="cursor:hand;" id="codeOutshow"></span>记录</span>
							</div>
						</div> --%>
                        </div>
                    </form>

                    <div class="tabCon pt-10">
                        <div class="processWrap">
                            <c:forEach var="pros" items="${fns:getOrderProcess(order.processDetail)}">
                                <p class="processItem">
                                    <span class="time">${pros.time}</span>
                                    <span>${pros.content}</span>
                                </p>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div id="serveFb" class="mt-25">
                    <div class="tabBarP">
                        <a href="javascript:;" class="tabswitch current">服务反馈</a>
                        <a href="javascript:showSQMsg();" class="tabswitch ">备件申请</a>
                        <a href="javascript:showSYMsg();" class="tabswitch ">备件使用</a>
                        <a href="javascript:showOldFitting();" class="tabswitch">旧件信息</a>
                        <a href="javascript:showGoodsMsg();" class="tabswitch">商品信息</a>
                    </div>
                    <div class="tabCon">
                        <div class="cl mt-10">
                            <div class="f-l pos-r txtwrap1">
                                <label class="lb lb1">服务工程师：</label>
                                <input type="text" name="fankui" class="input-text w-160 readonly" readonly="readonly"  value="${order.employeName}" title="手机号：${msg2Mobiles}"/>
                            </div>
                            <div class="f-l pos-r pl-100">
                                <label class="lb text-r w-100">服务状态：</label>
                                <input type="text" name="fankui" class="input-text w-120 readonly" readonly="readonly"  value="${dispStatus}"/>
                            </div>
                            <div class="f-l pos-r txtwrap2">
                                <label class="lb lb2">故障现象：</label>
                                <input type="text" name="fankui" class="input-text w-120 readonly" readonly="readonly"  value="${order.malfunctionType}"/>
                            </div>
                        </div>
                        <div class="cl mt-10">
                            <div class="f-l pos-r txtwrap1">
                                <label class="lb lb1">收费总额：</label>
                                <div class="priceWrap w-140 readonly">
                                    <input type="text" name="fankui" class="input-text readonly" readonly="readonly"  value="${fns:getOrderTotalFee(order.auxiliaryCost, order.serveCost, order.warrantyCost)}"/>
                                    <span class="unit">元</span>
                                </div>
                            </div>
                            <div class="f-l pl-10">
                                <label class="f-l">（辅材收费：</label>
                                <div class="priceWrap w-80 readonly f-l">
                                    <input type="text" name="fankui" class="input-text readonly" readonly="readonly" value="${order.auxiliaryCost}" />
                                    <span class="unit">元</span>
                                </div>
                            </div>
                            <div class="f-l pl-10">
                                <label class="f-l">服务收费：</label>
                                <div class="priceWrap w-80 readonly f-l">
                                    <input type="text" name="fankui" class="input-text readonly" readonly="readonly" value="${order.serveCost}" />
                                    <span class="unit">元</span>
                                </div>
                            </div>
                            <div class="f-l pl-10">
                                <label class="f-l">延保收费：</label>
                                <div class="priceWrap w-80 readonly f-l">
                                    <input type="text" name="fankui" class="input-text readonly" readonly="readonly" value="${order.warrantyCost}" />
                                    <span class="unit">元</span>
                                </div>
                            </div>
                            <span class="pd-5 f-l">）</span>
                            <c:if test="${not empty collectionslist}">
                                <c:forEach items="${collectionslist}" var="col">
                                    <c:set value="${sum + col.columns.payment_amount}" var="sum"/>
                                    <%--<c:if test="${col.columns.payment_type=='0'}">
									<c:set value="${sum1 + col.columns.payment_amount}" var="sum1"/>
								</c:if>
								<c:if test="${col.columns.payment_type=='1'}">
									<c:set value="${sum2 + col.columns.payment_amount}" var="sum2"/>
								</c:if>--%>
                                </c:forEach>
                                <div class="f-l lh-26">
                                    <div> 无现金收款：${sum}元<%--（
									<span>支付宝：${sum1}元</span>
									<span>微信：${sum2}元</span>）--%>
                                        <a class="proofImg c-0383dc" id="imgshows">凭证
                                            <c:forEach items="${collectionslist}" var="col">
                                                <c:if test="${not empty col.columns.imgs}">
                                                    <img src="${commonStaticImgPath}${col.columns.imgs}"/>
                                                </c:if>
                                            </c:forEach>
                                        </a>
                                    </div>
                                        <%--<span><a class="c-0383dc" href="javascript:showPz();">凭证</a></span>--%>
                                </div>
                            </c:if>

                        </div>
                        <div class="cl mt-10">
                            <div class="pos-r txtwrap1">
                                <label class="lb lb1">反馈内容：</label>
                                <div class="readonly processWrap2" style="width:807px">
                                    <c:forEach var="fbItems" items="${feedbackInfo.feedbackResults}">
                                        <p class="processItem">
                                            <span class="time">${fbItems.feedbackTime} </span>
                                            <span>${fbItems.feedbackName }：${fbItems.feedbackResults }</span>
                                        </p>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <div class="cl mt-10">
                            <div class="pos-r txtwrap1 h-50" id="Imgprocess2">
                                <label class="lb lb1">过程图片：</label>
                                <c:forEach var="fbImgItems" items="${feedbackInfo.feedbackImgs}">
                                    <c:if test="${not empty fbImgItems.fbImgPath }">
                                        <c:forEach var="fbImgItem" items="${fbImgItems.fbImgPath}">
                                            <div class="f-l mr-10">
                                                <div class="imgWrap">
                                                    <img src="${commonStaticImgPath}${fbImgItem}">
                                                    <p class="lh-20">${fbImgItems.fbImgTime}</p>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <div class="tabCon">
                        <div class="cl text-c">
                            <span class="caption_lb">工单关联配件申请</span>
                            <input onclick="addbjsq()" type="button" class="mr-20 mt-5 w-70 sfbtn sfbtn-opt f-r pos-r " value="备件申请" />
                        </div>
                        <div class="" style="max-height:140px;overflow:auto;">
                            <table id="pjsq" class="table table-border table-bordered table-bg table-relatedorder">
                                <thead>
                                <tr>
                                    <th class="w-110">备件条码</th>
                                    <th class="w-250">备件名称</th>
                                    <th class="w-150">备件型号</th>
                                    <th class="w-50">数量</th>
                                    <th class="w-100">备件状态</th>
                                    <th class="w-140">申请时间</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                        <%--<table id="pjsq" class="table table-border table-bordered table-bg table-relatedorder">
						<caption>工单关联配件申请</caption>
						<thead>
							<tr>
								<th class="w-180">备件条码</th>
								<th class="w-260">备件名称</th>
								<th class="w-120">备件型号</th>
								<th class="w-50">数量</th>
								<th class="w-70">状态</th>
							</tr>
						</thead>
					</table>--%>
                        <div class="cl mt-10 pos-r txtwrap1 showimg">
                        </div>
                    </div>
                    <div class="tabCon">
                        <div class="cl text-c">
                            <span class="caption_lb">工单关联配件使用</span>
                            <input onclick="useFit()" type="button" class="btn-usebj mr-20 w-70 mt-5 sfbtn sfbtn-opt f-r pos-r"  value="备件使用" />
                        </div>
                        <div class="" style="max-height:140px;overflow:auto;">
                            <table id="pjsy" class="table table-border table-bordered table-bg table-relatedorder">
                                <thead>
                                <tr>
                                    <th class="w-180">备件条码</th>
                                    <th class="w-260">备件名称</th>
                                    <th class="w-120">备件型号</th>
                                    <th class="w-90">最新入库价格</th>
                                    <th class="w-80">工程师价格</th>
                                    <th class="w-70">零售价格</th>
                                    <th class="w-50">数量</th>
                                    <th class="w-70">收费金额</th>
                                    <th class="w-70">状态</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                        <%--<div style="width: 920px;overflow: auto;">
					<table id="pjsy" class="table table-border table-bordered table-bg table-relatedorder">
						<caption>工单关联配件使用</caption>
						<thead>
							<tr>
								<th class="w-180">备件条码</th>
								<th class="w-260">备件名称</th>
								<th class="w-120">备件型号</th>
								<th class="w-90">最新入库价格</th>
								<th class="w-80">工程师价格</th>
								<th class="w-70">零售价格</th>
								<th class="w-50">数量</th>
								<th class="w-70">收费金额</th>
								<th class="w-70">状态</th>
							</tr>
						</thead>
					</table>
					</div>--%>
                    </div>

                    <div class="tabCon">
                        <div style="width: 920px;overflow: auto;">
                            <table class="table table-border table-bordered table-bg table-relatedorder">
                                <caption>工单关联旧件信息</caption>
                                <thead>
                                <tr>
                                    <th class="w-160">旧件条码</th>
                                    <th class="w-150">旧件名称</th>
                                    <th class="w-160">旧件型号</th>
                                    <th class="w-70">旧件品牌</th>
                                    <th class="w-70">是否原配</th>
                                    <th class="w-70">登记数量</th>
                                    <th class="w-70">状态</th>
                                    <th class="w-120">登记时间</th>
                                </tr>
                                </thead>
                                <tbody class="oldtbody">
                                </tbody>
                            </table>
                        </div>
                        <div class="cl mt-10 pos-r txtwrap1" id="oldfittingimg">
                        </div>
                    </div>
                    <div class="tabCon">
                        <div style="width: 920px;overflow: auto;">
                            <table class="table table-border table-bordered table-bg table-relatedorder">
                                <caption>工单关联商品销售</caption>
                                <thead>
									<tr>
										<th class="w-160">订单编号</th>
										<th class="w-200">商品名称</th>
										<th class="w-70">购买数量</th>
										<th class="w-70">入库价格</th>
										<th class="w-70">成交价</th>
										<th class="w-70">成交总额</th>
										<th class="w-70">实收金额</th>
										<th class="w-70">提成金额</th>
										<th class="w-120">销售人员</th>
										<th class="w-150">登记时间</th>
										<th class="w-120">状态</th>
									</tr>
								</thead>
                                <tbody class="oldtbody" id="goodsMsg">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>


            <div class="btnMenubox pb-80">
                <%--<c:if test="${'7' ne order.orderType}">--%>
                    <%--<sfTags:pagePermission authFlag="ORDER_MODORDER_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt" id="xggd" value="修改工单" type="button" />'></sfTags:pagePermission>--%>
                    <%--<input class="sfbtn sfbtn-opt sbtn" id="wxgd" onclick="showwxgd('${order.orderType}')" value="无效工单" type="button"/>--%>
                <%--</c:if>--%>
                <%--<input class="sfbtn sfbtn-opt notDispatch sbtn" onclick=showzbpg() id="zbpg" value="暂不派工" type="button" />--%>
                <%--<input class="sfbtn sfbtn-opt notDispatch sbtn" onclick="msgInform2('${order.id}')" id="dxcd" value="短信催单" type="button" />--%>
                <%--<input class="sfbtn sfbtn-opt sbtn" id="zp" value="转派" type="button" onclick="Turntosend('${order.customerLnglat}','${order.customerAddress}')"/>--%>
                <%--&lt;%&ndash;<input class="sfbtn sfbtn-opt sbtn" value="反馈封单" id="btn-fbOrder" type="button" />&ndash;%&gt;--%>
                <%--<sfTags:pagePermission authFlag="ORDER_FEEDBACKCLOSE_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt sbtn" value="反馈封单" id="btn-fbOrder" type="button" />'></sfTags:pagePermission>--%>
                <%--<!-- <input class="sfbtn sfbtn-opt sbtn" value="联系工程师" id="btn-contactServer" type="button"/> -->--%>
                <%--<input class="sfbtn sfbtn-opt sbtn" value="短信通知"  onclick="senMagPopup('${order.id}')" type="button" />--%>
                <%--<input class="sfbtn sfbtn-opt sbtn" type="button" id="repeatOrder"   target="_blank" onclick="dygd('${order.id}')" value="打印工单" />--%>
                <%--<input class="sfbtn sfbtn-opt sbtn" type="button" id="repeatOrder_custom"  onclick="dygdcustom('${order.id}')" value="打印工单" style="display: none;"/>--%>
                 <input class="sfbtn sfbtn-opt sbtn" value="新建工单" type="button" onclick="newOrder('${order.id}')"/>
                <sfTags:pagePermission authFlag="ORDER_MARKORDER_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt sbtn" value="标记工单" type="button" onclick="showMarkOrder(\'${order.id}\')"/>'></sfTags:pagePermission>

              <%--  <c:if test="${whereMark eq 1 }">
                    <div class="btnWrap text-c" style="bottom:0">
                        <a class="sfbtn sfbtn-opt3 sbtn " onclick="previousOrder('${order.id}','${order.number }')">上一单</a>
                        <a class="sfbtn sfbtn-opt3 sbtn " onclick="nextOrder('${order.id}','${order.number }')" >下一单</a>
                    </div>
                </c:if>--%>

                <sf:hasPermission perm="ORDERMGM_STAYVISTORDER_PERM_ZJFD_BTN"><input class="sfbtn sfbtn-opt zjfd sbtn" onclick="showzjfd()" value="直接封单" type="button"/></sf:hasPermission>

            </div>
        </div>
        <c:if test="${whereMark eq 1 }">

        </c:if>
    </div>
</div>
<!-- 暂不派工提示框 -->
<div class="popupBox notDispatch showzbpgdiv">
    <h2 class="popupHead">
        暂不派工
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain " >
            <div class="txtwrap1 pos-r mb-30">
                <label class="lb lb1"><em class="mark">*</em>暂不派工理由：</label>
                <textarea id="reasonofzbpg" class="textarea"></textarea>
            </div>
            <div class="text-c pl-30">
                <input onclick="savezbpg('${order.id}')" type="button" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
                <input type="button" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" onclick="cancelBox(this);"/>
            </div>
        </div>
    </div>
</div>
<div class="popupBox fbOrder">
    <h2 class="popupHead">
        反馈封单
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
        <form action="" id="generationOrderFrom">
            <div class="popupMain" ><div class="pcontent  pd-15">
                <div id="fbBaseInfo">
                    <div class="tabBarP cl">
                        <a href="javascript:;" class="tabswitch current">服务信息</a>
                    </div>
                    <div class="tabCon">
                        <div>
                            <input type="hidden"  name="orderId" value="${order.id }" datatype="*">
                            <input type="hidden"  name="disOrderId" value="${disOrder.columns.id }" datatype="*">
                            <div class="cl mt-10">
                                <div class="f-l pos-r txtwrap1" id="stateBox">
                                    <!--    <label class="lb lb1"><em class="mark">*</em>反馈类型：</label>
                                <a class="f-l w-80 selectLabel selectedLabel">
                                    <input hidden="hidden" name="feedTytpe" value="1" />
                                    服务完成<i class="icon-sel"></i>
                                </a>
                                <a class="f-l ml-5 w-80 selectLabel">
                                    <input hidden="hidden" name="feedTytpe" value="2" />
                                    过程反馈<i class="icon-sel"></i>
                                </a> -->
                                    <!--   <a class="f-l ml-5 w-80 selectLabel">
                                    <input hidden="hidden" name="feedTytpe" value="3" />
                                    无效工单<i class="icon-sel"></i>
                                </a> -->
                                    <input type="hidden" name="feedbackType"/>
                                    <%--<label class="lb lb1"><em class="mark">*</em>反馈类型：</label>
								<span class="select-box w-110 mustfill">
									<select class="select" name="feedbackType">
										<option value="1">服务完成</option>
										<option value="2">过程反馈</option>
										<option value="3">无效工单</option>
									</select>
								</span>--%>
                                </div>
                            </div>
                            <div class="cl mt-10">
                                <div class="f-l pos-r txtwrap1">
                                    <label class="lb lb1"><em class="mark">*</em>保修类型：</label>
                                    <span class="select-box w-110 mustfill">
									<select class="select" id="warrantyType1" name="warrantyType" datatype="*" nullmsg="请选择保修类型">
									<c:choose>
                                        <c:when test="${order.warrantyType eq '1'}">
                                            <option value="1" selected="selected">保内</option>
                                            <option value="2">保外</option>
                                            <!-- <option value="3">保内转保外</option> -->
                                        </c:when>
                                        <c:when test="${order.warrantyType eq '2'}">
                                            <option value="1">保内</option>
                                            <option value="2" selected="selected">保外</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="">请选择</option>
                                            <option value="1">保内</option>
                                            <option value="2">保外</option>
                                            <!-- <option value="3">保内转保外</option> -->
                                        </c:otherwise>
                                    </c:choose>
									</select>
								</span>
                                </div>
                                <div class="f-l pos-r txtwrap2">
                                    <label class="lb lb2">服务类型：</label>
                                    <span class="select-box w-110">
									<select class="select" name="serviceType">
										<c:forEach items="${fns:getServiceTypeWithDefault(order.serviceType) }" var="stype">
                                            <c:if test="${stype.columns.name eq order.serviceType}">
                                                <option value="${stype.columns.name }" selected="selected">${stype.columns.name }</option>
                                            </c:if>
                                            <c:if test="${stype.columns.name ne order.serviceType}">
                                                <option value="${stype.columns.name }">${stype.columns.name }</option>
                                            </c:if>
                                        </c:forEach>
									</select>
								</span>
                                </div>
                                <div class="f-l pos-r txtwrap2">
                                    <label class="lb lb2">服务方式：</label>
                                    <span class="select-box w-110">
									<select class="select" name="serviceMode">
										<c:forEach items="${fns:getServiceModeWithDefault(order.serviceMode) }" var="stype">
                                            <c:if test="${stype.columns.name eq order.serviceMode}">
                                                <option value="${stype.columns.name }" selected="selected">${stype.columns.name }</option>
                                            </c:if>
                                            <c:if test="${stype.columns.name ne order.serviceMode}">
                                                <option value="${stype.columns.name }">${stype.columns.name }</option>
                                            </c:if>
                                        </c:forEach>
									</select>
								</span>
                                </div>
                                <div class="f-l pos-r txtwrap2">
                                    <label class="lb lb2">服务工程师：</label>
                                    <input type="text" class="input-text w-130 readonly" readonly="readonly" value="${order.employeName }"/>
                                </div>
                            </div>
                            <div class="cl mt-10">
                                <div class="f-l pos-r txtwrap1">
                                    <label class="lb lb1">家电品类：</label>
                                    <span class="select-box w-110">
									<select class="select" name="applianceCategory">
										<c:forEach items="${category }" var="ca" varStatus="cast">
                                            <c:if test="${ca.columns.name eq order.applianceCategory}">
                                                <option value="${ca.columns.name }" selected="selected">${ca.columns.name }</option>
                                            </c:if>
                                            <c:if test="${ca.columns.name ne order.applianceCategory}">
                                                <option value="${ca.columns.name }">${ca.columns.name }</option>
                                            </c:if>
                                        </c:forEach>
									</select>
								</span>
                                </div>
                                <div class="f-l pos-r txtwrap2">
                                    <label class="lb lb2">产品型号：</label>
                                    <input type="text" class="input-text w-110" value="${order.applianceModel}" name="applianceModel"/>
                                </div>
                                <div class="f-l pos-r txtwrap2">
                                    <label class="lb lb2"><em class="mark">*</em>内机条码：</label>
                                    <input type="text" class="input-text w-110 mustfill" value="${order.applianceBarcode}" name="applianceBarcode" datatype="*" nullmsg="请输入内机条码"/>
                                </div>
                                <div class="f-l pos-r txtwrap2">
                                    <label class="lb lb2">外机条码：</label>
                                    <input type="text" class="input-text w-130" value="${order.applianceMachineCode}" name="applianceMachineCode"/>
                                </div>
                            </div>
                            <div class="cl mt-10">
                                <div class="f-l pos-r txtwrap1">
                                    <label class="lb lb1">故障现象：</label>
                                    <input type="text" class="input-text" style="width:534px;" value="${order.applianceModel}" id="malfunctionType1" name="malfunctionType"/>
                                </div>
                            </div>
                            <div class="pos-r mt-10 txtwrap1">
                                <label class="lb lb1"><em class="mark">*</em>反馈描述：</label>
                                <input type="text" class="input-text mustfill" name="feedback" id="feedback" datatype="*" nullmsg="请输入反馈描述" />
                            </div>
                            <div class="pos-r mt-10 txtwrap1 cl allDuringImgs" id="">
                                <label class="lb lb1">过程图片：</label>
                                <div id="Imgprocess1">
                                    <c:if test="${not empty duringFeedImgs }">
                                        <c:forEach items="${duringFeedImgsArr }" var="str" varStatus="da">
                                            <div class="f-l imgWrap1" id="img${da.index}">
                                                <div class="imgWrap">
                                                    <img src="${commonStaticImgPath}${str}" id="${commonStaticImgPath}${str}"></img>
                                                </div>
                                                <a class="sficon btn-delimg" onclick="deleteImg('img${da.index}')"></a>
                                                <input type="hidden" value="${str}" name="pickerImg" >
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                </div>

                                <div id="Imgprocess" class="f-l" >
                                </div>
                                <div class="f-l mr-10">
                                    <div class="imgWrap jiahao" id="jiahao" >
                                        <div id="filePicker-add">
                                            <a href="javascript:;" class="btn-upload"></a>
                                        </div>
                                        <p class="lh-20">最多可上传8张照片</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="tabBarP cl mt-10" style="overflow: visible;" id="bjNavBox">
                    <a href="javascript:fittingApply('pjmg');" class="tabswitch current">备件使用</a>
                    <a href="javascript:fittingApplyrecord();" class="tabswitch ">备件申请</a>

                </div>
                <div class="cl text-c" id="bjNavBox2">
                    <span class="caption_lb">工单关联配件使用</span>
                    <span class="caption_lb hide">工单关联配件申请</span>
                    <input onclick="useFit()" type="button" class="btn-usebj mr-20 w-70 mt-5 sfbtn sfbtn-opt f-r pos-r"  value="备件使用" />
                    <input onclick="addbjsq()" type="button" class="mr-20 mt-5 w-70 sfbtn sfbtn-opt f-r pos-r hide" value="备件申请" />
                </div>
                <div class="" style="max-height:140px;overflow:auto;">
                    <table id="pjmg" class="table table-border table-bordered table-bg table-relatedorder">
                        <thead>
                        <tr>
                            <th class="w-110">备件条码</th>
                            <th class="w-250">备件名称</th>
                            <th class="w-150">备件型号</th>
                            <th class="w-50">数量</th>
                            <th class="w-100">备件状态</th>
                            <th class="w-140">申请时间</th>
                        </tr>
                        </thead>
                    </table>
                </div>
                <div class="tabBarP cl mt-10">
                    <a href="javascript:;" class="tabswitch current">收费信息</a>
                    <!-- <input id="btn-usebj" type="button" class="mr-10 sfbtn sfbtn-opt3 f-r" value="收费信息" /> -->
                </div>
                <div class="tabCon" style="display:block">
                    <div>
                        <div class="cl mt-10">
                            <div class="f-l pos-r txtwrap1">
                                <label class="lb lb1">服务收费：</label>
                                <div class="priceWrap w-110">
                                    <input type="text" class="input-text" name="serveCost" id="serveCost" value="${order.serveCost }"  onchange="cost()"/>
                                    <span class="unit">元</span>
                                </div>
                            </div>
                            <div class="f-l pos-r txtwrap2">
                                <label class="lb lb2">辅材收费：</label>
                                <div class="priceWrap w-110 readonly">
                                    <input type="text" class="input-text readonly" id="auxiliaryCost" readonly="readonly" name="auxiliaryCost" onchange="cost()"/>
                                    <span class="unit">元</span>
                                </div>
                            </div>
                            <div class="f-l pos-r txtwrap2">
                                <label class="lb lb2">延保收费：</label>
                                <div class="priceWrap w-110">
                                    <input type="text" class="input-text" id="warrantyCost" value="${order.warrantyCost  }" name="warrantyCost" onchange="cost()"/>
                                    <span class="unit">元</span>
                                </div>
                            </div>
                            <div class="f-l pos-r txtwrap2">
                                <label class="lb lb2">收费总额：</label>
                                <div class="priceWrap w-130 readonly">
                                    <input type="text" class="input-text readonly" readonly="readonly" id="zongCost"/>
                                    <span class="unit">元</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="text-c mt-10">
                    <input type="button" class="mr-10 w-70 sfbtn sfbtn-opt" value="服务完成" id="Butorder"/>
                    <input type="button" class="mr-10 w-70 sfbtn sfbtn-opt" value="过程反馈" onclick="ReplaceEmploye()"/>
                    <input type="button" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" onclick="cancelCloseOrder();">
                </div>
            </div>
            </div>
        </form>
    </div>
</div>

<!-- 备件使用弹出框 -->
<div class="popupBox beijian usebj">
    <h2 class="popupHead">
        备件使用
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain" >
            <div class="cl mb-10" id="beijianshiyong">
                <label class="w-100 f-l"><em class="mark">*</em>备件名称：</label>
                <select class="select f-l w-230 mustfill" id="finame">
                </select>
                <span class="c-666 lh-26 ml-10">请选择工程师备件库存</span>
            </div>
            <div class="cl mb-15">
                <label class="f-l w-100">备件条码：</label>
                <input type="text " name="code" class="input-text w-140 f-l readonly" readonly="readonly"/>
                <label class="f-l w-100">备件型号：</label>
                <input type="text" name="type" class="input-text w-140 f-l readonly" readonly="readonly" />
            </div>
            <div class="cl mb-15">
                <label class="f-l w-100"><em class="mark">*</em>使用数量：</label>
                <input id="finum" name="num" type="text" class="input-text w-140 f-l mustfill" />
                <label class="f-l w-100">是否收费：</label>
                <div class="f-l" id="isPayBox">
                    <label class="radiobox f-l mt-3" for="noPay"> <input type="radio" id="noPay" name="isPayRadio" />否 </label>
                    <label class="radiobox f-l mt-3 ml-10" for="isPay"> <input type="radio" id="isPay" name="isPayRadio" /> 是</label>
                    <div class="priceWrap f-l w-60 ml-10 hide" id="hideMoney">
                        <input id="payPrice" type="text" class="input-text mustfill" /><span class="unit">元</span>
                    </div>
                </div>
            </div>
            <div class="text-c pl-20 mt-30 pt-15">
                <input type="button" id="bj_use" onclick="tj_bjuse()" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
                <input type="button"  name="bjca" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" />
            </div>
        </div>
    </div>
</div>

<!-- 备件申请 弹出框-->
<div class="popupBox beijian applybj" id="fitAp">
    <h2 class="popupHead">
        备件申请
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain" >
            <form id="bj_applyT" method="post" action="">
                <div class="cl mb-10">
                    <label class="f-l w-100">备件条码：</label>
                    <input name="acode" type="text " class="input-text w-140 f-l" />
                    <label class="w-100 f-l">备件名称：</label>
                    <input name="aname" type="text" class="input-text w-140 f-l" />
                </div>
                <div class="cl mb-10">
                    <label class="f-l w-100">备件型号：</label>
                    <input name="atype" type="text" class="input-text w-140 f-l readonly" readonly="readonly" />
                    <label class="f-l w-100">申请数量：</label>
                    <input name="anum" type="text" class="input-text w-140 f-l" />
                </div>
                <div class="cl txtwrap pos-r h-50 pr-5">
                    <label class="lb w-100">申请备注：</label>
                    <textarea name="appremarks" class="textarea h-50" value=""></textarea>
                </div>
                <div class="text-c pl-20 mt-30">
                    <input type="button" onclick="tj_bjapply()"  class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
                    <input type="button" name="bjca" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" />
                </div>
                <input type="hidden" name="fittingId" value="">
            </form>
        </div>
    </div>
</div>


<!-- 无效工单提示框 -->
<div class="popupBox notDispatch showwxgddiv">
    <h2 class="popupHead">
        无效工单
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain " >
            <div class="txtwrap1 pos-r mb-30">
                <label class="lb lb1"><em class="mark">*</em>无效工单理由：</label>
                <textarea id="reasonofwxgd" class="textarea"></textarea>
            </div>
            <div class="text-c pl-30">
                <input onclick="savewxgd('${order.id}')" type="button" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
                <input type="button" onclick="closeDivWX()"  class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" />
            </div>
        </div>
    </div>
</div>

<!-- 转派工单 -->
<div class="popupBox dispatch turnDispatch">
    <h2 class="popupHead">
        转派
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain cl" >
            <div class="f-l serversWrap">
                <div class="searchbox">
                    <input id="empSearchName" type="text" placeholder="请输入工程师姓名" class="input-text" />
                    <a href="javascript:;" class="btn-search"><i class="Hui-iconfont Hui-iconfont-search2 f-16"></i></a>
                </div>
                <div class="lh-26 cl">
                    <p class="f-l">
                        <span class="c-005aab">当前工程师：</span>
                        <span id="empName">${order.employeName }</span>
                    </p>
                </div>


                <div class="mt-5 serverlistWrap">
                    <div class="tableWrap">
                        <table class="table table-bg table-border table-serverlist">
                            <thead>
                            <th class="w-90" style="border-left: none;">工程师姓名</th>
                            <th class="w-100">未完成工单</th>
                            <th class="w-100">今日已完成</th>
                            <th class="w-80">选择</th>
                            </thead>

                            <tbody id="zhijiepaidan">

                            </tbody>
                        </table>
                    </div>
                    <div class="serversName">
                        <div class="txtwrap1 pos-r">
                            <label class="lb lb1" style="width:75px;"><em class="mark">*</em>转派原因：</label>
                            <textarea class="textarea mustfill" style="margin-left: 5px;" id="transferReasons"></textarea>
                        </div>
                        <div class="txtwrap2 pos-r">
                            <label class="lb lb2 mt-3"><em class="c-fe0101">派工至</em>：</label>
                            <p class="lh-30"  id="nameWrap"></p>
                            <input type="button" class="w-70 sfbtn sfbtn-opt" value="确认派工"  onclick="dispa()" />
                            <input type="hidden" name= "employeId" id="employeId">
                            <input type="hidden" name= "orderId" id="orderId" value="${order.id }">
                            <input type="hidden" name= "disorderId" id="disorderId" value="${disOrder.columns.id }">
                        </div>
                    </div>
                </div>
            </div>
            <div class="f-r w-460">
                <div class="cl mb-10">
                    <div class="f-l w-220 bk-gray" id="dispatch_map_container" style="height: 120px;">
                        <!-- 地图 -->
                    </div>
                    <div class="f-l w-230 ml-10 f-13 pt-10" style="height: 120px;">
                        <p class=""><strong class="custNam">${order.customerName}</strong></p>
                        <p class=""><strong class="custMob">${order.customerMobile}</strong></p>
                        <p class="custAddr">${order.customerAddress}</p>
                    </div>
                </div>
                <div class="cl mb-10">
                    <input type="text"  class="input-text w-330 f-l" id="arroundCustomerAddress" />
                    <a class="sfbtn sfbtn-opt f-r" href="javascript:searchArroundCust();"><i class="sficon sficon-search"></i>查看周边用户 </a>
                </div>
                <div class="serverlistWrap">
                    <div class="tableWrap" style="height: 195px;">
                        <table class="table table-border table-bg table-serverlist" style="table-layout: auto;">
                            <thead>
                            <th class="w-90" style="border-left: none;">姓名</th>
                            <th class="w-100">联系方式</th>
                            <th class="w-100">报修家电</th>
                            <th class="w-90">报修时间</th>
                            <th class="w-80">选择</th>
                            </thead>
                            <tbody id="arroundUserInfo">
                            <tr>
                                <%--<td style="border-left: none;">小灰灰</td>
								<td>15656565656</td>
								<td>格力空调</td>
								<td>2018-02-23</td>
								<td>
									<label class="label-cbox3" ><input type="checkbox" name="serverSelected" ></label>
								</td>--%>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="serversName">
                        <div class="pos-r pl-15 pr-80">
                            <p class="pt-5 pb-5 lh-20" style="min-height: 30px"><%--郑经文、小灰灰、张晓明郑经文、小灰灰、张晓明--%></p>
                            <input type="button" class="w-70 sfbtn sfbtn-opt3 " onclick="senMsgInTurnDisp()" value="发送短信" />
                            <input type="hidden" name="sendMsgOrderId" value="${order.id}" />
                            <input type="hidden" name="customerMobileNow" value="" />
                            <input type="hidden" name="jdTelephone" id="jdTelephone" value="" />
                        </div>
                    </div>
                </div>
            </div>
            <%--<div class="f-r mapWrap" id="dispatch_map_container">

			</div>--%>
        </div>
    </div>
</div>


<!-- 短信群发 -->
<div class="popupBox massTextNote massTextNoteQf">
    <h2 class="popupHead">
        短信群发
        <a href="javascript:;" class="sficon closePopup" onclick="guanbi()"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain " >
            <div class="f-14">
                您已发送<strong class="c-005aab" id="sucMsg">0</strong>条，未发送<strong class="c-fd7e2a" id="wroMsg">0</strong>条！
            </div>
            <a id="exportLink" onclick="closePopup()" href="${ctx}/order/exportWrongNumberDuring?formPath=/a/order/during" target="_blank" class="c-0383dc mt-10" style="text-decoration: underline;">查看发送失败的工单</a>
            <div class="text-c mt-20">
                <a  class="sfbtn sfbtn-opt w-70" onclick="guanbi()">关闭</a>
            </div>
        </div>
    </div>
</div>


<div class="popupBox promptBox1" style="width:400px;">
    <h2 class="popupHead">提示<a href="javascript:;" class="sficon closePopup"></a></h2>
    <div class="popupContainer">
        <div class="popupMain  f-14" >
            <p class="text-c">
                <i class="iconType iconType2"></i>
                工单有未完成的备件申请，确认继续封单？
            </p>
            <div class="text-c mt-25 ">
                <a href="javascript:;" class="sfbtn sfbtn-opt3 mr-10 " onclick="continueConfirm()">继续封单</a>
                <a href="javascript:;" class="sfbtn sfbtn-opt w-70" onclick="cancelFendan()">取消</a>
            </div>
        </div>
    </div>
</div>

<!-- 待派工工单下和服务中工单下 -->
<div class="popupBox msgText msgText1" style="height:470px;">
    <h2 class="popupHead">
        发送短信
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer" style="height:430px;overflow:auto;">
        <div class="popupMain pd-20" id="msgWrap" >
            <div class="tabBarP ">
                <a href="javascript:;" class="tabswitch current">模板发送</a>
                <a href="javascript:;" class="tabswitch ">编辑发送</a>
            </div>
            <div class="tabCon">
                <div class="pos-r pl-70 pr-80 mt-10">
                    <label class="lb w-70 text-r">选择模板：</label>
                    <span class="select-box w-160">
						<select class="select radius h-26" id="select-msgmode" name="selectModel" onchange="selectMsgMould(this)">
							<c:forEach items="${listModel }" var="lm6">
                                <c:if test="${lm6.columns.tag eq 6 }">
                                    <option value="${lm6.columns.tag }">上门前</option>
                                </c:if>
                            </c:forEach>
							<c:forEach items="${listModel }" var="lm7">
                                <c:if test="${lm7.columns.tag eq 7 }">
                                    <option value="${lm7.columns.tag }">增值产品</option>
                                </c:if>
                            </c:forEach>
							<c:forEach items="${listModel }" var="lm4">
                                <c:if test="${lm4.columns.tag eq 4 }">
                                    <option value="${lm4.columns.tag }">电话无人接听</option>
                                </c:if>
                            </c:forEach>
							<c:forEach items="${listModel }" var="lm4">
                                <c:if test="${lm4.columns.tag eq 9 }">
                                    <option value="${lm4.columns.tag }">配件无人接听</option>
                                </c:if>
                            </c:forEach>
							<c:forEach items="${listModel }" var="lm3">
                                <c:if test="${lm3.columns.tag eq 3 }">
                                    <option value="${lm3.columns.tag }">改约</option>
                                </c:if>
                            </c:forEach>
							<c:forEach items="${listModel }" var="lm2">
                                <c:if test="${lm2.columns.tag eq 2 }">
                                    <option value="${lm2.columns.tag }">缺件</option>
                                </c:if>
                            </c:forEach>
						</select>
					</span>
                </div>
                <div class="msgmould">
                    <div class="pos-r pl-70 pr-80 mt-10">
                        <span class="lb w-70 text-c">发送内容：<span class="c-0383dc">（模板一）</span></span>
                        <div class="bk-gray pd-10">
                            <input type="text" class="msg-input" id="custName" value="${order.customerName }"  onkeyup="inputWidth(this)" />您好，
                            您的<input type="text" class="msg-input" id="yw" value="${order.serviceType }"  onkeyup="inputWidth(this)"/>业务
                            <input type="text" class="msg-input" id="siteName" value="${siteName }"  onkeyup="inputWidth(this)"/>已受理，
                            <input type="text" class="msg-input" id="emNameMobile" value="${msg1 }" onkeyup="inputWidth(this)"/>，
                            将为您提供服务，请保持电话通畅，监督电话：
                            <input type="text" class="msg-input" id="jdMobile" value="${jdPhone }" onkeyup="inputWidth(this)"/>。
                            【<input type="text" class="msg-input" value="${serviceName }" id="sign1" onkeyup="inputWidth(this)"/>服务】
                        </div>
                        <div id="sendModel1">

                        </div>
                    </div>
                    <div class="pos-r pl-70 pr-80 mt-10">
                        <span class="lb w-70 text-c">发送内容：<span class="c-0383dc">（模板二）</span></span>
                        <div class="bk-gray pd-10">
                            尊敬的用户：您的信息<input type="text" class="msg-input" id="custNameMobile" value="${siteName }(${jdPhone }) " onkeyup="inputWidth(this)"/>
                            已经派工，服务工程师<input type="text" class="msg-input" id="emName" value="${msg2Names }" onkeyup="inputWidth(this)"/>，
                            联系电话<input type="text" class="msg-input" id="emMobile" value="${msg2Mobiles }" onkeyup="inputWidth(this)"/>，
                            请您对我们的服务进行监督！
                            【<input type="text" class="msg-input" value="${serviceName }" id="sign2" onkeyup="inputWidth(this)"/>服务】
                        </div>
                        <div id="sendModel2">	</div>
                    </div>
                </div>
                <div class="msgmould hide">
                    <div class="pos-r pl-70 pr-80 mt-10">
                        <span class="lb w-70 text-c">发送内容：<span class="c-0383dc">（模板一）</span></span>
                        <div class="bk-gray pd-10">
                            尊敬的<input type="text" class="msg-input" id="custName" value="${order.customerName }"  onkeyup="inputWidth(this)" />您好，
                            您的<input type="text" class="msg-input" id="yw" value="${order.serviceType }"  onkeyup="inputWidth(this)"/>业务，我司已受理，
                            指派<input type="text" class="msg-input"  value="${msg1 }" onkeyup="inputWidth(this)"/>为您服务，
                            <input type="text" class="msg-input" id="mode1" value="注意用电安全请点击${oneHref }" >，详情咨询上门工程师。
                            【<input type="text" class="msg-input" value="${serviceName }" id="sign10" onkeyup="inputWidth(this)"/>服务】
                        </div>
                        <div id="sendModel7">

                        </div>
                    </div>
                    <div class="pos-r pl-70 pr-80 mt-10">
                        <span class="lb w-70 text-c">发送内容：<span class="c-0383dc">（模板二）</span></span>
                        <div class="bk-gray pd-10">
                            尊敬的<input type="text" class="msg-input" id="custName" value="${order.customerName }"  onkeyup="inputWidth(this)" />您好，
                            您的<input type="text" class="msg-input" id="yw" value="${order.serviceType }"  onkeyup="inputWidth(this)"/>业务，我司已受理，
                            指派<input type="text" class="msg-input"  value="${msg1 }" onkeyup="inputWidth(this)"/>为您服务，
                            <input type="text" class="msg-input" id="mode2" value="另有专用自动止水水龙头和底座，可有效防止漏水和延长家电使用寿命">，详情咨询上门工程师。
                            【<input type="text" class="msg-input" value="${serviceName }" id="sign11" onkeyup="inputWidth(this)"/>服务】
                        </div>
                        <div id="sendModel8">	</div>
                    </div>
                    <div class="pos-r pl-70 pr-80 mt-10">
                        <span class="lb w-70 text-c">发送内容：<span class="c-0383dc">（模板三）</span></span>
                        <div class="bk-gray pd-10">
                            尊敬的<input type="text" class="msg-input" id="custName" value="${order.customerName }"  onkeyup="inputWidth(this)" />您好，
                            您的<input type="text" class="msg-input" id="yw" value="${order.serviceType }"  onkeyup="inputWidth(this)"/>业务，我司已受理，
                            指派<input type="text" class="msg-input"  value="${msg1 }" onkeyup="inputWidth(this)"/>为您服务，
                            <input type="text" class="msg-input" id="mode3" value="另有安全用电家电伴侣产品等为您提供试用，使您拥有最安心的家电使用体验，">
                            <input type="text" class="msg-input" id="mode4" value="洗衣机专用自动止水水龙头和洗衣机底座，可有效防止水淹事故导致财产损失，延长家电安全使用寿命">，详情咨询上门工程师。
                            【<input type="text" class="msg-input" value="${serviceName }" id="sign12" onkeyup="inputWidth(this)"/>服务】
                        </div>
                        <div id="sendModel9">	</div>
                    </div>
                </div>
                <div class="hide msgmould">
                    <div class="pos-r pl-70 pr-80 mt-10">
                        <span class="lb w-70 text-c">发送内容：</span>
                        <div class="bk-gray pd-10">
                            尊敬的用户，您的电话无法接通状态，请您在方便的时候回复
                            <input type="text" class="msg-input" id="siteMobile" value="${jdPhone }" onkeyup="inputWidth(this)"/>
                            或服务工程师电话<input type="text" class="msg-input" value="${msg1 }" onkeyup="inputWidth(this)"/>,
                            我们将尽快为您提供满意的服务！
                            【<input type="text" class="msg-input" value="${serviceName }" id="sign3" onkeyup="inputWidth(this)"/>服务】
                        </div>
                        <div id="sendModel3">	</div>
                    </div>
                </div>
                <!-- 配件无人接听 -->
                <div class="hide msgmould">
                    <div class="pos-r pl-70 pr-80 mt-10">
                        <span class="lb w-70 text-c">发送内容：</span>
                        <div class="bk-gray pd-10">
                            你好，你购买的商品
                            <input type="text" class="msg-input" id="goodsTime" value="今天" onkeyup="inputWidth(this)"/>到
                            <input type="text" class="msg-input" value="${siteArea }" id="pjArea" onkeyup="inputWidth(this)"/>,联系你电话无人接听，看到短信后请联系
                            <input type="text" class="msg-input" value="${siteMobile }" id="pjMobile" onkeyup="inputWidth(this)"/>。
                            【<input type="text" class="msg-input" value="${serviceName }" id="sign20" onkeyup="inputWidth(this)"/>服务】
                        </div>
                        <div id="sendModel20">	</div>
                    </div>
                </div>
                <div class="hide msgmould">
                    <div class="pos-r pl-70 pr-80 mt-10">
                        <span class="lb w-70 text-c">发送内容：</span>
                        <div class="bk-gray pd-10">
                            <input type="text" class="msg-input" value="${order.customerName }" onkeyup="inputWidth(this)"/>您好，
                            您的预约时间已改至<input type="text" class="msg-input" id="proTime" value="${proTime } "  onkeyup="inputWidth(this)"/>，
                            <input type="text" class="msg-input" id="promiseLimit" value="${order.promiseLimit }" onkeyup="inputWidth(this)"/>，
                            具体上门时间，<input type="text" class="msg-input" value="${msg1}" onkeyup="inputWidth(this)"/>，
                            会与您联系的，监督电话：<input type="text" class="msg-input" value="${jdPhone }" onkeyup="inputWidth(this)"/>。
                            【<input type="text" class="msg-input" value="${serviceName }" id="sign4" onkeyup="inputWidth(this)"/>服务】
                        </div>
                        <div id="sendModel4">	</div>
                    </div>
                </div>
                <div class="hide msgmould">
                    <div class="pos-r pl-70 pr-80 mt-10">
                        <span class="lb w-70 text-c">发送内容：</span>
                        <div class="bk-gray pd-10">
                            <input type="text" class="msg-input" value="${order.customerName }" onkeyup="inputWidth(this)"/>您好，
                            因店内配件无库存，现已紧急调度，配件到位后，具体上门时间，
                            <input type="text" class="msg-input" value="${msg1}" onkeyup="inputWidth(this)"/>，
                            会与您联系的，监督电话：<input type="text" class="msg-input" value="${jdPhone }" onkeyup="inputWidth(this)"/>。
                            【<input type="text" class="msg-input" value="${serviceName }" id="sign5" onkeyup="inputWidth(this)"/>服务】
                        </div>
                        <div id="sendModel5">	</div>
                    </div>
                </div>
            </div>
            <div class="tabCon">
                <p class="c-f55025 f-12 lh-30">
                    注：自定义文字内容需要人工审核，等待时间较长
                </p>
                <div class="pr-80 pos-r">
                    <div class="bk-gray" >
                        <textarea class="textarea radius" placeholder="请输入短信内容" id="content" style="border-width: 0; height: 60px;"></textarea>
                        <div class="h-26">
                            <p class="f-r">【<input type="text" class="msg-input"  value="${serviceName }" id="sign6" onkeyup="inputWidth(this)"/>服务】</p>
                        </div>
                    </div>
                    <a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg  " onclick="sendMsgConfirm()">发送</a>
                </div>
            </div>
        </div>
    </div>
</div>




<div class="popupBox msgText msgTextdefined" style="height:470px;" >
    <h2 class="popupHead">
        发送短信
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer" style="height:430px;overflow:auto;">
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
                    <div class="pos-r pl-70 pr-80 mt-10">
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

<!-- 直接封单提示框 -->
<div class="popupBox notDispatch showzjfddiv">
    <h2 class="popupHead">
        直接封单
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain " >
            <div class="txtwrap1 pos-r mb-30">
                <label class="lb lb1"><em class="mark">*</em>直接封单理由：</label>
                <textarea id="reasonofzjfd" class="textarea"></textarea>
            </div>
            <div class="text-c pl-30">
                <input onclick="savezjfd('${order.id}')" type="button" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
                <input type="button" onclick="cancerBox()" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" />
            </div>
        </div>
    </div>
</div>

<!-- 短信催单 -->
<div class="popupBox msgText msgText2"  style="height:212px;" >
    <h2 class="popupHead">
        发送短信
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer" style="height:172px;overflow:auto;">
        <div class="popupMain pd-20" id="msgWrap2" >
            <div class="tabBarP mb-10 ">
                <a href="javascript:;" class="tabswitch current">模板发送</a>
                <a href="javascript:;" class="tabswitch ">编辑发送</a>
            </div>
            <div class="tabCon">
                <div class="pos-r pl-70 pr-80">
                    <span class="lb w-70 text-c">发送内容：</span>
                    <div class="bk-gray pd-10">
                        单号: <input type="text" class="msg-input" value="${order.number} ${order.applianceBrand } ${order.applianceCategory}）" onkeyup="inputWidth(this)" />，
                        用户:<input type="text" class="msg-input" value="${order.customerName }（${order.customerMobile}）" onkeyup="inputWidth(this)"/>催单！

                        地址：<input type="text" class="msg-input" value="${order.customerAddress}" onkeyup="inputWidth(this)"/>
                    </div>
                    <a href="javascript:sendMsgDXCD('1');" class="sfbtn sfbtn-green w-70 btn-sendmsg  " >发送</a>
                </div>
            </div>
            <div class="tabCon">
                <div class="pr-80 pos-r">
                    <div class="bk-gray" >
                        <textarea id="content2" class="textarea radius" placeholder="请输入短信内容" style="border-width: 0; height: 60px;"></textarea>
                        <div class="h-26">
                            <p class="f-r">【<input type="text" class="msg-input" id="dxcdSn" value="${serviceName}" onkeyup="inputWidth(this)"/>服务】</p>
                        </div>
                    </div>
                    <a href="javascript:sendMsgDXCD('2');" class="sfbtn sfbtn-green w-70 btn-sendmsg  " >发送</a>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="popupBox qrcode" >
    <h2 class="popupHead">
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain pd-20" >
            <div class="text-c mt-25 " id="showCode">

            </div>
        </div>
    </div>
</div>



<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef" ></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript">
    var definedContentCd="";
    var definedContentTz="";
    var limitCount=0;
    var mark="";
    var orderMsgId="";
    var changeMark = true;
    var orderMsgMobile="";
    var isCheck="";
    var customerPrice="";

    var feedImgsCount = '${duringFeedImgsCount}';

    $("#cloZongDiv").on("click",function(){
        parent.search();
    });

    $(function(){
        if('${haveData}'=="1"){
            layer.msg("没有上一条数据了");
        }
        if('${haveData}'=="2"){
            layer.msg("没有下一条数据了");
        }
        if(feedImgsCount==8){
            $("#jiahao").addClass('hide');
        }
        var content1="@您好，您的@业务@已受理，@，将为您提供服务，请保持电话通畅，监督电话：@。【@服务】";
        var content2="尊敬的用户：您的信息@已经派工，服务工程师@，联系电话@，请您对我们的服务进行监督！【@服务】";
        $("#sendModel1").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick=sendModel1("2","6","'+content1+'") >发送</a>');
        $("#sendModel2").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick=sendModel1("3","6","'+content2+'") >发送</a>');
        if($.trim('${order.customerMobile}')!=null && $.trim('${order.customerMobile}')!="" ){
            orderMsgMobile=$.trim('${order.customerMobile}');
        }
        orderMsgId='${order.id}';

        $.post("${ctx}/order/remainMsgNum",{},function(result){
            $("#sign").val(result.columns.sms_sign);//签名
            $("#siteMsgNums").val(result.columns.sms_available_amount);//服务商剩余可发送短信总数
            $("#jdTelephone").val(result.columns.sms_phone);
        });
        codeNumberCounts();

        /*var addr='${order.customerAddress}';
	if(isBlank(addr)){
		getDefaultAddress();
	}else if(addr.indexOf("区") <= 0 && addr.indexOf("县") <=0 && addr.indexOf("市")<=0 ){
		getDefaultAddress();
	}else{
        if(addr.indexOf("西昌市")>1){
            $("#pcd").citySelect({
                url:'${ctxPlugin}/lib/city.min.js',
                address:'四川凉山'
            });
        }else{
            $("#pcd").citySelect({
                url:'${ctxPlugin}/lib/city.min.js',
                address:'${order.customerAddress}'
            });
        }

	}*/

        $('#empSearchName').keyup(function(){
            $('#zhijiepaidan tr').hide()
                .filter(":contains('" +($(this).val()) + "')").show();
            if(isBlank($(this).val())){
                $('#zhijiepaidan tr').show();
            }
        }).keyup();//DOM加载完时，绑定事件完成之后立即触发
        $("#origin").select2();
        $(".selection").css("width","120px");

        $('#applianceBrand').select2();
        $("#applianceBrand").next(".select2").find(".selection").css("width","160px");

        $('#applianceCategory').select2();
        $("#applianceCategory").next(".select2").find(".selection").css("width","120px");

        $("#pleaseReferMall").select2();
        $("#pleaseReferMall").next(".select2").find(".selection").css("width","120px");

        $('#stateBox .selectLabel').on('click', function () {
            $('#stateBox .selectLabel').removeClass('selectedLabel');
            $(this).addClass('selectedLabel');
        })

        $('#bjNavBox .tabswitch').each(function(i){
            $(this).on('click', function(){
                $('#bjNavBox .tabswitch').removeClass('current');
                $(this).addClass('current');
                $('#bjNavBox2 .caption_lb').hide().eq(i).show();
                $('#bjNavBox2 .sfbtn').hide().eq(i).show();
            })
        })

        judgedygd();
    });

    function getDefaultAddress(){
        $.ajax({
            type: "POST",
            url: "${ctx}/order/getDefaultAddress",
            datatype:"text",
            success: function (result) {
                $("#pcd").citySelect({
                    url:'${ctxPlugin}/lib/city.min.js',
                    address:result
                });
            },
            error: function () {
                layer.msg("系统繁忙!");
                return;
            },
            complete: function () {
            }
        });
    }

    //添加申请
    function addbjsq(){
        var number="${order.number}";
        var emNamId="${order.employeId}";
        if(isBlank(emNamId)){
            layer.msg("该信息没有申请人,不能直接添加申请！");
        } else {
            layer.open({
                type: 2,
                content: '${ctx}/fitting/fittingApply/addFittingApply?type=1&emNamId=' + emNamId + '&number=' + number,
                title: false,
                area: ['100%', '100%'],
                closeBtn: 0,
                shade: 0,
                fadeIn: 0,
                anim: -1
            });
        }
    }

    function closeAll(){
        $.closeAllDiv();
    }

    function cancelBox(a) {
//    $.closeDiv($(a).closest('.popupBox'));
        $.closeDiv($(".showzbpgdiv"), true);
    }
    function showzbpg() {
        if ("${order.status}" == 7) {
            layer.msg("已经为暂不派工!");
            return;
        }
        $('.showzbpgdiv').popup({level: 2,closeSelfOnly:true});
    }

    /* 保存暂不派工 */
    var adpoting = false;
    function savezbpg(id) {
        if(adpoting) {
            return;
        }
        var latest_process = $.trim($("#reasonofzbpg").val());
        if (isBlank(latest_process)) {
            layer.msg("请输入理由!");
            return;
        } else {
            adpoting = true;
            $.ajax({
                type: "POST",
                url: "${ctx}/order/orderDispatch/TemporarilyDis",
                data: {
                    id: id,
                    latest_process: latest_process
                },
                success: function (result) {
                    layer.msg("暂不派工更新完毕!", {time: 2000});
                    parent.search();
                    parent.numerCheck();
                    $.closeDiv($('.showzbpgdiv'));
                    $.closeDiv($('.orderdetailVb'));
                    parent.closeBatchForm();
                    parent.closeBatchForms();
                    $('#Hui-article-box',window.top.document).css({'z-index':'9'});
                },
                error: function () {
                    layer.msg("系统繁忙!");
                    return;
                },
                complete: function () {
                    adpoting = false;
                }

            });
        }
    }
    function closeDivWX(){
        $.closeDiv($(".showwxgddiv"), true);
    }
    function toggleMirror(isMirror) {
        if(!isMirror) {
            $("#applanceBrandMirror").hide();
            $("#applianceCategoryMirror").hide();
            $("#applianceCategory").show();
            $("#applianceBrand").show();
        } else {
            $("#applanceBrandMirror").show();
            $("#applianceCategoryMirror").show();
            $("#applianceCategory").hide();
            $("#applianceBrand").hide();
        }
    }

    //获取工单关联旧件信息
    function showOldFitting(){
        var orderNumber = "${order.number}";
        var str="";
        var imgstr="";
        $.ajax({
            url:"${ctx}/order/showOldFitting",
            data:{orderNumber:orderNumber},
            dataType:'json',
            async:false,
            success:function(result){
                $(".oldtbody").empty();
                $("#oldfittingimg").html("<label class='lb lb1'>旧件图片：</label>");
                if(result.list.length>0){
                    $.each(result.list,function(index,val){
                        str+="<tr>"+
                            "<td class='w-180'>"+val.columns.code+"</td>"+
                            "<td class='w-260'>"+val.columns.name+"</td>"+
                            "<td class='w-120'>"+val.columns.version+"</td>"+
                            "<td class='w-100'>"+val.columns.brand+"</td>";
                        if(val.columns.yrpz_flag=="1"){
                            str+="<td class='w-70'>是</td>";
                        }else if(val.columns.yrpz_flag=="2"){
                            str+="<td class='w-70'>否</td>";
                        }
                        str+= "<td class='w-50'>×"+val.columns.num+"</td>";
                        if(val.columns.status=="0"){
                            str+="<td class='w-70'>已登记</td>";
                        }else if(val.columns.status=="1"){
                            str+="<td class='w-70'>已入库</td>";
                        }else if(val.columns.status=="3"){
                            str+="<td class='w-70'>已返厂</td>";
                        }else if(val.columns.status=="4"){
                            str+="<td class='w-70'>已报废</td>";
                        }
                        str+= "<td class='w-50'>"+val.columns.cateTime+"</td>";
                        str+="</tr class='w-100'>";


                        var images=val.columns.img.split(",");
                        for(var i=0;i<images.length;i++){
                            imgstr+= "<div class='f-l mr-10'><div class='imgWrap w-120 text-c'><img src='${commonStaticImgPath}"+images[i]+"'></img>";
                            imgstr+= "<p class='lh-20'>"+val.columns.cateTime+" </p></div></div>";
                        }
                    });

                }else{
                    $("#oldfittingimg").html("");
                }

                $(".oldtbody").append(str);
                jQuery.getScript("${ctxPlugin}/static/h-ui.admin/js/imgShow.js", function(data, status, jqxhr) {
                    $("#oldfittingimg").append(imgstr);
                    $('#oldfittingimg').imgShow();
                });
                return;
            }

        });
    }


    /*获取必填项设置参数*/
    function getJurisdiction(){
        /*变量名要与元素中的id对应*/
        var promiseTime = '${mustfill.columns.promiseTime}';
        var applianceBuyTime = '${mustfill.columns.applianceBuyTime}';
        var origin = '${mustfill.columns.origin}';
        var promiseLimit = '${mustfill.columns.promiseLimit}';
        var remarks = '${mustfill.columns.remarks}';
        var applianceModel = '${mustfill.columns.applianceModel}';
        var applianceNum = '${mustfill.columns.applianceNum}';
        var applianceBarcode = '${mustfill.columns.applianceBarcode}';
        var applianceMachineCode = '${mustfill.columns.applianceMachineCode}';
        var pleaseReferMall = '${mustfill.columns.pleaseReferMall}';
        var warrantyType = '${mustfill.columns.warrantyType}';
        var level = '${mustfill.columns.level}';
        var customerFeedbackJuris = '${mustfill.columns.customerFeedback}';
        var jurisdiction=origin+","+promiseTime+","+promiseLimit+","+customerFeedbackJuris+","+remarks+","+applianceModel+","+applianceNum+","+applianceBarcode+","+applianceMachineCode+","+applianceBuyTime+","+pleaseReferMall+","+warrantyType+","+level;
        return jurisdiction;
    }
    /*获取参数*/
    function getJurisdisctionValue(){
        var origin= $("#origin").val();
        var promiseTime= $("#promiseTime").val();
        var promiseLimit= $("#promiseLimit").val();
        var customerFeedback= $("#customerFeedback").val();
        var remarks= $("#remarks").val();
        var applianceModel= $("#applianceModel").val();
        var applianceNum= $("#applianceNum").val();
        var applianceBarcode= $("#applianceBarcode").val();
        var applianceMachineCode= $("#applianceMachineCode").val();
        var applianceBuyTime= $("#buyDate").val();
        var pleaseReferMall= $("#pleaseReferMall").val();
        var warrantyType= $("#warrantyType").val();
        var level= $("#level").val();
        //var jurisdictionvalue=origin+"(**..)"+promiseTime+"(**..)"+promiseLimit+"(**..)"+customerFeedback+"(**..)"+remarks+"(**..)"+applianceModel+"(**..)"+applianceNum+"(**..)"+applianceBarcode+"(**..)"+applianceMachineCode+"(**..)"+applianceBuyTime+"(**..)"+pleaseReferMall+"(**..)"+warrantyType+"(**..)"+level;

        var array=new Array();
        array[0]=origin;
        array[1]=promiseTime;
        array[2]=promiseLimit;
        array[3]=customerFeedback;
        array[4]=remarks;
        array[5]=applianceModel;
        array[6]=applianceNum;
        array[7]=applianceBarcode;
        array[8]=applianceMachineCode;
        array[9]=applianceBuyTime;
        array[10]=pleaseReferMall;
        array[11]=warrantyType;
        array[12]=level;

        return array;
    }

    $(function(){
        $("#xggd").click(function(){
            $("#origin1").hide();
            $("#origin").removeClass("hide");
            var markMobile = '${order.customerMobile}';
            var firstNumber = "";
            if(markMobile!=null && markMobile!=""){ //如果联系方式的第一位为0，则为固话
                firstNumber = markMobile.substring(0,1);
            }
            var html='<span class="f-r pr-5">:</span>';
            html+='<select class="lb-sel f-r readonly select" style="width:75px" disabled="disabled" id="mobileOrtel">';
            if(firstNumber=="0"){
                html+='<option value="1"  >手机号码</option>';
                html+='<option value="2" selected="selected">固定电话</option>';
            }else{
                html+='<option value="1" selected="selected">手机号码</option>';
                html+='<option value="2" >固定电话</option>';
            }
            html+='</select>';
            html+='<em class="mark f-r">*</em>';
            $("#mobileType").empty().append(html);

            if($(this).val()!="保存"){
                /* toggleMirror(false); */
                $(".sbtn").prop("disabled", true);
                $("input[type='text']").removeClass("readonly");
                $("#factoryNumber").removeClass("readonly");
                $("#factoryNumber").removeAttr("readonly");
                $("#factoryNumber").removeAttr("disabled");
                $("#promiseTime").removeClass("readonly");
                $("#buyDate").removeClass("readonly");
                $("select").removeClass("readonly");
                $("textarea").removeClass("readonly");
                $(".priceWrap").removeClass("readonly");


                $("#promiseTime").prop("disabled",false);
                $("#buyDate").prop("disabled",false);
                //$("input[type='text']").prop("disabled",false);
                $("input[type='text']").prop("readonly",false);
                $("textarea").prop("readonly",false);
                $("#showProvince").css("display","");
                $("#showCity").css("display","");
                $("#showArea").css("display","");
                $("select").prop("disabled",false);
                $(".dischange").addClass("readonly");
                $(".dischange").prop("readonly",true);

                $("#serviceType").addClass("mustfill");
                $("#serviceMode").addClass("mustfill");
                $("#customerName").addClass("mustfill");
                $("#customerMobile").addClass("mustfill");
                $("#customerAddress1").addClass("mustfill");
                $("#applianceBrand").addClass("mustfill");
                $("#applianceCategory").addClass("mustfill");
                //$("#customerFeedback").addClass("mustfill");
                $("#styleMark .select2-selection--single").css({'background-color': '#dbf5fd','border':'1px solid #5ebdfb'});

                var str='origin,promiseTime,promiseLimit,customerFeedback,remarks,applianceModel,applianceNum,applianceBarcode,applianceMachineCode,buyDate,pleaseReferMall,warrantyType,level';
                addMustFill(getJurisdiction(),str);

                $(".mark").text("*");

                $("input[name='fankui']").addClass("readonly");
                $("input[name='fankui']").prop("readonly",true);
                $(".combo-arrow").addClass("textbox-icon-disabled");
                $("#_easyui_textbox_input1").css("display",true);
                $("#_easyui_textbox_input1").prop("disabled",true);
                /*$("#customerAddress1").css({'width':'480px'});*/

                $("#repeatOrder").addClass("sfbtn-disabled");
                $(".btnMenubox").find("input").addClass("sfbtn-disabled");
                $(this).removeClass("sfbtn-disabled");
                $(this).after("<input id='qxgf' class='sfbtn sfbtn-opt' onclick='getoff()'  value='取消' type='button'/>");
                $(this).val("保存");

                /*var addr='${order.customerAddress}';
			if(isBlank(addr)){
				getDefaultAddress();
			}else if(addr.indexOf("区") <= 0 && addr.indexOf("县") <=0 && addr.indexOf("市")<=0 ){
				getDefaultAddress();
			}else{
				address();
			}*/

            }else{
                var mobileOrtel = $("#mobileOrtel").val();
                var serviceType = $("#serviceType").val();
                var serviceMode = $("#serviceMode").val();
                var customerName = $.trim($("#customerName").val());
                var customerMobile = $("#customerMobile").val();
                var customerTelephone = $("#customerTelephone").val();
                var customerTelephone2=$("#customerTelephone2").val();
                var customerAddress = $("#customerAddress1").val();
                var applianceBrand = $("#applianceBrand").val();
                var applianceCategory = $("#applianceCategory").val();
                var customerFeedback = $.trim($("#customerFeedback").val());


                var moliereg= /^(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^0?[1][34578][0-9]{9}$)$/;
                var mtel=/^([\+][0-9]{1,3}[ \.\-])?([\(]{1}[0-9]{2,6}[\)])?([0-9 \.\-\/]{3,20})((x|ext|extension)[ ]?[0-9]{1,4})?$/;
                //var tel= /^(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^0?[1][34578][0-9]{9}$)|(^(0[0-9]{2,3})?([2-9][0-9]{6,7})+([0-9]{1,4})?$)$/;
                //var tel= /^(\d{3,4}-?\d{7,9})|\d{7,9}$/;
                //var tel = /^(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^0?[1][345789][0-9]{9}$)|(^(0[0-9]{2,3}?[2-9][0-9]{6,7})?$)$/;
                var tel = /(^1\d{10}$)|(^(\d{3,4}\-)?\d{5,9}$)/;
                if(isBlank(serviceType)){
                    layer.msg("服务类型为必填项");
                    return;
                }
                if(isBlank(serviceMode)){
                    layer.msg("服务方式为必填项");
                    return;
                }
                var factoryNumber = $("#factoryNumber").val();
                if('${order.recordAccount}'=='1'){
                    if(isBlank(factoryNumber)){
                        layer.msg("请填写厂家工单编号");
                        $("#factoryNumber").focus();
                        return;
                    }
                    if ($.trim(factoryNumber).length > 32) {
                        layer.msg("厂家工单编号过长");
                        $("#factoryNumber").focus();
                        return;
                    }
                }
                if(isBlank(customerName)){
                    layer.msg("用户姓名为必填项");
                    return;
                }

                if(!isBlank(customerMobile)){
                    //if(!moliereg.test($.trim(customerMobile))){
                    if(!tel.test($.trim(customerMobile))){
                        layer.msg("请输入正确的联系方式");
                        $("#mobileOrtel").prop("disabled",false);
                        $("#mobileOrtel").removeClass("readonly");
                        if(mobileOrtel == "1"){
                            $("#mobileOrtel").val("手机号码");
                        }else{
                            $("#mobileOrtel").val("固定电话");
                        }
                        return;
                    }
                    //}
                }else{
                    layer.msg("请输入联系方式");
                    return;
                }
                if(!isBlank(customerTelephone)){
                    if(!mtel.test($.trim(customerTelephone))){
                        layer.msg("请输入正确的联系方式2");
                        return;
                    }

                }
                if(!isBlank($.trim(customerTelephone2))){
                    if(!mtel.test(customerTelephone2)){
                        layer.msg("请输入正确的联系方式3");
                        return;
                    }

                }


                if(isBlank(customerAddress)){
                    layer.msg("详细地址为必填项");
                    return;
                }
                if(isBlank(applianceBrand)){
                    layer.msg("家电品牌为必填项");
                    return;
                }
                if(isBlank(applianceCategory)){
                    layer.msg("家电品类必填项");
                    return;
                }
                /*if(isBlank(customerFeedback)){
				layer.msg("服务描述为必填项");
				return;
			}*/


                /*var addressspace="";
			if($("#province").val()!=null){
				addressspace+=$("#province").val();
			}else{
				layer.msg("省市区为必填项");
				return;
			}
			if($("#city").val()!=null){
				addressspace+=$("#city").val();
			}else{
				layer.msg("省市区为必填项");
				return;
			}
			if($("#area").val()!=null){
				addressspace+=$("#area").val();
			}else{
				layer.msg("省市区为必填项");
				return;
			}*/

                var result=checkMustFill(getJurisdiction(),getJurisdisctionValue());
                if(!result){
                    return;
                } else {
                    /* addressspace += $("input[name='customerAddress1']").val();
                if ($("#province").val() == $("#city").val()) {
                    $("#customerAddress").val($("#province").val() + $("#area").val() + $("#customerAddress").val());
                }*/
                    $("#customerAddress").val($("#customerAddress1").val());
                    $.ajax({
                        url: "${ctx}/order/orderDispatch/update",
                        type: "post",
                        data: $("#updateOrder").serialize(),
                        success: function () {
                            parent.search();
//					$.closeDiv($(".orderdetailVb"));
                            window.location.reload();
                        }
                    });
                    return;
                }
            }
        });
    });
</script>

<script type="text/javascript">
    AMap.service('AMap.Geocoder', function () {//回调函数
        //实例化Geocoder
        geocoder = new AMap.Geocoder();
    });
    var dispatchMap,dispatchMarker,employeMarker;
    var marker;
    var mark;

    function showwxgd(type) {
        if(type=='6'){
            layer.msg("该工单为一级网点所派，不能进行无效工单操作！");
            return;
        }
        $('.showwxgddiv').popup({level: 2, closeSelfOnly: true});
    }

    var adpotin = false;
    function savewxgd(id){
        if(adpotin) {
            return;
        }
        var latest_process = $.trim($("#reasonofwxgd").val());
        if(isBlank(latest_process)){
            layer.msg("请输入理由!");
            return;
        }else{
            adpotin = true;
            $.ajax({
                type:"post",
                url:"${ctx}/order/orderDispatch/updateOrderInvalid",
                data:{
                    id:id,
                    latest_process:latest_process
                },
                success:function(result){
                    parent.layer.msg("无效工单更新完毕!", {time: 2000});
                    //$.closeDiv($('.orderdetailVb'));
                    //window.parent.location.reload(true);
                    parent.search();
                    parent.numerCheck();
                    $.closeDiv($('.showwxgddiv'));
                    $.closeDiv($('.orderdetailVb'));
                    parent.closeBatchForms();
                    //window.location.href='${ctx}/operate/site/saveTableHeader';
                    $('#Hui-article-box',window.top.document).css({'z-index':'9'});
                },
                error:function(){
                    layer.msg("系统繁忙!");
                    return;
                },
                complete:function(){
                    adpotin = false;
                }
            });
        }
    }
</script>
<script type="text/javascript">
    function cancelCloseOrder() {
        $.closeDiv($(".fbOrder"), true);
        //$.closeDiv($(".orderdetailVb"));
    }
    function updateDispatchStatus(callback) {
        $.ajax({
            type: "post",
            url: "${ctx}/order/orderDispatch/updateDispatchStatusToYJD?oid=${order.id}",
            success: function() {
                callback.call();
            }
        });
    }
    function showFeedbackPopup() {

        //获取反馈工单中数据 fbBaseInfo
        //showPjmsg();
        //$.Huitab("#fbBaseInfo .tabBarP .tabswitch","#fbBaseInfo .tabCon","current","click","0");

        $('#fbBaseInfo .tabswitch').each(function(index){
            $(this).on('click', function(){
                if(index == 1){
                    $('.btn-usebj').show();
                }/* else{
				$('#btn-usebj').hide();
			} */
            })
        });
        $('#bjNavBox .tabswitch').removeClass('current').eq(0).addClass('current');
        $('#bjNavBox .sfbtn').hide().eq(0).show();
        fittingApply("pjmg");
        $('.fbOrder').popup({level:2, closeSelfOnly: true,fixedHeight:false});
    }

    var ck = /^\d+(\.\d+)?$/;
    $(function(){
        /* $.post("${ctx}/order/orderDispatch/getCodeShowPopup",{id:'${order.id}'},function(result){
			var cdIn = result.codeIn;
			 var cdOut = result.codeOut;
			 if(cdIn == 0 && cdOut == 0){
				 $('#codeShow').hide();
			 }else{
				 if(cdIn < 1 || cdOut < 1){
					 $(".douhao").text("");
				 }
				 if(cdIn > 0){
					 $("#codeInshow").text('有'+cdIn+'条历史');
					 $(".codeIn").show();
				 }else{
					 $(".codeIn").hide();
				 }
				 if(cdOut > 0){

					 $("#codeOutshow").text('有'+cdOut+'条历史');
					 $(".codeOut").show();
				 }else{
					 $(".codeOut").hide();
				 }
				 $('#codeShow').show();
			 }
		}) */
        $.Huitab("#detialWd .tabBarP .tabswitch","#detialWd .tabCon","current","click","0");
        $.Huitab("#serveFb .tabBarP .tabswitch","#serveFb .tabCon","current","click","0");
        $.Huitab("#fbBaseInfo .tabBarP .tabswitch","#fbBaseInfo .tabCon","current","click","0");

        $(".codeConnectShow").bind('click', function () {
            var code = $(this).parent(".wrapss").find("input").val();
            layer.open({
                type : 2,
                content:'${ctx}/order/showHistoryPopupDetail2017?code=' + code+'&id='+'${order.id}',
                title:false,
                area: ['100%','100%'],
                closeBtn:0,
                shade:0,
                anim:-1
            });
        });

        $('.orderdetailVb').popup({fixedHeight:false});
        $('#wxImgList').imgShow();

        $("input.autoCal").change(function(){
            var sum = 0;
            $("input.autoCal").each(function(){
                if(testCash($(this).val())){
                    sum = numAdd(sum, $(this).val());
                }else if($(this).val() !=''){
                    $(this).val("");
                }
                $("#total_cost").val(sum);
            });
        });

        $('#btn-fbOrder').bind('click', function () {
            $.ajax({
                type: "POST",
                url: "${ctx}/order/orderDispatch/queryDispatchStatus?oid=${order.id}",
                success: function (data) {
                    if ('1' == data.status) {
                        $('body').popup({
                            level: '3',
                            type: 2,  // 提示是否进行某种操作
                            content: '服务工程师${order.employeName}未接单，您确认继续反馈封单吗？',
                            fnConfirm: function () {
                                updateDispatchStatus(function () {
                                    showFeedbackPopup();
                                });
                            },
                            closeSelfOnly: true
                        });
                    } else {
                        showFeedbackPopup();
                    }
                },
                error: function () {
                    layer.msg("数据加载失败，请重试！");
                }
            });
        });

        $("input.sfbtn.sfbtn-opt3").click(function(){
            $(".lb.lb1").removeClass("readonly");
        });


        // 选择品类时获取服务商维护对应的品牌
        $("#applianceCategory").change(function(){
            var brand = $("#applianceBrand").val();
            var cate = $("#applianceCategory").val();
            $.ajax({
                type:"post",
                url:"${ctx}/order/getBrand",
                data:{
                    category:cate
                },
                dataType:"json",
                success:function(data){
                    var obj = eval(data);
                    $("#applianceBrand").empty();
                    if(obj.count == 2){
                        layer.msg("没有相关品牌，请维护");
                    }else{
                        var HTML = " <option value=''>请选择</option> ";
                        $.each(obj.brand,function(key,values){
                            if(brand ==values){
                                HTML += '<option value="'+values+'" selected = "selected" >'+key+'</option>';
                            }else{
                                HTML += '<option value="'+values+'">'+key+'</option>';
                            }

                        });
                        $("#applianceBrand").append(HTML);
                    }
                }
            });

        });

        // 选择品牌时获取服务商维护对应的品类
        $("#applianceBrand").change(function () {
            var cate = $("#applianceCategory").val();
            var brand = $("#applianceBrand").val();
            $.ajax({
                type: "post",
                url: "${ctx}/order/getCategory",
                data: {
                    brand: brand
                },
                dataType: "json",
                success: function (data) {
                    var obj = eval(data);
                    $("#applianceCategory").empty();
                    if (obj.count == 2) {
                        layer.msg("没有相关品类，请维护");
                    } else {
                        var HTML = " <option value=''>请选择</option> ";
                        $.each(obj.cate, function (key, values) {
                            if (cate == values) {
                                HTML += '<option value="' + values + '" selected = "selected" >' + key + '</option>';
                            } else {
                                HTML += '<option value="' + values + '">' + key + '</option>';
                            }

                        });
                        $("#applianceCategory").append(HTML);
                    }
                }
            });
        });


    });

    $('#btn_showImg').on('click', function(){
        $('#wxImgList img').eq(0).click();
    })


    function ReplaceEmploye(){
        $("input[name='feedbackType']").val("2");
        //alert($("input[name='pickerImg']").val());
        var feedback = $("#feedback").val();
        if(isBlank(feedback)){
            layer.msg("请输入反馈描述");
            return ;
        }
        $.ajax({
            url: "${ctx}/order/orderDispatch/ReplaceEmploye",
            type: "POST",
            data: $('#generationOrderFrom').serialize(),
            async: false,
            success: function(result) {
                if(result == "ok"){
                    layer.msg('反馈成功');
                    setTimeout(function(){
                        parent.search();
                        parent.numerCheck();
                        $.closeDiv($('.fbOrder'));
                        $.closeDiv($('.orderdetailVb'));
                        parent.closeBatchForms();
                        $('#Hui-article-box',window.top.document).css({'z-index':'9'});
                    },500);
                }else {
                    $("#butnAdd").show();
                    layer.msg("反馈失败!", {time:2000});
                }
            }
        });

        return false;
    }


    $('#generationOrderFrom').Validform({
        btnSubmit:"#Butorder",
        postonce:true,
        tiptype:function(msg){
            if(!isBlank(msg)){
                layer.msg(msg);
            }
        },
        callback: function(form) {
            $("input[name='feedbackType']").val("1");
            var count = $("#count1").val();
            if(parseInt(count) > 0){
                $('.promptBox1').popup({level:4});
            }else{
                $.ajax({
                    url: "${ctx}/order/orderDispatch/ReplaceEmploye",
                    type: "POST",
                    data: form.serialize(),
                    async: false,
                    success: function(result) {
                        if(result == "ok"){
                            layer.msg('代反馈成功');
                            setTimeout(function(){
                                parent.search();
                                parent.numerCheck();
                                $.closeDiv($('.fbOrder'));
                                $.closeDiv($('.orderdetailVb'));
                                parent.closeBatchForms();
                                $('#Hui-article-box',window.top.document).css({'z-index':'9'});
                            },500);
                        }else {
                            $("#butnAdd").show();
                            layer.msg("代反馈失败!", {time:2000});
                        }
                    }
                });
            }
            return false;
        }
    });

    var adpoti = false;
    function continueConfirm(){//generationOrderFrom
        if(adpoti) {
            return;
        }
        adpoti = true;
        $.ajax({
            url: "${ctx}/order/orderDispatch/ReplaceEmploye",
            type: "POST",
            data: $("#generationOrderFrom").serialize(),
            success: function(result) {
                if(result == "ok"){
                    layer.msg('代反馈成功');
                    setTimeout(function(){
                        window.parent.location.reload(true);
                        window.location.href="${ctx}/operate/site/saveTableHeader";
                        $('#Hui-article-box',window.top.document).css({'z-index':'9'});

                    },500);
                }else {
                    $("#butnAdd").show();
                    layer.msg("代反馈失败!", {time:2000});
                }
            },
            complete: function() {
                adpoti = false;
            }
        });
    }

    function cancelFendan(){
        $.closeDiv($(".promptBox1"));
        $.closeDiv($(".fbOrder"));
        window.location.reload();
        $('#Hui-article-box',window.top.document).css({'z-index':'9'});
    }


    var adpot = false;
    function saveCallback(){
        if(adpot) {
            return;
        }
        adpot = true;
        var postData = $("#callback_form").serializeJson();
        $.post('${ctx}/order/orderCallback/saveCallback', postData, function(result){
            adpot = false;
        });
    }

    var adpo = false;
    function saveSettlement(){
        if(adpo) {
            return;
        }
        adpo = true;
        var postData = $("#seltment_form").serializeJson();
        $.post('${ctx}/order/orderSettlemnt/saveSettlement', postData, function(result){
            adpo = false;
        });
    }
    function isBlank(val) {
        if(val==null || val=='' || val == undefined) {
            return true;
        }
        return false;
    }

    function cost(){
        var wa = $("#warrantyCost").val();
        var au = $("#auxiliaryCost").val();
        var se = $("#serveCost").val();
        if(isBlank(wa)){
            wa = 0.00;
        }
        if(isBlank(au)){
            au = 0.00;
        }
        if(isBlank(se)){
            se = 0.00;
        }
        if(ck.test(se)&&ck.test(au)&&ck.test(wa)){
            var coun = parseFloat(se)+parseFloat(au)+parseFloat(wa);
            $("#zongCost").val(coun);
        }else{
            layer.msg("输入的价格格式错误");
        }
    }
    $(function(){
        createUploader("#filePicker-add","#Imgprocess","file_fake_addimg","file_fake_add","delpickerImg");
        createUploader('#filePicker-mdd','#ImgprocessPJ','','','');
    });
    function createUploader(picker,site, el,id,delimg) {
        var thumbnailWidth = 130;   //缩略图高度和宽度 （单位是像素），当宽高度是0~1的时候，是按照百分比计算，具体可以看api文档
        var thumbnailHeight = 130;
        var upSrc="";
        uploader = WebUploader.create({
            // 选完文件后，是否自动上传。
            auto: true,
            swf: '${ctxPlugin}/lib/webuploader/0.1.5/Uploader.swf',
            server: '${ctx}/common/uploadFile',

            duplicate:true,
            fileSingleSizeLimit:1024*1024*5,
            pick: picker,
            accept: {
                title: 'Images',
                extensions: 'gif,jpg,jpeg,bmp,png',
                mimeTypes: 'image/gif,image/jpg,image/jpeg,image/bmp,image/png'
            },
            method:'POST'
        });
        uploader.on("error",function (type){
            if (type=="Q_TYPE_DENIED"){
                layer.msg("请上传JPG、PNG格式文件");
            }else if(type=="F_EXCEED_SIZE"){
                layer.msg("文件大小不能超过5M"); }
        });

        uploader.on('beforeFileQueued', function(file){
        });
        uploader.on( 'uploadSuccess', function( file, response) {
            $("input[name='markAble']").each(function(index,items){
                if(items.value==file.id){
                    $(site).append('<input type="hidden"  name="pickerImg" id="pickerImg'+file.id+'" value="'+response.path+'">');
                }
            })
        });
        uploader.on( 'uploadError', function( file, reason ) {

        });
        uploader.on( 'uploadFinished', function() {
            if(uploader){
                uploader.reset();
            }
        });


        uploader.on( 'fileQueued', function( file ) {
            if(feedImgsCount>=7){
                $("#jiahao").addClass('hide');
            }
            if(parseInt(feedImgsCount) > 7 ){
                layer.msg("最多可上传8张图片！");
                return false;
            }
            uploader.makeThumb( file, function( error, src ) {
                if (error) {
                    layer.msg('不能预览');
                } else {
                    img(id,src,file,site);
                }
            }, thumbnailWidth, thumbnailHeight );
        });

    }

    function delx(obj,fileId) {
        $("#file"+fileId+"").remove();
        $("#mark"+fileId+"").remove();
        $(obj).parent('.imgWrap1').remove();
        $("#pickerImg"+fileId).remove();
        feedImgsCount = feedImgsCount-1;
        if(feedImgsCount<=7){
            $("#jiahao").removeClass('hide');
        }
        return ;
    }
    function img(id,src,file,site){
        if(feedImgsCount > 7){
            $("#jiahao").addClass('hide');
            layer.msg("最多可上传8张图片！");
            return false;
        }
        feedImgsCount=parseInt(feedImgsCount)+1;
        var html =' <div class="f-l imgWrap1 mb-10" id="file'+file.id+'"><div class="imgWrap"> ';
        html +='<img src="'+src+'" id=""></div><a class="sficon btn-delimg" onclick="delx(this, \''+file.id+'\')"></a></div>'+
            '<input name="markAble" id="mark'+file.id+'" hidden="hidden" value="'+file.id+'" />';
        $(site).append(html);
        if(feedImgsCount>=8){
            $("#jiahao").addClass('hide');
        }
    }

    var adp = false;
    function Turntosend(lat,address){
        if(adp) {
            return;
        }
        adp = true;
        var orderid = "${order.id}";
        $.ajax({
            url:"${ctx}/order/count2",
            data:{orderId:orderid},// 备注信息 wxz 暂时取消，服务中的工单、待回访、待结算的工单中备件信息分为：使用的配件和申请的配件
            dataType:'json',
            success:function(result){
                if(parseInt(result) > 0){
                    layer.msg("工单有未审核的备件申请记录，请审核后再转派！");
                }else{
                    $("#arroundUserInfo").empty();
                    splitAddress('${order.customerAddress}');

                    $.selectCheck2("serverSelected");
                    $('.turnDispatch').popup({level: 2, closeSelfOnly: true});
                    initDispatchMap(lat);
                    employe(lat,address);
                }
            },
            complete: function() {
                adp = false;
            }
        })
    }



    function searchArroundCust(){
        var address = $("#arroundCustomerAddress").val();
        var orderId = $("input[name='sendMsgOrderId']").val();
        var mobile = $("input[name='customerMobileNow']").val();
        if(isBlank(address)){
            layer.msg("请输入地址信息");
        }else if(address.length>=2){
            $.ajax({
                type : "POST",
                url : "${ctx}/order/geteArroundCustInfo",
                data : {
                    address :address,
                    orderId:orderId,
                    mobile:mobile
                },
                success : function(data) {
                    var html='';
                    if(data.length>0){
                        for(var i=0;i<data.length;i++){
                            html+='<tr><td style="border-left: none;">'+data[i].columns.customer_name+'</td>';
                            html+='<td class="customerMobile">'+data[i].columns.customer_mobile+'</td>';
                            html+='<td>'+data[i].columns.applBranCate+'</td>';
                            html+='<td>'+data[i].columns.repair_time+'</td>';
                            html+='<td><label class="label-cbox3" ><input type="hidden" name="customerTelephone" value="'+data[i].columns.customer_telephone+'"/><input type="hidden" name="customerTelephone2" value="'+data[i].columns.customer_telephone2+'"/><input type="hidden" name="number" value="'+data[i].columns.number+'"/><input type="checkbox" name="serverSelected" ></label></td></tr>';
                        }
                        $("#arroundUserInfo").empty().append(html);

                        $("#arroundUserInfo tr").on('click', function(ev) {
                            var name = ev.target.tagName.toLowerCase();
                            if(name == 'label') return;

                            var flag = $(this).hasClass('checked');
                            if (flag) {
                                $(this).removeClass('checked');
                            } else {
                                $(this).attr("class","checked");
                                $.trim($(this).children('td').eq(0).html())
                            }
                        });
                    }else{
                        layer.msg("该地址暂无周边用户信息！");
                    }
                },
            });
        }else{
            layer.msg("输入的地址信息需要超过两个字符！");
        }

    }


    function returnMobile(val1,val2,val3){
        var mobile=$.trim(val1);
        if(isBlank(mobile)){
            mobile= $.trim(val2);
        }
        if(isBlank(mobile)){
            mobile= $.trim(val3);
        }
        if(isBlank(mobile)){
            mobile= "";
        }
        return mobile;
    }

    var noRepeateSend=false;
    function senMsgInTurnDisp(){ //批量发送短信
        var ids=$("#arroundUserInfo").find(".checked");
        var mobile="";
        var number="";
        var wrongNumber="";

        var sign = $("#sign").val();
        var jsPhone = $("#jdTelephone").val();
        var toAnUrl='${oneHref}';
        var content ="";
        if(ids.length<1){
            layer.msg("您还未选中任何数据！");
            return false;
        }
        for(var i=0;i<ids.length;i++){
            var customer_mobile = $(ids[i]).find(".customerMobile").text();
            var customer_telephone = $(ids[i]).find("input[name='customerTelephone']").val();
            var customer_telephone2 = $(ids[i]).find("input[name='customerTelephone2']").val();
            var numb=$(ids[i]).find("input[name='number']").val();
            var applBranCate=$(ids[i]).find(".applBranCate").text();/*品牌品类*/

            var ph1=returnMobile(customer_mobile,customer_telephone,customer_telephone2);//去空格的mobile
            if($.trim(ph1)=="" || $.trim(ph1)==null){
                layer.msg("选择发送的工单中存在用户手机号为空的工单，请先维护或者重新选择工单！");
                return ;
            }
            if($.trim(ph1).length!=11 || $.trim(ph1).substring(0,1)!="1" ){
                if(wrongNumber==""){
                    wrongNumber=numb;
                }else{
                    wrongNumber=wrongNumber+','+numb;
                }
            }
            if(i==0){
                mobile=$.trim(ph1);
                number=$.trim(numb);
            }else{
                mobile=mobile+','+$.trim(ph1);
                number=number+','+$.trim(numb);
            }

            /*短信模板*/
            content+="尊敬的用户，您好。我们是曾为您服务过的"+sign+"维修部。" +
                "您的"+applBranCate+"产品在上次服务后使用效果是否满意，提醒您定期检查。如果需要服务，" +
                "可以联系我们公司："+jsPhone+"。同时，家用电器用电安全也需要进行关注，" +
                "可以放心点击观看以下用电安全内容（"+toAnUrl+"）。#";

        }
        $("#wrongNumber").val(wrongNumber);//未发送的工单编号
        if(wrongNumber==""){
            var a = document.getElementById("exportLink");
            a.removeAttribute("href");
            a.setAttribute("onclick","tishi()");
        }else{
            $("#exportLink").prop("href", $("#exportLink").prop("href")+"&no="+wrongNumber);
        }

        if($.trim(sign)=="" || sign==null ){
            layer.msg("短信签名不能为空！");
            $("#sign").focus();
            return false;
        }
        if($.trim(sign).length>6 ){
            layer.msg("短信签名过长，最多为6个汉字！");
            $("#sign").focus();
            return false;
        }
        var siteMsgNums = $("#siteMsgNums").val();
        var msgNumbers = mobile.split(",");
        var msgNums = msgNumbers.length;//需要发送短信的工单数
        var message="尊敬的用户，您好。我们是曾为您服务过的"+sign+"维修部。" +
            "您的XXXX产品在上次服务后使用效果是否满意，提醒您定期检查。如果需要服务，" +
            "可以联系我们公司："+jsPhone+"。同时，家用电器用电安全也需要进行关注，" +
            "可以放心点击观看以下用电安全内容（XXXXXX）。";

        $('body').popup({
            level:3,
            title:"短信确认",
            content:message,
            fnConfirm :function(){
                if(noRepeateSend){
                    return;
                }
                noRepeateSend=true;
                layer.msg("短信发送中，请耐心等待...",{time:5000000});
                $.ajax({
                    type:"POST",
                    traditional:true,
                    url:"${ctx }/order/msgNumbers",
                    data:{content:content,
                        sign:sign},
                    success:function(result){
                        if(parseInt(result)*parseInt(msgNums) > parseInt(siteMsgNums)){
                            layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
                        }else{
                            $.ajax({
                                type:"POST",
                                traditional:true,
                                url:"${ctx }/order/sendInDispOrTurnDisp",
                                data:{content:content,
                                    sign:sign,
                                    mobile:mobile,
                                    number:number
                                },
                                success:function(result){
                                    if(result=="noMessage"){
                                        layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
                                    }else{
                                        var n = 0;
                                        for(var j=0;j<msgNumbers.length;j++){
                                            if(msgNumbers[j].length==11 && msgNumbers[j].substring(0,1)=="1" ){
                                                n++;
                                            }
                                        }
                                        $("#sucMsg").text(n);
                                        $("#wroMsg").text(parseInt(msgNumbers.length)-parseInt(n));
                                        layer.msg("发送成功");
                                        $('.massTextNoteQf').popup({level:2});
                                    }
                                }
                            })
                        }
                    },complete:function(){
                        noRepeateSend=false;
                    }
                })
            },
            fnCancel:function (){

            }
        });
    }

    function guanbi(){
        $.closeDiv($(".massTextNote"));
    }

    function closePopup(){
        $.closeDiv($(".massTextNote"));
    }

    /*切割地址（去掉省市区）*/
    function splitAddress(address) {
        var addressDetail="";
        var sz = [];
        if (address.indexOf("区") > 0 && address.indexOf("县") <= 0 && address.indexOf("市") < 0) {
            sz = address.split("区");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "区";
                    } else {
                        strs += sz[i];
                    }
                }
                addressDetail=strs;
            } else if (1 < sz.length <= 2) {
                addressDetail=sz[1];
            } else {
                addressDetail=sz[0];
            }
        }else if (address.indexOf("县") > 0 && address.indexOf("市") < 0) {
            sz = address.split("县");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "县";
                    } else {
                        strs += sz[i];
                    }
                }
                addressDetail=strs;
            } else if (1 < sz.length <= 2) {
                addressDetail=sz[1];
            } else {
                addressDetail=sz[0];
            }
        }else if(address.indexOf("县") > 0 && address.indexOf("市") > 0){
            var ciAd=address.indexOf("市");
            var xaAd=address.indexOf("县");
            if(parseInt(ciAd) < parseInt(xaAd)){//市在前
                sz = address.split("市");
                if (sz.length > 2) {
                    var strs = "";
                    for (var i = 1; i < sz.length; i++) {
                        if (i != sz.length - 1) {
                            strs += sz[i] + "市";
                        } else {
                            strs += sz[i];
                        }
                    }
                    addressDetail=strs;
                } else if (sz.length == 2) {
                    addressDetail=sz[1];
                } else {
                    addressDetail=sz[0];
                }
            }else if(parseInt(ciAd) > parseInt(xaAd) ){//县在前
                sz = address.split("县");
                if (sz.length > 2) {
                    var strs = "";
                    for (var i = 1; i < sz.length; i++) {
                        if (i != sz.length - 1) {
                            strs += sz[i] + "县";
                        } else {
                            strs += sz[i];
                        }
                    }
                    addressDetail=strs;
                } else if (1 < sz.length <= 2) {
                    addressDetail=sz[1];
                } else {
                    addressDetail=sz[0];
                }
            }
        }else if(address.indexOf("市") > 0 && address.indexOf("区") < 0){
            sz = address.split("市");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "市";
                    } else {
                        strs += sz[i];
                    }
                }
                addressDetail=strs;
            } else if (sz.length == 2) {
                addressDetail=sz[1];
            } else {
                addressDetail=sz[0];
            }
        }else if (address.indexOf("市") > 0 && address.indexOf("区") > 0) {
            var ciAd=address.indexOf("市");
            var quAd=address.indexOf("区");

            if(parseInt(ciAd) < parseInt(quAd)){//市在前
                sz = address.split("市");
                if (sz.length > 2) {
                    var strs = "";
                    for (var i = 1; i < sz.length; i++) {
                        if (i != sz.length - 1) {
                            strs += sz[i] + "市";
                        } else {
                            strs += sz[i];
                        }
                    }
                    addressDetail=strs;
                } else if (sz.length == 2) {
                    addressDetail=sz[1];
                } else {
                    addressDetail=sz[0];
                }
            }else if(parseInt(ciAd) > parseInt(quAd) ){//区在前
                sz = address.split("区");
                if (sz.length > 2) {
                    var strs = "";
                    for (var i = 1; i < sz.length; i++) {
                        if (i != sz.length - 1) {
                            strs += sz[i] + "区";
                        } else {
                            strs += sz[i];
                        }
                    }
                    addressDetail=strs;
                } else if (1 < sz.length <= 2) {
                    addressDetail=sz[1];
                } else {
                    addressDetail=sz[0];
                }
            }
        } else if (address.indexOf("区") <= 0 && address.indexOf("县") <= 0 && address.indexOf("市") <= 0) {
            addressDetail=address;
        }
        $("#arroundCustomerAddress").val(addressDetail);
    }

    function initDispatchMap(la) {
        if (!dispatchMap) {
            dispatchMap = new AMap.Map('dispatch_map_container', {
                zoom: 12
            });

            dispatchMarker = new AMap.Marker({
                map:dispatchMap,
                draggable:true
            });

            if(!isBlank(la)){
                var lnglats = la.split(",");
                var position = new AMap.LngLat(lnglats[0], lnglats[1]);
                dispatchMap.setZoomAndCenter(12, position);
                dispatchMarker.setPosition(position);
            }
            employeMarker = new AMap.Marker({});
        }
        employeMarker.setMap(null);
    }

    function employe(lnglat,address) {
        //	var lnglat = $("#lnglat").val();
        var category = $('#applianceCategory').val();
        $.ajax({
            type : "POST",
            url : "${ctx}/operate/employe/dispatchList",
            data : {
                lnglat :lnglat,
                category:category,
                address:address
            },
            success : function(data) {
                var content = $("#zhijiepaidan");
                content.empty();
                var sites = data;
                var appendHtml = '';
                for (var i = 0; i < sites.length; i++) {
                    var item = sites[i].columns;
                    appendHtml +='<tr>'
                        +'<td style="border-left: none;">'+item.name+'</td>'
                        +'<td>'+item.wwg+'</td>'
                        +'<td>'+item.jrywg+'</td>'
                        +'<td><label class="label-cbox3" for="'+item.id+'"><input type="checkbox" name="serverSelected" id="'+item.id+'"></label></td>'
                        +'</tr>';
                }
                if(isBlank(appendHtml)){
                    layer.msg("服务工程师没有维护"+category+"服务品类，请先维护");
                }
                content.html(appendHtml);

                $("#zhijiepaidan tr").each(function(index) {
                    $(this).data("emp", sites[index].columns);
                });
                $("#zhijiepaidan tr").on('click', function(ev) {
                    var name = ev.target.tagName.toLowerCase();
                    if(name == 'label') return;
                    var flag = $(this).hasClass('checked');
                    if (flag) {
                        $(this).removeClass('checked');
                    } else {
                        $(this).attr("class","checked");
                        $.trim($(this).children('td').eq(0).html())
                    }
                    $("#nameWrap").empty();
                    var name="";
                    var id = "";
                    $("#zhijiepaidan tr").each(function(index) {
                        var flag = $(this).hasClass('checked');
                        if (flag) {
                            if(isBlank(name)){
                                name = $.trim($(this).children('td').eq(0).html());
                            }else{
                                name = name+" "+ $.trim($(this).children('td').eq(0).html());
                            }
                            if(isBlank(id)){
                                id= $.trim($(this).children('td').eq(3).children('label').attr('for'));
                            }else{
                                id= id+","+$(this).children('td').eq(3).children('label').attr('for');
                            }
                        }
                    });
                    $("#nameWrap").append("<span>"+name+"</span>");
                    $("#employeId").val(id);

                });
            }
        });
    }
    //确认派工按钮
    var confirmDispa = false;
    function dispa(){
        if(confirmDispa) {
            return;
        }
        var empId= $("#employeId").val();
        var orderId = $("#orderId").val();
        var disorderId = $("#disorderId").val();
        var transferReasons = $.trim($("#transferReasons").val());
        if(isBlank(empId)){
            layer.msg("请选择服务工程师");
        }else if(isBlank(transferReasons)){
            layer.msg("请输入转派原因");
            $("#transferReasons").focus();
        }else{
            var name=$.trim($("#nameWrap").children('span').html());
            $('body').popup({
                level: '3',
                type:2,  // 提示是否进行某种操作
                content: '确认派工至' + name + '吗？',
                fnConfirm: function () {
                    confirmDispa = true;
                    $.ajax({
                        type : "POST",
                        url : "${ctx}/order/orderDispatch/Redispatch",
                        data :{
                            orderId :orderId,
                            empId :empId,
                            disorderId :disorderId,
                            transferReasons:transferReasons,
                            path: "orderDuringForm"
                        },
                        success : function(data) {
                            if(data){
                                layer.msg('已派工!');
                                parent.search();
                                parent.numerCheck();
                                $.closeDiv($('.turnDispatch'));
                                $.closeDiv($('.orderdetailVb'));
                                parent.closeBatchForms();
                                $('#Hui-article-box',window.top.document).css({'z-index':'9'});
                            }else{
                                layer.msg('派工失败!');
                            }
                        },
                        complete: function() {
                            confirmDispa = false;
                        }
                    });
                },
                fnCancel: function () {
                }
            });
        }
    }

    function select(id,val){
        if(!isBlank(val)){
            var select = document.getElementById(id);
            for (var i = 0; i < select.options.length; i++){
                if (select.options[i].value == val){
                    select.options[i].selected = true;
                    break;
                }
            }
        }
    }


    function getoff(){
        window.location.reload();
    }
    function address() {
        var sz = [];
        var address = $("#customerAddress").val();
        if (address.indexOf("区") > 0 && address.indexOf("县") <= 0 && address.indexOf("市") < 0) {
            sz = address.split("区");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "区";
                    } else {
                        strs += sz[i];
                    }
                }
                $("#customerAddress1").val(strs);
            } else if (1 < sz.length <= 2) {
                $("#customerAddress1").val(sz[1]);
            } else {
                $("#customerAddress1").val(sz[0]);
            }
        }else if (address.indexOf("县") > 0 && address.indexOf("市") < 0) {
            sz = address.split("县");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "县";
                    } else {
                        strs += sz[i];
                    }
                }
                $("#customerAddress1").val(strs);
            } else if (1 < sz.length <= 2) {
                $("#customerAddress1").val(sz[1]);
            } else {
                $("#customerAddress1").val(sz[0]);
            }
        }else if(address.indexOf("县") > 0 && address.indexOf("市") > 0){
            var ciAd=address.indexOf("市");
            var xaAd=address.indexOf("县");
            if(parseInt(ciAd) < parseInt(xaAd)){//市在前
                sz = address.split("市");
                if (sz.length > 2) {
                    var strs = "";
                    for (var i = 1; i < sz.length; i++) {
                        if (i != sz.length - 1) {
                            strs += sz[i] + "市";
                        } else {
                            strs += sz[i];
                        }
                    }
                    $("#customerAddress1").val(strs);
                } else if (sz.length == 2) {
                    $("#customerAddress1").val(sz[1]);
                } else {
                    $("#customerAddress1").val(sz[0]);
                }
            }else if(parseInt(ciAd) > parseInt(xaAd) ){//县在前
                sz = address.split("县");
                if (sz.length > 2) {
                    var strs = "";
                    for (var i = 1; i < sz.length; i++) {
                        if (i != sz.length - 1) {
                            strs += sz[i] + "县";
                        } else {
                            strs += sz[i];
                        }
                    }
                    $("#customerAddress1").val(strs);
                } else if (1 < sz.length <= 2) {
                    $("#customerAddress1").val(sz[1]);
                } else {
                    $("#customerAddress1").val(sz[0]);
                }
            }
        }else if(address.indexOf("市") > 0 && address.indexOf("区") < 0){
            sz = address.split("市");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "市";
                    } else {
                        strs += sz[i];
                    }
                }
                $("#customerAddress1").val(strs);
            } else if (sz.length == 2) {
                $("#customerAddress1").val(sz[1]);
            } else {
                $("#customerAddress1").val(sz[0]);
            }
        }else if (address.indexOf("市") > 0 && address.indexOf("区") > 0) {
            var ciAd=address.indexOf("市");
            var quAd=address.indexOf("区");

            if(parseInt(ciAd) < parseInt(quAd)){//市在前
                sz = address.split("市");
                if (sz.length > 2) {
                    var strs = "";
                    for (var i = 1; i < sz.length; i++) {
                        if (i != sz.length - 1) {
                            strs += sz[i] + "市";
                        } else {
                            strs += sz[i];
                        }
                    }
                    $("#customerAddress1").val(strs);
                } else if (sz.length == 2) {
                    $("#customerAddress1").val(sz[1]);
                } else {
                    $("#customerAddress1").val(sz[0]);
                }
            }else if(parseInt(ciAd) > parseInt(quAd) ){//区在前
                sz = address.split("区");
                if (sz.length > 2) {
                    var strs = "";
                    for (var i = 1; i < sz.length; i++) {
                        if (i != sz.length - 1) {
                            strs += sz[i] + "区";
                        } else {
                            strs += sz[i];
                        }
                    }
                    $("#customerAddress1").val(strs);
                } else if (1 < sz.length <= 2) {
                    $("#customerAddress1").val(sz[1]);
                } else {
                    $("#customerAddress1").val(sz[0]);
                }
            }
        } else if (address.indexOf("区") <= 0 && address.indexOf("县") <= 0 && address.indexOf("市") <= 0) {
            $("#customerAddress1").val(address);
        }
        var province = $("#province").val();
        var city = $("#city").val();
        var area = $("#area").val();
        if (isBlank(province) || isBlank(city) || isBlank(area)) {
            getDefaultAddress();
        }
    }



    function fittingApply(id){
        var orderNumber = "${order.number}";
        var str="";
        var imgstr="";
        var img = [];
        $.ajax({
            url:"${ctx}/order/showSYMsg",
            data:{orderNumber:orderNumber,remark:'SYMsg'},// 备注信息 wxz 暂时取消，服务中的工单、待回访、待结算的工单中备件信息分为：使用的配件和申请的配件
            dataType:'json',
            async:false,
            success:function(result){
                /*if(id=="pjmg"){*/
                $("#"+id).html(""+
                    "<thead>" +
                    "<tr>" +
                    "<th class='w-180'>备件条码</th>" +
                    "<th class='w-260'>备件名称</th>" +
                    "<th class='w-120'>备件型号</th>" +
                    "<th class='w-90'>最新入库价格</th>" +
                    "<th class='w-80'>工程师价格</th>" +
                    "<th class='w-70'>零售价格</th>" +
                    "<th class='w-50'>数量</th>" +
                    "<th class='w-70'>收费金额</th>" +
                    "<th class='w-100'>使用类型</th>" +
                    "<th class='w-70'>状态</th>" +
                    "<th class='w-70'>操作</th>" +
                    "</tr>" +
                    "</thead>");
                /*  } else {
                    $("#" + id).html(
                        "<thead>" +
                        "<tr>" +
                        "<th class='w-180'>备件条码</th>" +
                        "<th class='w-260'>备件名称</th>" +
                        "<th class='w-120'>备件型号</th>" +
                        "<th class='w-90'>最新入库价格</th>" +
                        "<th class='w-80'>工程师价格</th>" +
                        "<th class='w-70'>零售价格</th>" +
                        "<th class='w-50'>数量</th>" +
                        "<th class='w-70'>收费金额</th>" +
                        "<th class='w-70'>状态</th>" +
                        "</tr>" +
                        "</thead>");
                }*/
                var auxiliaryCostSum=0.0;
                var warrantyCost1 = $("#warrantyCost").val();
                var serveCost1 = $("#serveCost").val();
                if(result.list.length>0){
                    $.each(result.list,function(index,val){
                        str += "<tr>" +
                            "<td class='text-c w-140'>" + val.columns.fitting_code + "</td>" +
                            "<td class='text-c w-300'>" + val.columns.fitting_name + "</td>" +
                            "<td class='text-c w-120'>" + val.columns.fitting_version + "</td>" +
                            "<td class='text-c w-90'>" + val.columns.site_price + "</td>" +
                            "<td class='text-c w-80'>" + val.columns.employe_price + "</td>" +
                            "<td class='text-c w-70'>" + val.columns.customer_price + "</td>" +
                            "<td class='text-c w-50'>×" + val.columns.used_num + "</td>" +
                            "<td class='text-c w-70'>" + val.columns.collection_money + "</td>";
                        if(val.columns.warranty_type=="1"){
                            str+="<td class='text-c  w-100'>保内使用</td>";
                        }else if(val.columns.warranty_type=="2"){
                            str+="<td class='text-c  w-100'>保外零售</td>";
                        }else{
                            str+="<td class='text-c  w-100'></td>";
                        }
                        if(val.columns.status=="1"){
                            str+="<td class='text-c c-fe0101 w-70'><i class='oState state-verifyPass'></i>待核销</td>";
                        }else if(val.columns.status=="2"){
                            str+="<td class='text-c c-fe0101 w-70'><i class='oState state-waitVerify'></i>已核销</td>";
                        }
                        /*if(id=="pjmg"){*/
                        if(val.columns.collection_money){
                            auxiliaryCostSum+=val.columns.collection_money;
                        }
                        if(val.columns.status=="2"){//已核销，不显示删除
                            str+="<td class='text-c c-fe0101 w-70'>---</td>";
                        }else{
                            str+="<td class='text-c c-fe0101 w-70'><a onclick='deleteOneFit(\""+val.columns.id+"\",\""+val.columns.fitting_name+"\",\""+val.columns.used_num+"\")'><i class='sficon sficon-del'></i></a></td>";
                        }

                        //}
                    });
                    $("#auxiliaryCost").val(auxiliaryCostSum);
                    if(warrantyCost1!=null && warrantyCost1!=""){
                        auxiliaryCostSum=auxiliaryCostSum + parseFloat(warrantyCost1);
                    }
                    if(serveCost1!=null && serveCost1!=""){
                        auxiliaryCostSum=auxiliaryCostSum + parseFloat(serveCost1);
                    }
                    $("#zongCost").val(auxiliaryCostSum);
                }else{
                    $("#auxiliaryCost").val(0.0);
                    if(warrantyCost1){
                        auxiliaryCostSum=auxiliaryCostSum + parseFloat(warrantyCost1);
                    }
                    if(serveCost1){
                        auxiliaryCostSum=auxiliaryCostSum + parseFloat(serveCost1);
                    }
                    $("#zongCost").val(auxiliaryCostSum);
                    $(".showimg").html("");
                }

                $("#"+id).append(str);

                return;
            }

        });
    }
    //备件申请记录
    function fittingApplyrecord(){
        var orderNumber = "${order.number}";
        var str="";
        $.ajax({
            url:"${ctx}/order/showSQMsg",
            data:{orderNumber:orderNumber,remark:'SQMsg'},// 备注信息 wxz 暂时取消，服务中的工单、待回访、待结算的工单中备件信息分为：使用的配件和申请的配件
            dataType:'json',
            async:false,
            success:function(result){

                $("#pjmg").html(""+
                    "<thead>" +
                    "<tr>" +
                    "<th class='w-180'>备件条码</th>" +
                    "<th class='w-260'>备件名称</th>" +
                    "<th class='w-120'>备件型号</th>" +
                    "<th class='w-50'>数量</th>" +
                    "<th class='w-150'>审核备注</th>" +
                    "<th class='w-70'>状态</th>" +
                    "<th class='w-70'>操作</th>" +
                    "</tr>" +
                    "</thead>");
                if(result.list.length>0){
                    $.each(result.list,function(index,val){
                        str += "<tr>" +
                            "<td class='text-c w-140'>" + val.columns.fitting_code + "</td>" +
                            "<td class='text-c w-300'>" + val.columns.fitting_name + "</td>" +
                            "<td class='text-c w-120'>" + val.columns.fitting_version + "</td>" +
                            "<td class='text-c w-50'>×" + val.columns.fitting_apply_num + "</td>" +
                            "<td class='text-c w-150'>" + val.columns.audit_marks + "</td>" ;
                        if(val.columns.status=="0"){
                            str+="<td class='text-c c-fe0101 w-70'><i class='oState state-verifyPass'></i>待核销</td>";
                            str+="<td class='text-c c-fe0101 w-70'><a onclick='deleteFittingApply(\""+val.columns.id+"\",\""+val.columns.fitting_name+"\")'><i class='sficon sficon-del'></i></a></td>";
                        }else if(val.columns.status=="1"){
                            str+="<td class='text-c c-fe0101 w-70'><i class='oState state-waitVerify'></i>缺件中</td>";
                            str+="<td class='text-c c-fe0101 w-70'><a onclick='deleteFittingApply(\""+val.columns.id+"\",\""+val.columns.fitting_name+"\")'><i class='sficon sficon-del'></i></a></td>";
                        }else if(val.columns.status=="2"){
                            str+="<td class='text-c c-fe0101 w-70'><i class='oState state-waitVerify'></i>待出库</td>";
                            str+="<td class='text-c c-fe0101 w-70'><a onclick='deleteFittingApply(\""+val.columns.id+"\",\""+val.columns.fitting_name+"\")'><i class='sficon sficon-del'></i></a></td>";
                        }else if(val.columns.status=="3"){
                            str+="<td class='text-c c-fe0101 w-70'><i class='oState state-waitVerify'></i>待领取</td>";
                            str+="<td class='text-c c-fe0101 w-70'>---</td>";
                        }else if(val.columns.status=="4"){
                            str+="<td class='text-c c-fe0101 w-70'><i class='oState state-waitVerify'></i>可使用</td>";
                            str+="<td class='text-c c-fe0101 w-70'>---</td>";
                        }else {
                            str+="<td class='text-c c-fe0101 w-70'>---</td>";
                            str+="<td class='text-c c-fe0101 w-70'>---</td>";
                        }

                    });

                }else{

                    $(".showimg").html("");
                }

                $("#pjmg").append(str);

                return;
            }

        });
    }

    function deleteFittingApply(id,fittingName){
        $('body').popup({
            level:'3',
            type:2,
            content:"您确定要删除备件申请"+fittingName+"?",
            closeSelfOnly: true,
            fnConfirm:function(){
                $.ajax({
                    type:"post",
                    url:"${ctx}/fitting/fittingApply/deleteFittingApply",
                    data:{id:id},
                    success:function(data){
                        if(data.code=="200"){
                            layer.msg("删除成功");
                            fittingApplyrecord();
                            showSQMsg();
                            //parent.closeBatchForms();
                        }else if(data.code=="400"){
                            layer.msg("删除失败，配件信息有误");
                            return;
                        }else{
                            layer.msg("删除失败，请联系管理员");
                            return;
                        }
                    }
                })
            }
        })

    }

    function deleteOneFit(id,fittingName,num){
        $('body').popup({
            level:'3',
            type:2,
            content:"您确定要删除备件"+fittingName+"*"+num+"?",
            closeSelfOnly: true,
            fnConfirm:function(){
                $.ajax({
                    type:"post",
                    url:"${ctx}/order/deleteOneFittingRecord",
                    data:{id:id},
                    success:function(data){
                        if(data.code=="200"){
                            layer.msg("删除成功");
                            fittingApply("pjmg");
                            fittingApply("pjsy");
                            //parent.closeBatchForms();
                        }else if(data.code=="421"){
                            layer.msg("删除失败，使用记录有误");
                            return;
                        }else if(data.code=="422"){
                            layer.msg("该配件已核销,不能删除");
                            return;
                        }else if(data.code=="423"){
                            layer.msg("删除失败，配件信息有误");
                            return;
                        }else if(data.code=="424"){
                            layer.msg("工程师不存在，不能删除");
                            return;
                        }else if(data.code=="425"){
                            layer.msg("工程师库存信息有误，不能删除");
                            return;
                        }else if(data.code=="426"){
                            layer.msg("删除失败，当前工程师库存信息有误");
                            return;
                        }else{
                            layer.msg("删除失败，请联系管理员");
                            return;
                        }
                    }
                })
            }
        })

    }

    //获取工单关联备件使用信息
    function showSYMsg(){
        fittingApply("pjsy");
    }


    //获取工单关联备件申请信息
    function showSQMsg(){
        var orderNumber = "${order.number}";
        var str="";
        var imgstr="";
        var img = [];
        $.ajax({
            url:"${ctx}/order/showSQMsg",
            data:{orderNumber:orderNumber,remark:'SQMsg'},// 备注信息 wxz 暂时取消，服务中的工单、待回访、待结算的工单中备件信息分为：使用的配件和申请的配件
            dataType:'json',
            async:false,
            success:function(result){
                mark=result.list.length;
                $("#pjsq").html(
                    "<thead>" +
                    "<tr>" +
                    "<th class='w-180'>备件条码</th>" +
                    "<th class='w-260'>备件名称</th>" +
                    "<th class='w-120'>备件型号</th>" +
                    "<th class='w-50'>数量</th>" +
                    "<th class='w-150'>审核备注</th>" +
                    "<th class='w-70'>状态</th>" +
                    "<th class='w-70'>操作</th>" +
                    "</tr>" +
                    "</thead>");
                $(".showimg").html("<label class='lb lb1'>备件图片：</label>");

                if(result.list.length>0){
                    $.each(result.list,function(index,val){
                        str += "<tr>" +
                            "<td class='text-c w-140'>" + val.columns.fitting_code + "</td>" +
                            "<td class='text-c w-300'>" + val.columns.fitting_name + "</td>" +
                            "<td class='text-c w-120'>" + val.columns.fitting_version + "</td>" +
                            "<td class='text-c w-50'>×" + val.columns.fitting_apply_num + "</td>" +
                            "<td class='text-c w-150'>" + val.columns.audit_marks + "</td>" ;
                        if(val.columns.status=="0"){
                            str+="<td class='text-c c-fe0101 w-70'><i class='oState state-verifyPass'></i>待审核</td>";
                            str+="<td class='text-c c-fe0101 w-70'><a onclick='deleteFittingApply(\""+val.columns.id+"\",\""+val.columns.fitting_name+"\")'><i class='sficon sficon-del'></i></a></td>";
                        }else if(val.columns.status=="1"){
                            str+="<td class='text-c c-fe0101 w-70'><i class='oState state-waitVerify'></i>缺件中</td>";
                            str+="<td class='text-c c-fe0101 w-70'><a onclick='deleteFittingApply(\""+val.columns.id+"\",\""+val.columns.fitting_name+"\")'><i class='sficon sficon-del'></i></a></td>";
                        }else if(val.columns.status=="2"){
                            str+="<td class='text-c c-fe0101 w-70'><i class='oState state-waitVerify'></i>待出库</td>";
                            str+="<td class='text-c c-fe0101 w-70'><a onclick='deleteFittingApply(\""+val.columns.id+"\",\""+val.columns.fitting_name+"\")'><i class='sficon sficon-del'></i></a></td>";
                        }else if(val.columns.status=="3"){
                            str+="<td class='text-c c-fe0101 w-70'><i class='oState state-waitVerify'></i>待领取</td>";
                            str+="<td class='text-c c-fe0101 w-70'>---</td>";
                        }else if(val.columns.status=="4"){
                            str+="<td class='text-c c-fe0101 w-70'><i class='oState state-waitVerify'></i>已完成</td>";
                            str+="<td class='text-c c-fe0101 w-70'>---</td>";
                        }else {
                            str+="<td class='text-c c-fe0101 w-70'>---</td>";
                            str+="<td class='text-c c-fe0101 w-70'>---</td>";
                        }
                        str+="</tr class='w-100'>";
                        img = (val.columns.fitting_img).split(",");
                        for(var i=0;i<img.length;i++){
                            if(img[i]!=""&&img[i]!=null){
                                imgstr+=("<div class='f-l mr-10'><div class='imgWrap'><img src='${commonStaticImgPath}"+img[i]+"'></div></div>");
                            }
                        }
                    });
                    if(imgstr==""){
                        imgstr+=("<div class='f-l mr-10'><div class='imgWrap'><img src='${ctxPlugin}/static/h-ui.admin/images/img-default.png'></img></div></div>");
                    }
                }else{
                    $(".showimg").html("");
                }

                $("#pjsq").append(str);
                jQuery.getScript("${ctxPlugin}/static/h-ui.admin/js/imgShow.js", function(data, status, jqxhr) {
                    $(".showimg").append(imgstr);
                    $('.showimg').imgShow();
                });
                return;
            }

        });
    }

    //备件使用弹出
    function useFit(){
        $("input[name='code']").val('');
        $("input[name='type']").val('');
        $("input[name='num']").val('');
        $("input[name='num']").prop("placeholder","");

        $("#noPay").parent().addClass("radiobox-selected");
        $("#isPay").parent().removeClass("radiobox-selected");
        $("#hideMoney").addClass("hide");
        isCheck="";

        $.ajax({
            url:"${ctx}/fitting/employeFitting/getEmployeFittings",
            data:{orderId:"${order.id}"},
            dataType:'json',
            success:function(result){
                var html='<option value="">请选择</option>';
                for(var i=0;i<result.length;i++){
                    if(!isBlank(result[i].columns.fittingName)){
                        html+='<option value="'+result[i].columns.fitting_id+','+result[i].columns.employe_id+'">'+result[i].columns.employName+':'+result[i].columns.fittingName+'</option>';
                    }
                }
                $("#finame").empty().append(html);

                $('.usebj').popup({level:4, closeSelfOnly:true});
                $('#bjuseT input[type="text"]').val('');
                $('#bjuseT input[type="hidden"]').val('');
            },
            error:function(){
                return;
            }
        });

    };

    $("#finame").change(function(){
        q_bjuser();
    });

    $("input[name='num']").blur(function(){
        if(markBlur=="1"){
            return false;
        }
        var num = $("input[name='num']").val();
        if(num==null||num==""){
            layer.msg("请输使用入数量");
            return;
        }
        if(!checkNum(num)){
            layer.msg("输入数量格式错误");
            return;
        }
        q_bjuser();
    });

    $(function(){
        $("#noPay").parent().addClass("radiobox-selected");
        $("#noPay").click(function(){
            $("#noPay").parent().addClass("radiobox-selected");
            $("#isPay").parent().removeClass("radiobox-selected");
            $("#hideMoney").addClass("hide");
            isCheck="";
        });
        $("#isPay").click(function(){
            $("#noPay").parent().removeClass("radiobox-selected");
            $("#isPay").parent().addClass("radiobox-selected");
            $("#hideMoney").removeClass("hide");
            isCheck="1";
        });
    });

    $("#payPrice").blur(function(){
        var te =/^(0|[1-9][0-9]{0,9})(\.[0-9]{1,2})?$/;
        var va=$(this).val();
        if(isBlank(va)){
            layer.msg("请输入收费价格");
            return;
        }
        if(!te.test(va)){
            $(this).val('');
            layer.msg("收费价格格式不正确！");
            return;
        }
    });

    function q_bjuser(){
        var fitIdBindEmpId = $("#finame").val();
        if(isBlank(fitIdBindEmpId)){
            layer.msg("请选择工程师备件库存");
            $("input[name='type']").val("");
            $("input[name='code']").val("");
            $("input[name='num']").val("");
            $("#payPrice").val("");
            return;
        }
        var flag = true;
        $.ajax({
            url:"${ctx}/fitting/employeFitting/showFittingType",
            data:{fitIdBindEmpId:fitIdBindEmpId},
            async:false,
            dataType:'json',
            success:function(result){
                if(result.jg=='data'){
                    $("input[name='type']").val(result.version);
                    $("input[name='name']").val(result.name);
                    $("input[name='fittingId']").val(result.fittingId);
                    $("input[name='code']").val(result.code);
                    customerPrice=result.customerPrice;
                    if(!isBlank($("input[name='fittingId']").val())){
                        $("input[name='num']").prop("placeholder","最大数量"+result.maxnum);
                    }
                    if(eval($("input[name='num']").val())>result.maxnum){
                        layer.msg("数量超过最大限制");
                        flag = false;
                    }else{
                        var num = $("input[name='num']").val();
                        $("#payPrice").val(num*customerPrice);
                    }
                }else{
                    if($("input[name='code']").val()!=null&&$("input[name='code']").val()!=""){
                        $("input[name='type']").val("");
                        $("input[name='name']").val("");
                        $("input[name='num']").val("");
                        layer.msg("没有该备件");
                        flag = false;
                    }
                }
            },
            error:function(){
                flag = false;
            }

        });

        return flag;

    }

    var btn = document.getElementById("bj_use");
    btn.onmousedown = function(event) {event.preventDefault()};

    function tj_bjuse(){//bjuseT-table
        //显示型号
        var flag = false;
        var code =  $("input[name='code']").val();
        var num = $("input[name='num']").val();
        var fitIdBindEmpId = $("#finame").val();
        var price="";
        if(isCheck=='1'){
            var te =/^(0|[1-9][0-9]{0,9})(\.[0-9]{1,2})?$/;
            price=$("#payPrice").val();
            if(isBlank(price)){
                layer.msg("请输入收费价格");
                return;
            }
            if(!te.test(price)){
                $(this).val('');
                layer.msg("收费价格格式不正确！");
                return;
            }
        }
        if(isBlank(fitIdBindEmpId)){
            layer.msg("请选择工程师备件库存");
            return;
        }else if(isBlank(num)){
            layer.msg("请输入使用数量！");
            return;
        }else if(!checkNum(num)){
            layer.msg("输入数量格式错误");
            return;
        }

        flag = q_bjuser(); // 判断有没有符合条件的配件

        if(flag&&checkNum(num)&&code!=null&&code!=""){
            $.ajax({
                type:"post",
                url:"${ctx}/fitting/employeFitting/BjEmpFit",
                data:{code:code,fitIdBindEmpId:fitIdBindEmpId,num:num,orderId:"${order.id}",price:price,orderNumber:"${order.number}",customerName:"${order.customerName}",customerMobile:"${order.customerMobile}",
                    customerAddress:"${order.customerAddress}",warrantyType:"${order.warrantyType}",applianceCategory:"${order.applianceCategory}",applianceBrand:"${order.applianceBrand}"},
                dataType:'text',
                async:false,
                success:function(result){
                    layer.msg("操作成功!");
                    markBlur="1";
                    $.closeDiv($('.usebj'),true);
                    fittingApply("pjmg");
                    fittingApply("pjsy");
                    parent.closeBatchForms();
                },
                error:function(){
                    return;
                }
            });

        }else if(code==""||code==null){
            layer.msg("请输入条码");
            return;

        }
    }

    //备件申请
    $("input[name='acode']").blur(function(){
        q_bjapply();
        //showFittingType
    });
    $("input[name='anum']").blur(function(){
        //showFittingType
        var num = $("input[name='anum']").val();
        if(num==null||num==""){
            layer.msg("请输入使用数量");
            return;
        }
        if(!checkNum(num)){
            layer.msg("输入数量格式错误");
            return;
        }
        q_bjapply();
    });

    function q_bjapply(){
        //q_bjapply
        var code = $("input[name='acode']").val();
        var flag = true;
        $.ajax({
            url:"${ctx}/fitting/fittingApply/q_bjapply",
            data:{code:code},
            async:false,
            dataType:'json',
            success:function(result){
                if(result.jg=='data'){
                    $("input[name='atype']").val(result.version);
                    $("input[name='aname']").val(result.name);
                    $("textarea[name='appremarks']").val(result.remarks);
                    $("input[name='fittingId']").val(result.fittingId);
                    $("input[name='anum']").prop("placeholder","最大数量"+result.maxnum);
                    if(eval($("input[name='anum']").val())>result.maxnum){
                        layer.msg("数量超过最大限制");
                        flag = false;
                    }
                }else{
                    if($("input[name='acode']").val()!=null&&$("input[name='acode']").val()!=""){
                        layer.msg("没有该备件");
                        $("input[name='atype']").val("");
                        $("input[name='aname']").val("");
                        $("textarea[name='appremarks']").val("");
                        $("input[name='anum']").prop("");
                        $("input[name='fittingId']").val("");
                        flag = false;
                    }
                }
            },
            error:function(){
                flag = false;
            }

        });

        return flag;
    }

    var markBlur = "0";
    function tj_bjapply(){//bjapplyT-table
        //显示型号
        var flag = false;
        var name = $("input[name='aname']").val();
        var type = $("input[name='atype']").val();
        var code =  $("input[name='acode']").val();
        var num = $("input[name='anum']").val();
        var remarks = $("textarea[name='appremarks']").val();
        var orderId = "${order.id}";
        var fittingId = $("input[name='fittingId']").val();
        flag = q_bjapply();
        if(flag&&checkNum(num)&&code!=null&&code!=""){
            $.ajax({
                url:"${ctx}/fitting/fittingApply/tj_bjapply",
                data:{fittingId:fittingId,orderId:orderId,name:name,empName:"${order.employeName}",empId:"${order.employeId}",num:num,type:type,remarks:remarks},
                dataType:'text',
                async:false,
                success:function(result){
                    layer.msg("操作成功!");
                    $.closeDiv($('.applybj'));
                    //showPjmsg();
                    showSYMsg();
                },
                error:function(){
                    return;
                }
            });

        }else if(code==""||code==null){
            layer.msg("请输入条码");
            return;

        }else{
            layer.msg("数量输入格式错误");
            return;
        }
    }



    function checkNum(num){

        var reg=/^([1-9]\d*\.?\d*)|(0\.\d*[1-9])$/;;
        return reg.test(num);
    }

    function showPjmsg(){
        var header = "<thead>"+
            "<tr>"+
            "<th class='w-110'>备件条码</th>"+
            "<th class='w-250'>备件名称</th>"+
            "<th class='w-150'>备件型号</th>"+
            "<th class='w-50'>数量</th>"+
            "<th class='w-100'>备件状态</th>"+
            "<th class='w-140'>申请时间</th>"+
            "</tr>"+
            "</thead>";
        $.ajax({//table - pjmg
            url:"${ctx}/order/orderDispatch/showPjms",
            async:false,
            dataType:'json',
            data:{orderId:"${order.id}"},
            success:function(result){
                var str="";
                if(result.list.length>0){
                    $.each(result.list,function(index,val){
                        str+="<tr>";
                        str+="<td style='text-align: center;'>"+val.columns.fitting_code+"</td>";
                        str+="<td>"+val.columns.fitting_name+"</td>";
                        str+="<td>"+val.columns.fitting_version+"</td>";
                        str+="<td style='text-align: center;'>×"+val.columns.fitting_apply_num+"</td>";
                        if(val.columns.status=="0"){
                            str+="<td>待审核</td>";
                        }else if(val.columns.status=="1"){
                            str+="<td>缺件中</td>";
                        }else if(val.columns.status=="2"){
                            str+="<td>待出库</td>";
                        }else if(val.columns.status=="3"){
                            str+="<td>待领取</td>";
                        }else if(val.columns.status=="4"){
                            str+="<td>已领取</td>";
                        }else if(val.columns.status=="5"){
                            str+="<td>申请已取消</td>";
                        }else if(val.columns.status=="6"){
                            str+="<td>申请审核未通过</td>";
                        }
                        str+="<td>"+new Date(val.columns.create_time).format('yyyy-MM-dd hh:mm')+"</td>";
                        str+="</tr>";
                    });
                    $("#pjmg").html("");
                    $("#pjmg").append(header+str);
                }
            }
        });
    }

    $("input[name='bjca']").click(function(){
        $.closeDiv($('.usebj'), true);
        /* $.closeDiv($('.applybj')); */
    });
    Date.prototype.format = function(fmt) {
        var o = {
            "M+" : this.getMonth()+1,                 //月份
            "d+" : this.getDate(),                    //日
            "h+" : this.getHours(),                   //小时
            "m+" : this.getMinutes(),                 //分
            "s+" : this.getSeconds(),                 //秒
            "q+" : Math.floor((this.getMonth()+3)/3), //季度
            "S"  : this.getMilliseconds()             //毫秒
        };
        if(/(y+)/.test(fmt)) {
            fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
        }
        for(var k in o) {
            if(new RegExp("("+ k +")").test(fmt)){
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
            }
        }
        return fmt;
    };

    function changeStyle(orderNum){
        var bStop = false;
        var bStopIndex = 1;
        var topWindow = $(window.top.document),
            show_navLi = topWindow.find("#min_title_list li");

        show_navLi.each(function() {
            $(this).removeClass('active');
            if($(this).find('span').text() =='短信发送记录'){
                bStopIndex=show_navLi.index($(this));
                bStop=true;
            }
        });
        if(!bStop){
            creatIframe('${ctx }/operate/sendedSms?orderNum='+orderNum+'&target=2','短信发送记录');
        }else{
            show_navLi.eq(bStopIndex).addClass('active');
            topWindow.find('#iframe_box .show_iframe').hide().eq(bStopIndex).show().find('iframe').attr({'src':'${ctx }/operate/sendedSms?orderNum='+orderNum+'&target=2'});
        }
    }

    function newOrder(id){ //新建工单
        window.location.href="${ctx}/order2017/newFormFormDetail?id="+id;
    }


    function msgInform(orderId){
        orderMsgId = orderId;
        if(!${empty definedmodel}){
            $.Huitab("#msgWrapdef .tabBarP .tabswitch","#msgWrapdef .tabCon","current","click","0");
            $('.msg-input').each(function(){
                inputWidth(this);
            });
            selectMsgMoulddef("");
            $('.msgTextdefined').popup({level:4, closeSelfOnly: true});
        }else{
            $.Huitab("#msgWrap .tabBarP .tabswitch","#msgWrap .tabCon","current","click","0");
            $('.msg-input').each(function(){
                inputWidth(this);
            });
            $('.msgText1').popup({level:4, closeSelfOnly: true});
        }
    }
    function msgInform2(orderId){
        orderMsgId = orderId;
        $('.msgText2').popup({level:4, closeSelfOnly: true});
        $.Huitab("#msgWrap2 .tabBarP .tabswitch","#msgWrap2 .tabCon","current","click","0");
        $('.msg-input').each(function(){
            inputWidth(this);
        });
    }
    // 下拉框切换模板
    function selectMsgMould(obj){
        var tag;
        var aDiv = $('.msgText1 .msgmould');
        var index = obj.selectedIndex;
        var tag = $('#select-msgmode option:selected') .val();
        $.ajax({
            type:"POST",
            url:"${ctx }/order/getTag",
            data:{tag:tag},
            success:function(result){
                if(tag==6){
                    if(result[0].columns.id==2){
                        $("#sendModel1").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" >发送</a>');
                    }else{
                        $("#sendModel2").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[1].columns.id+'\',\''+result[1].columns.tag+'\',\''+result[1].columns.content+'\',3)" >发送</a>');
                    }
                    if(result[1].columns.id="2"){
                        $("#sendModel1").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[1].columns.id+'\',\''+result[1].columns.tag+'\',\''+result[1].columns.content+'\',3)" >发送</a>');
                    }else{
                        $("#sendModel2").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" >发送</a>');
                    }
                }else if(tag==4){
                    $("#sendModel3").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" >发送</a>');
                }else if(tag==3){
                    $("#sendModel4").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" >发送</a>');
                }else if(tag==2){
                    $("#sendModel5").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" >发送</a>');
                }else if(tag==7){
                    //$("#mode1").text('另有安全用电家电伴侣产品等为您提供试用');
                    //$("#mode2").text('另有专用自动止水水龙头和底座，可有效防止漏水和延长家电使用寿命');
                    $("#sendModel7").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',1)" >发送</a>');
                    $("#sendModel8").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',2)" >发送</a>');
                    $("#sendModel9").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',0)" >发送</a>');
                }else if(tag==9){
                    $("#sendModel20").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" >发送</a>');
                }else if(tag==11){

                }
                //$.setPos($(".msgText1"))
            }
        });
        aDiv.hide().eq(index).show();
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
        var emName = $("#emName").val();//工程师集合
        var customerMobile = $("#customerMobile").val();
        if($.trim(emName)=="" || emName==null){
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
        var goodsTime = $("#goodsTime").val();
        var pjArea = $("#pjArea").val();
        var pjMobile = $("#pjMobile").val();
        var yw = $("#yw").val();
        var siteName = $("#siteName").val();
        var jdMobile = $("#jdMobile").val();
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
                    layer.msg("发送成功!");
                    $.closeDiv($(".msgText1"));
                    $.closeDiv($(".msgTextdefined"));
                    window.location.reload();
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

    var defafs1
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
                    layer.msg("发送成功!");
                    $.closeDiv($(".msgText1"));
                    $.closeDiv($(".msgTextdefined"));
                    window.location.reload();
                }else if(result=="noMessage"){
                    layer.msg("剩余可发送短信条数不足，请先购买后再发送！");
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
    var afe = false;
    function sendMsgDXCD(type){
        $("#clickSend").empty();
        if(afe) {
            return;
        }
        var siteMsgNums = $("#siteMsgNums").val();//服务商已购还有短信数
        var sign = $("#sign").val();
        if(sign.length>6){
            layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
            return;
        }
        var customerMobile = $("#customerMobile").val();//用户联系方式
        var empMobiles = "${empMobile}".split(",");
        var contentRecord="";
        for(var i=0;i<empMobiles.length;i++){
            var empMobile = empMobiles[i];
            if($.trim(empMobile).length==11 && $.trim(empMobile).substring(0,1)=="1"){
            }else{
                layer.msg("工程师的手机号码信息有误，请确认后重新发送！");
                return;
            }
        }
        if($.trim(sign)=="" || sign==null){
            layer.msg("短信签名不能为空");
            $("#dxcdSn").focus();
            return;
        }
        if(sign.length>6){
            layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
            $("#dxcdSn").focus();
            return;
        }
        //自定义模板
        if(type=='1'){//固定模板
            afe = true;
            var danhao = "${order.number}";
            var pailei = "${order.applianceBrand}"+"${order.applianceCategory}";
            var useP = "${order.customerName}";
            var mobile = "${order.customerMobile}";
            var addreU = "${order.customerAddress}";
            $.ajax({
                type:"POST",
                url:"${ctx }/order/getTag",
                data:{tag:'11'},
                async:false,
                success:function(result){
                    contentRecord = result[0].columns.content;
                },
                complete: function() {
                    afe = false;
                }
            });
            // 查询出"@"的所有位置
            var path_1 = contentRecord.indexOf("@");// 第一个位置
            var path_2 = path_1 + contentRecord.substring(path_1 + 1).indexOf("@") + 1;// 第二个位置
            var path_3 = path_2 + contentRecord.substring(path_2 + 1).indexOf("@") + 1;// 第三个位置
            var path_4 = path_3 + contentRecord.substring(path_3 + 1).indexOf("@") + 1;// 第四个位置
            var content = contentRecord.substring(0, path_1) + danhao+"("+pailei+")"
                + contentRecord.substring(path_1 + 1, path_2) + useP+"("+mobile+")"
                + contentRecord.substring(path_2 + 1,path_3) + addreU
                + contentRecord.substring(path_3 + 1,path_4) + sign+ contentRecord.substring(path_4+1);
        }else if(type=='2'){//自定义模板
            var content = $.trim($("#content2").val());
            if(content=="" ){
                layer.msg("自定义发送短信内容不能为空");
                $("#content2").focus();
                return;
            }
            sign=$.trim($("#dxcdSn").val());
        }
        afe = true;
        $.ajax({//check短信为几条，并对比看服务商已购买短信够不够发送
            type:"POST",
            url:"${ctx }/order/msgNumbers",
            data:{content:content,
                sign:sign},
            async:false,
            success:function(result){
                if(parseInt(result)>parseInt(siteMsgNums)){//发送短信数大于购买数
                    layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
                    return;
                }else{
                    if(type=='1'){//模板
                        $("#peoples").html('${order.employeName}');
                        $("#sendContent").text("“"+content+"”？");
                        $("#clickSend").append('<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70  " onclick="sendMsgEmpModel(\''+sign+'\',\''+content+'\',\''+orderMsgId+'\',\''+empMobiles+'\')" >确定</a>&nbsp;&nbsp;'+
                            '<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="cancelQuren" onclick="cancelQueren()">取消</a>');
                        $(".msgTextQuren").popup({level:5,closeSelfOnly:true});
                    }else if(type=='2'){//自定义
                        definedContentCd=content;
                        $("#peoples").html('${order.employeName}');
                        $("#sendContent").text("“"+content+"”？");
                        $("#clickSend").append('<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70  " onclick="sendMsgEmp(\''+sign+'\',\''+empMobiles+'\',\''+orderMsgId+'\')" >确定</a>&nbsp;&nbsp;'+
                            '<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="cancelQuren" onclick="cancelQueren()">取消</a>');
                        $(".msgTextQuren").popup({level:5,closeSelfOnly:true});
                    }
                }
            },
            complete: function() {
                afe = false;
            }

        })

    }


    $('#Imgprocess2').imgShow();
    $('.showimg').imgShow();
    function dygd(id){
        //使用默认
        window.open("${ctx}/print/order?orderId="+id);
    }

    /*自定义*/
    function dygdcustom(id){
        $.ajax({
            type : 'POST',
            url : "${ctx}/order/printdesign/getOrderKeyName",
            data : {orderId:id},
            datatype:"JSON",
            success : function(data) {
                if(data == null || data.content == null || data.content.length<=0){
                    var newTab=window.open('about:blank');
                    newTab.location.href="${ctx}/print/order?orderId="+id;
                    return
                }
                var number='${order.number}';
                $.ajax({url:"${ctx}/print/writePrintTimes", type:"post", data:{number:number}, success:function(result){}});
                prn_Preview(data);
            }

        });
    }
    //判断是否设置自定义打印模板
    function judgedygd(){
        $.ajax({
            type : 'POST',
            url : "${ctx}/order/printdesign/getOrderPrin",
            data : {},
            datatype:"JSON",
            success : function(data) {
                if(data == "ok"){
                    $("#repeatOrder").hide();
                    $("#repeatOrder_custom").show();
                    return
                }else{
                    $("#repeatOrder").show();
                    $("#repeatOrder_custom").hide();
                }

            }

        });
    }

    function cancelQueren(){
        $.closeDiv($(".msgTextQuren"),true);
    }

    var empModels=false;
    function sendMsgEmpModel(sign,content,orderMsgId,empMobiles){
        if(empModels){
            return;
        }
        empModels=true;
        $.ajax({
            type:"POST",
            url:"${ctx }/order/fwzSendmsgModel",
            async:false,
            data:{
                temId:'8',
                sign:sign,
                content:content,
                extno:'11',//
                orderId:orderMsgId,
                customerMobile:empMobiles
            },
            success:function(result){
                if(result=="ok"){
                    layer.msg("发送成功!");
                    $.closeDiv($(".msgText2"));
                    window.location.reload();
                }else if(result=="noMessage"){
                    layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
                    return;
                } else{
                    layer.msg("发送失败，请稍后重试!");
                }
            },
            complete: function() {
                empModels = false;
            }
        })
    }

    var empNoModels=false;
    function sendMsgEmp(sign,empMobiles,orderMsgId){
        if(empNoModels){
            return;
        }
        empNoModels=true;
        $.ajax({
            type:"POST",
            url:"${ctx }/order/fwzSendmsg",
            async:false,
            data:{
                content:definedContentCd+"【"+sign+"服务】",
                sign:sign,
                orderMsgMobile:empMobiles,//工程师号码
                orderMsgId:orderMsgId
            },
            success:function(result){
                if(result=="ok"){
                    layer.msg("发送成功!");
                    $.closeDiv($(".msgText2"));
                    window.location.reload();
                }else if(result=="noMessage"){
                    layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
                    return;
                } else{
                    layer.msg("发送失败，请稍后重试!");
                }
            },
            complete: function() {
                empNoModels = false;
            }
        })
    }
    function showMarkOrder(id) {
        layer.open({
            type : 2,
            content:'${ctx}/order/showMarkOrdersFor2017?ids=' + id,
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
        });
    }

    //下一页
    function nextOrder(id,number) {
        toOrderDetail(id,number,'1');
    }

    //上一页
    function previousOrder(id,number) {
        toOrderDetail(id,number,'0');
    }

    function toOrderDetail(id,number,previousOrNext){
        var dtMsg = parent.getConditions();
        var topWin = window.top;
        parent.search();
        $.closeAllDiv();
        var $pFrame = $("#Hui-article-box iframe:visible", topWin.document);
        var frameWin = $pFrame.get(0).contentWindow || $pFrame.get(0);
        frameWin.layer.open({
            type : 2,
            content:'${ctx}/order/orderDispatch/Wholeform?map='+dtMsg+'&id='+id+'&previousOrNext='+previousOrNext+'&whereMark=1'+'&parentNumber='+number,
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
        });
    }

    $(".proofImg").imgShow();

    function deleteImg(ff) {
        $("#" + ff).remove();
        feedImgsCount = feedImgsCount - 1;
        if (feedImgsCount >= 7) {
            $("#jiahao").removeClass('hide');
        }
        if (uploader) {
            uploader = null;
        }
        createUploader("#filePicker-add", "#Imgprocess", "file_fake_addimg","file_fake_add", "delpickerImg");
    }

    function showGoodsMsg(){
    	var orderNumber = "${order.number}";
    	$.ajax({
    		url:"${ctx}/order/showGoodsMsg2017",
    		data:{orderNumber:orderNumber},
    		dataType:'json',
    		async:false,
    		success:function(data){
    			var html="";
    			if(data.length > 0){
    				for(var i=0;i<data.length;i++){
    					var dataJson = eval(data[i].columns.detailList);
    					html+="<tr>" +
                        "<td title='"+data[i].columns.number+"'>"+data[i].columns.number+"</td>" ;
                        var ht1="";
                        var ht2="";
                        var ht3="";
                        var ht4="";
                        var ht5="";
    					for(var j=0;j<dataJson.length;j++){
    						var goods = dataJson[j].columns;
    						ht1+="<div style='width:195px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;' title='"+goods.good_name+"'>"+goods.good_name+"</div>";
    						ht2+="<div title='"+goods.purchase_num+"'>"+goods.purchase_num+"</div>";
    						ht3+="<div title='"+goods.site_price+"'>"+goods.site_price+"</div>";
    						ht4+="<div title='"+goods.real_amount+"'>"+goods.real_amount+"</div>";
    						if(j<dataJson.length-1){
    							ht5+="<div style='border-bottom:1px solid #ccc;' title='"+goods.sales_commissions+"'>"+goods.sales_commissions+"</div>";
    						}else{
    							ht5+="<div title='"+goods.sales_commissions+"'>"+goods.sales_commissions+"</div>";
    						}
    					}
    					html+="<td>"+ht1+"</td>"+
    					"<td style='border-left:none;'>"+ht2+"</td>"+
    					"<td style='border-left:none;'>"+ht3+"</td>"+
    					"<td style='border-left:none;'>"+ht4+"</td>";
                        html+="<td title='"+data[i].columns.real_amount+"'>"+data[i].columns.real_amount+"</td>" +
                        "<td title='"+data[i].columns.confirm_amount+"'>"+data[i].columns.confirm_amount+"</td>";
    					html+="<td style='padding-left:0px;padding-right:0px;' class='bb h-30 pd-5'>"+ht5+"</td>";
                        html+= "<td  title='"+data[i].columns.placing_name+"'>"+data[i].columns.placing_name+"</td>" +
    	                    "<td >"+formatDate(data[i].columns.placing_order_time)+"</td>" +
    	                    "<td style='color:red;'>"+goodsOrderStatus(data[i].columns.status,goods.outstock_type,goods.stocks,goods.purchase_num,goods.outstock_type)+"</td>" +
    	                "</tr>";
    				}
    				$("#goodsMsg").empty();
    				$("#goodsMsg").append(html);
    			}
    		}
    	})
    }

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

    function showMore(obj){
        if($('#moreConWrap').is(':visible')){

            $('#moreConWrap').slideUp();
            $(obj).text('展开');
        }else{
            console.log(2);
            $('#moreConWrap').slideDown();
            $(obj).text('收起');
        }
    }

    function showQRCode(siteId,type){
        var code = $("#applianceBarcode").val();
        if("2"==type){
            code = $("#applianceMachineCode").val();
        }
        if(isBlank(code)){
            layer.msg("条码为空！");
            return;
        }
        // var str="http://www.sifangerp.com/wxweb/toScan?sid="+siteId+"&xcode="+code;
        $("#showCode").empty().qrcode({width: 200, height: 200, text: code});
        $(".qrcode").popup({level:2,closeSelfOnly:true});

    }

    function codeNumberCounts(){
        codeCounts();
        $('#applianceBarcode').bind('blur', function() {
            codeCounts();
            var code = $.trim($(this).val());
            if(!isBlank(code)){
                changeMark = false;
                loadAlreadyCode(1,code);//历史工单显示
                $(".code1").show();
                $(".weishu1").show();
            }else{
                changeMark = true;
                $("#codeInshow").hide();
                $(".code1").hide();
                $(".weishu1").hide();
            }
        });
        $('#applianceMachineCode').bind('input propertychange', function() {
            codeCounts1();//条码字数统计
        })
        $('#applianceBarcode').bind('input propertychange', function() {
            codeCounts1();//条码字数统计
        })
        $('#applianceMachineCode').bind('blur', function() {
            codeCounts();
            var code = $(this).val();
            if(!isBlank(code)){
                changeMark = false;
                loadAlreadyCode(2,code);//历史工单显示
                $(".code2").show();
                $(".weishu2").show();
            }else{
                changeMark = true;
                $("#codeOutshow").hide();
                $(".code2").hide();
                $(".weishu2").hide();
            }
        });
    }

    function codeCounts1(){
        var applianceBarcode = $.trim($("#applianceBarcode").val());
        var applianceMachineCode = $.trim($("#applianceMachineCode").val());
        $("#incodeNum").text(applianceBarcode.length);
        $("#outcodeNum").text(applianceMachineCode.length);
        if(!isBlank(applianceBarcode)){
            $(".weishu1").show();
            $(".code1").show();
            changeMark=false;
            //loadAlreadyCode(1,applianceBarcode);
        }else{
            $(".weishu1").hide();
            $(".code1").hide();
        }
        if(!isBlank(applianceMachineCode)){
            $(".weishu2").show();
            $(".code2").show();
            changeMark=false;
            //loadAlreadyCode(2,applianceMachineCode);
        }else{
            $(".weishu2").hide();
            $(".code2").hide();
        }
    }

    function codeCounts(){
        var applianceBarcode = $.trim($("#applianceBarcode").val());
        var applianceMachineCode = $.trim($("#applianceMachineCode").val());
        $("#incodeNum").text(applianceBarcode.length);
        $("#outcodeNum").text(applianceMachineCode.length);
        if(!isBlank(applianceBarcode)){
            $(".weishu1").show();
            $(".code1").show();
            changeMark=false;
            loadAlreadyCode(1,applianceBarcode);
        }else{
            $(".weishu1").hide();
            $(".code1").hide();
        }
        if(!isBlank(applianceMachineCode)){
            $(".weishu2").show();
            $(".code2").show();
            changeMark=false;
            loadAlreadyCode(2,applianceMachineCode);
        }else{
            $(".weishu2").hide();
            $(".code2").hide();
        }
    }

    function loadAlreadyCode(type,code){
        if(changeMark){
            return;
        }
        if(isBlank(code)){
            if(type==1){
                $("#codeInshow").hide();
                $(".codeIn").hide();
            }else{
                $("#codeOutshow").hide();
                $(".codeOut").hide();
            }
            return;
        }
        $.ajax({
            url: "${ctx}/order/getHistoryOrdersCodeOutCountByTelDetail2017?code=" + $.trim(code)+"&id="+'${order.id}',
            type: 'GET',
            success: function(data) {
                if(changeMark){
                    return;
                }
                var count = data.cnt;
                if(count == 0){
                    if(type==1){
                        $("#codeInshow").hide();
                        $(".codeIn").hide();
                    }else{
                        $("#codeOutshow").hide();
                        $(".codeOut").hide();
                    }
                }else{
                    if(count < 1){
                        $(".douhao").text("");
                    }
                    if(count > 0){
                        if(type==1){
                            $("#codeInshow").text(count+'条历史工单');
                            $("#codeInshow").show();
                            $(".codeIn").show();
                        }else{
                            $("#codeOutshow").text(count+'条历史工单');
                            $("#codeOutshow").show();
                            $(".codeOut").show();
                        }
                    }else{
                        if(type==1){
                            $(".codeIn").hide();
                        }else{
                            $(".codeOut").hide();
                        }

                    }
                    $('#codeShow').show();
                }
                changeMark=false;
            }
        });
    }

    function senMagPopup(id){
        layer.open({
            type : 2,
            content:'${ctx}/order/sendMsgAccountsOne?ids=' + id + "&type=1",
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
        });
    }

    function showzjfd(){
        $('.showzjfddiv').popup({level:2, closeSelfOnly:true});
    }

    function cancerBox(){
        $.closeDiv($('.showzjfddiv'), true);
    }

    function savezjfd(id){
        var latest_process = $.trim($("#reasonofzjfd").val());
        if(isBlank(latest_process)){
            layer.msg("请输入理由!");
            return;
        }else{
            $.ajax({
                type:"POST",
                url:"${ctx}/order/orderDispatch/updateOrderClose2017",
                data:{
                    id:id,
                    latest_process:latest_process
                },
                success:function(result){
                    layer.msg("封单完成");
                    $('#Hui-article-box',window.top.document).css({'z-index':'9'});
                    parent.search();
                    parent.numerCheck();
                    $.closeAllDiv();
                },
                error:function(){
                    alert("系统繁忙!");
                    return;
                }
            });
        }
    }
</script>
</body>
</html>