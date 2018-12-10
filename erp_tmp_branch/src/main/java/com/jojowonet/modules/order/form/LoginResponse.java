package com.jojowonet.modules.order.form;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

public class LoginResponse {

	private String status;
	private String siteId;
	private String userType;
	private String siteName;
	private List<?> vendors;
	private String version;
	private String updateUrl;
	private List<Map<String, String>> updateFiles;
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getSiteId() {
		return siteId;
	}
	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}
	public String getSiteName() {
		return siteName;
	}
	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}
	public List<?> getVendors() {
		return vendors;
	}
	public void setVendors(List<?> vendors) {
		this.vendors = vendors;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getUpdateUrl() {
		return updateUrl;
	}
	public void setUpdateUrl(String updateUrl) {
		this.updateUrl = updateUrl;
	}
	public List<Map<String, String>> getUpdateFiles() {
		return updateFiles;
	}
	public void setUpdateFiles(List<Map<String, String>> updateFiles) {
		this.updateFiles = updateFiles;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}
}
