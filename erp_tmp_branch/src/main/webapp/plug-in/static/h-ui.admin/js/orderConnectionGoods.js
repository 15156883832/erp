	function formatDate(dt) { 
		var time = new Date(dt);
		var y = time.getFullYear();
		var m = time.getMonth()+1;
		var d = time.getDate();
		var h = time.getHours();
		var mm = time.getMinutes();
		var s = time.getSeconds();
		if(s=="0"){
			s="00";
		}
		return y+"-"+m+"-"+d+" "+h+":"+mm+":"+s;
	}   
	
	function goodsOrderStatus(status,outstock_type,stocks,num,type){
		if(outstock_type!="3"){//公司库存
			if(status=='1' || status=='4'){
				return "<span class='oState state-waitPay'>待收款</span>";
	        }else if(status=='2' || status=='3'){
				return "<span class='oState state-waitXd'>已完成</span>";
	        }else if(status=='0'){
	            return "<span class='oState state-canceled'>已取消</span>";
	        }else{
                return "";
			}
		}
		if(outstock_type=="3"){//工程师库存
			 if(status=='3'){
                return "<span class='oState state-waitCheck'>待确认</span>";
			 }else if(status=='5') {
                return "<span class='oState state-finished'>已确认</span>";
             }else if(status=='0'){
				return "<span class='oState state-canceled'>已取消</span>";
			 }else{
			 	return "";
			 }
		}
	}
	
	function outStocksType(status,type){
		if(status=="3" || status=="4"){
			if(type=="0"){
				return "工程师库存";
			}
			if(type=="1"){
				return "公司库存";
			}
			if(type=="2"){
				return "平台发货";
			}
		}
		return "---";
	}