package com.jojowonet.modules.sys.config;

import java.util.List;
import java.util.Map;

/**
 * @author gaols
 */
public interface SfCacheService {

    String set(String key, String value);

    String setex(String key, int seconds, String value);

    Long decr(String key);

    String get(String key);

    List<String> mget(final String... keys);

    Long exists(String... keys);

    Long del(String... keys);

    String hmset(String key, Map<String, String> hash);

    List<String> hmget(String key, String... fields);

    Boolean hexists(String key, String field);

    Long hset(final String key, final String field, final String value);

    String hget(final String key, final String field);

    Long hdel(final String key, final String... fields);

    void hdelDelay(final String key, int delaySeconds, final String... fields);

    void delDelay(int delaySeconds, final String... keys);

    void delayed(final Runnable action, final int sec);
}
