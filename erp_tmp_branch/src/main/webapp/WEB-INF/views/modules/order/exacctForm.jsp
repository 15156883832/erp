
 <!DOCTYPE HTML>
<html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<head>
<meta name="decorator" content="base"/>
<title>系统设置-商品品类设置</title>
</head>
<body>
<!-- 新增信息来源 -->
<div class="popupBox w-400 exacctPopup" style="z-index: 199;">
	<h2 class="popupHead">
		添加
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer ">
		<div class="popupMain pb-50 pos-r pt-25 pl-15">
			<div class="pcontent" id="originbox" >
				<div class="cl mb-10">
					<label class="f-l w-120"><em class="mark">*</em>费用科目名称：</label>
					<input type="text" class="input-text w-160 f-l  labelname" />
					<a href="javascript:;" class="sficon sficon-reduce2 f-l mt-3 ml-5" onclick="delOrigin(this)"  style="display: none;" ></a>
					<a href="javascript:;" class="sficon sficon-add2 f-l mt-3 ml-5 " onclick="addOrigin(this)"></a>
				</div>
				
			</div>	
			<div class="text-c btnWrap pt-10">
				<a class="sfbtn sfbtn-opt3 w-70 mr-5" id="btnSubmit">保存</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5"  onclick="closed()">取消</a>
			</div>
		</div>
		
	</div>
</div>

<script type="text/javascript">




	
	var addMark = false;
	$(function() {
		//新增商品品类
		$('.exacctPopup').popup({
			fixedHeight : false
		});
		
		$("#btnSubmit").click(function() {
			if(addMark){
				return ;
			}
			var nameArr = [];
			var names = $(".labelname");
			var repeatname = false;
			var nameflag = false;
			names.each(function(indx, el) {
				nameArr[indx] = $(el).val();
				if (nameArr[indx].length == 0) {
					nameflag = true;
					layer.msg("请输入费用科目名称");
				}
			});
			if (nameflag) {//费用科目名称讯在空的情况
				return;
			}
			var s = nameArr.join(",") + ",";
			for (var i = 0; i < nameArr.length; i++) {
				if (s.replace(nameArr[i] + ",", "").indexOf(
						nameArr[i] + ",") > -1) {
					repeatname = true;
					layer.msg("费用科目名有重复")
					break;
				}
			}
			if (repeatname) {//费用科目名有重复的情况
				return;
			}
			addMark=true;
			$.ajax({
				type : 'POST',
				url : "${ctx}/finance/balanceManager/saveExacctAdd",
				traditional : true,
				data : {
					"nameArr" : nameArr
				},
				success : function(data) {
					addMark=false;
					if(data.code=="200"){
						layer.msg("添加成功");
						parent.search();
						$.closeDiv($(".exacctPopup"));
						
					}else if(data.code=="420"){
						layer.msg("添加失败,费用科目名“"+data.data+"”已存在，请勿重复添加");
					}else{
						layer.msg("未知错误，请联系管理员！");
					}
					return;
				}
			});
		});
	});
	
	function closed() {
		$.closeDiv($('.exacctPopup'));
	}

	function addOrigin(obj) {
		var oParent = $('#originbox');
		var html = '<div class="cl mb-10">'
				+ '<label class="f-l w-120"><em class="mark">*</em>费用科目名称：</label>'
				+ '<input type="text" class="input-text w-160 f-l labelname" />'
				+ '<a href="javascript:;" class="sficon sficon-reduce2 f-l mt-3 ml-5" onclick="delOrigin(this)" ></a>'
				+ '<a href="javascript:;" class="sficon sficon-add2 f-l mt-3 ml-5 " onclick="addOrigin(this)"></a>'
				+ '</div>';
		oParent.append(html);
		$(obj).hide();
		$(obj).prev('a.sficon-reduce2').show();
		$.setPos($('.exacctPopup'));
	}
	function delOrigin(obj) {
		var oParent = $('#originbox');
		$(obj).parent('div').remove();

		var childLenth = oParent.children().size();
		oParent.children().eq(childLenth - 1).find('a.sficon-add2').show();

		if (childLenth == 1) {
			oParent.children().eq(0).find('a.sficon-reduce2').hide();
		}
		$.setPos($('.exacctPopup'));
	}
</script> 
</body>
</html> 


