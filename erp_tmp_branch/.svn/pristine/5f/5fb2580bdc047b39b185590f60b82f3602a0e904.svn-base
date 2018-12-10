function brandchange(url){
		var name=$("#applianceBrand").find("option:selected").prop("value");
		var strls = "";
		$.ajax({
			url:url,//"${ctx}/order/getCategory"
			dataType:'json',
			data:{"brand":name},
			async:false,
			success:function(result){
				 $.each(result.cate,function(index,val){
					
					if("${order.applianceCategory}"==val){
						alert(val);
						strls+="<option value="+val+" selected='selected'>"+val+"</option>";
					}else{
						strls+="<option value="+val+">"+val+"</option>";
					}
				}); 
				$("#applianceCategory").html();
				$("#applianceCategory").html(strls);
			},
			error:function(){
				return;
			}
			
		});
	}
	
	function address(cityUrl,areaUrl){
		var sz=[];
		var regsheng="省";
		var regshi = "市";
		var regqu="区";
		
		var address = $("#customerAddress").val();
		
		
		
		var flag = true;
		var province="";
		var city="";
		var area = "";
		//截取省
		sz = address.split(regsheng);
		if(sz.length>1&&flag){
			province = sz[0]+regsheng;
			sz=sz[1].split(regshi);
			if(sz.length>1){
				city = sz[0]+regshi;
				sz = sz[1].split(regqu);
			 	if(sz.length>1){
					area = sz[0]+regqu;
					$("#customerAddress1").val(sz[1]);
				}
			}
			
			flag = false;
		}
		//截取市
		sz = address.split(regshi);
		if(sz.length>1&&flag){
			province = sz[0]+regshi;
			city=sz[0]+regshi;
			$("#customerAddress1").val(sz[2]);
			flag = false;
		}
		$("option[value="+province+"]").prop("selected",true);
		$.ajax({
				type:"post",
				url:cityUrl,//${ctx}/order/getCity  ${ctx}/order/getArea
				async:true,
				data:{
					province:province
				},
				dataType:"json",
				success:function(data){
					var obj = eval(data);
					 var length = obj.length;
					 if(length<1){
						layer.msg("无数据");
					 }else{
						$("#city").empty();
						$("#area").empty();
						var HTML = " ";	
						for(var i=0; i < length; i++)
						{
							if(city==obj[i].columns.CityName){
								HTML += '<option selected="selected" value="'+obj[i].columns.CityName+'">'+obj[i].columns.CityName+'</option>';
							}else{
							
								HTML += '<option value="'+obj[i].columns.CityName+'">'+obj[i].columns.CityName+'</option>';
							}
						}
						$("#city").html($("#city").html()+HTML);
					 }
					
				},
				error:function(){
					alert("error");
					return;
				}
			});
		$.ajax({
				type:"post",
				url:areaUrl,//${ctx}/order/getArea
				async:false,
				data:{
					city:city
				},
				dataType:"json",
				success:function(data){
					var obj = eval(data);
					 var length = obj.length;
					 if(length<1){
						layer.msg("无数据");
					 }else{
						$("#area").empty();
					var HTML = " ";	
					for(var i=0; i < length; i++) 
					{
						if(area==obj[i].columns.DistrictName){
							HTML += '<option selected="selected" value="'+obj[i].columns.DistrictName+'" >'+obj[i].columns.DistrictName+'</option>';
							
						}else{
						
							HTML += '<option value="'+obj[i].columns.DistrictName+'" >'+obj[i].columns.DistrictName+'</option>';
						}
					}
					//$("#area").append(HTML); 
					$("#area").html($("#area").html()+HTML);
					 }
					 
				},
				error:function(){
					alert("error");
					return;
				}
			});
	}
	
	
	
	
/*	$(function(){
		
		var name="${order.applianceBrand}";
		var strls = "";
		$.ajax({
			url:"${ctx}/order/orderDispatch/changeBrand",
			dataType:'json',
			data:{"name":name},
			async:false,
			success:function(result){
				$.each(result.changecstr,function(index,val){
					if("${order.applianceCategory}"==val){
						strls+="<option value="+val+" selected='selected'>"+val+"</option>";
					}else{
						strls+="<option value="+val+">"+val+"</option>";
					}
				});
				$("#applianceCategory").html();
				$("#applianceCategory").html(strls);
			},
			error:function(){
				return;
			}
			
		});
		
		
	});	*/
	
	
	
	
	
	
	
