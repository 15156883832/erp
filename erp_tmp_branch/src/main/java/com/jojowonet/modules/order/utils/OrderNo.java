package com.jojowonet.modules.order.utils;

public class OrderNo {
    private String Data;
    private String Msg;
    private Integer Code;
    private Integer Seq;

    public String getData() {
        return Data;
    }

    public void setData(String data) {
        Data = data;
    }

    public String getMsg() {
        return Msg;
    }

    public void setMsg(String msg) {
        Msg = msg;
    }

    public Integer getCode() {
        return Code;
    }

    public void setCode(Integer code) {
        Code = code;
    }

    public Integer getSeq() {
        return Seq;
    }

    public void setSeq(Integer seq) {
        Seq = seq;
    }

    public boolean isValid() {
        return 200 == getCode();
    }
}
