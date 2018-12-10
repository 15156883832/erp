<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta name="decorator" content="base">
<title>首页</title>
</head>
<body>

<div class="homepage">
	<div class="cl mb-15">
		<div class="f-l col-5-2">
			<div class="radius modeBox" id="home1">
				<h2 class="boxHeader2 tabBarP2">
					<a href="javascript:;" class="tabswitch current">今日工单</a>
					<a href="javascript:;" class="tabswitch">备件申请待办</a>
				</h2>
				<div class="cl tabCon" style="height: 281px;padding-top: 75px;">
					<div class="col-3-1 f-l pt-30 pb-30">
						<div class="bjbox bjbox4">
							<p class="num c-0e8ee7">321</p>
							<p class="f-14">今日预约</p>
						</div>
					</div>
					<div class="col-3-1 f-l bl br pt-30 pb-30">
						<div class="bjbox bjbox5">
							<p class="num c-ef6d6d">10</p>
							<p class="f-14">待派工工单</p>
						</div>
					</div>
					<div class="col-3-1 f-l  pt-30 pb-30">
						<div class="bjbox bjbox6">
							<p class="num c-00c3a3">226</p>
							<p class="f-14">缺件中</p>
						</div>
					</div>
				</div>
				<div class="cl tabCon" style="height: 281px;padding-top: 75px;">
					<div class="col-3-1 f-l pt-30 pb-30">
						<div class="bjbox bjbox1">
							<p class="num c-0e8ee7">321</p>
							<p class="f-14">待审核</p>
						</div>
					</div>
					<div class="col-3-1 f-l bl br pt-30 pb-30">
						<div class="bjbox bjbox2">
							<p class="num c-ef6d6d">10</p>
							<p class="f-14">缺件中</p>
						</div>
					</div>
					<div class="col-3-1 f-l  pt-30 pb-30">
						<div class="bjbox bjbox3">
							<p class="num c-00c3a3">226</p>
							<p class="f-14">待出库</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="f-l col-5-3" style="padding-left: 20px;">
			<div class="radius modeBox" style="height: 317px/;">
				<h2 class="boxHeader">待办事项<a href="javascript:;" class="f-r c-white f-14" id="btn-addItem"><i class="sficon sficon-edit3"></i> 新增事项</a></h2>
				<div class="" style="height: 270px;">
					<div class="col-6 f-l mt-10"style="padding-top: 0;padding-bottom: 0;">
						<div class="data-con" id="data-con">
							<div class="added-event" data-date="2017-6-19" data-time="Tüm Gün" data-title="WWDC 13 on San Francisco, LA"></div>
					        <div class="added-event" data-date="2017-6-20" data-time="20:45" data-title="Tarkan İstanbul Concert on Harbiye Açık Hava Tiyatrosu"></div>
					        <div class="added-event" data-date="2017-6-30" data-time="21:00" data-title="CodeCanyon İstanbul Meeting on Starbucks, Kadıköy"></div>
					        <div class="added-event" data-date="2017-7-19" data-time="22:00" data-title="Front-End Design and Javascript Conferance on Haliç Kongre Merkezi"></div>
					        <div class="added-event" data-date="2017-7-2" data-time="22:00" data-title="Lorem ipsum dolor sit amet"></div>
						</div>
					</div>
					<div class="col-6 f-l bl mt-15" style="padding-top: 0;padding-bottom: 0;">
						<p class="lh-30 f-14">待办事项</p>
						<div class="itemList " id="itemList">
							<ul>
								<li>
									<p class="c-0e8ee7 f-13 lh-30">2017-04-08 08:30</p>
									<p class="lh-20">服务部全体工作人员在服务部店内会议室开会 </p>
								</li>
							</ul>
						</div>
						<div class="itemBox hide" id="itemBox">
							<div class="mb-10 txtwrap1 pos-r">
								<label class="lb">日期：</label>
								<input type="text" onfocus="WdatePicker({mineDate:'#F{$dp.$D(\'datemin\')||\'%y-%M-%d\'}'})" id="datemin" name="datemin" class="input-text Wdate w-100">
								<select class="select w-70 va-m">
									<option value="1">10:00</option>
									<option value="2">10:30</option>
								</select> ~
								<select class="select w-70 va-m">
									<option value="1">10:30</option>
									<option value="2">11:30</option>
								</select>
							</div>
							<div class="txtwrap1 pos-r mb-10">
								<label class="lb">事项：</label>
								<textarea class="textarea"></textarea>
							</div>
							<div class="txtwrap1">
								<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" id="btn-save">保存</a>
								<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" id="btn-cancel">取消</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="radius modeBox" id="">
		<h2 class="boxHeader">快捷方式</h2>
		<div class="cl pt-20 pb-20">
			<div class="f-l pl-15 pr-15">
				<div class="bk-gray quickOptWrap">
					全部工单
				</div>
			</div>
			<div class="f-l pl-15 pr-15">
				<div class="bk-gray quickOptWrap">
					录入工单
				</div>
			</div>
			<div class="f-l pl-15 pr-15">
				<a class="bk-gray btn_addQuickOpt" id="btn_addQuickOpt">添加</a>
			</div>
		</div>
	</div>
</div>



