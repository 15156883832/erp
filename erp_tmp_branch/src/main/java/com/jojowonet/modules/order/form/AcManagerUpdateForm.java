package com.jojowonet.modules.order.form;

import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.Pattern;

public class AcManagerUpdateForm {
    private String id;
    @NotBlank
    private String name;
    private String img;
    @NotBlank
    @Pattern(regexp = "^[0-9]+$")
    private String mobile;
    @Pattern(regexp = "^[0-9a-zA-Z]{1,16}$")
    private String login;
    private String remarks;
    @Pattern(regexp = "[01]")
    private String sex;
    private String qualifications;
    private String qq;
    private String email;
    private String password;

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getQualifications() {
        return qualifications;
    }

    public void setQualifications(String qualifications) {
        this.qualifications = qualifications;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
