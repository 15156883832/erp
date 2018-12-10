package com.jojowonet.modules.sys.util;


public class TranslationUtils {
    /**
     * 翻译派工单状态。
     *
     * @return
     */
    public static String translateDispatchOrderStatus(String status) {
//        1.待接单 2.已接单待上门 3.已拒单待派工 4.已上门维修中 5.维修已完工 6.已转派 7派工取消
        if ("1".equals(status)) {
            return "待接单";
        } else if ("2".equals(status)) {
            return "已接单待上门";

        } else if ("3".equals(status)) {
            return "已拒单待派工";

        } else if ("4".equals(status)) {
            return "已上门维修中";

        } else if ("5".equals(status)) {
            return "维修已完工";

        } else if ("6".equals(status)) {
            return "已转派";

        } else if ("7".equals(status)) {
            return "派工取消";
        }
        return "";
    }
    public static String translateOrderStatus(String status) {
//        0.待网点接收 1.待派工 2.服务中 3.待回访待结算 4.已回访待结算 5.已完成 6.取消工单 7.暂不派工 8.无效工单 9.尚未指派二级网点
        if ("0".equals(status)) {
            return "待网点接收";
        }else if("1".equals(status)){
            return "待网点派工";
        } else if ("2".equals(status)) {
            return "服务中";
        } else if ("3".equals(status)) {
            return "待回访待结算";
        } else if ("4".equals(status)) {
            return "已回访待结算";
        } else if ("5".equals(status)) {
            return "已完成";
        } else if ("6".equals(status)) {
            return "工单已取消";
        } else if ("7".equals(status)) {
            return "暂不派工";
        }else if("8".equals(status)){
            return "无效工单";
        }else if ("9".equals(status)){
            return "尚未指派二级网点";
        }else{
            return "";
        }
    }

    public static String translateServiceAttitude(String status) {
        if ("1".equals(status)) {
            return "十分不满意";
        } else if ("2".equals(status)) {
            return "不满意";

        } else if ("3".equals(status)) {
            return "一般";

        } else if ("4".equals(status)) {
            return "满意";

        } else if ("5".equals(status)) {
            return "十分满意";
        } else if ("6".equals(status)){
            return "无效回访";
        } else if ("7".equals(status)){
            return "回访未成功";
        }
        return "";
    }

    public static String translateSafeEval(String status) {
        if ("1".equals(status)) {
            return "按安全规范操作";
        } else if ("2".equals(status)) {
            return "未出示上岗证";

        } else if ("3".equals(status)) {
            return "未穿工作服鞋套";

        } else if ("4".equals(status)) {
            return "未清理现场";
        }else if("5".equals(status)){
        	return "未按安全规范操作";
        }
        return "";
    }

    public static String translateWarrantyType(String status) {
        if ("1".equals(status)) {
            return "保内";
        } else if ("2".equals(status)) {
            return "保外";

        } else if ("3".equals(status)) {
            return "保内转保外";
        }
        return "";
    }

}
