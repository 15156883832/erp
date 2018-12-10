package com.jojowonet.modules.sys.util.care;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Properties;

@Component
public class PropertiesActionPathNameMapper implements ActionPathNameMapper {

    private static Logger logger = Logger.getLogger(PropertiesActionPathNameMapper.class);
    private Properties p = new Properties();

    public PropertiesActionPathNameMapper() {
        try {
            p.load(getClass().getResourceAsStream("/action.properties"));
        } catch (IOException e) {
            logger.error("load action.properties failed", e);
        }
    }

    @Override
    public String getName(String actionPath) {
        return p.getProperty(actionPath, "");
    }
}
