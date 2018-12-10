package com.jojowonet.modules.order.utils;

import com.google.common.base.Ticker;
import com.google.common.cache.Cache;
import com.google.common.cache.CacheBuilder;
import org.apache.log4j.Logger;

import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;

public abstract class SimpleCache<T> {

    private final Cache<Object, Object> cacheImpl;
    private static Logger logger = Logger.getLogger(SimpleCache.class);

    protected SimpleCache() {
        this.cacheImpl = CacheBuilder.newBuilder()
                .maximumSize(cacheSize())
                .ticker(Ticker.systemTicker())
                .expireAfterWrite(expireHour(), TimeUnit.HOURS)
                .build();
    }

    protected int cacheSize() {
        return 10000;
    }

    protected int expireHour() {
        return 1;
    }

    @SuppressWarnings("unchecked")
    public T get(final String key) {
        try {
            Object ret = this.cacheImpl.get(key, new Callable<T>() {
                @Override
                public T call() throws Exception {
                    return getCacheObject(key);
                }
            });
            if (ret == null) {
                logger.info("-> missing cache key:" + key);
                invalidate(key);
                ret = getCacheObject(key);
            }
            return (T) ret;
        } catch (ExecutionException e) {
            throw new RuntimeException(e);
        }
    }

    protected long getCacheSize() {
        return this.cacheImpl.size();
    }

    protected abstract T getCacheObject(String key);

    public void invalidate(String key) {
        this.cacheImpl.invalidate(key);
    }
}