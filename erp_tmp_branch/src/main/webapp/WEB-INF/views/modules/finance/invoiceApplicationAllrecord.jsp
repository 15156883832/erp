<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>

    <meta name="decorator" content="base"/>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script> 
    <script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
</head>
<body>
<div class="sfpagebg bk-gray ">
    <div class="sfpage ">
        <div class="page-orderWait">
            <div id="tab-system" class="HuiTab">
                <div class="tabBar cl mb-10">
                    <a class="btn-tabBar  current" href="${ctx}/finance/invoiceApplication/allrecord">发票申请记录</a>
                    <p class="f-r btnWrap">
                        <a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
                        <a href="javascript:;" onclick="reset()" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
                    </p>
                </div>
                <form id="searchForm">
                    <input type="hidden" name="page" id="pageNo" value="1">
                    <input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
                    <div class="bk-gray pt-10 pb-5">
                        <table class="table table-search ">
                            <tr>
                                <th style="width: 76px;" class="text-r">申请人：</th>
                                <td>
								<span class="select-box">
									<select class="select" name="userMan" id="userMan">
									<option value="">请选择</option>
									<c:forEach items="${namemap }" var="names">
                                        <option value="${names.key}">${names.value}</option>
                                    </c:forEach>
									</select>
								</span>
                                </td>
                                <th style="width: 76px;" class="text-r">开票类型：</th>
                                <td>
								<span class="select-box">
									<select class="select" name="makeIvtype">
									<option value="">请选择</option>
		                            <option value="0">个人</option>
                                     <option value="1">企业</option>
									</select>
								</span>
                                </td>
                                <th style="width: 76px;" class="text-r">发票类型：</th>
                                <td>
								<span class="select-box">
									<select class="select" name="invoiceType">
									<option value="">请选择</option>
		                            <option value="0">增值税普通发票</option>
                                     <option value="1">增值税专用发票</option>
									</select>
								</span>
                                </td>
                                <th style="width: 76px;" class="text-r">审核状态：</th>
                                <td>
								<span class="select-box">
									<select class="select" name="reviewStatus">
									<option value="">请选择</option>
		                            <option value="0">待开票</option>
                                     <option value="1">已开票</option>
                                     <option value="2">审核未通过</option>
                                     <option value="3">待审核</option>
                                     <option value="4">已完成</option>
									</select>
								</span>
                                </td>
                            </tr>
                            <tr>
                                <th style="width: 76px;" class="text-r">申请时间：</th>
                                <td colspan="5">
                                    <input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'createTimeMax\')||\'%y-%M-%d\'}'})" id="createTimeMin" name="createTimeMin" value="" class="input-text Wdate w-120" style="width:120px">
                                    至
                                    <input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'createTimeMin\')}',maxDate:'%y-%M-%d'})" id="createTimeMax" name="createTimeMax"  value="" class="input-text Wdate w-120" style="width:120px">
                                    <label class="lb text-r">开票时间：</label>
                                    <input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'kaipiaoTimeMax\')||\'%y-%M-%d\'}'})"  id="kaipiaoTimeMin" name="kaipiaoTimeMin" value="" class="input-text Wdate w-120" style="width:120px">
                                    至
                                    <input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'kaipiaoTimeMin\')}',maxDate:'%y-%M-%d'})" id="kaipiaoTimeMax" name="kaipiaoTimeMax"  value="" class="input-text Wdate w-120" style="width:120px">

                                </td>
                            </tr>
                        </table>
                    </div>

                    <div class="pt-10 pb-5 cl">
                        <div class="f-l">
                            <%--<a href="javascript:deletes();" class="sfbtn sfbtn-opt"><i class="sficon sficon-rubbish"></i>删除</a>--%>
                        </div>
                        <div class="f-r">
                            <%--  <a onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>--%>
                        </div>
                    </div>
                    <div>
                        <table id="table-waitdispatch" class="table"></table>
                        <!-- pagination -->
                        <div class="cl pt-10">
                            <div class="f-r">
                                <div class="pagination"></div>
                            </div>
                        </div>
                        <!-- pagination -->
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="popupBox w-620 fpWrap fpsqshWrap">
    <h2 class="popupHead">
        发票详情
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer pb-50">
        <div class="popupMain pt-10 pl-15 pr-15">
            <div class="infoWrap">
                <p class="infoWrapTitle"><strong>发票信息</strong></p>
                <div class="cl lh-26 f-13">
                    <div class="f-l w-280">
                        <span class="f-l ">开票类型：</span>
                        <span class="f-l  c-888" id="makeIvtype1">个人</span>
                    </div>
                    <div class="f-r w-280">
                        <span class="f-l ">发票类型：</span>
                        <span class="f-l c-888" id="invoiceType1">增值税普通发票</span>
                    </div>
                </div>
                <!-- 个人 -->
                <div class="cl lh-26 f-13 hide geren">
                    <div class="f-l w-280">
                        <span class="f-l ">发票抬头：</span>
                        <span class="f-l c-888" id="invoiceTitle1">胖子</span>
                    </div>
                    <div class="f-r w-280">
                        <span class="f-l ">开票金额：</span>
                        <span class="f-l c-888"><span class="va-t pr-5 c-0e8ee7 f-18" id="invoiceValue1">12,000</span>元</span>
                    </div>
                </div>

                <!-- 企业 -->
                <div class="qiye">
                    <div class="cl lh-26 f-13">
                        <div class="f-l w-280">
                            <span class="f-l ">发票抬头：</span>
                            <span class="f-l c-888" id="invoiceTitle">安徽思方科技有限公司</span>
                        </div>
                    </div>
                    <div class="cl lh-26 f-13">
                        <div class="f-l w-280">
                            <span class="f-l ">开票金额：</span>
                            <span class="f-l c-888"><span class="va-t pr-5 c-0e8ee7 f-18" id="invoiceValue">12,000</span>元</span>
                        </div>
                        <div class="f-r w-280">
                            <span class="f-l ">联系电话：</span>
                            <span class="f-l c-888" id="mobile1">15655445566</span>
                        </div>
                    </div>
                    <div class="cl lh-26 f-13">
                        <div class="f-l w-280">
                            <span class="f-l ">企业地址：</span>
                            <span class="f-l c-888" id="address1"></span>
                        </div>
                    </div>
                    <div class="cl lh-26 f-13">
                        <div class="f-l w-280">
                            <span class="f-l ">税务登记证号：</span>
                            <span class="f-l c-888" id="taxRegistrationNumber1"></span>
                        </div>
                    </div>
                    <div class="cl lh-26 f-13">
                        <div class="f-l w-280">
                            <span class="f-l ">基本开户银行：</span>
                            <span class="f-l  c-888" id="bankOfDeposit1"></span>
                        </div>
                        <div class="f-r w-280">
                            <span class="f-l ">基本开户账号：</span>
                            <span class="f-l c-888" id="openAccount1"></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="infoWrap">
                <p class="infoWrapTitle"><strong>发票寄送地址</strong></p>
                <div class="cl lh-26 f-13">
                    <div class="f-l w-280">
                        <span class="f-l ">收件人姓名：</span>
                        <span class="f-l  c-888" id="receiverName1">胖纸</span>
                    </div>
                    <div class="f-r w-280">
                        <span class="f-l ">手机号：</span>
                        <span class="f-  c-888" id="receiverMobile1">13805510551</span>
                    </div>
                </div>
                <div class="cl lh-26 f-13">
                    <span class="f-l text-r">&#12288;收件地址：</span>
                    <p class="f-l c-888 w-420" id="receiverAddress1">湖南张家界永定区湖南张家界永定区北门幼儿园后面</p>
                </div>
                <div class="cl lh-26 f-13">
                    <span class="f-l text-r">&#12288;邮政编码：</span>
                    <p class="f-l c-888 " id="postcode1">230011</p>
                </div>
                <div class="line-dashed mb-10 mt-10"></div>
                <div class="cl lh-26 f-13 mt-5 mb-10">
                    <span class="f-l text-r">&#12288;&#12288;&#12288;备注：</span>
                    <input type="text" class="f-l c-888 input-text w-480" id="reviewRemark1" readonly="readonly" />
                </div>
                <div class="cl lh-26 f-13 detailwuliu" >
                    <div class="f-l w-280 ">
                        <span class="f-l ">&#12288;物流名称：</span>
                        <input type="text" class="input-text f-l w-190" id="logisticsNames1" readonly="readonly" />
                    </div>
                    <div class="f-r w-280">
                        <span class="f-l w-70 text-r">物流单号：</span>
                        <input type="text" class="input-text f-l w-190" id="logisticsNumber1" readonly="readonly"/>
                    </div>
                </div>
            </div>
        </div>
