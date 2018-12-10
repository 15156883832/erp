package com.jojowonet.modules.sys.util;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;

import com.google.common.collect.Maps;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fmss.utils.HttpUtils;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.SFIMCache;
import com.jojowonet.modules.sys.entity.SystemMenuRule;

import ivan.common.config.Global;
import ivan.common.entity.mysql.common.Menu;
import ivan.common.entity.mysql.common.User;
import ivan.common.utils.UserUtils;

public class SFUserUtils extends UserUtils {

    public static List<SfMenu> getMenuListL2() {
        List<Menu> userAvailMenu = getMenuList();
        List<SfMenu> sfMenus = new ArrayList<>();
        User user = UserUtils.getUser();
        String[] userPermissions = getUserPermissions(user);
        filterL1SiteOnlyMenus(userAvailMenu, user, userPermissions);
        filterL2SiteOnlyMenus(userAvailMenu, user, userPermissions);
        filterMicroFactoryMenus(userAvailMenu, user, userPermissions);
        ShoppingMllSiteOnlyMenus(userAvailMenu, user, userPermissions);

        for (Menu m : userAvailMenu) {
            if (isTopVisibleMenu(m)) {
                SfMenu sfMenu = new SfMenu(m);
                sfMenus.add(sfMenu);
                fillL2Menu(sfMenu, userAvailMenu, user); // 根据不同的userType, 给sfMenu设值二级菜单。
            }
        }
        return sfMenus;
    }

    @SuppressWarnings("unchecked")
    private static void filterMicroFactoryMenus(List<Menu> userAvailMenu, User user, String[] userPermissions) {
        Map<String, Map<String, Record>> factoryMenuMap = (Map<String, Map<String, Record>>) SFIMCache.get("micro_factory_binding_menu");
        if (factoryMenuMap == null) {
            throw new RuntimeException("read cache error");
        }
        Set<String> bindingFactorys = CrmUtils.getUserBindingFactorys(user);
        Set<String> availFactoryMenus = new HashSet<>(); // common factory menus + 绑定厂家的相应菜单
        Map<String, Record> allFactoryMenus = factoryMenuMap.get("all");
        for (String fid : bindingFactorys) {
            Map<String, Record> menus = factoryMenuMap.get(fid);
            if (menus != null) {
                availFactoryMenus.addAll(menus.keySet());
            }
        }
        if (bindingFactorys.size() > 0) {
            availFactoryMenus.addAll(factoryMenuMap.get("common").keySet());
        }
        Iterator<Menu> iterator = userAvailMenu.iterator();
        while (iterator.hasNext()) {
            Menu menu = iterator.next();
            if (allFactoryMenus.containsKey(menu.getId())) {//小厂家权限
                if (!availFactoryMenus.contains(menu.getId())) {
                    iterator.remove();
                }
            }
        }
    }

    @SuppressWarnings("unchecked")
    private static void ShoppingMllSiteOnlyMenus(List<Menu> userAvailMenu, User user, String[] userPermissions) {
        Map<String, Record> map = (Map<String, Record>) SFIMCache.get("SF-MALL");
        if (map == null) {
            throw new RuntimeException("read cache error");
        }
      
        String siteId = CrmUtils.getCurrentSiteId(user);
        if(StringUtils.isNotBlank(siteId)) {
        	//查询判断当前服务商是否绑定经销商
        	boolean sitecke = getCheckSiteId(siteId);
        	/*if("40000011111222223333344444555556".equals(user.getId())) {
        		sitecke = true;
        	}*/
        	Iterator<Menu> iterator = userAvailMenu.iterator();
        	while (iterator.hasNext()) {
        		Menu menu = iterator.next();
        		if ("2".equals(user.getUserType())) {
        			//  if (map.containsKey(menu.getId()) && !CrmUtils.isL1Site(user)) {
        			if (map.containsKey(menu.getId()) && !sitecke) {
        				iterator.remove();
        			}
        		} else if ("3".equals(user.getUserType())) {
        			if (!hasPermission(menu.getId(), userPermissions) || map.containsKey(menu.getId()) && !CrmUtils.isL1SitePCUser(user)) {
        				iterator.remove();
        			}
        		}
        	}
        	
        }
    }
    @SuppressWarnings("unchecked")
    private static void filterL1SiteOnlyMenus(List<Menu> userAvailMenu, User user, String[] userPermissions) {
    	Map<String, Record> map = (Map<String, Record>) SFIMCache.get("L1SITE");
    	if (map == null) {
    		throw new RuntimeException("read cache error");
    	}
    	Iterator<Menu> iterator = userAvailMenu.iterator();
    	while (iterator.hasNext()) {
    		Menu menu = iterator.next();
    		if ("2".equals(user.getUserType())) {
    			if (map.containsKey(menu.getId()) && !CrmUtils.isL1Site(user)) {
    				iterator.remove();
    			}
    		} else if ("3".equals(user.getUserType())) {
    			if (!hasPermission(menu.getId(), userPermissions) || map.containsKey(menu.getId()) && !CrmUtils.isL1SitePCUser(user)) {
    				iterator.remove();
    			}
    		}
    	}
    }

