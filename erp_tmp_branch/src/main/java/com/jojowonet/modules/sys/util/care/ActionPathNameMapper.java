package com.jojowonet.modules.sys.util.care;

public interface ActionPathNameMapper {
    /**
     * @param actionPath action path, may contains context path.
     * @return action name
     */
    String getName(String actionPath);
}
