package com.jojowonet.modules.unipay.utils.sign;

import weixin.popular.util.SignatureUtil;
import weixin.popular.util.StreamUtils;
import weixin.popular.util.XMLConverUtil;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.Map;

public class WxSignCheckUtils {
    /**
     * Weixin sign check
     *
     * @param request http request.
     * @return true if check passed, false otherwise.
     */
    public static boolean signCheck(HttpServletRequest request, String key) {
        try {
            String xmlData = StreamUtils.copyToString(request.getInputStream(), Charset.forName("UTF-8"));
            Map<String, String> mapData = XMLConverUtil.convertToMap(xmlData);
            return signCheck(mapData, key);
        } catch (IOException ex) {
            throw new RuntimeException(ex);
        }
    }

    public static boolean signCheck(Map<String, String> paras, String key) {
        return SignatureUtil.validateSign(paras, key);
    }
}
