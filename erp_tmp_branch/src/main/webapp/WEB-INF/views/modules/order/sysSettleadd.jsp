<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
  <head>
    <meta name="decorator" content="base"/>
    
    <title>My JSP 'proLimitForm.jsp' starting page</title>
    <script type="text/javascript">
        function check(names) {//判断用
            var s = document.getElementById("select").value;
            if (s.length != 0) {
                $.ajax({
                    type: 'POST',
                    url: "${ctx}/order/settle/querytype",
                    data: {"s": s},
                    success: function (msg) {
                        if (msg.length != 0) {
                        }

                    }
                })

            }

        }
	</script>
  </head>
  
  <body>
 <%--  <form action="${ctx}/order/proLimit/save">
    <input type="text" value="${proLimit.name}"><br>
    <input type="submit" value="保存">
    </form> --%>
    
    
    
    <div class="sfpagebg">
<div class="sfpage bk-gray table-header-settable">
	<ul class="nav nav-tabs">
		
	</ul><br/>
	<form id="inputForm" action="${ctx}/order/settle/save" method="post" class="form-horizontal">
		 
		<div class="control-group">
			<label class="control-label">设置项:</label>
			<div class="controls">
					<select class="select" name="type" onchange="return check()" id="select" style="width: 20%">
									<option>请选择</option>
									<option value="1">结算设置值</option>					
								</select>
			</div>
			<label class="control-label">开关:</label>
			<div class="controls">
			<label>开：</label>
				<input type="radio" value="0"  name="figure" checked="checked" />
			<label>关：</label>
	<input type="radio" value="1"  name="figure"  />
			
			</div>
		</div>
		<div class="form-actions">
			<%-- <shiro:hasPermission name="order:orderOrigin:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/> --%>
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"  />
			&nbsp;<%-- </shiro:hasPermission> --%>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form>
</div></div>
  </body>
</html>