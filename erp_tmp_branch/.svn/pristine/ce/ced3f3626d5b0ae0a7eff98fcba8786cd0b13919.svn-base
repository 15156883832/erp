package com.jojowonet.modules.goods.service;

import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.goods.dao.GoodsPlatFormMjlOrderDao;
import com.jojowonet.modules.order.service.SupplierService;

@Component
@Transactional(readOnly = true)
public class GoodsPlatFormMjlOrderService extends BaseService {
	@Autowired
	private SupplierService supplierService;

	@Autowired
	private GoodsPlatFormMjlOrderDao goodsPlatFormMjlOrderDao;

	public Page<Record> sysMjlGrid(Page<Record> page,Map<String,Object> map){
		List<Record> list = getSysMjlList(page,map);
		Long count = getSysMjlCount(map);
		page.setCount(count);
		page.setList(list);
		return page;
	}
	
	public List<Record> getSysMjlList(Page<Record> page,Map<String,Object> map){
		StringBuilder sf = new StringBuilder();
		sf.append("SELECT a.*,CONCAT(a.province , a.city , a.area , a.customer_address) as cusAddress,p.unit,s.name AS siteName,p.distribution_type as distributionType FROM crm_goods_platform_mjl_order a LEFT JOIN crm_goods_platform p ON p.number=a.good_number  LEFT JOIN crm_site s ON s.id=a.site_id where s.status='0' ");
		sf.append(queryConditions1(map));
		sf.append("ORDER BY a.placing_order_time DESC ");
		if(page!=null){
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		}
		return Db.find(sf.toString());
	}
	
	public Long getSysMjlCount(Map<String,Object> map){
		StringBuilder sf = new StringBuilder();
		sf.append("SELECT count(*) FROM crm_goods_platform_mjl_order a LEFT JOIN crm_goods_platform p ON p.number=a.good_number  LEFT JOIN crm_site s ON s.id=a.site_id where s.status='0'   ");
		sf.append(queryConditions1(map));
		return Db.queryLong(sf.toString());
	}
	
	public String queryConditions1(Map<String,Object> map){
		StringBuilder sf = new StringBuilder();
		if(map!=null){
			if(map.get("number") != null && StringUtils.isNotEmpty((CharSequence)((String[])map.get("number"))[0])){
				sf.append(" and a.number like '%"+((String[])map.get("number"))[0].trim()+"%' ");
			}
			if(map.get("status") != null && StringUtils.isNotEmpty((CharSequence)((String[])map.get("status"))[0])){
				sf.append(" and a.status ='"+((String[])map.get("status"))[0].trim()+"' ");
			}
//			if(map.get("goodNumber") != null && StringUtils.isNotEmpty((CharSequence)((String[])map.get("goodNumber"))[0])){
//				sf.append(" and a.good_number like '%"+((String[])map.get("goodNumber"))[0].trim()+"%' ");
//			}
			if(map.get("placeOrderBy") != null && StringUtils.isNotEmpty((CharSequence)((String[])map.get("placeOrderBy"))[0])){
				List<Record> list = Db.find("select a.* from crm_site a where a.name like'%"+((String[])map.get("placeOrderBy"))[0].trim()+"%' and a.status='0'");
				if(list.size()>0){
					String ids = "";
					for(Record rd : list){
						if(StringUtils.isNotBlank(rd.getStr("id"))){
							if("".equals(ids)){
								ids="'"+rd.getStr("id")+"'";
							}else{
								ids=ids+",'"+rd.getStr("id")+"'";
							}
						}
					}
					if("".equals(ids)){
						sf.append(" and a.site_id = '' ");
					}else{
						sf.append(" and a.site_id in ("+ids+") ");
					}
					
				}else{
					sf.append(" and a.site_id = '' ");
				}
			}
			if(map.get("goodName") != null && StringUtils.isNotEmpty((CharSequence)((String[])map.get("goodName"))[0])){
				sf.append(" and a.good_name like '%"+((String[])map.get("goodName"))[0].trim()+"%' ");
			}
			if(map.get("createTimeMin") != null && StringUtils.isNotEmpty(((String[])map.get("createTimeMin"))[0])){
				sf.append(" and a.placing_order_time >= '"+((String[])map.get("createTimeMin"))[0]+" 00:00:00' ");
			}
			if(map.get("createTimeMax") != null && StringUtils.isNotEmpty(((String[])map.get("createTimeMax"))[0])){
				sf.append(" and a.placing_order_time <= '"+((String[])map.get("createTimeMax"))[0]+" 23:59:59' ");
			}
			if(map.get("outTimeMin") != null && StringUtils.isNotEmpty(((String[])map.get("outTimeMin"))[0])){
				sf.append(" and a.sendgood_time >= '"+((String[])map.get("outTimeMin"))[0]+" 00:00:00' ");
			}
			if(map.get("outTimeMax") != null && StringUtils.isNotEmpty(((String[])map.get("outTimeMax"))[0])){
				sf.append(" and a.sendgood_time <= '"+((String[])map.get("outTimeMax"))[0]+" 23:59:59' ");
			}
		}
		return sf.toString();
	}
	
