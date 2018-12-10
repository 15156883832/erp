package com.jojowonet.modules.order.utils;

import java.util.List;

public class BatchOrderNo {
    private String Msg;
    private Integer Code;
    private List<SimpleOrderNo> Data;

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

    public List<SimpleOrderNo> getData() {
        return Data;
    }

    public void setData(List<SimpleOrderNo> data) {
        Data = data;
    }

    public boolean isValid() {
        return 200 == getCode();
    }

    @Override
    public String toString() {
        return "BatchOrderNo{" +
                "Msg='" + Msg + '\'' +
                ", Code=" + Code +
                ", Data=" + Data +
                '}';
    }
}
