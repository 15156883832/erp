package com.jojowonet.modules.goods.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.goods.dao.GoodsSiteselfDetailDao;
import com.jojowonet.modules.goods.entity.GoodsSiteselfDetail;
import com.jojowonet.modules.operate.dao.NonServicemanDao;
import com.jojowonet.modules.operate.entity.NonServiceman;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.Result;

import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.UserUtils;

@Component
@Transactional(readOnly = true)
public class GoodsUsedRecordService extends BaseService {
	@Autowired 
	private NonServicemanDao nonDao;
	@Autowired 
	private GoodsSiteselfDetailDao goodsSiteselfDetailDao;
	
	
	public Page<Record> waitReturnList(Page<Record> page,Map<String,Object> map,String siteId){
		if(map.get("pageSize")!=null){
			if(StringUtils.isNotBlank(map.get("pageSize").toString())){
				page.setPageSize(Integer.valueOf(map.get("pageSize").toString()));
				page.setPageNo(Integer.valueOf(map.get("pageNo").toString()));
			}
		}
		List<Record> list = returnList(page,map,siteId);
		for(Record rd : list){
			rd.set("firstIcon", "");
			if(StringUtils.isNotBlank(rd.getStr("good_icon"))){
				rd.set("firstIcon", rd.getStr("good_icon").split(",")[0]);
			}
		}
		page.setList(list);
		page.setCount(returnCount(map,siteId));
		return page;
	}
	
	public List<Record> returnList(Page<Record> page,Map<String,Object> map,String siteId){
		StringBuffer sf = new StringBuffer();
		sf.append("select a.*,s.unit from crm_goods_used_record a left join crm_goods_siteself s on s.id=a.good_id where  a.site_id='"+siteId+"' and s.site_id='"+siteId+"' and s.status='0' and a.status='1'  ");
		sf.append(returnConditions(map));
		if(page!=null){
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		}
		return Db.find(sf.toString());
	}
	
	public Long returnCount(Map<String,Object> map,String siteId){
		StringBuffer sf = new StringBuffer();
		sf.append("select count(*) from crm_goods_used_record a left join crm_goods_siteself s on s.id=a.good_id where a.site_id='"+siteId+"' and s.site_id='"+siteId+"' and s.status='0' and a.status='1' ");
		sf.append(returnConditions(map));
		return Db.queryLong(sf.toString());
	}
	
	public List<Record> getEmployes(String siteId){
		return Db.find("select a.* from crm_employe a where a.status='0' and a.site_id='"+siteId+"'");
	}
	
	public Long allCount(String siteId){
		return Db.queryLong("select count(*) from crm_goods_used_record a left join crm_goods_siteself s on s.id=a.good_id where a.site_id='"+siteId+"' and s.site_id='"+siteId+"' and s.status='0' and a.status='1' ");
	}
	