	public Record showOrderdetail(String id){
		return Db.findFirst("select a.*,s.name as site_name,p.site_price from crm_goods_platform_mjl_order a left join crm_goods_platform p on a.good_id=p.id left join  crm_site s on a.site_id=s.id where a.id=?",id);
	}
	
	public Page<Record> supplyMjlGrid(Page<Record> page,Map<String,Object> map){
		List<Record> list = getSupplyMjlList(page,map);
		Long count = getSupplyMjlCount(map);
		page.setCount(count);
		page.setList(list);
		return page;
	}
	
	public List<Record> getSupplyMjlList(Page<Record> page,Map<String,Object> map){
		StringBuilder sf = new StringBuilder();
		String supplierId=supplierService.getSupplierByuserId(UserUtils.getUser().getId()).getStr("id");
		//sf.append("SELECT a.*,p.unit,s.name AS siteName,p.distribution_type as distributionType FROM crm_goods_platform_mjl_order a LEFT JOIN crm_goods_platform p ON p.number=a.good_number  LEFT JOIN crm_site s ON s.id=a.site_id where s.status='0' and a.supplier_id='"+supplierId+"' ");
		sf.append("SELECT a.*,CONCAT(a.province , a.city , a.area , a.customer_address) as cusAddress,p.unit,s.name AS siteName,p.distribution_type as distributionType FROM crm_goods_platform_mjl_order a LEFT JOIN crm_goods_platform p ON p.number=a.good_number  LEFT JOIN crm_site s ON s.id=a.site_id where s.status='0'  ");
		sf.append(queryConditionsSup(map));
		sf.append("ORDER BY a.placing_order_time DESC ");
		if(page!=null){
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		}
		return Db.find(sf.toString());
	}
	
	public Long getSupplyMjlCount(Map<String,Object> map){
		StringBuilder sf = new StringBuilder();
		String supplierId=supplierService.getSupplierByuserId(UserUtils.getUser().getId()).getStr("id");
		//sf.append("SELECT count(*) FROM crm_goods_platform_mjl_order a LEFT JOIN crm_goods_platform p ON p.number=a.good_number  LEFT JOIN crm_site s ON s.id=a.site_id where s.status='0' and a.supplier_id='"+supplierId+"'  ");
		sf.append("SELECT count(*) FROM crm_goods_platform_mjl_order a LEFT JOIN crm_goods_platform p ON p.number=a.good_number  LEFT JOIN crm_site s ON s.id=a.site_id where s.status='0'   ");
		sf.append(queryConditionsSup(map));
		return Db.queryLong(sf.toString());
	}


