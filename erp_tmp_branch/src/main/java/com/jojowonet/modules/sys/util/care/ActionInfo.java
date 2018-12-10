package com.jojowonet.modules.sys.util.care;

/**
 * renderConsumed := performConsumed + render_time
 */
public class ActionInfo {
    private String actionPath;
    /**
     * time millions when action get performed
     */
    private Long performAt;
    private Long performConsumed;
    private Long renderConsumed;
    private boolean hasEx;

    public String getActionPath() {
        return actionPath;
    }

    public void setActionPath(String actionPath) {
        this.actionPath = actionPath;
    }

    public Long getPerformConsumed() {
        return performConsumed;
    }

    public void setPerformConsumed(Long performConsumed) {
        this.performConsumed = performConsumed;
    }

    public Long getRenderConsumed() {
        return renderConsumed;
    }

    public void setRenderConsumed(Long renderConsumed) {
        this.renderConsumed = renderConsumed;
    }


    public Long getPerformAt() {
        return performAt;
    }

    public void setPerformAt(Long performAt) {
        this.performAt = performAt;
    }

    public boolean isHasEx() {
        return hasEx;
    }

    public void setHasEx(boolean hasEx) {
        this.hasEx = hasEx;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ActionInfo that = (ActionInfo) o;
        return actionPath != null ? actionPath.equals(that.actionPath) : that.actionPath == null;
    }

    @Override
    public int hashCode() {
        return actionPath != null ? actionPath.hashCode() : 0;
    }

    @Override
    public String toString() {
        return "ActionInfo{" +
                "actionPath='" + actionPath + '\'' +
                ", performAt=" + performAt +
                ", performConsumed=" + performConsumed +
                ", renderConsumed=" + renderConsumed +
                '}';
    }
}
