package com.jojowonet.modules.goods.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.dao.NonServicemanDao;
import com.jojowonet.modules.operate.entity.NonServiceman;
import com.jojowonet.modules.order.utils.CrmUtils;

import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.UserUtils;

@Component
@Transactional(readOnly = true)
public class GoodsSiteEmployeRecordService extends BaseService {
	@Autowired 
	private NonServicemanDao nonDao;
	
	
	public Page<Record> waitReturnList(Page<Record> page,Map<String,Object> map,String siteId){
		List<Record> list = returnList(page,map,siteId);
		page.setList(list);
		page.setCount(returnCount(map,siteId));
		return page;
	}
	
	public List<Record> returnList(Page<Record> page,Map<String,Object> map,String siteId){
		StringBuffer sf = new StringBuffer();
		sf.append("select a.* from crm_goods_siteself_detail a left join crm_goods_siteself s on s.id=a.good_id where a.type='6' and a.site_id='"+siteId+"' and s.status='0'  ");
		sf.append(returnConditions(map));
		if(page!=null){
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		}
		return Db.find(sf.toString());
	}
	
	public Long returnCount(Map<String,Object> map,String siteId){
		StringBuffer sf = new StringBuffer();
		sf.append("select count(*) from crm_goods_siteself_detail a left join crm_goods_siteself s on s.id=a.good_id where a.type='6' and a.site_id='"+siteId+"' and s.status='0' ");
		sf.append(returnConditions(map));
		return Db.queryLong(sf.toString());
	}
	
	public List<Record> getEmployes(String siteId){
		return Db.find("select a.* from crm_employe a where a.status='0' and a.site_id='"+siteId+"'");
	}
	
	public Long allCount(String siteId){
		return Db.queryLong("select count(*) from crm_goods_siteself_detail a left join crm_goods_siteself s on s.id=a.good_id where a.type='6' and a.site_id='"+siteId+"' and s.status='0' ");
	}
	
	public String confirmInStocks(String id,String amount,String goodId,String siteId){
		try {
			User user = UserUtils.getUser();
			String name = "";
			String msgId="";
			NonServiceman no = null;
			if (User.USER_TYPE_SIT.equals(user.getUserType())) {
			name= CrmUtils.getSiteName();
			msgId = CrmUtils.getCurrentSiteId(user);
			} else {
			no = nonDao.getNonServiceman(user);
			name = no.getName();
			msgId = no.getId();
			}
			Db.update("update crm_goods_siteself_detail a set a.type='7',a.confirm_time=now(),a.confirmor='"+name+"' where a.id='"+id+"'");
			Record rd = Db.findFirst("select a.* from crm_goods_siteself a where a.id='"+goodId+"' and a.status='0'");
			if(rd==null){
				return "noTExist";
			}
			String sales="0";
			String stocks="0";
			if(rd.getBigDecimal("sales")!=null){
				sales = rd.getBigDecimal("sales").toString();
			}
			if(rd.getBigDecimal("stocks")!=null){
				stocks = rd.getBigDecimal("stocks").toString();
			}
			Db.update("update crm_goods_siteself a set a.stocks=("+stocks+"+"+amount+"),a.sales=("+sales+"-"+amount+") where a.id='"+goodId+"' and a.status='0' ");
			return "ok";
		} catch (Exception e) {
			return "no";
		}
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
			String applyName = getTrimmedParamValue(map, "applyName1");
			if(StringUtils.isNotEmpty(applyName)){
				sf.append(" and a.applicant like '%"+applyName+"%' ");
			}
			String applyTimeMin = getTrimmedParamValue(map, "applyTimeMin");
			if(StringUtils.isNotEmpty(applyTimeMin)){
				sf.append(" and a.apply_time >= '"+applyTimeMin+" 00:00:00' ");
			}
			String applyTimeMax = getTrimmedParamValue(map, "applyTimeMax");
			if(StringUtils.isNotEmpty(applyTimeMax)){
				sf.append(" and a.apply_time <= '"+applyTimeMax+" 23:59:59' ");
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
	
	public Record getDetailById(String id,String goodId,String siteId){
		return Db.findFirst("select a.* from crm_goods_siteself a where a.id='"+goodId+"' and a.status='0' and a.site_id='"+siteId+"'");
	}
	
	public Record getDetailByIdReturn(String id,String goodId,String siteId){
		return Db.findFirst("select a.* from crm_goods_siteself_detail a where a.id='"+id+"'");
	}
}