<%--        <div class="text-c btbWrap">
            <a href="javascript:;" class="sfbtn sfbtn-opt3 mr-5">通过</a>
            <a href="javascript:;" class="sfbtn sfbtn-opt">不通过</a>
        </div>--%>
    </div>
</div>


<div class="popupBox w-620 fpWrap kaipiao">
    <h2 class="popupHead">
         开票
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer pb-50">
        <div class="popupMain pt-10 pl-15 pr-15">
            <div class="infoWrap">
                <input type="hidden" id="kprecordid"/>
                <p class="infoWrapTitle"><strong>发票信息</strong></p>
                <div class="cl lh-26 f-13">
                    <div class="f-l w-280">
                        <span class="f-l ">开票类型：</span>
                        <span class="f-l  c-888" id="makeIvtype2">个人</span>
                    </div>
                    <div class="f-r w-280">
                        <span class="f-l ">发票类型：</span>
                        <span class="f-l c-888" id="invoiceType2">增值税普通发票</span>
                    </div>
                </div>
                <!-- 个人 -->
                <div class="cl lh-26 f-13 hide kaipiaogeren">
                    <div class="f-l w-280">
                        <span class="f-l ">发票抬头：</span>
                        <span class="f-l c-888" id="invoiceTitle2">胖子</span>
                    </div>
                    <div class="f-r w-280">
                        <span class="f-l ">开票金额：</span>
                        <span class="f-l c-888"><span class="va-t pr-5 c-0e8ee7 f-18" id="invoiceValue2">12,000</span>元</span>
                    </div>
                </div>

                <!-- 企业 -->
                <div class="kaipiaoqiye">
                    <div class="cl lh-26 f-13">
                        <div class="f-l w-280">
                            <span class="f-l ">发票抬头：</span>
                            <span class="f-l c-888" id="invoiceTitle3">安徽思方科技有限公司</span>
                        </div>
                    </div>
                    <div class="cl lh-26 f-13">
                        <div class="f-l w-280">
                            <span class="f-l ">开票金额：</span>
                            <span class="f-l c-888"><span class="va-t pr-5 c-0e8ee7 f-18" id="invoiceValue3">12,000</span>元</span>
                        </div>
                        <div class="f-r w-280">
                            <span class="f-l ">联系电话：</span>
                            <span class="f-l c-888" id="mobile2">15655445566</span>
                        </div>
                    </div>
                    <div class="cl lh-26 f-13">
                        <div class="f-l w-280">
                            <span class="f-l ">企业地址：</span>
                            <span class="f-l c-888" id="address2"></span>
                        </div>
                    </div>
                    <div class="cl lh-26 f-13">
                        <div class="f-l w-280">
                            <span class="f-l ">税务登记证号：</span>
                            <span class="f-l c-888" id="taxRegistrationNumber2"></span>
                        </div>
                    </div>
                    <div class="cl lh-26 f-13">
                        <div class="f-l w-280">
                            <span class="f-l ">基本开户银行：</span>
                            <span class="f-l  c-888" id="bankOfDeposit2"></span>
                        </div>
                        <div class="f-r w-280">
                            <span class="f-l ">基本开户账号：</span>
                            <span class="f-l c-888" id="openAccount2"></span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="infoWrap">
                <p class="infoWrapTitle"><strong>发票寄送地址</strong></p>
                <div class="cl lh-26 f-13">
                    <div class="f-l w-280">
                        <span class="f-l ">收件人姓名：</span>
                        <span class="f-l  c-888" id="receiverNamekp">胖纸</span>
                    </div>
                    <div class="f-r w-280">
                        <span class="f-l ">手机号：</span>
                        <span class="f-  c-888" id="receiverMobilekp">13805510551</span>
                    </div>
                </div>
                <div class="cl lh-26 f-13">
                    <span class="f-l text-r">&#12288;收件地址：</span>
                    <p class="f-l c-888 w-420" id="receiverAddresskp">湖南张家界永定区湖南张家界永定区北门幼儿园后面</p>
                </div>
                <div class="cl lh-26 f-13">
                    <span class="f-l text-r">&#12288;邮政编码：</span>
                    <p class="f-l c-888 " id="postcodekp">230011</p>
                </div>
                <div class="cl lh-26 f-13 mt-5 mb-10">
                    <span class="f-l text-r">&#12288;&#12288;&#12288;备注：</span>
                    <input type="text" class="f-l c-888 input-text w-480" id="reviewRemarkkp" readonly="readonly" />
                </div>
            </div>

        </div>
        <div class="line-dashed mb-10 mt-10"></div>
        <div class="cl lh-26 f-13">
            <div class="f-l w-280">
                <span class="f-l ">&#12288;开票时间：</span>
                <input type="text" onfocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'yyyy-MM-dd'})"  id="kaipiaoTime1" name="kaipiaoTime1"  class="input-text Wdate w-170 f-l">
            </div>
        </div>
           <div class="text-c btbWrap">
                <a href="javascript:querenkp();" class="sfbtn sfbtn-opt3 mr-5">确定</a>
                <a href="javascript:quxiaokp();" class="sfbtn sfbtn-opt">取消</a>
            </div>
    </div>
