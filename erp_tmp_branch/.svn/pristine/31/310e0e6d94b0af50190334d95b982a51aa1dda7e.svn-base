package com.jojowonet.modules.unipay.core;

import javax.servlet.http.HttpServletRequest;

public interface NotifyHandler {
    /**
     * 返回给微信或者支付宝的处理结果。
     * @param handleResult true if successfully handled, false otherwise.
     */
    String generateResult(boolean handleResult);

    AsyncPayNotifyParser getPayNotifyParser(HttpServletRequest request);
}
