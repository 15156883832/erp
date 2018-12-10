package com.jojowonet.modules.unipay.weixin;

import com.jojowonet.modules.unipay.core.AsyncPayNotifyParser;
import com.jojowonet.modules.unipay.utils.ParaUtils;
import com.jojowonet.modules.unipay.utils.sign.WxSignCheckUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import weixin.popular.util.StreamUtils;
import weixin.popular.util.XMLConverUtil;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.Collections;
import java.util.Map;

/**
 * @author gaols
 */
public class WxAsyncPayNotifyParser implements AsyncPayNotifyParser {

    private final Map<String, String> parasMap;
    private static final Log logger = LogFactory.getLog(WxAsyncPayNotifyParser.class);

    @Override
    public boolean isSuccess() {
        String resultCode = parasMap.get("result_code");
        return "SUCCESS".equals(resultCode);
    }

    @Override
    public boolean isSignValid() {
        return WxSignCheckUtils.signCheck(parasMap, Configs.getPartnerKey());
    }

    @Override
    public Map<String, String> getNotifyParasMap() {
        return parasMap;
    }

    public WxAsyncPayNotifyParser(HttpServletRequest request) {
        try {
            String xmlData = StreamUtils.copyToString(request.getInputStream(), Charset.forName("UTF-8"));
            logger.error("wx pay notify xml:\n" + xmlData);
            Map<String, String> mapData = XMLConverUtil.convertToMap(xmlData);
            this.parasMap = Collections.unmodifiableMap(mapData);
            logParas(parasMap);
        } catch (IOException ex) {
            throw new RuntimeException(ex);
        }
    }

    private void logParas(Map<String, String> parasMap) {
        logger.error(ParaUtils.formatParas(parasMap, "\nWeixin Notify:")); // error here means important.
    }
}
