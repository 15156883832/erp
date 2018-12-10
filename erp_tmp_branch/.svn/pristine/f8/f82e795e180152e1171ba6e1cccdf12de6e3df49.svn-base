package com.jojowonet.modules.order.service;

import com.google.common.collect.Lists;
import com.google.gson.JsonObject;
import com.jojowonet.modules.operate.service.SendedSmsService;
import com.jojowonet.modules.order.dao.SmsSignDao;
import com.jojowonet.modules.order.entity.SmsSign;
import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.sys.util.SfSmsUtils;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Parameter;
import ivan.common.service.BaseService;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import ivan.common.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.Entity;
import java.util.Date;
import java.util.List;

/**
 * 
 * @author yc
 * 短信签名service
 *
 */
@Component
@Transactional(readOnly = false)
public class SmsSignSetService extends BaseService{

	@Autowired
	private SmsSignDao smsSignDao;


	public Record getSiteSmsSign(String siteId){
		String sql = "SELECT * FROM crm_site WHERE id='" + siteId + "' and status='0'";
		return Db.findFirst(sql);
	}

	public Record getSignInfo(String siteId){
		return Db.findFirst("select * from crm_site_sms_sign a where a.site_id=? and a.status='0' ", siteId);
	}

	//更新签名
	@Transactional(rollbackFor = Exception.class)
	public Result updateSiteSign(String siteId, String smsSign) {
		Result ret = new Result();
		ret.setCode("0");
		boolean signNameRepeat = false;//签名是否已维护
		Record similerRec = Db.findFirst("select * from crm_site_sms_sign a where a.name=? and a.reviewsms_status='1' and a.site_id<>? ", smsSign,siteId);
		Record re = Db.findFirst("select * from crm_site_sms_sign a where a.site_id=? and status='0'", siteId);
		if (similerRec != null) {
			signNameRepeat = true;
		}
		if (signNameRepeat) {//签名已存在
			if (re == null) {
				User user = UserUtils.getUser();
				SmsSign sign = new SmsSign();
				sign.setName(smsSign);
				sign.setCreateBy(user.getId());
				sign.setCreateTime(new Date());
				sign.setCreateType(user.getUserType());
				sign.setNumber(similerRec.getStr("number"));
				sign.setSiteId(siteId);
				sign.setReviewsmsStatus("1");//0待审核1审核通过2审核未通过
				smsSignDao.save(sign);
				return ret;
			}else{
				User user = UserUtils.getUser();
				SmsSign sign = smsSignDao.get(re.getStr("id"));
				sign.setName(smsSign);
				sign.setCreateBy(user.getId());
				sign.setCreateTime(new Date());
				sign.setCreateType(user.getUserType());
				sign.setNumber(similerRec.getStr("number"));
				sign.setSiteId(siteId);
				sign.setReviewsmsStatus("1");//0待审核1审核通过2审核未通过
				smsSignDao.save(sign);
				return ret;
			}

		}
		if(re==null || "1".equals(re.getStr("reviewsms_status"))){//未维护过签名或签名已审核通过
			List<SmsSign> list = Lists.newArrayList();

			if(re!=null && "1".equals(re.getStr("reviewsms_status"))){
				if (smsSign == re.getStr("name")) {
					ret.setCode("205");
					ret.setData("请勿做无效操作！");
					return ret;
				}

				SmsSign sign2 = smsSignDao.get(re.getStr("id"));
				sign2.setStatus("1");
				list.add(sign2);
			}

			User user = UserUtils.getUser();
			SmsSign sign = new SmsSign();
			sign.setName(smsSign);
			sign.setCreateBy(user.getId());
			sign.setCreateTime(new Date());
			sign.setCreateType(user.getUserType());
			String result = SfSmsUtils.addSign("【" + smsSign + "】", "思方科技");
			JsonObject obj = SfSmsUtils.convertStringToJsonObject(result);
			String smsId = "";
			if(obj != null && obj.has("ret") && "0".equals(obj.get("ret").getAsString())){//提交成功
				smsId = obj.get("data").getAsJsonObject().get("signId").getAsString();
			}else{//提交失败
				ret.setCode(obj.get("ret").getAsString());
				ret.setMsg(obj.get("msg").getAsString());
				return ret;
			}
			sign.setNumber(smsId);
			sign.setSiteId(siteId);
			sign.setReviewsmsStatus("0");//0待审核1审核通过2审核未通过
			list.add(sign);

			smsSignDao.save(list);
			ret.setCode("0");
		}else{
			SmsSign sign = smsSignDao.get(re.getStr("id"));
			String smsId = re.getStr("number");

			String result = SfSmsUtils.modifySign(smsId, "【" + smsSign + "】", "思方科技");
			JsonObject obj = SfSmsUtils.convertStringToJsonObject(result);
			if(obj != null && obj.has("ret") && "0".equals(obj.get("ret").getAsString())){//提交成功
				sign.setReviewsmsStatus("0");
				sign.setName(smsSign);
				smsSignDao.save(sign);
				ret.setCode("0");
			}else{//提交失败
				ret.setCode(obj.get("ret").getAsString());
				ret.setMsg(obj.get("msg").getAsString());
			}
		}
		return ret;
	}
	//修改手机号
	public int updateMobile(String siteId, String smsPhone) {
		String sql="UPDATE crm_site SET sms_phone=? WHERE id='"+siteId+"'";
		return Db.update(sql, smsPhone);
	}


}