	public String queryConditionsSup(Map<String,Object> map){
		StringBuilder sf = new StringBuilder();
		if(map!=null){
			if(map.get("goodName") != null && StringUtils.isNotEmpty((CharSequence)((String[])map.get("goodName"))[0])){
				sf.append(" and a.good_name like '%"+((String[])map.get("goodName"))[0].trim()+"%' ");
			}
			if(map.get("createTimeMin") != null && StringUtils.isNotEmpty(((String[])map.get("createTimeMin"))[0])){
				sf.append(" and a.placing_order_time >= '"+((String[])map.get("createTimeMin"))[0]+" 00:00:00' ");
			}
			if(map.get("createTimeMax") != null && StringUtils.isNotEmpty(((String[])map.get("createTimeMax"))[0])){
				sf.append(" and a.placing_order_time <= '"+((String[])map.get("createTimeMax"))[0]+" 23:59:59' ");
			}
			if(map.get("outTimeMin") != null && StringUtils.isNotEmpty(((String[])map.get("outTimeMin"))[0])){
				sf.append(" and a.sendgood_time >= '"+((String[])map.get("outTimeMin"))[0]+" 00:00:00' ");
			}
			if(map.get("outTimeMax") != null && StringUtils.isNotEmpty(((String[])map.get("outTimeMax"))[0])){
				sf.append(" and a.sendgood_time <= '"+((String[])map.get("outTimeMax"))[0]+" 23:59:59' ");
			}
		}
		return sf.toString();
	}
	
	public String pass(String id){
		try {
			Db.update("update crm_goods_platform_mjl_order a set a.status='1' where a.id=?",id);
			return "ok";
		} catch (Exception e) {
			return "no";
		}
	}
	
	public String noPass(String id,String reason){
		try {
			Db.update("update crm_goods_platform_mjl_order a set a.status='3',a.no_pass_time=now(),a.no_pass_source=? where a.id=?",reason,id);
			return "ok";
		} catch (Exception e) {
			return "no";
		}
	}
	
	public Record getDetailById(String id){
		return Db.findFirst("select a.*,s.name as siteName,p.unit from crm_goods_platform_mjl_order a left join crm_site s on s.id=a.site_id left Join crm_goods_platform p on a.good_id=p.id where a.id='"+id+"' ");
	}
	
	public String outStockConfirm(String id,String logisticsName,String logisticsNo,String goodId){
		try {
			Record rd = Db.findFirst("select a.*,p.sales from crm_goods_platform_mjl_order a left join crm_goods_platform p on p.number=a.good_number  where a.id=?",id);
			Db.update("update crm_goods_platform_mjl_order a set a.status='2',a.sendgood_time=now(),a.finish_time=now(),a.logistics_name=?,a.logistics_no=? where a.id=?",logisticsName,logisticsNo,id);
			if(rd.getBigDecimal("sales")!=null){
				Db.update("update crm_goods_platform a set a.sales=(a.sales+?)  where a.id=? ",rd.getBigDecimal("purchase_num"),goodId);
			}else{
				Db.update("update crm_goods_platform a set a.sales=?  where a.id=? ",rd.getBigDecimal("purchase_num"),goodId);
			}
			return "ok";
		} catch (Exception e) {
			return "no";
		}
	}

    // 获取 服务商 商品线上付款交易记录
    public Page<Record> getPlatformGoodsRecord(Page<Record> page, String siteId, Map<String, Object> map) {
        List<Record> list = goodsPlatFormMjlOrderDao.getSitePlatformGoodsRecord(page, siteId, map);
		for (Record re : list) {
			if (StringUtils.isNotBlank(re.getStr("good_icon"))) {
				re.set("good_icon", re.getStr("good_icon").split(",")[0]);
			}
		}
        long count = goodsPlatFormMjlOrderDao.getCount(map, siteId);
        page.setCount(count);
        page.setList(list);
        return page;
    }

    public void cancelOrder(String id){
        String sql="update crm_goods_platform_mjl_order set status='4' where id='"+id+"' ";
        Db.update(sql);
    }

    public Page<Record> nandaoGrid(Page<Record> page,Map<String,Object> map){
        List<Record> list = getNandaoList(page,map);
        for (Record rd : list) {
            String adress="";
            String province="";
            String city="";
            String area="";
            if(StringUtils.isNotBlank(rd.getStr("province"))){
                province=rd.getStr("province");
            }
            if(StringUtils.isNotBlank(rd.getStr("city"))){
                city=rd.getStr("city");
            }
            if(StringUtils.isNotBlank(rd.getStr("area"))){
                area=rd.getStr("area");
            }
            adress=province+city+area+rd.getStr("customer_address");
            rd.set("customer_address", adress);
        }
        Long count = getNanDaoCount(map);
        page.setCount(count);
        page.setList(list);
        return page;
    }

