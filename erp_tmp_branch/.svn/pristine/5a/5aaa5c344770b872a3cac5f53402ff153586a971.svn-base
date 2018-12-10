<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>商品信息管理</title>
    <meta name="decorator" content="base"/>

</head>
<body>
<div class="sfpagebg bk-gray">
    <div class="sfpage  table-header-settable">
        <div class="page-orderWait">
            <div id="tab-system" class="HuiTab">
                <div class="tabBar cl mb-10">
                    <sfTags:pagePermission
                            authFlag="SYSSETTLE_GOODSMSGSET_GOODSCATESET_TAB"
                            html='<a class="btn-tabBar " href="${ctx}/order/smsSignSet">短信签名设置</a>'></sfTags:pagePermission>
                    <%-- <sfTags:pagePermission
                        authFlag="SYSSETTLE_GOODSMSGSET_GOODSCATESET_TAB"
                    html=' --%><sfTags:pagePermission authFlag="SMSMGM_SIGN_SEND_TAB" html='<a class="btn-tabBar " href="${ctx}/order/commonsetting/getShortmessage">短信发送设置</a>'/>
                    <sfTags:pagePermission
                            authFlag="SMSMGM_SIGN_CREATETEMP_TAB"
                            html=' <a class="btn-tabBar  current" href="${ctx}/order/smstempletSet/headlist">短信模板</a>'></sfTags:pagePermission>
                    <p class="f-r btnWrap">
                    </p>

                </div>
               <%-- <div class="mt-10"></div>--%>
                <div class="tabCon">
                    <form id="searchForm">
                        <input type="hidden" name="page" id="pageNo" value="1">
                        <input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
                        <div>
                            <table class="table table-search">
                            </table>
                        <div class="pt-10 pb-5 cl">
                            <div class="f-l">
                              <!--   <a class="sfbtn sfbtn-opt" id="btn-add" onclick="openadd()"><i class="sficon sficon-add"></i>新增模板</a> -->
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
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </div>
</div>


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
                    <p class="c-fe0101 pl-10  pb-10 ">注意：短信签名在短信签名设置中维护好，请勿在内容中重复添加</p>
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


<script type="text/javascript">

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
            }
        });
    }

    $('.msgModuleText').on('click','span',function(){
        var msgTextarea = document.getElementById('msgTextarea');
        insertAtCursor(msgTextarea,$(this).attr('data-text'));
    })

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



    var sfGrid;
    var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
    var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部


    function fmtOper(rowData){
            return "<span >---</span>";
            return "<span ><a class='c-0383dc' onclick=editOne('"+rowData.id+"') ><i class='sficon sficon-edit'></i>修改</a></span>&nbsp;&nbsp;&nbsp;<span><a class='c-0383dc' onclick=delOne('"+rowData.id+"') ><i class='sficon sficon-del'></i>删除</a></span>";
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


    function search(){
        var pageSize = $("#pageSize").val();
        if ($.trim(pageSize) == '' || pageSize == null) {
            $("#pageSize").val(20);
        }
        $("#table-waitdispatch").sfGridSearch({
            postData: $("#searchForm").serializeJson()
        });
    }

    function openadd(){//打开添加弹出框
        $("#temname").val("");
        $("#msgTextarea").val("");
        $('.addMsgModule').popup();
    }

    var saveflag = false
    function save(){
        if(saveflag){
            return
        }
        var id = $("#smsid").val();
        var number=$("#tid").val();
        var name = $("#temname").val();
        var content = $("#msgTextarea").val();
        var createBy = $("#createBy").val();
        var createType = $("#createType").val();
         var faildreason = $("#faildreason").val();
        if('${siteSign.columns.sms_sign}'==""||${empty siteSign.columns.sms_sign}){
            layer.msg("短信签名不能为空请维护");
            return;
        }
        if(name==""||name==null){
            layer.msg("请填写模板名称");
            return
        }
        if(content==""||content==null){
            layer.msg("请填写模板内容");
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
                "number":number,
                "createBy":createBy,
                "createType":createType,
                "faildreason":faildreason
            },
            success:function(data){
                if(data=="rename"){
                    layer.msg("模板名称已存在");
                    $("#temname").focus;
                    saveflag=false;
                    return;
                }
                if(data=="ok1"){
                    layer.msg("添加成功");
                    search();
                    $.closeDiv($(".addMsgModule"));
                }else if(data=="faild"){
                    layer.msg("添加失败请稍后重试或待审核通过重试");
                    return;
                } else if(data=="nullsignname"){
                    layer.msg("请到短信签名设置中维护短信签名");
                    return;
                }else if(data=="ok2"){
                    layer.msg("修改成功");
                    search();
                    $.closeDiv($(".addMsgModule"));
                }else{
                    layer.msg("操作失败请稍后重试");
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
                   layer.msg("删除成功");
                   search();
               }else{
                   layer.msg("删除失败");
                   return;
               }
           },
           error:function(){
               layer.alert("系统繁忙!");
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




</script>
</body>
</html>