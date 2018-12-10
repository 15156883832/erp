package com.jojowonet.modules.order.form;

import org.hibernate.validator.constraints.NotBlank;

public class AreaManagerForm {
    private String id;
    @NotBlank
    private String name;
    @NotBlank
    private String phone;
    @NotBlank
    private String area;
    @NotBlank
    private String unique;
    @NotBlank
    private Long discountAmount;
    
    private String superiorDistrict;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getArea() {
        return area.trim();
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getUnique() {
        return unique;
    }

    public void setUnique(String unique) {
        this.unique = unique;
    }

    public Long getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(Long discountAmount) {
        this.discountAmount = discountAmount;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

	public String getSuperiorDistrict() {
		return superiorDistrict;
	}

	public void setSuperiorDistrict(String superiorDistrict) {
		this.superiorDistrict = superiorDistrict;
	}
    
}
