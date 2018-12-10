package com.jojowonet.modules.order.utils;

public class OrderCountChangeTypes {

    /**
     * 思傅帮
     */
    public static final String TYPE_sfb = "sfb";
    /**
     * 经理人
     */
    public static final String TYPE_jlr = "jlr";
    /**
     * 新建工单
     */
    public static final String TYPE_xjgd = "xjgd";
    /**
     * 新建工单后直接派工
     */
    public static final String TYPE_zjpg = "zjpg";

    /**
     * 删除无效工单
     */
    public static final String TYPE_scgd = "scgd";
    /**
     * 复制工单
     */
    public static final String TYPE_fzgd = "fzgd";
    /**
     * 来电弹屏
     */
    public static final String TYPE_ldtp = "ldtp";
    /**
     * 微信报单
     */
    public static final String TYPE_wxbd = "wxbd";
    /**
     * 转字自接
     */
    public static final String TYPE_zzj = "zzj";
    /**
     * 信息员小程序
     */
    public static final String TYPE_xcx = "xcx";
    /**
     * 一级网点派工
     */
    public static final String TYPE_yjwdpg = "yjwdpg";
    /**
     * 一级网点转派
     */
    public static final String TYPE_yjwdzp = "yjwdzp";
    /**
     * 二级网点返回工单
     */
    public static final String TYPE_fhgd = "fhgd";
    /**
     * 二级网点接收一级网点工单，理论上二级网点工单数量是不会变的，因为在一级网点指派工单给我二级网点的时候，工单数量已经改变。
     */
    public static final String TYPE_jsyjwdgd = "jsyjwdgd";
    /**
     * 二级网点拒收一级网点工单。
     */
    public static final String TYPE_jjyjwdgd = "jjyjwdgd";
}
