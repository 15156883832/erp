package com.jojowonet.modules.sys.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

import java.util.List;
import java.util.Map;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

@Component
public class JedisCacheService implements SfCacheService {

    private final ScheduledExecutorService threadPool;
    @Autowired
    JedisPool jedisPool;

    JedisCacheService() {
        this.threadPool = Executors.newScheduledThreadPool(2);
    }

    @Override
    public String set(String key, String value) {
        try (Jedis jedis = this.jedisPool.getResource()) {
            return jedis.set(key, value);
        }
    }

    @Override
    public String setex(String key, int seconds, String value) {
        try (Jedis jedis = this.jedisPool.getResource()) {
            return jedis.setex(key, seconds, value);
        }
    }

    @Override
    public Long decr(String key) {
        try (Jedis jedis = this.jedisPool.getResource()) {
            return jedis.decr(key);
        }
    }

    @Override
    public String get(String key) {
        try (Jedis jedis = this.jedisPool.getResource()) {
            return jedis.get(key);
        }
    }

    @Override
    public List<String> mget(String... keys) {
        try (Jedis jedis = this.jedisPool.getResource()) {
            return jedis.mget(keys);
        }
    }

    @Override
    public Long exists(String... keys) {
        try (Jedis jedis = this.jedisPool.getResource()) {
            return jedis.exists(keys);
        }
    }

    @Override
    public Long del(String... keys) {
        try (Jedis jedis = this.jedisPool.getResource()) {
            return jedis.del(keys);
        }
    }

    @Override
    public String hmset(String key, Map<String, String> hash) {
        try (Jedis jedis = this.jedisPool.getResource()) {
            return jedis.hmset(key, hash);
        }
    }

    @Override
    public List<String> hmget(String key, String... fields) {
        try (Jedis jedis = this.jedisPool.getResource()) {
            return jedis.hmget(key, fields);
        }
    }

    @Override
    public Boolean hexists(String key, String field) {
        try (Jedis jedis = this.jedisPool.getResource()) {
            return jedis.hexists(key, field);
        }
    }

    @Override
    public Long hset(String key, String field, String value) {
        try (Jedis jedis = this.jedisPool.getResource()) {
            return jedis.hset(key, field, value);
        }
    }

    @Override
    public String hget(String key, String field) {
        try (Jedis jedis = this.jedisPool.getResource()) {
            return jedis.hget(key, field);
        }
    }

    @Override
    public Long hdel(String key, String... fields) {
        try (Jedis jedis = this.jedisPool.getResource()) {
            return jedis.hdel(key, fields);
        }
    }

    @Override
    public void hdelDelay(final String key, int delaySeconds, final String... fields) {
        threadPool.schedule(new Runnable() {
            @Override
            public void run() {
                hdel(key, fields);
            }
        }, delaySeconds, TimeUnit.SECONDS);
    }

    @Override
    public void delDelay(int delaySeconds, final String... keys) {
        threadPool.schedule(new Runnable() {
            @Override
            public void run() {
                del(keys);
            }
        }, delaySeconds, TimeUnit.SECONDS);
    }

    @Override
    public void delayed(Runnable action, int sec) {
        threadPool.schedule(action, sec, TimeUnit.SECONDS);
    }
}
