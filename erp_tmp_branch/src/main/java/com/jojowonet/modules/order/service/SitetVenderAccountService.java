package com.jojowonet.modules.order.service;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.dao.SiteDao;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.order.dao.SitetVenderAccountDao;
import com.jojowonet.modules.order.entity.SiteVenderAccount;
import com.jojowonet.modules.order.form.SiteVendorAccountForm;
import com.jojowonet.modules.order.utils.FlagResult;
import com.jojowonet.modules.order.utils.SqlKit;
import com.jojowonet.modules.order.utils.StringUtil;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;


/**
 * 网点的厂家账号信息表Service
 * @author Ivan
 * @version 2017-05-04
 */
@Component
@Transactional
public class SitetVenderAccountService extends BaseService{
	
	@Autowired
	private SitetVenderAccountDao sitetVenderAccountDao;
	@Autowired
	private SiteDao siteDao;
	
	public Page<Record> getSiteVenderAccountGrid(String siteId,Page<Record> page) {

		StringBuilder sb = new StringBuilder("");
		sb.append("SELECT a.* FROM crm_site_vender_account a WHERE a.status='0' AND site_id = '"+siteId+"' ORDER BY vender_id");
		sb.append(" limit "+page.getPageSize()+" offset " + (page.getPageNo()-1)*page.getPageSize());
		List<Record> list = Db.find(sb.toString());

		Long count = sitetVenderAccountDao.getCount(siteId);
		page.setList(list);
		page.setCount(count);
		return page;
		
	}
	
	public Boolean delOne(String rowId) {
		Db.update("UPDATE crm_site_vender_account SET status = '1' WHERE id=?", rowId);
		return true;
	}
	
	public Record editOne(String rowId) {
		return Db.findFirst("SELECT a.* FROM crm_site_vender_account a WHERE a.status='0' AND id = '"+rowId+"'");
	}
	
	public void saveEdit(String rowId,String loginName,String password) {
		Db.update("UPDATE crm_site_vender_account a SET a.login_name='"+loginName+"',a.password='"+password+"' WHERE a.status='0' AND a.id='"+rowId+"'");
		
	} 
	
	public List<Record> getVenderInfo(){
		return Db.find("SELECT * FROM crm_vender_info WHERE status='0'");
	}
	
	public Boolean addSave(String siteId,String getSelectedId,String loginName,String password) {
		SiteVenderAccount siteVenderAccount = new SiteVenderAccount();
		Record record = getVenderInfoById(getSelectedId);
		siteVenderAccount.setLoginName(loginName);
		siteVenderAccount.setPassword(password);
		siteVenderAccount.setVenderId(getSelectedId);
		siteVenderAccount.setLink(record.getStr("url"));
		siteVenderAccount.setStatus("0");
		siteVenderAccount.setName(record.getStr("name"));
		siteVenderAccount.setSiteId(siteId);
		sitetVenderAccountDao.save(siteVenderAccount);
		return true;
	}

	private FlagResult<String> errorResult(String code, String msg) {
		FlagResult<String> ret = new FlagResult<>();
		ret.setCode(code);
		ret.setMsg(msg);
		ret.setData("");
		ret.setFlag("addFactoryAccount");
		return ret;
	}

