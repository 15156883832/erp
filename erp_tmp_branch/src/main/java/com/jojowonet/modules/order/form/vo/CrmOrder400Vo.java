package com.jojowonet.modules.order.form.vo;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.CrmOrder400;

public class CrmOrder400Vo extends CrmOrder400 {

    private String migration;

    public Record asRecord() {
        Record r = new Record();
        r.set("id", getId());
        r.set("number", getNumber());
        r.set("order_type", getOrderType());
        r.set("create_time", getCreateTime());
        r.set("repair_time", getRepairTime());
        r.set("create_by", getCreateBy());
        r.set("appliance_brand", getApplianceBrand());
        r.set("appliance_category", getApplianceCategory());
        r.set("appliance_model", getApplianceModel());
        r.set("appliance_barcode", getApplianceBarcode());
        r.set("appliance_buy_time", getApplianceBuyTime());
        r.set("appliance_price", getAppliancePrice());
        r.set("appliance_num", getApplianceNum());
        r.set("appliance_machine_code", getApplianceMachineCode());
        r.set("customer_name", getCustomerName());
        r.set("customer_address", getCustomerAddress());
        r.set("customer_address2", getCustomerAddress2());
        r.set("customer_mobile", getCustomerMobile());
        r.set("customer_telephone", getCustomerTelephone());
        r.set("customer_telephone2", getCustomerTelephone2());
        r.set("promise_time", getPromiseTime());
        r.set("promise_limit", getPromiseLimit());
        r.set("customer_feedback", getCustomerFeedback());
        r.set("remarks", getRemarks());
        r.set("origin", getOrigin());
        r.set("c_service_type", getcServiceType());
        r.set("c_service_mode", getcServiceMode());
        r.set("service_type", getServiceType());
        r.set("service_mode", getServiceMode());
        r.set("important", getImportant());
        r.set("level", getLevel());
        r.set("site_name", getSiteName());
        r.set("employe1", getEmploye1());
        r.set("employe2", getEmploye2());
        r.set("employe3", getEmploye3());
        r.set("dispatch_time", getDispatchTime());
        r.set("update_time", getUpdateTime());
        r.set("warranty_type", getWarrantyType());
        r.set("malfunction_type", getMalfunctionType());
        r.set("malfunction_description", getMalfunctionDescription());
        r.set("malfunction_cause", getMalfunctionCause());
        r.set("malfunction_cause_description", getMalfunctionCauseDescription());
        r.set("measures", getMeasures());
        r.set("measures_description", getMeasuresDescription());
        r.set("site_id", getSiteId());
        r.set("process_detail", getProcessDetail());
        r.set("end_time", getEndTime());
        r.set("status", getStatus());
        r.set("order_id", getOrderId());
        r.set("feedback", getFeedback());
        r.set("feedback_time", getFeedbackTime());
        r.set("feedback_result", getFeedbackResult());
        r.set("feedback_name", getFeedbackName());
        r.set("is_convert", getIsConvert());
        r.set("flag", getFlag());
        r.set("flag_desc", getFlagDesc());
        r.set("flag_alert_date", getFlagAlertDate());
        r.set("print_times", getPrintTimes());
        r.set("migration", getMigration());
        return r;
    }

    public String getMigration() {
        return migration;
    }

    public void setMigration(String migration) {
        this.migration = migration;
    }
}