</div>

<div class="popupBox w-620 fpWrap shenhe">
    <h2 class="popupHead">
        发票申请审核
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer pb-50">
        <div class="popupMain pt-10 pl-15 pr-15">
            <div class="infoWrap">
                <input type="hidden" id="shrecordid"/>
                <p class="infoWrapTitle"><strong>发票信息</strong></p>
                <div class="cl lh-26 f-13">
                    <div class="f-l w-280">
                        <span class="f-l ">开票类型：</span>
                        <span class="f-l  c-888" id="makeIvtype3">个人</span>
                    </div>
                    <div class="f-r w-280">
                        <span class="f-l ">发票类型：</span>
                        <span class="f-l c-888" id="invoiceType3">增值税普通发票</span>
                    </div>
                </div>
                <!-- 个人 -->
                <div class="cl lh-26 f-13 hide shgeren">
                    <div class="f-l w-280">
                        <span class="f-l ">发票抬头：</span>
                        <span class="f-l c-888" id="invoiceTitle4">胖子</span>
                    </div>
                    <div class="f-r w-280">
                        <span class="f-l ">开票金额：</span>
                        <span class="f-l c-888"><span class="va-t pr-5 c-0e8ee7 f-18" id="invoiceValue4">12,000</span>元</span>
                    </div>
                </div>

                <!-- 企业 -->
                <div class="shqiye">
                    <div class="cl lh-26 f-13">
                        <div class="f-l w-280">
                            <span class="f-l ">发票抬头：</span>
                            <span class="f-l c-888" id="invoiceTitle5">安徽思方科技有限公司</span>
                        </div>
                    </div>
                    <div class="cl lh-26 f-13">
                        <div class="f-l w-280">
                            <span class="f-l ">开票金额：</span>
                            <span class="f-l c-888"><span class="va-t pr-5 c-0e8ee7 f-18" id="invoiceValue5">12,000</span>元</span>
                        </div>
                        <div class="f-r w-280">
                            <span class="f-l ">联系电话：</span>
                            <span class="f-l c-888" id="mobile3">15655445566</span>
                        </div>
                    </div>
                    <div class="cl lh-26 f-13">
                        <div class="f-l w-280">
                            <span class="f-l ">企业地址：</span>
                            <span class="f-l c-888" id="address3"></span>
                        </div>
                    </div>
                    <div class="cl lh-26 f-13">
                        <div class="f-l w-280">
                            <span class="f-l ">税务登记证号：</span>
                            <span class="f-l c-888" id="taxRegistrationNumber3"></span>
                        </div>
                    </div>
                    <div class="cl lh-26 f-13">
                        <div class="f-l w-280">
                            <span class="f-l ">基本开户银行：</span>
                            <span class="f-l  c-888" id="bankOfDeposit3"></span>
                        </div>
                        <div class="f-r w-280">
                            <span class="f-l ">基本开户账号：</span>
                            <span class="f-l c-888" id="openAccount3"></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="infoWrap">
                <p class="infoWrapTitle"><strong>发票寄送地址</strong></p>
                <div class="cl lh-26 f-13">
                    <div class="f-l w-280">
                        <span class="f-l ">收件人姓名：</span>
                        <span class="f-l  c-888" id="receiverName3">胖纸</span>
                    </div>
                    <div class="f-r w-280">
                        <span class="f-l ">手机号：</span>
                        <span class="f-  c-888" id="receiverMobile3">13805510551</span>
                    </div>
                </div>
                <div class="cl lh-26 f-13">
                    <span class="f-l text-r">&#12288;收件地址：</span>
                    <p class="f-l c-888 w-420" id="receiverAddress3">湖南张家界永定区湖南张家界永定区北门幼儿园后面</p>
                </div>
                <div class="cl lh-26 f-13">
                    <span class="f-l text-r">&#12288;邮政编码：</span>
                    <p class="f-l c-888 " id="postcode3">230011</p>
                </div>
                <div class="line-dashed mb-10 mt-10"></div>
                <div class="cl lh-26 f-13 mt-5">
                    <span class="f-l text-r">&#12288;&#12288;&#12288;备注：</span>
                    <input type="text" class="f-l c-888 input-text w-480" id="reviewRemark3"  />
                </div>
            </div>
        </div>
           <div class="text-c btbWrap">
                    <a href="javascript:reviewok('ok');" class="sfbtn sfbtn-opt3 mr-5">通过</a>
                    <a href="javascript:reviewok('failed');" class="sfbtn sfbtn-opt">不通过</a>
           </div>
    </div>
