package com.jojowonet.modules.sys.util;

import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.CPI;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;

import java.lang.reflect.Method;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

public class SfJsonKit {

    private static int convertDepth = 8;
    private String timestampPattern = "yyyy-MM-dd HH:mm:ss";
    private String datePattern = "yyyy-MM-dd";

    public SfJsonKit(String datePattern) {
        this.datePattern = datePattern;
    }

    public static void setConvertDepth(int convertDepth) {
        if (convertDepth < 2) {
            throw new IllegalArgumentException("convert depth can not less than 2.");
        } else {
            convertDepth = convertDepth;
        }
    }

    public static void setTimestampPattern(String timestampPattern) {
        if (timestampPattern != null && !"".equals(timestampPattern.trim())) {
            timestampPattern = timestampPattern;
        } else {
            throw new IllegalArgumentException("timestampPattern can not be blank.");
        }
    }

    public void setDatePattern(String datePattern) {
        if (datePattern != null && !"".equals(datePattern.trim())) {
            datePattern = datePattern;
        } else {
            throw new IllegalArgumentException("datePattern can not be blank.");
        }
    }

    public String mapToJson(Map map, int depth) {
        if (map == null) {
            return "null";
        } else {
            StringBuilder sb = new StringBuilder();
            boolean first = true;
            Iterator iter = map.entrySet().iterator();
            sb.append('{');

            while (iter.hasNext()) {
                if (first) {
                    first = false;
                } else {
                    sb.append(',');
                }

                Map.Entry entry = (Map.Entry) iter.next();
                toKeyValue(String.valueOf(entry.getKey()), entry.getValue(), sb, depth);
            }

            sb.append('}');
            return sb.toString();
        }
    }

    private String toKeyValue(String key, Object value, StringBuilder sb, int depth) {
        sb.append('"');
        if (key == null) {
            sb.append("null");
        } else {
            escape(key, sb);
        }

        sb.append('"').append(':');
        sb.append(toJson(value, depth));
        return sb.toString();
    }

    public String listToJson(List list, int depth) {
        if (list == null) {
            return "null";
        } else {
            boolean first = true;
            StringBuilder sb = new StringBuilder();
            Iterator iter = list.iterator();
            sb.append('[');

            while (iter.hasNext()) {
                if (first) {
                    first = false;
                } else {
                    sb.append(',');
                }

                Object value = iter.next();
                if (value == null) {
                    sb.append("null");
                } else {
                    sb.append(toJson(value, depth));
                }
            }

            sb.append(']');
            return sb.toString();
        }
    }

    private String escape(String s) {
        if (s == null) {
            return null;
        } else {
            StringBuilder sb = new StringBuilder();
            escape(s, sb);
            return sb.toString();
        }
    }

    private void escape(String s, StringBuilder sb) {
        for (int i = 0; i < s.length(); ++i) {
            char ch = s.charAt(i);
            switch (ch) {
                case '\b':
                    sb.append("\\b");
                    continue;
                case '\t':
                    sb.append("\\t");
                    continue;
                case '\n':
                    sb.append("\\n");
                    continue;
                case '\f':
                    sb.append("\\f");
                    continue;
                case '\r':
                    sb.append("\\r");
                    continue;
                case '"':
                    sb.append("\\\"");
                    continue;
                case '/':
                    sb.append("\\/");
                    continue;
                case '\\':
                    sb.append("\\\\");
                    continue;
            }

            if (ch >= 0 && ch <= 31 || ch >= 127 && ch <= 159 || ch >= 8192 && ch <= 8447) {
                String str = Integer.toHexString(ch);
                sb.append("\\u");

                for (int k = 0; k < 4 - str.length(); ++k) {
                    sb.append('0');
                }

                sb.append(str.toUpperCase());
            } else {
                sb.append(ch);
            }
        }

    }

    public String toJson(Object value) {
        return toJson(value, convertDepth);
    }

    public String toJson(Object value, int depth) {
        if (value != null && depth-- >= 0) {
            if (value instanceof String) {
                return "\"" + escape((String) value) + "\"";
            } else if (value instanceof Double) {
                return !((Double) value).isInfinite() && !((Double) value).isNaN() ? value.toString() : "null";
            } else if (value instanceof Float) {
                return !((Float) value).isInfinite() && !((Float) value).isNaN() ? value.toString() : "null";
            } else if (value instanceof Number) {
                return value.toString();
            } else if (value instanceof Boolean) {
                return value.toString();
            } else if (value instanceof Date) {
                if (value instanceof Timestamp) {
                    return "\"" + (new SimpleDateFormat(timestampPattern)).format(value) + "\"";
                } else {
                    return value instanceof Time ? "\"" + value.toString() + "\"" : "\"" + (new SimpleDateFormat(datePattern)).format(value) + "\"";
                }
            } else if (value instanceof Map) {
                return mapToJson((Map) value, depth);
            } else if (value instanceof List) {
                return listToJson((List) value, depth);
            } else {
                String result = otherToJson(value, depth);
                return result != null ? result : "\"" + escape(value.toString()) + "\"";
            }
        } else {
            return "null";
        }
    }

    private String otherToJson(Object value, int depth) {
        if (value instanceof Character) {
            return "\"" + escape(value.toString()) + "\"";
        } else {
            Map map;
            if (value instanceof Model) {
                map = CPI.getAttrs((Model) value);
                return mapToJson(map, depth);
            } else if (value instanceof Record) {
                map = ((Record) value).getColumns();
                return mapToJson(map, depth);
            } else if (!(value instanceof Object[])) {
                return value instanceof Enum ? "\"" + ((Enum) value).name() + "\"" : beanToJson(value, depth);
            } else {
                Object[] arr = (Object[]) value;
                List list = new ArrayList(arr.length);

                for (int i = 0; i < arr.length; ++i) {
                    list.add(arr[i]);
                }

                return listToJson(list, depth);
            }
        }
    }

    private String beanToJson(Object model, int depth) {
        Map map = new HashMap();
        Method[] methods = model.getClass().getMethods();
        Method[] var7 = methods;
        int var6 = methods.length;

        for (int var5 = 0; var5 < var6; ++var5) {
            Method m = var7[var5];
            String methodName = m.getName();
            int indexOfGet = methodName.indexOf("get");
            if (indexOfGet == 0 && methodName.length() > 3) {
                String attrName = methodName.substring(3);
                if (!attrName.equals("Class")) {
                    Class[] types = m.getParameterTypes();
                    if (types.length == 0) {
                        try {
                            Object value = m.invoke(model);
                            map.put(StrKit.firstCharToLowerCase(attrName), value);
                        } catch (Exception var14) {
                            throw new RuntimeException(var14.getMessage(), var14);
                        }
                    }
                }
            } else {
                int indexOfIs = methodName.indexOf("is");
                if (indexOfIs == 0 && methodName.length() > 2) {
                    String attrName = methodName.substring(2);
                    Class[] types = m.getParameterTypes();
                    if (types.length == 0) {
                        try {
                            Object value = m.invoke(model);
                            map.put(StrKit.firstCharToLowerCase(attrName), value);
                        } catch (Exception var15) {
                            throw new RuntimeException(var15.getMessage(), var15);
                        }
                    }
                }
            }
        }

        return mapToJson(map, depth);
    }
}
