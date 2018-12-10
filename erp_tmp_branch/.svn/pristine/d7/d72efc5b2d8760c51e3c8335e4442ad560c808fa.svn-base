package com.jojowonet.modules.order.form;

import ivan.common.utils.excel.annotation.ExcelField;

import org.hibernate.validator.constraints.Length;


public class AreaExManagerForm {
    private String mobile;//账号
    private String name; //区管姓名
    
    private String area; //区域
    private String phone;//区管联系方式
    private Long discountAmount;
    private String siteName;
    private String address;
    private String dueTime;
    
    
    @Length(min = 1, max = 50)
	@ExcelField(title = "区管姓名", align = 2, sort=1)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    @Length(min = 1, max = 50)
	@ExcelField(title = "区管联系电话", align = 2, sort=2)
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
    @Length(min = 1, max = 50)
	@ExcelField(title = "区域", align = 2, sort=0)
    public String getArea() {
        return area.trim();
    }

    public void setArea(String area) {
        this.area = area;
    }
    @Length(min = 1, max = 50)
	@ExcelField(title = "续费次数", align = 2, sort=8)
    public Long getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(Long discountAmount) {
        this.discountAmount = discountAmount;
    }
    @Length(min = 1, max = 50)
	@ExcelField(title = "账号", align = 2, sort=4)
	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	@Length(min = 1, max = 50)
	@ExcelField(title = "服务商名称", align = 2, sort=3)
	public String getSiteName() {
		return siteName;
	}

	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}
	@Length(min = 1, max = 50)
	@ExcelField(title = "地址", align = 2, sort=5)
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	@Length(min = 1, max = 50)
	@ExcelField(title = "到期时间", align = 2, sort=6)
	public String getDueTime() {
		return dueTime;
	}

	public void setDueTime(String dueTime) {
		this.dueTime = dueTime;
	}


}