</div>

<div class="popupBox w-620 fpWrap wlxxWrap">
    <h2 class="popupHead">
        寄件
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer pb-50">
        <div class="popupMain pt-10 pl-15 pr-15">
            <div class="infoWrap">
                <input type="hidden" id="jjrecordid"/>
                <p class="infoWrapTitle"><strong>发票信息</strong></p>
                <div class="cl lh-26 f-13">
                    <div class="f-l w-280">
                        <span class="f-l ">开票类型：</span>
                        <span class="f-l  c-888" id="makeIvtypejj">个人</span>
                    </div>
                    <div class="f-r w-280">
                        <span class="f-l ">发票类型：</span>
                        <span class="f-l c-888" id="invoiceTypejj">增值税普通发票</span>
                    </div>
                </div>
                <!-- 个人 -->
                <div class="cl lh-26 f-13 hide jjgeren">
                    <div class="f-l w-280">
                        <span class="f-l ">发票抬头：</span>
                        <span class="f-l c-888" id="invoiceTitlejj">胖子</span>
                    </div>
                    <div class="f-r w-280">
                        <span class="f-l ">开票金额：</span>
                        <span class="f-l c-888"><span class="va-t pr-5 c-0e8ee7 f-18" id="invoiceValuejj">12,000</span>元</span>
                    </div>
                </div>

                <!-- 企业 -->
                <div class="jjqiye">
                    <div class="cl lh-26 f-13">
                        <div class="f-l w-280">
                            <span class="f-l ">发票抬头：</span>
                            <span class="f-l c-888" id="invoiceTitlejj2">安徽思方科技有限公司</span>
                        </div>
                    </div>
                    <div class="cl lh-26 f-13">
                        <div class="f-l w-280">
                            <span class="f-l ">开票金额：</span>
                            <span class="f-l c-888"><span class="va-t pr-5 c-0e8ee7 f-18" id="invoiceValuejj2">12,000</span>元</span>
                        </div>
                        <div class="f-r w-280">
                            <span class="f-l ">联系电话：</span>
                            <span class="f-l c-888" id="mobilejj">15655445566</span>
                        </div>
                    </div>
                    <div class="cl lh-26 f-13">
                        <div class="f-l w-280">
                            <span class="f-l ">企业地址：</span>
                            <span class="f-l c-888" id="addressjj"></span>
                        </div>
                    </div>
                    <div class="cl lh-26 f-13">
                        <div class="f-l w-280">
                            <span class="f-l ">税务登记证号：</span>
                            <span class="f-l c-888" id="taxRegistrationNumberjj"></span>
                        </div>
                    </div>
                    <div class="cl lh-26 f-13">
                        <div class="f-l w-280">
                            <span class="f-l ">基本开户银行：</span>
                            <span class="f-l  c-888" id="bankOfDepositjj"></span>
                        </div>
                        <div class="f-r w-280">
                            <span class="f-l ">基本开户账号：</span>
                            <span class="f-l c-888" id="openAccountjj"></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="infoWrap">
                <p class="infoWrapTitle"><strong>发票寄送地址</strong></p>
                <div class="cl lh-26 f-13">
                    <div class="f-l w-280">
                        <span class="f-l ">收件人姓名：</span>
                        <span class="f-l  c-888" id="receiverNamejj">胖纸</span>
                    </div>
                    <div class="f-r w-280">
                        <span class="f-l ">手机号：</span>
                        <span class="f-  c-888" id="receiverMobilejj">13805510551</span>
                    </div>
                </div>
                <div class="cl lh-26 f-13">
                    <span class="f-l text-r">&#12288;收件地址：</span>
                    <p class="f-l c-888 w-420" id="receiverAddressjj">湖南张家界永定区湖南张家界永定区北门幼儿园后面</p>
                </div>
                <div class="cl lh-26 f-13">
                    <span class="f-l text-r">&#12288;邮政编码：</span>
                    <p class="f-l c-888 " id="postcodejj">230011</p>
                </div>
                <div class="line-dashed mb-10 mt-10"></div>
                <div class="cl lh-26 f-13 mt-5 mb-10">
                    <span class="f-l text-r">&#12288;&#12288;&#12288;备注：</span>
                    <input type="text" class="f-l c-888 input-text w-480" id="reviewRemarkjj" readonly="readonly" />
                </div>
                <div class="cl lh-26 f-13">
                    <div class="f-l w-280 ">
                        <span class="f-l ">&#12288;物流名称：</span>
                        <span class="select-box w-190">
                            <select class="select" name="logisticsNamesjj" id="logisticsNamesjj">
                              <option value="">请选择</option>
                              <option value="中通快递">中通快递</option>
                                <option value="顺丰速运">顺丰速运</option>
                                <option value="EMS">EMS</option>
                                <option value="申通快递">申通快递</option>
                                <option value="圆通快递">圆通快递</option>
                                <option value="韵达快递">韵达快递</option>
                                <option value="百世汇通快递">百世汇通快递</option>
                                <option value="天天快递">天天快递</option>
                                <option value="德邦快递">德邦快递</option>
                                <option value="全一快递">全一快递</option>
                                <option value="全峰快递">全峰快递</option>
                                <option value="盛辉快递">盛辉快递</option>
                                <option value="中铁快递">中铁快递</option>
                            </select>
                        </span>
                    </div>
                    <div class="f-r w-280">
                        <span class="f-l w-70 text-r">物流单号：</span>
                        <input type="text" class="input-text f-l w-190" id="logisticsNumberjj" />
                    </div>
                </div>
            </div>
        </div>
        <div class="text-c btbWrap">
            <a href="javascript:qurenjj();" class="sfbtn sfbtn-opt3 mr-5">确认寄件</a>
            <a href="javascript:quxiaojj();" class="sfbtn sfbtn-opt">取消</a>
        </div>
    </div>
