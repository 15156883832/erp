/**
 */
package com.jojowonet.modules.fitting.dao;

import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.entity.FittingOuterApply;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;

import org.springframework.stereotype.Repository;


/**
 * 备件申请DAO接口
 * @author DQChen
 * @version 2018-01-22
 */
@Repository
public class FittingOuterApplyDao extends BaseDao<FittingOuterApply> {
	//备件待审核/待出库列表
	public List<Record> getWaitShenheList(Page<Record> page ,String siteId,int type,Map<String,Object> ma){
		StringBuffer sf = new StringBuffer();
		sf.append("SELECT a.*,b.warning as fitStocks,s.name as siteName FROM  crm_site_fitting_outer_apply a  left join crm_site_fitting b on a.apply_fitting_code=b.code and b.status='1'  AND b.site_id =?  left join crm_site s  on s.id=a.apply_site_id  WHERE a.target_site_id=? ");
		
		if(type == 0){ // 待审核申请中 ： 0.申请待审核 1.缺件中
			sf.append(" AND ( a.status = '0' OR a.status = '1' ) ");
		} else if(type == 1) { //待出库  2.审核通过待出库 
			sf.append(" AND a.status = '2' ");
		} else if(type == 2) {//全部申请 0.申请待审核 1.缺件中 2.审核通过待出库 3.确认出库待领取 4.已领取可使用 5.申请已取消 6.申请审核未通过 7申请已删除
			sf.append(" AND a.status != '7' ");
		}

		sf.append(getqueryCriteriaSecondSite(ma));
		sf.append(createOrderBy(ma,"order by a.create_time desc"));
		if(page != null){
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		}
		return Db.find(sf.toString(),siteId,siteId);
	}
	
	public long getWaitShenheCount(String siteId,int type,Map<String,Object> ma){
		StringBuffer sf = new StringBuffer();
		sf.append("SELECT count(*) FROM  crm_site_fitting_outer_apply a  left join crm_site_fitting b on a.apply_fitting_code=b.code and b.status='1'  AND b.site_id =?  left join crm_site s  on s.id=a.apply_site_id  WHERE a.target_site_id=? ");
		
		if(type == 0){ // 待审核申请中 ： 0.申请待审核 1.缺件中
			sf.append(" AND ( a.status = '0' OR a.status = '1' ) ");
		} else if(type == 1) { //待出库  2.审核通过待出库 
			sf.append(" AND a.status = '2' ");
		} else if(type == 2) {//全部申请 0.申请待审核 1.缺件中 2.审核通过待出库 3.确认出库待领取 4.已领取可使用 5.申请已取消 6.申请审核未通过 7申请已删除
			sf.append(" AND a.status != '7' ");
		}
		sf.append(getqueryCriteriaSecondSite(ma));
		return Db.queryLong(sf.toString(), siteId,siteId);
	}

    /**
     * 二级网点备件申请列表
     */
    public List<Record> getFittingApplyList(Page<Record> page , String siteId, Map<String,Object> ma){
        StringBuffer sf = new StringBuffer();
        sf.append("SELECT a.id,a.status,a.apply_fitting_code AS fitting_code,a.apply_fitting_name AS fitting_name,a.apply_fitting_version AS fitting_version, ");
        sf.append(" a.apply_fitting_brand AS fittingBrand,a.applicant_feedback AS apply_feedback,a.create_time, ");
        sf.append(" a.audit_fitting_num AS fitting_audit_num,a.audit_marks,a.refuse_reason,a.apply_fitting_num  ");
        sf.append(" FROM crm_site_fitting_outer_apply a ");
        sf.append(" WHERE  a.status IN('0','2','3','4','5','6') and a.apply_site_id=?  ");
        sf.append(getqueryCriteria(ma));
        sf.append(createOrderBy(ma,"order by create_time desc"));
        if(page != null){
            sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
        }
        return Db.find(sf.toString(),siteId);
    }
    /**
     * 二级网点备件申请数量
     */
    public long getFittingApplyCount(String siteId,Map<String,Object> ma){
        StringBuffer sf = new StringBuffer();
        sf.append(" SELECT count(*) as count FROM crm_site_fitting_outer_apply a ");
        sf.append(" WHERE  a.status IN('0','2','3','4','5','6') and a.apply_site_id=?   ");
        sf.append(getqueryCriteria(ma));
        return Db.queryLong(sf.toString(), siteId);
    }

