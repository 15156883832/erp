package com.jojowonet.modules.sys.web;

import com.jojowonet.modules.sys.util.care.ActionStat;
import com.jojowonet.modules.sys.util.care.ActionStatsWorker;
import com.jojowonet.modules.sys.util.care.site.SiteDailyRecorder;
import ivan.common.entity.mysql.common.User;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * Created by Administrator on 2018/2/23.
 */
@Controller
@RequestMapping(value = "${adminPath}/main/ac")
public class ActionStatsController extends BaseController {

    @Autowired
    private ActionStatsWorker actionStatsWorker;

    @Autowired
    private SiteDailyRecorder siteDailyRecorder;

    @RequestMapping("countlist")
    public String countlist(HttpServletRequest request, HttpServletResponse response, Model model) {
        User user = UserUtils.getUser();
        Map<String, ActionStat> map = isLegalUser(user) ? actionStatsWorker.getActionStats() : new HashMap<String, ActionStat>();
        model.addAttribute("actionmap", map);
        model.addAttribute("sites", siteDailyRecorder.getActiveSites());
        return "modules/sys/actionStatsList";
    }

    @RequestMapping("statlist")
    public String statlist(HttpServletRequest request, HttpServletResponse response, Model model) {
        int[] span = getStatsSpan(request);
        User user = UserUtils.getUser();
        List<ActionStat> stats = isLegalUser(user) ? actionStatsWorker.getActionStats(span[0], span[1]) : new ArrayList<ActionStat>();

        String sort = request.getParameter("sort");
        if (StringUtils.isBlank(sort)) {
            //sort by invoke times by default
            Collections.sort(stats, new Comparator<ActionStat>() {
                @Override
                public int compare(ActionStat o1, ActionStat o2) {
                    long diff = o2.getInvokeTimesBetweens() - o1.getInvokeTimesBetweens();
                    if (diff == 0) {
                        return 0;
                    }
                    return diff > 0 ? 1 : -1;
                }
            });
            model.addAttribute("tab", "i");
        } else {
            //sort by avg times
            Collections.sort(stats, new Comparator<ActionStat>() {
                @Override
                public int compare(ActionStat o1, ActionStat o2) {
                    double diff = o2.getAvgTimeCostBetweens() - o1.getAvgTimeCostBetweens();
                    if (diff == 0) {
                        return 0;
                    }
                    return diff > 0 ? 1 : -1;
                }
            });
            model.addAttribute("tab", "a");
        }

        String slow = request.getParameter("slow");
        if (slow != null) {
            model.addAttribute("tab", "s");
            stats = filterSlow(stats, slow);
        }

        model.addAttribute("list", stats);
        model.addAttribute("sites", siteDailyRecorder.getActiveSites());
        return "modules/sys/actionStatsOverview";
    }

    private List<ActionStat> filterSlow(List<ActionStat> stats, String timesStr) {
        if (StringUtils.isBlank(timesStr)) {
            timesStr = "200";
        }
        Integer slowTimes = Integer.valueOf(timesStr);
        List<ActionStat> slow = new ArrayList<>();
        for (ActionStat s : stats) {
            if (s.getInvokeTimesBetweens() >= slowTimes && s.getAvgTimeCostBetweens() >= 180) {
                slow.add(s);
            }
        }
        return slow;
    }

    @RequestMapping("countmap")
    public String countmap(HttpServletRequest request, HttpServletResponse response, Model model) {
        int[] span = getStatsSpan(request);
        User user = UserUtils.getUser();
        List<ActionStat> map = isLegalUser(user) ? actionStatsWorker.getActionStats(span[0], span[1]) : new ArrayList<ActionStat>();
        model.addAttribute("countmap", map);
        model.addAttribute("sites", siteDailyRecorder.getActiveSites());
        return "modules/sys/actionStatsMap";
    }

    private static boolean isLegalUser(User user) {
        //线上15655445653账号
//        return "ff8080815d86ba2b015d8c4f6dfa0016".equals(user.getId()) || "40000011111222223333344444555556".equals(user.getId());
        return true;
    }

    public int[] getStatsSpan(HttpServletRequest request) {
        String span = StringUtils.defaultString(request.getParameter("s"), "0,24");
        String[] parts = span.split(",");
        int start = 0;
        int end = 24;
        if (parts.length == 1) {
            start = Integer.valueOf(parts[0]);
            end = start + 1;
        } else if (parts.length > 1) {
            start = Integer.valueOf(parts[0]);
            end = Integer.valueOf(parts[1]);
        }
        return new int[]{start, end};
    }
}
