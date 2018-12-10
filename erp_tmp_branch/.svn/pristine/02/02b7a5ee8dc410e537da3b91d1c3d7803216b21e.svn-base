package com.jojowonet.modules.order.form;

import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class ResetPwdBySmsForm {
    @NotNull
    private String mobile;
    @NotEmpty
    private String code;
    @NotNull
    @Size(min = 6, max = 16)
    private String password;
    @NotNull
    @Size(min = 6, max = 16)
    private String passwordConfirmation;

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPasswordConfirmation() {
        return passwordConfirmation;
    }

    public void setPasswordConfirmation(String passwordConfirmation) {
        this.passwordConfirmation = passwordConfirmation;
    }
}
