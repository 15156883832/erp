<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>奖品</title>
	<meta name="decorator" content="base"/>
	<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
</head>
<body>
<div class="sfpagebg bk-gray">
	<div class="sfpage table-header-settable">
		<div class="page-orderWait">
			<div id="tab-system" class="HuiTab">
				<div class="tabBar cl mb-10">
					<sfTags:pagePermission authFlag=" OPERATEMGM_SHARE_SHARE_TAB" html='<a class="btn-tabBar current" href="${ctx}/sys/gift">分享会员奖励</a>'></sfTags:pagePermission>
					<p class="f-r btnWrap">
					</p>
				</div>
				<div class="tabCon" style="display: block;">
					<form id="searchForm">
						<input type="hidden" name="page" id="pageNo" value="1">
						<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
						<div>
							<table id="table-ordermarks" class="table"></table>
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
</div>

<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript">
    var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的

    $(function () {
        initGrid();
    });

    function initGrid() {
        $("#table-ordermarks").sfGrid({
            url: '${ctx}/sys/gift/giftPackGrid',
            sfHeader: defaultHeader,
            shrinkToFit: true,
			multiselect: false,
			rownumbers : true,
	 		gridComplete:function(){
	 			_order_comm.gridNum();
	 		}
        });
    }

	var posting = false;
    function takeGift(id) {
        if (posting) {
            return;
        }

        posting = true;
        $.ajax({
            url: '${ctx}/sys/gift/vipTake',
            type: 'post',
            data: {
                "id": id
            },
            success: function (data) {
                search();
                if ("200" === data.code) {
                    $('body').popup({
                        level: '3',
                        type: 1,
                        content: "恭喜您成功领取了" + data.data.gift + "，您的会员有效期延长至" + data.data.due,
                        fnConfirm: function () {
                        }
                    });
                }
            },
            error: function () {
            },
            complete: function () {
                posting = false;
            }
        });
    }

    function fmtOper(rowData) { //列表操作
    	if ('${fns:checkBtnPermission(" OPERATEMGM_SHARE_SHARE_RECEIVE_BTN")}' === 'true') {
	        if (rowData.take_time) {
	            return "已领取";
	        } else {
	            return '<a href="javascript:takeGift(\'' + rowData.id + '\');" class="c-0383dc">领取</a>';
	        }
    	}
   		return '';
    }

    function search(){
    	var pageSize = $("#pageSize").val();
    	if ($.trim(pageSize) == '' || pageSize == null) {
    		$("#pageSize").val(20);
    	}
        $("#table-ordermarks").sfGridSearch({
            postData: $("#searchForm").serializeJson()
        });
    }
</script>
</body>
</html>
