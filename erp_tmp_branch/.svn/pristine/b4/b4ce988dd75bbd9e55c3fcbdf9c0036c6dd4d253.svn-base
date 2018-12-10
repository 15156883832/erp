package com.jojowonet.modules.sys.config;

public class SfCacheKey {
    public static final String uidSiteIdMap = "uid_siteid_map"; // struct: map, key:uid, val:site_id
    public static final String nonServicemanCateBrandMap = "nonserviceman_cb_map"; // struct: hash, key: nonserviceman_cb_map field: uid, val: {c: '', b: ''} c表示品类，b表示品牌
    public static final String mustFillMap = "mustfill_map"; // struct: hash, key: mustfill_map field: site_id, val是一个map: {name1:1},{name2:0} name1,name2表示必填字段的名称
    public static final String siteMallMap = "site_mall_map"; // struct: hash, key: site_mall_map field: site_id, val是一个arr: ['mall1','mall2'] mall1,mall2表示mall的名称
    public static final String siteCateMap = "site_category_map"; // struct: hash, key: site_category_map field: site_id, val是一个arr: ['c1','c2'] c1,c2表示品类名称
    public static final String siteMarkSettingMap = "site_mark_setting_map"; // struct: hash, key: site_mark_setting_map field: site_id, val是一个arr: [{id:'id',n:'xxx'}] n:是name
    /**
     * 这个是缓存内外机条码是000000这种情况下的工单数量的key。
     */
    public static final String siteDefault0CodeCountMap = "sid:%s_zero_map"; // struct: kv, param: site_id, val: 'number',
    /**
     * 某个用户的全部工单列表的工单数量。
     */
    public static final String siteUserOrderCountMap = "oc:user:sid:%s"; // struct: kv, param: site_id, value: {uid: count}表示该用户的工单总数量
}