</div>


<script type="text/javascript">

    var sfGrid;
    var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
    var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部

    $(function(){
        initSfGrid();
    	$("#userMan").select2();
    	$("#userMan").next(".select2").find(".selection").css("width","140px");
    });

    //初始化jqGrid表格，传递的参数按照说明
    function initSfGrid(){
        var url = "${ctx}/finance/invoiceApplication/getalllist";
        sfGrid = $("#table-waitdispatch").sfGrid({
            url:url,
            sfHeader:defaultHeader,
            sfSortColumns:sortHeader,
            //shrinkToFit: true,
            multiselect: false,
            postData:$("#searchForm").serializeJson(),
            rownumbers : true,
            gridComplete:function(){
                _order_comm.gridNum();
            },
            loadComplete:function(){
            $('.proofImg').each(function(){
                $(this).imgShow({hasIframe:true});
            });
        }
        });
    }


    function reviewStatus(rowDate) {
        if (rowDate.review_status == "0") {
            return "<span>待开票</span>";
        } else if (rowDate.review_status == "1") {
            return "<span>已开票</span>";
        } else if (rowDate.review_status == "2") {
            return "<span>审核未通过</span>";
        } else if (rowDate.review_status == "3") {
            return "<span>待审核</span>";
        } else if (rowDate.review_status == "4") {
            return "<span>已完成</span>";
        } else {
            return "<span></span>";
        }
    }

    function ivtypeStatus(rowDate) {
        if (rowDate.invoice_type == "0") {
            return "<span>增值税普通发票</span>";
        } else {
            return "<span>增值税专用发票</span>";
        }
    }
    function fmtOper(rowData) {//操作
        var html = "---";
        if (rowData.review_status == '0') {
            html = "<span  ><a onclick='kaipiao(\"" + rowData.id + "\")' class='c-0383dc' >开票</a></span>";
        } else if (rowData.review_status == '1') {
            html = "<span  ><a onclick='jijian(\"" + rowData.id + "\")' class='c-0383dc' >寄件</a></span>";
        } else if (rowData.review_status == '2') {
            html = "<span  ><a onclick='getDetail(\"" + rowData.id + "\")' class='c-0383dc' >查看详情</a></span>";
        } else if (rowData.review_status == '3') {
            html = "<span  ><a onclick='toReview(\"" + rowData.id + "\")' class='c-0383dc' >审核</a></span>";
        } else if (rowData.review_status == '4') {
            html = "<span  ><a onclick='getDetail(\"" + rowData.id + "\")' class='c-0383dc' >查看详情</a></span>";
        } else {
            html = "<span  class='c-0383dc'>---</span>";
        }
        return html;
    }

    function iconShow(rowData){
        return html='<span class="proofImg"><a class="c-0383dc">资格证</a> <img src="${commonStaticImgPath}'+rowData.icon+'" /> </span>';
    }

    function getDetail(id){
        $.ajax({
            url: "${ctx}/finance/invoiceApplication/getDetaile",
            type: "POST",
            data: {invoiceapplicationid:id},
            success: function (data) {
                if (data !=null) {
                    if(data.columns.make_ivtype=="0"){
                        $("#makeIvtype1").html("个人");
                        $("#invoiceType1").html(data.columns.invoice_type);
                        $("#invoiceTitle1").html(data.columns.invoice_title);
                        $("#invoiceValue1").html(data.columns.invoice_value);
                        $("#receiverName1").html(data.columns.receiver_name);
                        $("#receiverMobile1").html(data.columns.receiver_mobile);
                        $("#receiverAddress1").html(data.columns.receiver_address);
                        $("#postcode1").html(data.columns.postcode);
                        $("#reviewRemark1").val(data.columns.review_remark);
                        $("#logisticsNames1").val(data.columns.logistics_names);
                        $("#logisticsNumber1").val(data.columns.logistics_number);
                        $(".geren").removeClass("hide");
                        $(".qiye").addClass("hide");
                    }else{
                        $("#kprecordid").val(data.columns.id);
                        $("#makeIvtype1").html("企业");
                        $("#invoiceType1").html(data.columns.invoice_type);
                        $("#invoiceTitle").html(data.columns.invoice_title);
                        $("#invoiceValue").html(data.columns.invoice_value);
                        $("#mobile1").html(data.columns.mobile);
                        $("#address1").html(data.columns.address);
                        $("#taxRegistrationNumber1").html(data.columns.tax_registration_number);
                        $("#bankOfDeposit1").html(data.columns.bank_of_deposit);
                        $("#openAccount1").html(data.columns.open_account);
                        $("#receiverName1").html(data.columns.receiver_name);
                        $("#receiverMobile1").html(data.columns.receiver_mobile);
                        $("#receiverAddress1").html(data.columns.receiver_address);
                        $("#postcode1").html(data.columns.postcode);
                        $("#reviewRemark1").val(data.columns.review_remark);
                        $("#logisticsNames1").val(data.columns.logistics_names);
                        $("#logisticsNumber1").val(data.columns.logistics_number);
                        $(".qiye").removeClass("hide");
                        $(".geren").addClass("hide");
                    }
                    if(data.columns.review_status=="2"){
                        $(".detailwuliu").addClass("hide");
                    }else{
                        $(".detailwuliu").removeClass("hide");
                    }
                    $('.fpsqshWrap').popup();
                } else{
                    layer.msg("查询失败");
                }
            }
        });
    }
