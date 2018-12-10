package com.jojowonet.modules.order.form.vo;

public class EntryItem<T, K> {
    public T key;
    public K value;

    public T getKey() {
        return key;
    }

    public void setKey(T key) {
        this.key = key;
    }

    public K getValue() {
        return value;
    }

    public void setValue(K value) {
        this.value = value;
    }
}
