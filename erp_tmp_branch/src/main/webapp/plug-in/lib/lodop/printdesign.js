	var LODOP;  
	
	//var imgurl = "<img src='http://www.0755rc.com/fck_upload/images/%E7%89%A9%E7%90%86%E6%95%99%E5%B8%88%E4%B8%AA%E4%BA%BA%E7%AE%80%E5%8E%86%E8%A1%A8%E6%A0%BC.jpg'/>";
	//初始化设计
	function prn_design(data,psize,url) {
		
		InitPage(data,psize,url);
		
		LODOP.SET_PRINT_MODE("PRINT_SETUP_PROGRAM",true);
		if (LODOP.CVERSION) CLODOP.On_Return=function(TaskID,Value){
			 										$("#content").val(getEncodeValue(Value));
											};
		var val = LODOP.PRINT_DESIGN();
		
		$("#content").val(getEncodeValue(val));
			
	};	
/*	//修改模板
	function prn_setup(data,psize) {
		
		InitPage(data,psize);
		
		LODOP.SET_PRINT_MODE("PRINT_SETUP_PROGRAM",true);
		if (LODOP.CVERSION) CLODOP.On_Return=function(TaskID,Value){
			 										$("#content").val(getEncodeValue(Value));
		};
		
		var val = LODOP.PRINT_SETUP();
		$("#content").val(getEncodeValue(val));
			
	};*/
	
	
	
	function prn_Preview(data){
		if(data == null || data.content == null || data.content.length<=0){
			alert("请先设置打印模版");
			return;
		}

		var number = data.number;
		var customer_name = data.customer_name;
		var customer_mobile = data.customer_mobile;
		var customer_telephone = data.customer_telephone;
		var customer_telephone2 = data.customer_telephone2;

		var customer_address = "";
		if(data.province!=null && data.province!="" && data.province!=undefined){
            customer_address+=data.province;
        }
        if(data.city!=null && data.city!="" && data.city!=undefined){
			if(data.province!=data.city){
                customer_address+=data.city;
            }
		}
		if(data.area!=null && data.area!="" && data.area!=undefined){
            customer_address+=data.area;
		}
		if(data.customer_address!=null && data.customer_address!="" && data.customer_address!=undefined){
            customer_address+=data.customer_address;
		}
		var repair_time = data.repair_time;
		var appliance_brand = data.appliance_brand;
		var appliance_category = data.appliance_category;
		var appliance_num = data.appliance_num;
		var appliance_buy_time = data.appliance_buy_time;
		var appliance_model = data.appliance_model;
		var appliance_barcode = data.appliance_barcode;
		var appliance_machine_code = data.appliance_machine_code;
		var customer_feedback = data.customer_feedback;
		var service_type = data.service_type;
		var service_mode = data.service_mode;
		var promise_time = data.promise_time;
		var promise_limit = data.promise_limit;
		var please_refer_mall = data.please_refer_mall;
		var warranty_type = data.warranty_type;
		var origin = data.origin;
		var level = data.level;
		var warranty_type = data.warranty_type;
		var remarks = data.remarks;
		var serve_cost = data.serve_cost;
		var auxiliary_cost = data.auxiliary_cost;
		var warranty_cost = data.warranty_cost;
		var confirm_cost = data.confirm_cost;
		//var serviceRemarks = data.serviceRemarks;
		var end_time = data.end_time;
	//	var serviceAttitude = data.serviceAttitude;
	//	var customerSign = data.customerSign;
		var site_name = data.site_name;
		var smsPhone = data.smsPhone;
		var employe_name = data.employe_name;
		var printTime = data.printTime;
		
		LODOP=getLodop(); 
		if(LODOP == null){
			var strCLodopInstall="CLodop云打印服务(本地)未安装启动!请到工单打印模板设置页面下载,执行安装。";
			layer.msg(strCLodopInstall);
			return;
		}
		
		var deval = getDecodeValue(data.content);
		eval(deval); 	
		if (LODOP.CVERSION) CLODOP.On_Return=null;
		LODOP.PREVIEW();
	
	}
	
	function prn_Previews(data){
		
		if(data == null || data.content == null || data.content.length<=0){
			alert("请先设置打印模版");
			return;
		}
		
		var number = data.number;
		var customer_name = data.customer_name;
		var customer_mobile = data.customer_mobile;
		var customer_telephone = data.customer_telephone;
		var customer_telephone2 = data.customer_telephone2;
		var customer_address = data.province+data.city+data.area+data.customer_address;
        if(data.province==data.city){
            customer_address = data.city+data.area+data.customer_address;
        }
        var repair_time = data.repair_time;
		var appliance_brand = data.appliance_brand;
		var appliance_category = data.appliance_category;
		var appliance_num = data.appliance_num;
		var appliance_buy_time = data.appliance_buy_time;
		var appliance_model = data.appliance_model;
		var appliance_barcode = data.appliance_barcode;
		var appliance_machine_code = data.appliance_machine_code;
		var customer_feedback = data.customer_feedback;
		var service_type = data.service_type;
		var service_mode = data.service_mode;
		var promise_time = data.promise_time;
		var promise_limit = data.promise_limit;
		var please_refer_mall = data.please_refer_mall;
		var warranty_type = data.warranty_type;
		var origin = data.origin;
		var level = data.level;
		var warranty_type = data.warranty_type;
		var remarks = data.remarks;
		var serve_cost = data.serve_cost;
		var auxiliary_cost = data.auxiliary_cost;
		var warranty_cost = data.warranty_cost;
		var confirm_cost = data.confirm_cost;
		//var serviceRemarks = data.serviceRemarks;
		var end_time = data.end_time;
		//	var serviceAttitude = data.serviceAttitude;
		//	var customerSign = data.customerSign;
		var site_name = data.site_name;
		var smsPhone = data.smsPhone;
		var employe_name = data.employe_name;
		var printTime = data.printTime;
		
		LODOP=getLodop(); 
		/*alert(LODOP.GET_PRINTER_NAME(-1));*/
		if(LODOP == null){
			var strCLodopInstall="CLodop云打印服务(本地)未安装启动!请到工单打印模板设置页面下载,执行安装。";
			layer.msg(strCLodopInstall);
			return;
		}
		
		
		var deval = getDecodeValue(data.content);
		
		eval(deval); 	
		if (LODOP.CVERSION) CLODOP.On_Return=null;
		//LODOP.PREVIEW();
		if (LODOP.SET_PRINTER_INDEX(-1)) 
			LODOP.PRINT();	
	}
	
	
	function InitPage(data,psize,url){
		
		if( url == null || url == '' || url == undefined){
			alert("请设置打印模版图片");
			return;
		}
		var imgurl = formatImgUrl(url);
		var coordinate = new Object();
		
		coordinate.x = 50;
		coordinate.y = 50;
		
		LODOP=getLodop();  
		if(LODOP == null){
			/*var strCLodopInstall="<br><font color='#FF00FF'>CLodop云打印服务(本地)未安装启动!点击这里<a href='http://www.c-lodop.com/download/CLodop_Setup_for_Win32NT_https_3.025Extend.zip' target='_self'>执行安装</a>,安装后请刷新页面。</font>";
			
			$("#msg").html(strCLodopInstall);*/
			var strCLodopInstall="CLodop云打印服务(本地)未安装启动!请先下载,执行安装。";
			layer.msg(strCLodopInstall);
			return;
		}
		
		LODOP.PRINT_INIT("");
		LODOP.SET_PRINT_MODE("PROGRAM_CONTENT_BYVAR",true);//生成程序时，内容参数有变量用变量，无变量用具体值

		LODOP.SET_SHOW_MODE("BKIMG_PRINT",1);
		var img = new Image();
		img.src =url;
		var w = img.width;
		var h = img.height;
		
		// 纸张大小
	/*	var width,height;
		var strPageName = "";
		switch(psize){
		case 1:
			width = 210;
			height = 297;
			strPageName = "A4";
			break;
		case 2:
			width = 215;
			height = 93;
			strPageName = "7孔";
			break;
		case 3:
			width = 215;
			height = 140;
			strPageName = "11孔";
			break;
		default:
			
			width = 210;
			height = 297;
			strPageName = "A4";
			break;
		}*/
		// 宽，高的精度是0.1mm
		//LODOP.SET_PRINT_PAGESIZE(0,width*10,height*10,strPageName); 	
		LODOP.ADD_PRINT_IMAGE(30,20,w,h,imgurl);
	    LODOP.SET_PRINT_STYLEA(0,"Stretch",2);//按原图比例(不变形)缩放模式
		
		CreateItem("number",data.number,coordinate);
		CreateItem("customer_name",data.customer_name,coordinate);

		CreateItem("customer_mobile",data.customer_mobile,coordinate);
		CreateItem("customer_telephone",data.customer_telephone,coordinate);
		CreateItem("customer_telephone2",data.customer_telephone2,coordinate);
		
		CreateItem("customer_address",data.customer_address,coordinate);
	
		CreateItem("repair_time",data.repair_time,coordinate);
		
		CreateItem("appliance_brand",data.appliance_brand,coordinate);
		CreateItem("appliance_category",data.appliance_category,coordinate);
		
		CreateItem("appliance_num",data.appliance_num,coordinate);
	
		CreateItem("appliance_buy_time",data.appliance_buy_time,coordinate);
		
		CreateItem("appliance_barcode",data.appliance_barcode,coordinate);
		CreateItem("appliance_model",data.appliance_model,coordinate);
	
		CreateItem("appliance_machine_code",data.appliance_machine_code,coordinate);
		CreateItem("customer_feedback",data.customer_feedback,coordinate);
	
		CreateItem("service_type",data.service_type,coordinate);
	
		CreateItem("service_mode",data.service_mode,coordinate);
	
		CreateItem("promise_time",data.promise_time,coordinate);
		
		CreateItem("promise_limit",data.promise_limit,coordinate);
		
		CreateItem("please_refer_mall",data.please_refer_mall,coordinate);
	
		CreateItem("warranty_type",data.warranty_type,coordinate);
	
		CreateItem("origin",data.origin,coordinate);
	
		CreateItem("level",data.level,coordinate);
		CreateItem("remarks",data.remarks,coordinate);
		CreateItem("serve_cost",data.serve_cost,coordinate);
		CreateItem("auxiliary_cost",data.auxiliary_cost,coordinate);
		
		CreateItem("warranty_cost",data.warranty_cost,coordinate);
		CreateItem("confirm_cost",data.confirm_cost,coordinate);
	//	CreateItem("serviceRemarks",data.serviceRemarks,coordinate);
		CreateItem("end_time",data.end_time,coordinate);
	//	CreateItem("serviceAttitude",data.serviceAttitude,coordinate);
	//	CreateItem("customerSign",data.customerSign,coordinate);
		CreateItem("site_name",data.site_name,coordinate);
		CreateItem("smsPhone",data.smsPhone,coordinate);
		CreateItem("employe_name",data.employe_name,coordinate);
		CreateItem("printTime",data.printTime,coordinate);
		
	}
	
	function CreateItem(key,val,coordinate){
		
		LODOP.ADD_PRINT_TEXT(coordinate.x,coordinate.y,150,23,val);
		LODOP.SET_PRINT_STYLEA(0,"ContentVName",key);//设置内容参数的变量名
		LODOP.SET_PRINT_STYLEA(0,"FontSize",13);
		LODOP.SET_PRINT_STYLEA(0,"FontColor","#FF0000");
		coordinate.x += 18;
		coordinate.y += 0;
		return coordinate;
		
	}
	
	function getEncodeValue(strValue){
       var b = new Base64();  
	   var val = b.encode(strValue);
	   return val;
	}
	
	function getDecodeValue(strValue){
		var b = new Base64();
		var val = b.decode(strValue);
		return val;
	}
	
	function formatImgUrl(url){
		var imgurl = "<img src='"+url+"'/>";
		return imgurl;
	}