    public List<Record> getNandaoList(Page<Record> page,Map<String,Object> map){
        StringBuilder sf = new StringBuilder();
        sf.append("SELECT a.*,p.unit,s.name AS siteName,p.distribution_type as distributionType FROM crm_goods_platform_mjl_order a LEFT JOIN crm_goods_platform p ON p.number=a.good_number  LEFT JOIN crm_site s ON s.id=a.site_id where s.status='0' and a.good_category like '%底座%'  ");
        sf.append(queryConditions(map));
        sf.append("ORDER BY a.placing_order_time DESC ");
        if(page!=null){
            sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
        }
        return Db.find(sf.toString());
    }

    public String queryConditions(Map<String,Object> map){
        StringBuilder sf = new StringBuilder();
        if(map!=null){
            if(map.get("number") != null && StringUtils.isNotEmpty((CharSequence)((String[])map.get("number"))[0])){
                sf.append(" and a.number like '%"+((String[])map.get("number"))[0].trim()+"%' ");
            }
            if(map.get("status") != null && StringUtils.isNotEmpty((CharSequence)((String[])map.get("status"))[0])){
                sf.append(" and a.status ='"+((String[])map.get("status"))[0].trim()+"' ");
            }
            if(map.get("goodNumber") != null && StringUtils.isNotEmpty((CharSequence)((String[])map.get("goodNumber"))[0])){
                sf.append(" and a.good_number like '%"+((String[])map.get("goodNumber"))[0].trim()+"%' ");
            }
            if(map.get("placeOrderBy") != null && StringUtils.isNotEmpty((CharSequence)((String[])map.get("placeOrderBy"))[0])){
                List<Record> list = Db.find("select a.* from crm_site a where a.name like'%"+((String[])map.get("placeOrderBy"))[0].trim()+"%' and a.status='0'");
                if(list.size()>0){
                    String ids = "";
                    for(Record rd : list){
                        if(StringUtils.isNotBlank(rd.getStr("id"))){
                            if("".equals(ids)){
                                ids="'"+rd.getStr("id")+"'";
                            }else{
                                ids=ids+",'"+rd.getStr("id")+"'";
                            }
                        }
                    }
                    if("".equals(ids)){
                        sf.append(" and a.site_id = '' ");
                    }else{
                        sf.append(" and a.site_id in ("+ids+") ");
                    }

                }else{
                    sf.append(" and a.site_id = '' ");
                }
            }
            if(map.get("goodName") != null && StringUtils.isNotEmpty((CharSequence)((String[])map.get("goodName"))[0])){
                sf.append(" and a.good_name like '%"+((String[])map.get("goodName"))[0].trim()+"%' ");
            }
            if(map.get("createTimeMin") != null && StringUtils.isNotEmpty(((String[])map.get("createTimeMin"))[0])){
                sf.append(" and a.placing_order_time >= '"+((String[])map.get("createTimeMin"))[0]+" 00:00:00' ");
            }
            if(map.get("createTimeMax") != null && StringUtils.isNotEmpty(((String[])map.get("createTimeMax"))[0])){
                sf.append(" and a.placing_order_time <= '"+((String[])map.get("createTimeMax"))[0]+" 23:59:59' ");
            }
            if(map.get("outTimeMin") != null && StringUtils.isNotEmpty(((String[])map.get("outTimeMin"))[0])){
                sf.append(" and a.sendgood_time >= '"+((String[])map.get("outTimeMin"))[0]+" 00:00:00' ");
            }
            if(map.get("outTimeMax") != null && StringUtils.isNotEmpty(((String[])map.get("outTimeMax"))[0])){
                sf.append(" and a.sendgood_time <= '"+((String[])map.get("outTimeMax"))[0]+" 23:59:59' ");
            }
        }
        return sf.toString();
    }

    public long getNanDaoCount(Map<String,Object> map){
        StringBuilder sf = new StringBuilder();
        sf.append("SELECT count(*) FROM crm_goods_platform_mjl_order a LEFT JOIN crm_goods_platform p ON p.number=a.good_number  LEFT JOIN crm_site s ON s.id=a.site_id where s.status='0' and a.good_category like '%插座%'  ");
        sf.append(queryConditions(map));
        return Db.queryLong(sf.toString());
    }

}
