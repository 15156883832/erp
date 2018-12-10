package com.jojowonet.modules.sys.service;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.sys.dao.GiftPackDao;
import ivan.common.persistence.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class GiftPackService {

    @Autowired
    GiftPackDao giftPackDao;

    public Page<Record> getVipGifts(Page<Record> pages, String siteId, Map<String, Object> map) {
        return giftPackDao.getVipGiftPackList(pages, siteId, map);
    }

    public Result<Map<String, String>> takeVipGift(String giftId) {
        Map<String, String> d = giftPackDao.takeVipGift(giftId);
        Result<Map<String, String>> ret = new Result<>();
        if (d != null) {
            ret.setData(d);
            ret.setCode("200");
        } else {
            ret.setCode("422");
        }
        return ret;
    }

    public long giftAvailable(String siteId) {
        return giftPackDao.giftAvailable(siteId);
    }

    public long allVipGiftCount(String siteId) {
        return giftPackDao.allVipGiftCount(siteId);
    }
}