	public FlagResult<String> save(SiteVendorAccountForm form) {
		if (StringUtil.isBlank(form.getLoginName())) {
			return errorResult("422", "missing login name");
		}
		if (StringUtil.isBlank(form.getPassword())) {
			return errorResult("422", "missing login name");
		}
		if (StringUtil.isBlank(form.getName())) {
			return errorResult("422", "missing factory name");
		}
		if (StringUtil.isBlank(form.getSiteId())) {
			return errorResult("422", "missing site id");
		}

		Site site = siteDao.get(form.getSiteId());
		if (site == null) {
			return errorResult("422", "invalid site id");
		}

		Record vendorInfo = Db.findFirst("select * from crm_vender_info where name=? and status='0' limit 1", form.getName());
		if (vendorInfo == null) {
			return errorResult("422", "invalid factory name");
		}

		String vendorId = vendorInfo.getStr("id");
		Record acc = Db.findFirst("select * from crm_site_vender_account where vender_id=? and site_id=? and login_name=? and status='0' limit 1", vendorId, site.getId(), form.getLoginName());
		if (acc != null) {
			FlagResult<String> ret = new FlagResult<>();
			ret.setCode("200");
			ret.setMsg("ok");
			ret.setData(acc.getStr("id"));
			ret.setFlag("addFactoryAccount");
			return ret;
		}

		Record acc1 = Db.findFirst("select * from crm_site_vender_account where vender_id=? and login_name=? and status='0' limit 1", vendorId, form.getLoginName());
		if (acc1 != null) {
			return errorResult("423", "厂家账号已存在");
		}

		SiteVenderAccount account = new SiteVenderAccount();
		account.setLoginName(form.getLoginName());
		account.setName(vendorInfo.getStr("name"));
		account.setLink(vendorInfo.getStr("url"));
		account.setVenderId(vendorInfo.getStr("id"));
		account.setSiteId(form.getSiteId());
		account.setPassword(form.getPassword());
		sitetVenderAccountDao.save(account);

		FlagResult<String> ret = new FlagResult<>();
		ret.setCode("200");
		ret.setMsg("ok");
		ret.setData(account.getId());
		ret.setFlag("addFactoryAccount"); // 用来表明接口是干什么用的，主要是助手那边需要这个标志。
		return ret;
	}

    
	public Record getVenderInfoById(String getSelectedId){
		return Db.findFirst("SELECT * FROM crm_vender_info WHERE status='0' AND id ='"+getSelectedId+"'");
	}

	public Integer queryAccountByName(String siteId, String loginName) {
		Integer i=0;
		i=Db.find("SELECT * FROM crm_site_vender_account WHERE status='0' AND login_name='"+loginName+"'").size();
		return i;
	}

	public Record querybyid(String siteId, String names, String id) {
		return Db.findFirst("SELECT * FROM crm_site_vender_account WHERE status='0'  AND login_name='"+names+"' AND id!='"+id+"'" );
	}

	/**
	 * 修改厂家账号，凡是给助手的api。
	 * 注意：凡是返回给助手的api的返回值类型必须都得是<code>FlagResult</code>
	 *
	 * @param params should contain login_name or password field
	 * @return modify status.
	 */
	public FlagResult<Void> modifyAccount(Map<String, String> params) {
		FlagResult<Void> ret = new FlagResult<>();
		ret.setFlag("modFactoryAccount");
		String id = params.get("id");
		String loginName = params.get("login_name");
		String password = params.get("password");
		if (StringUtil.isBlank(id)) {
			ret.setErrMsg("site vendor id required");
			ret.setCode("422");
		}

		Record vendorRecord = Db.findFirst("select * from crm_site_vender_account where id=? and status='0'", id);
		if (vendorRecord == null) {
			ret.setErrMsg("site vendor with id not found: " + id);
			ret.setCode("423");
		} else {
			if (StringUtil.isBlank(loginName) && StringUtil.isBlank(password)) {
				ret.setErrMsg("at least one modify field required");
				ret.setCode("424");
			} else {
				if (StringUtil.isBlank(loginName)) {
					loginName = vendorRecord.getStr("login_name");
				}
				if (StringUtil.isBlank(password)) {
					password = vendorRecord.getStr("password");
				}
				SqlKit kit = new SqlKit().append("update crm_site_vender_account set ");
				kit.append("login_name=?,");
				kit.append("password=?");
				kit.append("where id=? and status='0'");
				Db.update(kit.toString(), loginName, password, id);

				ret.setCode("200");
				ret.setMsg("OK");
			}
		}
		return ret;
	}
}