//打开开票弹框
    function kaipiao(id) {
        var kaipiaotime = getNowFormatDate();
        $("#kaipiaoTime1").val(kaipiaotime);
        $.ajax({
            url: "${ctx}/finance/invoiceApplication/getDetaile",
            type: "POST",
            data: {invoiceapplicationid: id},
            success: function (data) {
                if (data != null) {
                    if (data.columns.make_ivtype == "0") {
                        $("#kprecordid").val(data.columns.id);
                        $("#makeIvtype2").html("个人");
                        $("#invoiceType2").html(data.columns.invoice_type);
                        $("#invoiceTitle2").html(data.columns.invoice_title);
                        $("#invoiceValue2").html(data.columns.invoice_value);
                        $("#receiverNamekp").html(data.columns.receiver_name);
                        $("#receiverMobilekp").html(data.columns.receiver_mobile);
                        $("#receiverAddresskp").html(data.columns.receiver_address);
                        $("#postcodekp").html(data.columns.postcode);
                        $("#reviewRemarkkp").val(data.columns.review_remark);
                        $(".kaipiaogeren").removeClass("hide");
                        $(".kaipiaoqiye").addClass("hide");
                    } else {
                        $("#kprecordid").val(data.columns.id);
                        $("#makeIvtype2").html("企业");
                        $("#invoiceType2").html(data.columns.invoice_type);
                        $("#invoiceTitle3").html(data.columns.invoice_title);
                        $("#invoiceValue3").html(data.columns.invoice_value);
                        $("#mobile2").html(data.columns.mobile);
                        $("#address2").html(data.columns.address);
                        $("#taxRegistrationNumber2").html(data.columns.tax_registration_number);
                        $("#bankOfDeposit2").html(data.columns.bank_of_deposit);
                        $("#openAccount2").html(data.columns.open_account);
                        $("#receiverNamekp").html(data.columns.receiver_name);
                        $("#receiverMobilekp").html(data.columns.receiver_mobile);
                        $("#receiverAddresskp").html(data.columns.receiver_address);
                        $("#postcodekp").html(data.columns.postcode);
                        $("#reviewRemarkkp").val(data.columns.review_remark);
                        $(".kaipiaoqiye").removeClass("hide");
                        $(".kaipiaogeren").addClass("hide");
                    }
                    $('.kaipiao').popup();
                } else {
                    layer.msg("查询失败");
                }
            }
        });
    }

    //打开审核弹框
    function toReview(id){
        $("#reviewRemark3").val("");
        $.ajax({
            url: "${ctx}/finance/invoiceApplication/getDetaile",
            type: "POST",
            data: {invoiceapplicationid:id},
            success: function (data) {
                if (data !=null) {
                    if(data.columns.make_ivtype=="0"){
                        $("#shrecordid").val(data.columns.id);
                        $("#makeIvtype3").html("个人");
                        $("#invoiceType3").html(data.columns.invoice_type);
                        $("#invoiceTitle4").html(data.columns.invoice_title);
                        $("#invoiceValue4").html(data.columns.invoice_value);
                        $("#receiverName3").html(data.columns.receiver_name);
                        $("#receiverMobile3").html(data.columns.receiver_mobile);
                        $("#receiverAddress3").html(data.columns.receiver_address);
                        $("#postcode3").html(data.columns.postcode);
                        $(".shgeren").removeClass("hide");
                        $(".shqiye").addClass("hide");
                    }else{
                        $("#shrecordid").val(data.columns.id);
                        $("#makeIvtype3").html("企业");
                        $("#invoiceType3").html(data.columns.invoice_type);
                        $("#invoiceTitle5").html(data.columns.invoice_title);
                        $("#invoiceValue5").html(data.columns.invoice_value);
                        $("#mobile3").html(data.columns.mobile);
                        $("#address3").html(data.columns.address);
                        $("#taxRegistrationNumber3").html(data.columns.tax_registration_number);
                        $("#bankOfDeposit3").html(data.columns.bank_of_deposit);
                        $("#openAccount3").html(data.columns.open_account);
                        $("#receiverName3").html(data.columns.receiver_name);
                        $("#receiverMobile3").html(data.columns.receiver_mobile);
                        $("#receiverAddress3").html(data.columns.receiver_address);
                        $("#postcode3").html(data.columns.postcode);
                        $(".shqiye").removeClass("hide");
                        $(".shgeren").addClass("hide");
                    }
                    $('.shenhe').popup();
                } else{
                    layer.msg("查询失败");
                }
            }
        });
    }
