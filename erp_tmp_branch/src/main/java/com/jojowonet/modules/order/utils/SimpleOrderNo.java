package com.jojowonet.modules.order.utils;

public class SimpleOrderNo {
    private String No;
    private Integer S;

    public String getNo() {
        return No;
    }

    public void setNo(String no) {
        No = no;
    }

    public Integer getS() {
        return S;
    }

    public void setS(Integer s) {
        S = s;
    }

    @Override
    public String toString() {
        return "SimpleOrderNo{" +
                "No='" + No + '\'' +
                ", S=" + S +
                '}';
    }
}
