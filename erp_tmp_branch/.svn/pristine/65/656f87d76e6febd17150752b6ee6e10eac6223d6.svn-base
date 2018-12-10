/**
 */
package com.jojowonet.modules.order.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.IdGen;
import ivan.common.utils.StringUtils;
import ivan.common.utils.excel.ImportExcel;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.dao.BrandDao;
import com.jojowonet.modules.order.entity.Brand;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.order.utils.SysConfUtils;


/**
 * 品牌Service
 * @author Ivan
 * @version 2016-08-01
 */
@Component
@Transactional(readOnly = true)
public class BrandService extends BaseService {

	@Autowired
	private BrandDao brandDao;
	
	public Brand get(String id) {
		if(StringUtils.isNumeric(id)){
			return brandDao.get(Integer.valueOf(id));
		}
		return null;
	}

	@Transactional(readOnly = false)
	public void save(Brand brandOrder) {
		brandDao.save(brandOrder);
	}
	
	@Transactional(readOnly = false)
	public void delete(String id) {
		brandDao.deleteById(id);
	}

    public Page<Record> findBrand(Page<Record> page) {
        List<Record> list =brandDao.getBrandList(page);
        long count = brandDao.getListcount();
        page.setCount(count);
        page.setList(list);

        return page;
    }
	
	public List<Record> getListBrandRel(String id){
		return brandDao.getListBrandRel(id);
	}
	
	public List<Map<String, String>> getBrand(String caId,String brand){
		List<Record> list = brandDao.getbrand(caId);
		List<Map<String ,String>> listmap = Lists.newArrayList();
		if(list != null){
			String[] byCat = brand.split("/"); 
			for(Record rd : list){
				Map<String ,String> map = new HashMap<String, String>();
				map.put("name", rd.getStr("name"));
				map.put("id", rd.getInt("bid").toString());
	             for(String bran : byCat){	
	             if(bran.equals(rd.getStr("name"))){
	            	 map.put("biao", "y");
	             }
	             }
				listmap.add(map);
				
			}
		}
		
		return listmap;
	}
	
	public String getbrangname(String siteId,String caId){
		List<Record> list = brandDao.getBrandSite(siteId, caId);
		String name = null ;
		if(list != null){
			for(Record rd : list){
				if(name==null){
					name = rd.getStr("name");
				}else{
				name = name+"/"+rd.getStr("name");
				}
				}
		}
		return name;
	}


	public Page<Record> getBMPage(Page<Record> page, Map map, String siteId) {
		Map<String, Object> info = getBMList(page, map, siteId);
        page.setList((List<Record>)info.get("list"));
        page.setCount((Long)info.get("count"));
        return page;
    }
	
