package com.jojowonet.modules.sys.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import ivan.common.config.Global;
import ivan.common.utils.UserUtils;

/**
 * 
 * @author billtsang
 *
 */
public class LogintHelper {
	Map<String, String> parameter = new HashMap<String, String>();
	HttpServletResponse response;
	
//	public static final String SF_HELP_URL = "http://192.168.2.129:8280/order/a/login";
	public static final String SF_HELP_URL = Global.getConfig("sended.helper.interface.url");

	public LogintHelper(HttpServletResponse response) {
		this.response = response;
		this.setParameter("username", UserUtils.getUser().getLoginName());
		this.setParameter("password", "SFUnifiedCipher!");
	}

	public void setParameter(String key, String value) {
		this.parameter.put(key, value);
	}

	/**
	 *跳转到思方帮手系统 
	 */
	public void goSFHelper() throws IOException {
		sendByPost(SF_HELP_URL);
	}
	
	public void sendByPost(String url) throws IOException {
		this.response.setContentType("text/html");
		PrintWriter out = this.response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println(" <HEAD><TITLE>sender</TITLE></HEAD>");
		out.println(" <BODY>");
		out.println("<form name=\"submitForm\" action=\"" + url + "\" method=\"post\">");
		Iterator<String> it = this.parameter.keySet().iterator();
		while (it.hasNext()) {
			String key = it.next();
			out.println("<input type=\"hidden\" name=\"" + key + "\" value=\"" + this.parameter.get(key) + "\"/>");
		}
		out.println("</from>");
		out.println("<script>window.document.submitForm.submit();</script> ");
		out.println(" </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();

	}
}
