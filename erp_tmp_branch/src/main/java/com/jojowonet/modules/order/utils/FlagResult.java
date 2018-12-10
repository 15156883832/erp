package com.jojowonet.modules.order.utils;

public class FlagResult<T> {
    private T data;
    private String code;
    private String msg;
    private String errMsg;
    private String flag;

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getErrMsg() {
        return errMsg;
    }

    public void setErrMsg(String errMsg) {
        this.errMsg = errMsg;
    }

    public static FlagResult<Void> ok(String msg) {
        FlagResult<Void> ok = new FlagResult<>();
        ok.setCode("200");
        ok.setMsg(msg);
        return ok;
    }

    public boolean isOk() {
        return "200".equals(getCode());
    }

    public static FlagResult<Void> ok() {
        return ok("ok");
    }

    public static FlagResult<Void> fail(String msg) {
        FlagResult<Void> fail = new FlagResult<>();
        fail.setCode("500");
        fail.setErrMsg(msg);
        return fail;
    }

    public static FlagResult<Void> fail(String code, String msg) {
        FlagResult<Void> fail = new FlagResult<>();
        fail.setCode(code);
        fail.setErrMsg(msg);
        return fail;
    }

    public FlagResult<T> data(T data) {
        this.data = data;
        return this;
    }

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }
}