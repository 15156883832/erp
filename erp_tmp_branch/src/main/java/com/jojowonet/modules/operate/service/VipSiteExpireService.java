package com.jojowonet.modules.operate.service;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.dao.SiteManagerDao;
import com.jojowonet.modules.operate.dao.VipSiteExpireDao;
import com.jojowonet.modules.order.dao.AreaManagerDao;

import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/10/9.
 */

@Component
@Transactional(readOnly = true)
public class VipSiteExpireService {
    @Autowired
    private VipSiteExpireDao vipSiteExpireDao;
    
	@Autowired
	private SiteManagerDao siteManagerDao;
	@Autowired
	private AreaManagerDao areaManagerDao;
    
    public Page<Record> getVipSite(Page<Record> page, Map<String,Object> map,String mon){
        List<Record> list=vipSiteExpireDao.VipsiteList(page,map,mon);
        Date now = new Date();
        for (Record rd : list) {//统计商品订单总数（包括平台商品订单和自营商品订单）
         if(rd.getLong("goodsselforder")!=null){
           rd.set("goodsOrder",rd.getLong("goodsplatorder"));
        }else if(rd.getLong(rd.getStr("goodsplatorder"))!=null){
             rd.set("goodsOrder",rd.getLong("goodsselforder"));
        }else if(rd.getLong(rd.getStr("goodsplatorder"))!=null&&rd.getLong(rd.getStr("goodsselforder"))!=null){
             Integer selforder=rd.getLong("goodsselforder").intValue();
             Integer platorder=rd.getLong("goodsplatorder").intValue();
            Integer allorder=selforder+platorder;
            Long goodsOrder=allorder.longValue();
             rd.set("goodsOrder",goodsOrder);
         }else{
             rd.set("goodsOrder","0");
         }
            if (rd.getDate("due_time") == null) {
                rd.set("version", "免费版");
            } else {
                if (rd.getDate("due_time").getTime() >= now.getTime()) {
                    rd.set("version", "收费版");
                } else {
                    rd.set("version", "免费版");
                }
            }
        }
        long count=vipSiteExpireDao.getVipListCount(map,mon);
        page.setList(list);
        page.setCount(count);
        return page;
    }

    public Page<Record> getVipAttermsList(Page<Record> page, Map<String,Object> map){
        List<Record> list=vipSiteExpireDao.getVipAttermsList(page,map);
        Date now = new Date();
		String sitename;
		String parenttype;
        for (Record rd : list) {//统计商品订单总数（包括平台商品订单和自营商品订单）
            if(rd.getLong("goodsselforder")!=null){
                rd.set("goodsOrder",rd.getLong("goodsplatorder"));
            }else if(rd.getLong(rd.getStr("goodsplatorder"))!=null){
                rd.set("goodsOrder",rd.getLong("goodsselforder"));
            }else if(rd.getLong(rd.getStr("goodsplatorder"))!=null&&rd.getLong(rd.getStr("goodsselforder"))!=null){
                Integer selforder=rd.getLong("goodsselforder").intValue();
                Integer platorder=rd.getLong("goodsplatorder").intValue();
                Integer allorder=selforder+platorder;
                Long goodsOrder=allorder.longValue();
                rd.set("goodsOrder",goodsOrder);
            }else{
                rd.set("goodsOrder","0");
            }
            if (rd.getDate("due_time") == null) {
                rd.set("version", "免费版");
            } else {
                if (rd.getDate("due_time").getTime() >= now.getTime()) {
                    rd.set("version", "收费版");
                } else {
                    rd.set("version", "免费版");
                }
            }
        	if(StringUtils.isNotBlank(rd.getStr("share_code_site_parent_id"))){
				if(siteManagerDao.querySiteByid(rd.getStr("share_code_site_parent_id"))!=null){
					sitename=siteManagerDao.querySiteByid(rd.getStr("share_code_site_parent_id")).getStr("name");
					parenttype="售后服务商";
					rd.set("shareParentName", sitename);
					rd.set("shareParenttype", parenttype);
			       }

				}else{
					if(StringUtils.isNotBlank(rd.getStr("area_manager_id"))){
						if(rd.getStr("area_manager_id")!=null){
							sitename=areaManagerDao.getAreaManagerById(rd.getStr("area_manager_id")).getStr("name");
							parenttype="区域管理员";
							rd.set("shareParentName", sitename);
							rd.set("shareParenttype", parenttype);
						}
					
				}
				
			}
        }
        long count=vipSiteExpireDao.getAttermsListCount(map);
        page.setList(list);
        page.setCount(count);
        return page;
    }
}