    @SuppressWarnings("unchecked")
    private static void filterL2SiteOnlyMenus(List<Menu> userAvailMenu, User user, String[] userPermissions) {
        Map<String, Record> map = (Map<String, Record>) SFIMCache.get("L2SITE");
        if (map == null) {
            throw new RuntimeException("read cache error");
        }
        Iterator<Menu> iterator = userAvailMenu.iterator();
        while (iterator.hasNext()) {
            Menu menu = iterator.next();
            if ("2".equals(user.getUserType())) {
                if (map.containsKey(menu.getId()) && !CrmUtils.isL2Site(user)) {
                    iterator.remove();
                }
            } else if ("3".equals(user.getUserType())) {
                if (!hasPermission(menu.getId(), userPermissions) || map.containsKey(menu.getId()) && !CrmUtils.isL2SitePCUser(user)) {
                    iterator.remove();
                }
            }
        }
    }

    private static void fillL2Menu(SfMenu sfMenu, List<Menu> userAvailableMenu, User user) {
        Menu parent = sfMenu.getMenu();
        String[] perms = getUserPermissions(user);

        for (Menu m : userAvailableMenu) {
            if (isUserOwnsMenu(user, m, parent, perms)) {
                sfMenu.addChild(m);
            }
        }
    }

    private static String[] getUserPermissions(User user) {
        String permission = user.getPermission();
        return StringUtils.isNotBlank(permission) ? permission.split(",") : new String[0];
    }

    private static boolean isUserOwnsMenu(User user, Menu m, Menu topMenu, String[] perms) {
        if (m.getParent() != null && topMenu.getId().equalsIgnoreCase(m.getParent().getId())) {
            if ("1".equals(user.getUserType())) {//system角色的登录人员需要鉴权
                return checkSystemUserPermission(m.getName(), user.getLoginName(), "2");
            }
            if (user.isAdmin() || !"3".equals(user.getUserType())) {
                return true;
            } else if ("3".equals(user.getUserType())) {
                return hasPermission(m.getId(), perms);
            }
        }

        return false;
    }

    private static boolean isTopVisibleMenu(Menu menu) {
        Menu parent = menu.getParent();
        User user = UserUtils.getUser();
        boolean ret = parent != null && "1".equals(parent.getId()) && "1".equals(menu.getIsShow());
        if (!ret) {
            return false;
        }

        if ("3".equals(user.getUserType())) {
            return hasPermission(menu.getId(), getUserPermissions(user));
        } else if ("1".equals(user.getUserType())) {//system角色的登录人员需要鉴权
            return checkSystemUserPermission(menu.getName(), user.getLoginName(), "1");
        }

        return true;
    }

    private static boolean hasPermission(String menuId, String[] permissions) {
        if (permissions == null || permissions.length <= 0) {
            return false;
        }
        for (String perm : permissions) {
            if (menuId.equalsIgnoreCase(perm)) {
                return true;
            }
        }
        return false;
    }

    /**
     * @param menuName 一二级菜单的名称
     * @param userName system角色的login_name
     * @param level    1:一级菜单，２:二级菜单
     */
    private static boolean checkSystemUserPermission(String menuName, String userName, String level) {
        SystemMenuRule smr = AuthUtils.getSysMenuByUserName(userName);
        return smr.isValid(menuName, level);
    }


    public static class SfMenu extends Menu {
        private final Menu menu;
        private List<Menu> children = new ArrayList<>();

        SfMenu(Menu menu) {
            this.menu = menu;
        }

        public Menu getMenu() {
            return menu;
        }

        public List<Menu> getChildren() {
            return children;
        }

        void addChild(Menu menu) {
            children.add(menu);
        }

        public void setChildren(List<Menu> menus) {
            children.addAll(menus);
        }
    }
    
    public static boolean getCheckSiteId(String siteId) {
    	String url = Global.getConfig("sended.marketing.interface.url")+"/getCheckSiteId";
    	Map<String, String> params = Maps.newHashMap();
    	params.put("siteId", siteId);
    	String retStr = HttpUtils.doPost(url, params);
    	
    	Map<String,Long> map =  new Gson().fromJson(retStr, new TypeToken<Map<String,Long>>(){}.getType());
    	System.out.println("ft:<<>>>"+map);
    	if(map != null) {
    		if(map.get("siteckec")>0) {
    			return true; 
    		}
    	}
    	return false;
    	}
    	
}
