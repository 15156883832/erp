var jqGridOptin = {
	url : "modules/custom/getAll",
	datatype : "json",
	mtype : "post",
	height : "100%",
	autowidth : true,
	caption : "客户资料",
	colNames : [ "ID", "姓名", "性别", "年龄", "出生日期", "电话", "地址", "操作" ],
	colModel : [{
		name : "custId",
		cellattr : me.cellattr,
		hidden : true
	},{
		name : "custname"
	},{
		name : "gender",
		formatter : me.genderFormatter
	},{
		name : "age"
	},{
		name : "birthday"
	},{
		name : "phoneno"
	},{
		name : "address"
	},{
		name : "act",
		title : false,
		formatter : me.actFormatter
	}],
	jsonReader : {
		userdata : "rows",
		root : "rows",// 所有数据项
		page : "page",// 当前页数
		total : "total",// 总页数
		records : "records",// 总记录数
		repeatitems : false
	},
	prmNames : {
		page : "page",
		rows : "rows"
	},
	rowList : [ "15", "20", "50", "100", "500" ],
	rowNum : "20",
	repeatitems : false,
	viewrecords : true,
	emptyrecords : "查询结果为空!",
	pager : "#customListPager",
	sortable : true,
	onSelectRow : function(id) {
		// alert(id);
	}
};



me.actFormatter = function(cellvalue, options, rawObject) {
	var detail = '<input type="button" value="详情" onclick="showCustomDetail('+ rawObject.custid + ',' + options.rowId + ')">';


	var deleteBtn = '<input type="button" value="删除" onclick="deleteCustom('+ rawObject.custid + ',' + options.rowId + ')">';

	return "&nbsp;&nbsp;&nbsp;\t" + detail + "&nbsp;&nbsp;&nbsp;\t"+ deleteBtn;
};