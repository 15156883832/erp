package com.jojowonet.modules.unipay.alipay;

import com.jojowonet.modules.unipay.core.AsyncPayNotifyParser;
import com.jojowonet.modules.unipay.core.NotifyHandler;

import javax.servlet.http.HttpServletRequest;

/**
 * @author gaols
 */
public class AlipayNotifyHandler implements NotifyHandler {
    @Override
    public String generateResult(boolean handleResult) {
        return handleResult ? "SUCCESS" : "FAIL";
    }

    @Override
    public AsyncPayNotifyParser getPayNotifyParser(HttpServletRequest request) {
        return new AlipayAsyncPayNotifyParser(request);
    }
}
