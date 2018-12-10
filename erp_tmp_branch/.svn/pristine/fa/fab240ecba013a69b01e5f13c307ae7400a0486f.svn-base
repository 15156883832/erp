package com.jojowonet.modules.unipay.alipay;

import com.jojowonet.modules.unipay.core.AsyncPayNotifyParser;
import com.jojowonet.modules.unipay.utils.ParaUtils;
import com.jojowonet.modules.unipay.utils.sign.AlipaySignCheckUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.servlet.http.HttpServletRequest;
import java.util.Collections;
import java.util.Map;

/**
 * https://docs.open.alipay.com/194/103296/
 *
 * @author gaols
 */
public class AlipayAsyncPayNotifyParser implements AsyncPayNotifyParser {

    private final Map<String, String> parasMap;
    private final Map<String, String> originalParasMap;
    private static final Log logger = LogFactory.getLog(AlipayAsyncPayNotifyParser.class);

    @Override
    public boolean isSuccess() {
        String status = parasMap.get("trade_status");
        return "TRADE_SUCCESS".equals(status) || "TRADE_FINISHED".equals(status);
    }

    @Override
    public boolean isSignValid() {
        return AlipaySignCheckUtils.rsaSignCheck(originalParasMap);
    }

    @Override
    public Map<String, String> getNotifyParasMap() {
        return this.parasMap;
    }

    public AlipayAsyncPayNotifyParser(HttpServletRequest request) {
        Map map = request.getParameterMap();
        this.originalParasMap = ParaUtils.getParasMap(map);
        this.parasMap = Collections.unmodifiableMap(originalParasMap);
        logParas(parasMap);
    }

    private void logParas(Map<String, String> parasMap) {
        logger.error(ParaUtils.formatParas(parasMap, "\nAlipay Notify:")); // error here means important.
    }
}
