package com.jojowonet.modules.order.utils;

public class Result<T> {
    private T data;
    private String code;
    private String msg;
    private String errMsg;

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

    public static Result<Void> ok(String msg) {
        Result<Void> ok = new Result<>();
        ok.setCode("200");
        ok.setMsg(msg);
        return ok;
    }

    public boolean isOk() {
        return "200".equals(getCode());
    }

    public static Result<Void> ok() {
        return ok("ok");
    }

    public static Result<Void> fail(String msg) {
        Result<Void> fail = new Result<>();
        fail.setCode("500");
        fail.setErrMsg(msg);
        return fail;
    }

    public static Result<Void> fail(String code, String msg) {
        Result<Void> fail = new Result<>();
        fail.setCode(code);
        fail.setErrMsg(msg);
        return fail;
    }

    public Result<T> data(T data) {
        this.data = data;
        return this;
    }
}
