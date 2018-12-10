package com.jojowonet.modules.operate.dao;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

import org.apache.commons.lang3.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.entity.EmployeDailySign;
import com.jojowonet.modules.operate.entity.SiteSignRule;
import com.jojowonet.modules.order.utils.CrmUtils;

/**
 * 员工每日签到记录表DAO接口
 * @author Ivan
 * @version 2016-08-01
 */
@Repository
public class EmployeDailySignDao extends BaseDao<EmployeDailySign>{
	@Autowired
	private SiteSignRuleDao siteSignRuleDao;
	
	public List<Record> employeDailySignList(Page<Record> page,String siteId,Map<String,Object> map){//查询grid表格
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT e.name as empName,a.*,SUBSTRING(a.sign_time, 12, 5) AS hm,SUBSTRING(a.sign_time, 1, 10) AS ymd FROM crm_employe e LEFT JOIN crm_employe_daily_sign a ON a.employe_id = e.id AND a.status='0'  ");
		sb.append(employeDailySignConditions(map));
		sb.append(" WHERE e.status = '0' AND e.site_id = '"+siteId+"'");
		sb.append(employeDailySignConditions1(map));
		sb.append(" order by a.create_time desc");
		if(page!=null){
			sb.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		}
		return Db.find(sb.toString());
	}
	
	public Long queryCount(String siteId,Map<String,Object> map){//查询数据总条数
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT count(*) FROM crm_employe e LEFT JOIN crm_employe_daily_sign a ON a.employe_id = e.id  AND a.status='0'");
		sb.append(employeDailySignConditions(map));
		sb.append(" WHERE e.status = '0' AND e.site_id = '"+siteId+"'");
		sb.append(employeDailySignConditions1(map));
		return Db.queryLong(sb.toString());
		
	}
	
	public String employeDailySignConditions1(Map<String, Object> map) {//查询条件
		StringBuilder stringBuilder = new StringBuilder();
		if(map != null){
			if(map.get("employeName") != null && StringUtils.isNotEmpty(((String[])map.get("employeName"))[0])){
				stringBuilder.append(" and e.name = '"+(((String[])map.get("employeName"))[0]).trim()+"' ");
			}
			if(map.get("signType") != null && StringUtils.isNotEmpty(((String[])map.get("signType"))[0])){
				stringBuilder.append(" and a.sign_type = '"+((String[])map.get("signType"))[0]+"' ");
			}
			if(map.get("signResult") != null && StringUtils.isNotEmpty(((String[])map.get("signResult"))[0])){
				String rt = ((String[])map.get("signResult"))[0];
				if("4".equals(rt)) {
					stringBuilder.append(" and a.id is null ");
				}else {
					stringBuilder.append(" and a.sign_result = '"+((String[])map.get("signResult"))[0]+"' ");
				}
			}
		}
		return stringBuilder.toString();
	}
	
