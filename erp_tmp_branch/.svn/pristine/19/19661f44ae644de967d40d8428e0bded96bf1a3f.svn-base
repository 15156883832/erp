package com.jojowonet.modules.sys.tag;

import com.jojowonet.modules.sys.util.AuthUtils;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;

public class HasPermissionTag extends SimpleTagSupport {
    private String perm;

    public String getPerm() {
        return perm;
    }

    public void setPerm(String perm) {
        this.perm = perm;
    }

    @Override
    public void doTag() throws JspException, IOException {
        if (AuthUtils.checkPagePermission(null, this.perm)) {
            getJspBody().invoke(null);
        }
    }
}
