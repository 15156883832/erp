package com.jojowonet.modules.sys.util;

import org.apache.commons.lang.StringUtils;

import java.util.Collection;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;

/**
 * @author gaols
 */
public class TrimMap implements Map<String, Object> {

    private final Map<String, Object> internalMap;
    private boolean safe = true;
    private static final Pattern UNSAFE_MATCHER = Pattern.compile("[%']");

    public TrimMap(Map<String, Object> internalMap) {
        this(internalMap, true);
    }

    public TrimMap(Map<String, Object> internalMap, boolean safe) {
        this.internalMap = internalMap;
        this.safe = safe;
    }

    @Override
    public int size() {
        return internalMap.size();
    }

    @Override
    public boolean isEmpty() {
        return internalMap.isEmpty();
    }

    @Override
    public boolean containsKey(Object key) {
        return internalMap.containsKey(key);
    }

    @Override
    public boolean containsValue(Object value) {
        return internalMap.containsValue(value);
    }

    @Override
    public Object get(Object key) {
        Object o = internalMap.get(key);
        if (!(o instanceof String)) {
            return o;
        }
        String ret  = StringUtils.trim((String) o);
        return safe ? UNSAFE_MATCHER.matcher(ret).replaceAll("") : ret;
    }

    @Override
    public Object put(String key, Object value) {
        return internalMap.put(key, value);
    }

    @Override
    public Object remove(Object key) {
        return internalMap.remove(key);
    }

    @Override
    public void putAll(Map<? extends String, ?> m) {
        internalMap.putAll(m);
    }

    @Override
    public void clear() {
        internalMap.clear();
    }

    @Override
    public Set<String> keySet() {
        return internalMap.keySet();
    }

    @Override
    public Collection<Object> values() {
        return internalMap.values();
    }

    @Override
    public Set<Entry<String, Object>> entrySet() {
        return internalMap.entrySet();
    }

    public TrimMap safe() {
        safe = true;
        return this;
    }

}
