package com.jojowonet.modules.order.utils;

import java.util.ArrayList;
import java.util.List;

public class Area<T> {
    private String name;
    private List<T> managers = new ArrayList<>();
    private int managersCount;
    private boolean isMultipleManagers;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<T> getManagers() {
        return managers;
    }

    public void setManagers(List<T> managers) {
        this.managers = managers;
    }

    public int getManagersCount() {
        return managers == null ? 0 : managers.size();
    }

    public void setManagersCount(int managersCount) {
        this.managersCount = managersCount;
    }

    public boolean isMultipleManagers() {
        return managers != null && managers.size() > 1;
    }

    public void setMultipleManagers(boolean multipleManagers) {
        isMultipleManagers = multipleManagers;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Area<?> area = (Area<?>) o;

        return name.equals(area.name);
    }

    @Override
    public int hashCode() {
        return name.hashCode();
    }
}