	@Transactional
	public Object confirmInStocks(String id,String amount,String goodId,String siteId){
		    Result rt = new Result();
			User user = UserUtils.getUser();
			String name = CrmUtils.getUserXM();
			Record rd2 = Db.findFirst("select * from crm_goods_used_record where `id`=? and `status`='1' ",id);
			if(rd2==null){
				rt.setCode("424");
				rt.setErrMsg("goods record already hx");
				return rt;
			}
			Record rd = Db.findFirst("select a.* from crm_goods_siteself a where a.id='"+goodId+"' and a.status='0'");
			if(rd==null){
				rt.setCode("421");
				rt.setErrMsg("goods not exist");
				return rt;
			}
			BigDecimal receives = rd.getBigDecimal("receives");//领取数量
			if(StringUtils.isBlank(amount) || Double.parseDouble(amount)<0){//返还数量不能为空，且要求大于零
				rt.setCode("423");
				rt.setErrMsg("amount is invalid");
				return rt;
			}
			/*if(receives.doubleValue() <  Double.parseDouble(amount)){//商品领取数量小于返还数量，则数据有误
				rt.setCode("422");
				rt.setErrMsg("goods msg error");
				return rt;
			}*/
			//更新crm_goods_used_record
			SQLQuery sqlQuery = goodsSiteselfDetailDao.getSession().createSQLQuery("update crm_goods_used_record a set a.status='2',a.check_time=now(),a.confirmor='"+name+"',a.confirmor_id='"+user.getId()+"' where a.id='"+id+"'");
			sqlQuery.executeUpdate();
			//公司库存加，销售数量减
			SQLQuery sqlQuery1 = goodsSiteselfDetailDao.getSession().createSQLQuery("update crm_goods_siteself a set a.stocks=(a.stocks+"+amount+"),a.receives=(a.receives-"+amount+") where a.id='"+goodId+"' and a.status='0'");
			sqlQuery1.executeUpdate();
			//出入库明细新增一条入库数据
			Record rd1 = Db.findFirst("select a.* from crm_goods_used_record a where a.id=?",id);
			GoodsSiteselfDetail gsd = new GoodsSiteselfDetail();
			gsd.setAmount(new BigDecimal(amount));
			gsd.setApplicant(rd1.getStr("employe_name"));
			gsd.setApplyTime(rd1.getDate("used_time"));
			gsd.setConfirmor(name);
			gsd.setConfirmTime(rd1.getDate("check_time"));
			gsd.setCreateTime(new Date());
			gsd.setCustomerPrice(rd.getBigDecimal("customer_price"));
			gsd.setEmployePrice(rd.getBigDecimal("employe_price"));
			gsd.setGoodBrand(rd1.getStr("good_brand"));
			gsd.setGoodCategory(rd1.getStr("good_category"));
			gsd.setGoodId(rd1.getStr("good_id"));
			gsd.setGoodModel(rd1.getStr("good_model"));
			gsd.setGoodName(rd1.getStr("good_name"));
			gsd.setGoodNumber(rd1.getStr("good_number"));
			gsd.setUnit(rd.getStr("unit"));
			gsd.setType("6");
			gsd.setSitePrice(rd.getBigDecimal("site_price"));
			gsd.setSiteId(siteId);
			goodsSiteselfDetailDao.save(gsd);
			rt.setCode("200");
			rt.setMsg("ruku success");
			return rt;
	}
	
	public String returnConditions(Map<String,Object> map){
		StringBuffer sf = new StringBuffer();
		if(map!=null){
			String number = getTrimmedParamValue(map, "number");
			if(StringUtils.isNotEmpty(number)){
				sf.append(" and a.good_number like '%"+number+"%' ");
			}
			String name = getTrimmedParamValue(map, "name");
			if(StringUtils.isNotEmpty(name)){
				sf.append(" and a.good_name like '%"+name+"%' ");
			}
			String model = getTrimmedParamValue(map, "model");
			if(StringUtils.isNotEmpty(model)){
				sf.append(" and a.good_model like '%"+model+"%' ");
			}
			String applyName = getTrimmedParamValue(map, "applyName");
			if(StringUtils.isNotEmpty(applyName)){
				sf.append(" and a.employe_name like '%"+applyName+"%' ");
			}
			String applyTimeMin = getTrimmedParamValue(map, "applyTimeMin");
			if(StringUtils.isNotEmpty(applyTimeMin)){
				sf.append(" and a.used_time >= '"+applyTimeMin+" 00:00:00' ");
			}
			String applyTimeMax = getTrimmedParamValue(map, "applyTimeMax");
			if(StringUtils.isNotEmpty(applyTimeMax)){
				sf.append(" and a.used_time <= '"+applyTimeMax+" 23:59:59' ");
			}
		}
		return sf.toString();
	}
	
	private String getParamValue(Map<String, Object> map, String param) {
        Object value = map.get(param);
        return value == null ? null : (map.get(param).toString());
    }
    
	private String getTrimmedParamValue(Map<String, Object> map, String param) {
        return StringUtils.trim(getParamValue(map, param));
    }
	
	public Record getDetailById(String id){
		return Db.findFirst("select a.* from crm_goods_siteself a where a.id='"+id+"' and a.status='0' ");
	}
	
	public Record getDetailByIdReturn(String id){
		return Db.findFirst("select a.* from crm_goods_used_record a where a.id='"+id+"'");
	}
}
