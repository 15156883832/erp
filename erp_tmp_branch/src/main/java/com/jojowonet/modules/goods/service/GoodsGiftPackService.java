package com.jojowonet.modules.goods.service;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.goods.dao.GoodsGiftPackDao;
import com.jojowonet.modules.goods.entity.GiftPacks;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/12/19.
 */
@Component
@Transactional(readOnly = true)
public class GoodsGiftPackService extends BaseService {
    @Autowired
    private GoodsGiftPackDao goodsGiftPackDao;

    public Page<Record> getGiftPackList(Page<Record> page, Map<String, Object> map) {
        List<Record> list = goodsGiftPackDao.getGiftPackList(page,map);
        long count = goodsGiftPackDao.getCount(map);
        page.setCount(count);
        page.setList(list);
        return page;
    }

    public  List<Record> getSiteList(){
        return goodsGiftPackDao.getSiteList();
    }

    public String addGiftpack(String packname, String takeSites, String addnum) {
        String result = "";
        GiftPacks giftPacks = new GiftPacks();
        giftPacks.setName(packname);
        giftPacks.setTakeSiteId(takeSites);
        giftPacks.setCreateTime(new Date());
        giftPacks.setIdc("00");
        if ("1".equals(addnum)) {
            giftPacks.setDescription("思方VIP会员1个月有效期");
            giftPacks.setNum(1);
        } else if ("3".equals(addnum)) {
            giftPacks.setDescription("思方VIP会员3个月有效期");
            giftPacks.setNum(3);
        } else if ("6".equals(addnum)) {
            giftPacks.setDescription("思方VIP会员6个月有效期");
            giftPacks.setNum(6);
        } else if ("12".equals(addnum)) {
            giftPacks.setDescription("思方VIP会员1年有效期");
            giftPacks.setNum(12);
        } else if ("24".equals(addnum)) {
            giftPacks.setDescription("思方VIP会员2年有效期");
            giftPacks.setNum(24);
        } else {
            Integer num = Integer.parseInt(StringUtils.trim(addnum));
            giftPacks.setDescription(String.format("思方VIP会员%s个月有效期", num));
            giftPacks.setNum(num);
        }
        goodsGiftPackDao.save(giftPacks);
        result = "ok";
        return result;
    }

    //删除礼包
    public Integer deleteGiftpack(String id) {
        return goodsGiftPackDao.deletGiftByid(id);
    }
}