    //表头排序
    private String createOrderBy(Map<String, Object> map, String defaultOrderBy) {
        String sort =null;
        String dir = null;
        if(map.get("sidx")!=null){
            if(StringUtils.isNotBlank(map.get("sidx").toString())){
                sort = map.get("sidx").toString();
            }
        }
        if(map.get("sord")!=null){
            if(StringUtils.isNotBlank(map.get("sord").toString())){
                dir = map.get("sord").toString();
            }
        }
        return (StringUtils.isNotBlank(sort) && StringUtils.isNotBlank(dir)) ? ("order by `" + sort + "` " + dir) : defaultOrderBy;
    }

    /**
     * 查询条件
     * @param ma
     * @return
     */
    public String getqueryCriteria(Map<String, Object> ma) {
        StringBuffer sf = new StringBuffer();
        if (StringUtils.isNotEmpty((CharSequence) ma.get("fittingCode"))) {
            sf.append(" and a.apply_fitting_code like '%" + ma.get("fittingCode") + "%' ");
        }
        if (StringUtils.isNotEmpty((CharSequence) ma.get("fittingName"))) {
            sf.append(" and a.apply_fitting_name like '%" + ma.get("fittingName") + "%' ");
        }
        if (StringUtils.isNotEmpty((CharSequence) ma.get("suitBrand"))) {
            sf.append(" and a.apply_fitting_brand like '%" + ma.get("suitBrand") + "%' ");
        }
        if (StringUtils.isNotEmpty((CharSequence) ma.get("status"))) {
            sf.append(" and a.status = '" + ma.get("status") + "' ");
        }
        if (StringUtils.isNotEmpty((CharSequence) ma.get("createTimeMin"))) {
            sf.append(" and a.create_time >= '" + ma.get("createTimeMin") + "' ");
        }
        if (StringUtils.isNotEmpty((CharSequence) ma.get("createTimeMax"))) {
            sf.append(" and a.create_time <= '" + ma.get("createTimeMax") + " 23:59:59' ");
        }
        if (StringUtils.isNotBlank((CharSequence) ma.get("suitCategory"))) {
            sf.append(" and a.suit_category='" + ma.get("suitCategory") + "' ");
        }
        return sf.toString();
    }
    
    /**
     * 查询条件
     * @param ma
     * @return
     */
    public String getqueryCriteriaSecondSite(Map<String, Object> ma) {
    	StringBuffer sf = new StringBuffer();
    	if (StringUtils.isNotEmpty((CharSequence) ma.get("fittingCode"))) {
    		sf.append(" and a.apply_fitting_code like '%" + ma.get("fittingCode") + "%' ");
    	}
    	if (StringUtils.isNotEmpty((CharSequence) ma.get("fittingName"))) {
    		sf.append(" and a.apply_fitting_name like '%" + ma.get("fittingName") + "%' ");
    	}
    	if (StringUtils.isNotEmpty((CharSequence) ma.get("secondSiteName"))) {
    		sf.append(" and s.name like '%" + ma.get("secondSiteName") + "%' ");
    	}
    	if (StringUtils.isNotEmpty((CharSequence) ma.get("employeName"))) {
    		sf.append(" and a.applicant_name like '%" + ma.get("employeName") + "%' ");
    	}
    	if (StringUtils.isNotEmpty((CharSequence) ma.get("suitBrand"))) {
    		sf.append(" and a.apply_fitting_brand like '%" + ma.get("suitBrand") + "%' ");
    	}
    	if (StringUtils.isNotBlank((CharSequence) ma.get("suitCategory"))) {
    		sf.append(" and a.suit_category='" + ma.get("suitCategory") + "' ");
    	}
    	if (StringUtils.isNotBlank((CharSequence) ma.get("status"))) {
    		sf.append(" and a.status='" + ma.get("status") + "' ");
    	}
    	return sf.toString();
    }
}
