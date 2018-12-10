package com.jojowonet.modules.sys.util.care;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.NamedThreadLocal;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ActionInterceptor implements HandlerInterceptor {

    private final ActionAnalytics actionAnalytics;
    private NamedThreadLocal<Long> preHandleTimeHolder = new NamedThreadLocal<>("Watch");
    private NamedThreadLocal<Long> postHandleTimeHolder = new NamedThreadLocal<>("Watch-2");

    @Autowired
    public ActionInterceptor(ActionAnalytics actionAnalytics) {
        this.actionAnalytics = actionAnalytics;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        preHandleTimeHolder.set(System.currentTimeMillis());
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        postHandleTimeHolder.set(System.currentTimeMillis());
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        long handleTime = postHandleTimeHolder.get() - preHandleTimeHolder.get();
        long renderTime = System.currentTimeMillis() - preHandleTimeHolder.get();
        boolean hasEx = ex != null;
        actionAnalytics.actionPerformed(request.getRequestURI(), preHandleTimeHolder.get(), handleTime, renderTime, hasEx);
    }

}