	public Map<String, Object> getBMList(Page<Record> page, Map map, String userSiteId){
		Map<String, Object> ret = Maps.newHashMap();
		StringBuilder listSb = new StringBuilder("");
		StringBuilder countSb = new StringBuilder("");
		StringBuilder fromSb = new StringBuilder("");
		StringBuilder whereSb = new StringBuilder("");
		StringBuilder optionSb = new StringBuilder("");
		listSb.append(" select *  ");
		countSb.append(" select count(1) as count  ");
		fromSb.append(" from crm_barcode_bcm_rel a ");
		//whereSb.append(" where a.site_id = '"+userSiteId+"' ");
		whereSb.append(" where a.status = '0' ");
		if(map.get("category") != null && StringUtils.isNotBlank(((String[])map.get("category"))[0])){
            whereSb.append(" and a.category like '%"+((String[])map.get("category"))[0]+"%' ");
        }
		if(map.get("brand") != null && StringUtils.isNotBlank(((String[])map.get("brand"))[0])){
            whereSb.append(" and a.brand like '%"+((String[])map.get("brand"))[0]+"%' ");
        }
		if(map.get("barcode") != null && StringUtils.isNotBlank(((String[])map.get("barcode"))[0])){
            whereSb.append(" and a.barcode like '%"+((String[])map.get("barcode"))[0]+"%' ");
        }
		if(map.get("model") != null && StringUtils.isNotBlank(((String[])map.get("model"))[0])){
            whereSb.append(" and a.model like '%"+((String[])map.get("model"))[0]+"%' ");
        }
		if(page != null){
			optionSb.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() -1) * page.getPageSize());
		}
		List<Record> rds = Db.find(listSb.append(fromSb.toString()).append(whereSb.toString()).append(optionSb.toString()).toString());
        long count = Db.queryLong(countSb.append(fromSb.toString()).append(whereSb.toString()).toString());
        ret.put("list", rds);
        ret.put("count", count);
        return ret;
	}


	public void saveCbm(Map<String, String[]> params) {
		String[] idArr = params.get("svId");
		String id = IdGen.uuid();
		
		String[] categoryArr = params.get("category");
		String[] barcodeArr = params.get("barcode");
		String[] modelArr = params.get("model");
		String[] brandArr = params.get("brand");
		
		String category = (categoryArr != null && categoryArr.length > 0  && StringUtils.isNotBlank(categoryArr[0])) ? "'"+categoryArr[0]+"'" : "NULL";
		String barcode = (barcodeArr != null && barcodeArr.length > 0  && StringUtils.isNotBlank(barcodeArr[0])) ? "'"+barcodeArr[0]+"'" : "NULL";
		String model = (modelArr != null && modelArr.length > 0  && StringUtils.isNotBlank(modelArr[0])) ? "'"+modelArr[0]+"'" : "NULL";
		String brand = (brandArr != null && brandArr.length > 0  && StringUtils.isNotBlank(brandArr[0])) ? "'"+brandArr[0]+"'" : "NULL";
		
		if(idArr != null && idArr.length > 0 && StringUtils.isNotBlank(idArr[0])){//更新
			id = idArr[0];
			Db.update("UPDATE crm_barcode_bcm_rel SET category = "+category+", brand = "+brand+", barcode = "+barcode+", model = "+model+" WHERE id = '"+id+"'");
		}else{//新增
			StringBuilder sb = new StringBuilder("");
			sb.append(" INSERT INTO crm_barcode_bcm_rel (id, category, brand, barcode, model, status) VALUES ");
			sb.append(" ( ");
			sb.append(" '"+id+"', ");
			sb.append(" "+category+", ");
			sb.append(" "+brand+", ");
			sb.append(" "+barcode+", ");
			sb.append(" "+model+", ");
			sb.append(" '0' ");
			sb.append(" ) ");
			Db.update(sb.toString());
		}
	}


	public void cbmDel(Map<String, String[]> params) {
		String[] idArr = params.get("svId");
		if(idArr != null && idArr.length > 0){//更新
			Db.update("UPDATE crm_barcode_bcm_rel SET status = '1' WHERE id = '"+idArr[0]+"'");
		}
	}


	public Map<String, Object> handleExcelFile(MultipartFile file) {		
		long startL = System.currentTimeMillis();
		String serialNo = String.valueOf(System.currentTimeMillis()+""+System.nanoTime());
		Map<String, Object> result = Maps.newHashMap();
		result.put("isTemplate", "yes");
		
		try {
			logger.info(" ["+serialNo+"] >> barcodeBrandModel excel file:" + file.getName() + ", size:" + file.getSize());
			ImportExcel ei = new ImportExcel(file, 0, 0);
			String[] stdTitle = {"品类", "品牌", "家电条码", "家电型号"};
			
			int rn = ei.getLastDataRowNum();
			logger.info(" ["+serialNo+"] >> excel has " + rn + " rows. ");
			if(rn > 0){
				List<Map<String, Object>> dataList = Lists.newArrayList();
				StringBuilder itemSb = new StringBuilder("");
				StringBuilder sb = new StringBuilder("");
				sb.append(" INSERT INTO crm_barcode_bcm_rel (id, category, brand, barcode, model, status) ");
				sb.append(" VALUES ");
				
				StringBuilder upSb = new StringBuilder("");
				upSb.append(" ON DUPLICATE KEY UPDATE ");
				upSb.append(" category = VALUES(category), brand = VALUES(brand), barcode = VALUES(barcode), model = VALUES(model), status = '0' ");
				
				boolean isTemplateTitle = true;
				for(int i = 0; i <= rn; i++){
					Row row = ei.getRow(i);
					Map<String, Object> dateItem = Maps.newHashMap();
					
					for(int j = 0; j < stdTitle.length; j++){
						Object val = null;
						if(i > 0){
							val = ei.getCellValue(row, j);
							dateItem.put(stdTitle[j], val);
						}else{//Title行，进行title检验，判断是否是和模板的title行一致
							Cell cell = row.getCell(j);
							val = cell.getStringCellValue();
							if(val != null && !stdTitle[j].equals(val.toString().trim())){//如果有一个不一致那么就直接返回FALSE：不是使用模板的导入行为
								isTemplateTitle = false;
								break;
							}
						}
					}
					
					if(isTemplateTitle){
						//是使用正确的模板导入的，执行正确逻辑
						if(!dateItem.isEmpty() && !(
								StringUtils.isBlank(String.valueOf(dateItem.get("品类")))
								&& StringUtils.isBlank(String.valueOf(dateItem.get("品牌")))
								&& StringUtils.isBlank(String.valueOf(dateItem.get("家电条码")))
								&& StringUtils.isBlank(String.valueOf(dateItem.get("家电型号")))
								)){
							dataList.add(dateItem);
							itemSb.append(",(")
							.append(StringUtil.wrapSqlParams(IdGen.uuid())+",")
							.append(StringUtil.wrapSqlParams(dateItem.get("品类"))+",")
							.append(StringUtil.wrapSqlParams(dateItem.get("品牌"))+",")
							.append(StringUtil.wrapSqlParams(dateItem.get("家电条码"))+",")
							.append(StringUtil.wrapSqlParams(dateItem.get("家电型号"))+",")
							.append("'0'")
							.append(")");
						}
					}else{//如果不是用模板导入的，直接跳出
						result.put("isTemplate", "no");
						break;
					}
				}
				
				if(isTemplateTitle && dataList != null && dataList.size() > 0){
					long parseL = System.currentTimeMillis();
					result.put("jxsj", (parseL - startL));
					//准备执行插入数据库操作
					if(StringUtil.isNotBlank(itemSb.toString())){
						String exeSql = sb.append(itemSb.toString().substring(1)).append(upSb.toString()).toString();
						if(exeSql.getBytes().length > 20 * 1000 * 1000){
							result.put("tooLarge", "yes");
						}else{
							Db.update(exeSql);
						}
					}
					long exeL = System.currentTimeMillis();
					result.put("dbsj", (exeL - parseL));//数据库操作时间
				}
				
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(" exec db error ");
		}
		return result;
	}
	
	/**
	 * Save modify.
	 *
	 * @param brand the brand
	 * @return true, if successful
	 */
	@Transactional(readOnly = false)
	public boolean saveModify(Brand brand)
	{
		boolean result = true;
		//
		//获取brandid
		Integer id = brand.getId();
		
		List<Integer> categoryIds = brandDao.getAllCategoryIdsByBrandId(id);
		//分析已有的categoryids（假设为集合A）和现在用户选择的（假设为集合B）之间有哪些是新增的（属于B但是不属于A），哪些是需要删除的（属于A但是不属于B）
		List<Integer> deleteNeed = SysConfUtils.getBelongANotB(categoryIds, brand.getCategorys());
		List<Integer> newAdd = SysConfUtils.getBelongANotB(brand.getCategorys(), categoryIds);
		if(id != null)//用户修改
		{
			//根据brandid从crm_category_brand_rel表中找到所有的categoryid
			//新增关系到crm_category_brand_rel表
			brandDao.addNewRelation(newAdd, id);
			//从crm_category_brand_rel表删除关系
			brandDao.deleteRelation(deleteNeed, id);
			//更新brand本身的信息
			result = brandDao.updateModify(brand);
		}
		else//用户新增的品牌
		{
//			result = brandDao.saveAdd(brand);
			brandDao.save(brand);
			//获取id
			Integer brandid = brand.getId();
			//新增关系到crm_category_brand_rel表
			brandDao.addNewRelation(newAdd, brandid);
		}
		return result;
	}
	
}