//打开寄件弹框
    function jijian(id){
        $.ajax({
            url: "${ctx}/finance/invoiceApplication/getDetaile",
            type: "POST",
            data: {invoiceapplicationid:id},
            success: function (data) {
                if (data !=null) {
                    if(data.columns.make_ivtype=="0"){
                        $("#jjrecordid").val(data.columns.id);
                        $("#makeIvtypejj").html("个人");
                        $("#invoiceTypejj").html(data.columns.invoice_type);
                        $("#invoiceTitlejj").html(data.columns.invoice_title);
                        $("#invoiceValuejj").html(data.columns.invoice_value);
                        $("#receiverNamejj").html(data.columns.receiver_name);
                        $("#receiverMobilejj").html(data.columns.receiver_mobile);
                        $("#receiverAddressjj").html(data.columns.receiver_address);
                        $("#postcodejj").html(data.columns.postcode);
                        $("#reviewRemarkjj").val(data.columns.review_remark);
                        $(".jjgeren").removeClass("hide");
                        $(".jjqiye").addClass("hide");
                    }else{
                        $("#jjrecordid").val(data.columns.id);
                        $("#makeIvtypejj").html("企业");
                        $("#invoiceTypejj").html(data.columns.invoice_type);
                        $("#invoiceTitlejj2").html(data.columns.invoice_title);
                        $("#invoiceValuejj2").html(data.columns.invoice_value);
                        $("#mobilejj").html(data.columns.mobile);
                        $("#addressjj").html(data.columns.address);
                        $("#taxRegistrationNumberjj").html(data.columns.tax_registration_number);
                        $("#bankOfDepositjj").html(data.columns.bankOf_deposit);
                        $("#openAccountjj").html(data.columns.open_account);
                        $("#receiverNamejj").html(data.columns.receiver_name);
                        $("#receiverMobilejj").html(data.columns.receiver_mobile);
                        $("#receiverAddressjj").html(data.columns.receiver_address);
                        $("#postcodejj").html(data.columns.postcode);
                        $("#reviewRemarkjj").val(data.columns.review_remark);
                        $(".jjqiye").removeClass("hide");
                        $(".jjgeren").addClass("hide");
                    }
                    $('.wlxxWrap').popup();
                } else{
                    layer.msg("查询失败");
                }
            }
        });
    }

    //开票
    var markkp= false;
    function querenkp(){
        if (markkp) {
            return;
        }
        var id = $("#kprecordid").val();
        var kaipiaotime = $("#kaipiaoTime1").val();
        markkp = true;
        $.ajax({
            url: "${ctx}/finance/invoiceApplication/kaipiao",
            type: "POST",
            data: {invoiceapplicationid:id,
                  kaipiaotime:kaipiaotime
                  },
            success: function (data) {
                markkp = false;
                if (data =="ok") {
                    layer.msg("开票成功");
                    search();
                    $.closeDiv($('.kaipiao'));
                } else{
                    layer.msg("开票失败");
                }
            }
        });
    }
