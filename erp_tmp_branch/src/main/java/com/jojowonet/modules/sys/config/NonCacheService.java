package com.jojowonet.modules.sys.config;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class NonCacheService implements SfCacheService {

    @Override
    public String set(String key, String value) {
        return "";
    }

    @Override
    public String setex(String key, int seconds, String value) {
        return "";
    }

    @Override
    public Long decr(String key) {
        return 0L;
    }

    @Override
    public String get(String key) {
        return null;
    }

    @Override
    public List<String> mget(String... keys) {
        return new ArrayList<>();
    }

    @Override
    public Long exists(String... keys) {
        return 0L;
    }

    @Override
    public Long del(String... keys) {
        return 0L;
    }

    @Override
    public String hmset(String key, Map<String, String> hash) {
        return null;
    }

    @Override
    public List<String> hmget(String key, String... fields) {
        return new ArrayList<>();
    }

    @Override
    public Boolean hexists(String key, String field) {
        return false;
    }

    @Override
    public Long hset(String key, String field, String value) {
        return 0L;
    }

    @Override
    public String hget(String key, String field) {
        return null;
    }

    @Override
    public Long hdel(String key, String... fields) {
        return 0L;
    }

    @Override
    public void hdelDelay(final String key, int delaySeconds, final String... fields) {
    }

    @Override
    public void delDelay(int delaySeconds, final String... keys) {
    }

    @Override
    public void delayed(Runnable action, int sec) {
    }
}
