package com.jojowonet.modules.order.utils;

public class Tuple<T, E> {
    private final T val1;
    private final E val2;

    public Tuple(T t, E e) {
        this.val1 = t;
        this.val2 = e;
    }

    public T getVal1() {
        return val1;
    }

    public E getVal2() {
        return val2;
    }
}