//审核
    var marksh = false;
    function reviewok(flag) {
        if (marksh) {
            return;
        }
        var id = $("#shrecordid").val();
        var flags = flag;
        var reviewRemark = $("#reviewRemark3").val();
        marksh = true;
        $.ajax({
            url: "${ctx}/finance/invoiceApplication/review",
            type: "POST",
            data: {
                invoiceapplicationid: id,
                flag: flags,
                reviewRemark: reviewRemark
            },
            success: function (data) {
                marksh = false;
                if (data == "ok") {
                    layer.msg("审核成功");
                    search();
                    $.closeDiv($('.shenhe'));
                } else {
                    layer.msg("审核失败");
                }
            }
        });
    }

    //寄件
    var markjj = false;
    function qurenjj() {
        if (markjj) {
            return;
        }
        var id = $("#jjrecordid").val();
        var logisticsNames = $("#logisticsNamesjj").val();
        var logisticsNumber = $("#logisticsNumberjj").val();
        markjj = true;
        $.ajax({
            url: "${ctx}/finance/invoiceApplication/jijian",
            type: "POST",
            data: {
                invoiceapplicationid: id,
                logisticsNames: logisticsNames,
                logisticsNumber: logisticsNumber
            },
            success: function (data) {
                markjj = false;
                if (data == "ok") {
                    layer.msg("寄件成功");
                    search();
                    $.closeDiv($('.wlxxWrap'));
                } else {
                    layer.msg("寄件失败");
                }
            }
        });

    }

    function quxiaokp() {
        $.closeDiv($('.kaipiao'));
    }

    function quxiaojj() {
        $.closeDiv($('.wlxxWrap'));
    }


    function search() {
        var pageSize = $("#pageSize").val();
        if ($.trim(pageSize) == '' || pageSize == null) {
            $("#pageSize").val(20);
        }
        $("#table-waitdispatch").sfGridSearch({
            postData: $("#searchForm").serializeJson()
        });
    }

    function getNowFormatDate() {
        var date = new Date();
        var seperator1 = "-";
        var month = date.getMonth() + 1;
        var strDate = date.getDate();
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        if (strDate >= 0 && strDate <= 9) {
            strDate = "0" + strDate;
        }
        var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
        return currentdate;
    }
    function reset() {
        $("#searchForm").get(0).reset();
    }

</script>
</body>
</html>