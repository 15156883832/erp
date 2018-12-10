package com.jojowonet.modules.sys.util;

import org.springframework.stereotype.Component;

/**
 * @author gaols
 *         我写处这么有用的类，你们应该感谢我，请吃饭。
 */
@Component
public class TranslationService {
    /**
     * 回访之服务态度。
     */
    public String translateCallbackAttitude(String level) {
        if ("1".equals(level)) {
            return "十分不满意";
        } else if ("2".equals(level)) {
            return "不满意";
        } else if ("3".equals(level)) {
            return "一般";
        } else if ("4".equals(level)) {
            return "满意";
        } else if ("5".equals(level)) {
            return "十分满意";
        } else if ("6".equals(level)){
            return "无效回访";
        } else if ("7".equals(level)){
            return "回访未成功";
        }
        return "";
    }

    /**
     * 回访之安全评价。
     */
    public String translateCallbackSafety(String level) {
        if ("1".equals(level)) {
            return "师傅没有系安全带";
        } else if ("2".equals(level)) {
            return "有系安全带但没系安全绳";
        } else if ("3".equals(level)) {
            return "安全带系在主机铁架上";
        } else if ("4".equals(level)) {
            return "安全带系在防盗网上";
        } else if ("5".equals(level)) {
            return "按安全规范操作";
        }
        return "";
    }

    /**
     * 是否交回卡单。
     */
    public String translateReturnCard(String flag) {
        if ("1".equals(flag)) {
            return "是";
        } else if ("0".equals(flag)) {
            return "否";
        }
        return "";
    }

    /**
     * 回访标准达标。
     */
    public String translateCallbackStandard(String flag) {
        if ("1".equals(flag)) {
            return "是";
        } else if ("0".equals(flag)) {
            return "否";
        }
        return "";
    }

    /**
     * 回访多次上门。
     */
    public String translateMultipleRepair(String flag) {
        if ("1".equals(flag)) {
            return "是";
        } else if ("0".equals(flag)) {
            return "否";
        }
        return "";
    }

    /**
     * 保修类型。
     */
    public String translateServiceType(String value) {
        if ("1".equals(value)) {
            return "保内";
        } else if ("2".equals(value)) {
            return "保外";
        } else if ("3".equals(value)) {
            return "保外转保内";
        }
        return "";
    }

    /**
     * 回访结果。
     */
    public String translateCallbackResult(String value) {
        if ("1".equals(value)) {
            return "已完工";
        } else if ("0".equals(value)) {
            return "仍需上门";
        }
        return "";
    }

    /**
     * 施工类型。
     */
    public String translateRepairType(String value) {
//        施工类型: 1.维修 2.安装 3.咨询 4.保养 5.工程 6.其他
        if ("1".equals(value)) {
            return "维修";
        } else if ("2".equals(value)) {
            return "安装";
        } else if ("3".equals(value)) {
            return "咨询";
        } else if ("4".equals(value)) {
            return "保养";
        } else if ("5".equals(value)) {
            return "工程";
        } else if ("6".equals(value)) {
            return "其他";
        }
        return "";
    }

    /**
     * 工单的信息等级。
     */
    public String translateOrderLevel(String value) {
        if ("1".equals(value)) {
            return "很紧急";
        } else if ("2".equals(value)) {
            return "紧急";
        } else if ("3".equals(value)) {
            return "尽快";
        } else if ("4".equals(value)) {
            return "一般";
        }
        return "";
    }

    /**
     * 工单状态
     *
     * @return
     */
    public String translateOrderStatus(String value) {
//        0.待接收 1.待派工 2.维修中 3.待回访 4.待结算 5.已结单 6.直接封单完成，7暂不派工
        if ("0".equals(value)) {
            return "待接收";
        } else if ("1".equals(value)) {
            return "待派工";
        } else if ("2".equals(value)) {
            return "维修中";
        } else if ("3".equals(value)) {
            return "待回访";
        } else if ("4".equals(value)) {
            return "待结算";
        } else if ("5".equals(value)) {
            return "已结单";
        } else if ("6".equals(value)) {
            return "直接封单完成";
        } else if ("7".equals(value)) {
            return "暂不派工";
        }
        return "";
    }

    /**
     * 工单来源。
     */
    public String translationOrderOrigin(String value) {
//        信息来源 1.美的，2用户，3其他网点，4.微信，5经销商，6惠而浦 7 厂家派单 8海信
        if ("1".equals(value)) {
            return "美的";
        } else if ("2".equals(value)) {
            return "用户";
        } else if ("3".equals(value)) {
            return "其他网点";
        } else if ("4".equals(value)) {
            return "微信";
        } else if ("5".equals(value)) {
            return "经销商";
        } else if ("6".equals(value)) {
            return "惠而浦";
        } else if ("7".equals(value)) {
            return "厂家派单";
        } else if ("8".equals(value)) {
            return "海信";
        }
        return "";
    }

    /**
     * 工单来源。
     */
    public String translationWarrantyType(String value) {
        if ("1".equals(value)) {
            return "保内";
        } else if ("2".equals(value)) {
            return "保外";
        }
        return "";
    }
}