	public String employeDailySignConditions(Map<String, Object> map) {//查询条件
		StringBuilder stringBuilder = new StringBuilder();
		if(map != null){
			
			/*if(map.get("signResult") != null && StringUtils.isNotEmpty(((String[])map.get("signResult"))[0])){
				stringBuilder.append(" and a.sign_result = '"+((String[])map.get("signResult"))[0]+"' ");
			}*/
			if(map.get("startDate") != null && StringUtils.isNotEmpty(((String[])map.get("startDate"))[0])){
				stringBuilder.append(" and a.date >= '"+((String[])map.get("startDate"))[0]+" ' ");
			}
			if(map.get("endDate") != null && StringUtils.isNotEmpty(((String[])map.get("endDate"))[0])){
				stringBuilder.append(" and a.date <= '"+((String[])map.get("endDate"))[0]+" 23:59:59' ");
			}
		}
		return stringBuilder.toString();
	}
	
	
	public  Boolean editSignTime(String rowId,String signTime,String signType){//修改打卡时间
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Record record = ifExist(siteId);
		if(record!=null){
		Date workTime = record.getDate("working_time");
		Date offWorkTime = record.getDate("off_working_time");
//		String outTime = new String();
		if(signType.equals("1")){//签到
			DateFormat sf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			DateFormat sdf=new SimpleDateFormat("HH:mm:ss");
			String wTime = sdf.format(workTime);
			//String sTime = sdf.format(signTime);
			try{
				Date three = sf.parse(signTime);
				String sTime = sdf.format(three);
				Date one = sdf.parse(sTime);
				Date two = sdf.parse(wTime);
				Long snTime = one.getTime();
				Long wkTime = two.getTime();
				if(((int)(snTime-wkTime)/(1000*60))>1){//早上迟到的情况
					int minutes = (int)(snTime-wkTime)/(1000*60);//得到int型的分钟整数
					Db.update("UPDATE crm_employe_daily_sign a SET a.sign_time='"+signTime+"',a.out_time='"+minutes+"',a.sign_result='1' WHERE a.id='"+rowId+"'");
				}else{//早上早到的情况
					Db.update("UPDATE crm_employe_daily_sign a SET a.sign_time='"+signTime+"',a.sign_result='0' WHERE a.id='"+rowId+"'");
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
		}else if(signType.equals("2")){//签退
			DateFormat sf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			SimpleDateFormat sdf=new SimpleDateFormat("HH:mm:ss");
			String oTime = sdf.format(offWorkTime);
			//String sTime = sdf.format(signTime);
			try{
				Date three = sf.parse(signTime);
				String sTime = sdf.format(three);
				Date one = sdf.parse(sTime);
				Date two = sdf.parse(oTime);
				Long snTime = one.getTime();
				Long ofwkTime = two.getTime();
				if(((int)(ofwkTime-snTime)/(1000*60))>1){//早退的情况
					int minutes = (int)(ofwkTime-snTime)/(1000*60);//得到int型的分钟整数
					Db.update("UPDATE crm_employe_daily_sign a SET a.sign_time='"+signTime+"',a.out_time='"+minutes+"',a.sign_result='2' WHERE a.id='"+rowId+"'");
				}else{//迟走的情况
					Db.update("UPDATE crm_employe_daily_sign a SET a.sign_time='"+signTime+"',a.sign_result='0' WHERE a.id='"+rowId+"'");
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		}
		return true;
	}
	
	public Record ifExist(String siteId){//服务商siteId查询考勤
		return Db.findFirst("SELECT * FROM crm_site_sign_rule WHERE site_id='"+siteId+"'");
	}
	
	public  String saveSign(String workingTime,String offWorkingTime,String signPoint,Integer signRange,BigDecimal latitude,BigDecimal longitude,String employeIds){//保存设置的考勤
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		try{
			DateFormat sf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date ofwkTime = sf.parse(offWorkingTime);
			Date wkTime = sf.parse(workingTime);
			SiteSignRule siteSignRule = new SiteSignRule();
			siteSignRule.setCreateTime(new Date());
			siteSignRule.setOffWorkingTime(ofwkTime);
			siteSignRule.setWorkingTime(wkTime);
			siteSignRule.setSiteId(siteId);
			siteSignRule.setSignPoint(signPoint);
			siteSignRule.setSignRange(signRange);
			siteSignRule.setLongitude(longitude);
			siteSignRule.setLatitude(latitude);

			siteSignRule.setEmployeId(employeIds);
			siteSignRule.setStatus("0");
			if(StringUtils.isNotBlank(employeIds)){
				String empIds[] = employeIds.split(",");
				List<Record> listRe = Db.find("select employe_id from crm_site_sign_rule where status='0' and  type='1' and site_id=? ",siteId);
				if(listRe.size()>0){
					for(Record re:listRe){
						String emIds[]=re.getStr("employe_id").split(",");
						String[] both = ArrayUtils.addAll(empIds,emIds);

						List<String> list = new ArrayList<>();
						list.add(both[0]);
						for(int i=1;i<both.length;i++){
							if(list.toString().indexOf(both[i]) == -1){
								list.add(both[i]);
							}
						}
						if(both.length != list.size()){
							return "201";
						}
					}
				}
				siteSignRule.setType("1");
			}else{
				siteSignRule.setType("0");
			}

			siteSignRuleDao.save(siteSignRule);
		}catch (ParseException e) {
			e.printStackTrace();
		}
		return "200";
	}
	
	//修改服务商考勤时的保存方法
	public  String saveSignEdit(String workingTime,String offWorkingTime,String signPoint,Integer signRange,BigDecimal latitude,BigDecimal longitude,String signId,String employeIds){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		if(latitude==null){
			if(!checkRepeat(employeIds,signId,siteId)){
				return "201";
			}
			String sql = "UPDATE crm_site_sign_rule a SET a.working_time=?,a.off_working_time=?,a.sign_point=?,a.sign_range=?,a.employe_id=? WHERE a.id=? ";
			Db.update(sql,workingTime,offWorkingTime,signPoint,signRange,employeIds,signId);
		}else{
			if(!checkRepeat(employeIds,signId,siteId)){
				return "201";
			}
			String sql = "UPDATE crm_site_sign_rule a SET a.working_time=?,a.off_working_time=?,a.sign_point=?,a.sign_range=?,a.latitude=?,a.longitude=?,a.employe_id=? WHERE a.id=?";
			Db.update(sql,workingTime,offWorkingTime,signPoint,signRange,latitude,longitude,employeIds,signId);
		}
		return "200";
	}

	private boolean checkRepeat(String employeIds,String signId,String siteId){
		String empIds[] = employeIds.split(",");
		List<Record> listRe = Db.find("select employe_id from crm_site_sign_rule where status='0' and  type='1' and id!=? and site_id=? ",signId,siteId);
		if(listRe.size()>0){
			for(Record re:listRe){
				String emIds[]=re.getStr("employe_id").split(",");
				String[] both = ArrayUtils.addAll(empIds,emIds);

				List<String> list = new ArrayList<>();
				list.add(both[0]);
				for(int i=1;i<both.length;i++){
					if(list.toString().indexOf(both[i]) == -1){
						list.add(both[i]);
					}
				}
				if(both.length != list.size()){
					return false;
				}
			}
		}
		return true;
	}

	//导出数据的不分页查询所有数据
	public List<Record> employeDailySignforexcel(String siteId,Map<String,Object> map){
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT a.*,SUBSTRING( a.sign_time,12,5) AS hm,SUBSTRING( a.sign_time,1,10) AS ymd FROM crm_employe_daily_sign a WHERE a.site_id='"+siteId+"'");
		sb.append(employeDailySignConditions(map));
	    return Db.find(sb.toString());
	}

	/**
	 * 考情设置记录
	 * @param siteId
	 * @param page
	 * @return
	 */
	public List<Record> getSignList(String siteId,Page<Record> page){
		String sql="select *,DATE_FORMAT(working_time,'%H:%i:%s') as working_time,DATE_FORMAT(off_working_time,'%H:%i:%s') as off_working_time from crm_site_sign_rule  where status='0' and site_id=? order by create_time asc LIMIT " + page.getPageSize() + " OFFSET " + (page.getPageNo() - 1) * page.getPageSize();
		return Db.find(sql,siteId);
	}

	public long getSignListCount(String siteId){
		String sql="select count(*) from crm_site_sign_rule  where status='0' and site_id=? ";
		return Db.queryLong(sql,siteId);
	}
}
