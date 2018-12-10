package com.jojowonet.modules.unipay.utils.sign;

import com.alipay.api.AlipayApiException;
import com.alipay.api.internal.util.AlipaySignature;
import com.alipay.demo.trade.config.Configs;
import com.jojowonet.modules.unipay.utils.ParaUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public class AlipaySignCheckUtils {

    private static final Log logger = LogFactory.getLog(AlipaySignCheckUtils.class);

    /**
     * sign check based on rsa algorithm
     *
     * @param request http request.
     * @return true if check passed, false otherwise.
     */
    public static boolean rsaSignCheck(HttpServletRequest request) {
        Map originalParasMap = request.getParameterMap();
        Map<String, String> parasMap = ParaUtils.getParasMap(originalParasMap);
        return rsaSignCheck(parasMap);
    }

    public static boolean rsaSignCheck(Map<String, String> paras) {
        try {
            return AlipaySignature.rsaCheckV1(paras, Configs.getAlipayPublicKey(), "UTF-8", Configs.getSignType());
        } catch (AlipayApiException e) {
            logger.error("sign check failed", e);
            throw new RuntimeException(e);
        }
    }
}
