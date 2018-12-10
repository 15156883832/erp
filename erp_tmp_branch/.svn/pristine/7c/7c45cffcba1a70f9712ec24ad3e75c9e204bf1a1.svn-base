package com.jojowonet.modules.operate.web;

import com.jojowonet.modules.operate.dao.UserCustomDao;
import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.order.utils.StringUtil;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("${adminPath}/user_custom")
public class UserCustomController extends BaseController {

    @Autowired
    UserCustomDao userCustomDao;

    @RequestMapping("skin")
    public Result<Void> setSkin(HttpServletRequest request) {
        String skin = request.getParameter("skin");
        if (StringUtil.isBlank(skin)) {
            return Result.fail("missing skin");
        }
        userCustomDao.updateSkin(UserUtils.getUser().getId(), skin);
        request.getSession().setAttribute("skin", skin);
        return Result.ok();
    }
}