<div class="popupBox quickOptDialog">
	<h2 class="popupHead">
		快捷方式设置
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pd-15">
		<div class="popupMain ">
			<div class="pos-r cl shortcut-main" >
				<div id="leftmodelb" class="f-l bk-gray w-210 leftmodel radius">
					<dl>
						<dt><i class="quickIcon"></i> 工单管理</dt>
						<dd class="pt-5 pb-5">
							<ul>
								<li><i class="label-cbox3 "></i> 录入工单 </li>
								<li><i class="label-cbox3 "></i>未完工信息</li>
								<li><i class="label-cbox3 "></i>待回访信息</li>
								<li><i class="label-cbox3 "></i>待结算信息</li>
								<li><i class="label-cbox3 "></i>历史工单</li>
							</ul>
						</dd>
					</dl>
					<dl>
						<dt><i class="quickIcon"></i> 机构管理</dt>
						<dd class="pt-5 pb-5">
							<ul>
								<li><i class="label-cbox3 "></i> 录入工单 </li>
								<li><i class="label-cbox3 "></i>未完工信息</li>
								<li><i class="label-cbox3 "></i>待回访信息</li>
								<li><i class="label-cbox3 "></i>待结算信息</li>
								<li><i class="label-cbox3 "></i>历史工单</li>
							</ul>
						</dd>
					</dl>
					
				</div>
					
				<div id="rightmodelb" class="f-r bk-gray w-250 rightmodel radius">
					<dl>
						<dt class="cl">
							<span class="w-110 f-l">快捷方式</span>
							<span class="w-120 f-l text-c ">操作</span>
						</dt>
						<dd class="pt-5 pb-5">
							<ul>
								<li>
									<p class="w-110 f-l">录入工单</p>
									<p class="w-120 text-c f-l optionsWrap">
										<a class="sficon sficon-arrowtop1"></a>
										<a class="sficon sficon-arrowdown1"></a>
										<a class="sficon sficon-delete1"></a>
									</p>
								</li>
								<li>
									<p class="w-110 f-l">未完工信息</p>
									<p class="w-120 text-c f-l optionsWrap">
										<a class="sficon sficon-arrowtop1"></a>
										<a class="sficon sficon-arrowdown1"></a>
										<a class="sficon sficon-delete1"></a>
									</p>
								</li>
								<li>
									<p class="w-110 f-l">录入工单2</p>
									<p class="w-120 text-c f-l optionsWrap">
										<a class="sficon sficon-arrowtop1"></a>
										<a class="sficon sficon-arrowdown1"></a>
										<a class="sficon sficon-delete1"></a>
									</p>
								</li>
								<li>
									<p class="w-110 f-l">未完工信息2</p>
									<p class="w-120 text-c f-l optionsWrap">
										<a class="sficon sficon-arrowtop1"></a>
										<a class="sficon sficon-arrowdown1"></a>
										<a class="sficon sficon-delete1"></a>
									</p>
								</li>
							</ul>
						</dd>
					</dl>
				</div>
			</div>
		
		</div>
		<div class="text-c mt-20">
			<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5">确定</a>
			<a href="javascript:;" class="sfbtn sfbtn-opt w-70">取消</a>
		</div>
	</div>
</div>

<script type="text/javascript">
	
	$.Huitab("#home1 .tabBarP2 .tabswitch","#home1 .tabCon","current","click","0");
	
	var dateTable= $('#data-con').calendar();
	
	$('#btn-addItem').on('click',function(){
		$(this).hide();
		showBox($('#itemList'),$('#itemBox'));
		
	})
	$('#btn-save').on('click',function(){
		$('#btn-addItem').show();
		showBox($('#itemBox'),$('#itemList'));
		
		var ttext = $('input[name="datemin"]').val();
		var oDate= new Date(ttext.replace(/-/g,   "/"));
		
		dateTable = $('#data-con').calendar({
			itemDate:oDate
		});
		
		$('input[name="datemin"]').val('');
	});
	$('#btn-cancel').on('click',function(){
		$('#btn-addItem').show();
		showBox($('#itemBox'),$('#itemList'));
	});
	
	function showBox(obj1, obj2){
		obj1.hide();
		obj2.show();
	};
	
	$('#btn_addQuickOpt').on('click', function(){
		$('.quickOptDialog').popup();
	})
	$('.quickOptDialog .leftmodel').on('click','dt', function(){
		if($(this).hasClass('selected')){
			$(this).removeClass('selected');
			$(this).next('dd').hide();
		}else{
			$('.quickOptDialog .leftmodel dt').removeClass('selected');
			$('.quickOptDialog .leftmodel dd').hide();
			$(this).addClass('selected');
			$(this).next('dd').show();
		}
	})
	$('.quickOptDialog .leftmodel').on('click','li', function(){
		if($(this).hasClass('selectedItem')){
			$(this).removeClass('selectedItem');
		}else{
			$(this).addClass('selectedItem');
		}
	})
	
	$('.quickOptDialog .rightmodel ').on('click','.sficon', function(){
		var $li = $(this).parents('li');
		$li.addClass('selected');
		if($(this).hasClass('sficon-delete1')){
			$li.remove();
		}else if($(this).hasClass('sficon-arrowtop1')){
			// 上移
			if($li.prev().length >0){
				$li.insertBefore($li.prev()); 
			}
		}else if($(this).hasClass('sficon-arrowdown1')){
			// 下移
			if($li.next().length >0){
				$li.insertAfter($li.next()); 
			}
		}
	})

</script> 
</body>
</html>