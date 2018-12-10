package com.jojowonet.modules.sys.util.http;

import org.apache.http.client.config.RequestConfig;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.client.ClientHttpRequestFactory;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import java.lang.reflect.Array;
import java.util.*;

@Component
public class EzTemplate extends RestTemplate {

    private static Logger logger = Logger.getLogger(EzTemplate.class);

    private RestTemplate restTemplate = new RestTemplate(getClientHttpRequestFactory());

    @Value("${sync.server.host.default}")
    private String host;

    public <T> T postForm(String url, Map<String, Object> data,
                          ParameterizedTypeReference<T> responseType, Object... uriVariables) throws RestClientException {

        long start = System.currentTimeMillis();
        url = normalizeUri(host, url);
        MultiValueMap<String, Object> postData = new LinkedMultiValueMap<>();
        if (data != null) {
            Set<String> keys = data.keySet();
            for (String key : keys) {
                Object val = data.get(key);
                if (val != null) {
                    if (isArray(val) || (val instanceof List) || val instanceof Set) {
                        List<String> list = extractList(val);
                        for (String el : list) {
                            postData.add(key, el);
                        }
                    } else {
                        postData.set(key, val.toString());
                    }
                }
            }
        }

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

        HttpEntity<MultiValueMap<String, Object>> entity = new HttpEntity<>(postData, headers);
        T body = doPostForm(url, responseType, entity, uriVariables);
        logger.info(String.format("post to %s consumed: %s", url, (System.currentTimeMillis() - start)));
        return body;
    }

    public <T> T postForm(String url, Map<String, Object> data, Class<T> responseType, Object... uriVariables) throws RestClientException {

        long start = System.currentTimeMillis();
        url = normalizeUri(host, url);
        MultiValueMap<String, Object> postData = new LinkedMultiValueMap<>();
        postData.setAll(data);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        HttpEntity<MultiValueMap<String, Object>> entity = new HttpEntity<>(postData, headers);
        T ret = restTemplate.postForObject(url, entity, responseType, uriVariables);
        logger.info(String.format("post to %s consumed: %s", url, (System.currentTimeMillis() - start)));
        return ret;
    }

    private String normalizeUri(String host, String url) {
        if (host.endsWith("/")) {
            host = host.substring(0, host.length() - 1);
        }
        if (!url.startsWith("/")) {
            url = "/" + url;
        }
        return host + url;
    }

    private <T> T doPostForm(String url, ParameterizedTypeReference<T> responseType, HttpEntity<MultiValueMap<String, Object>> entity, Object[] uriVariables) {
        return restTemplate.exchange(url,
                HttpMethod.POST,
                entity,
                responseType,
                uriVariables).getBody();
    }

    public <T> T postJson(String url, Map<String, Object> data,
                          ParameterizedTypeReference<T> responseType, Object... uriVariables) throws RestClientException {
        return postJson(url, new ValueHolder<Object>(data), responseType, uriVariables);
    }

    public <T> T postJson(String url, Object data,
                          ParameterizedTypeReference<T> responseType, Object... uriVariables) throws RestClientException {
        return postJson(url, new ValueHolder<>(data), responseType, uriVariables);
    }

    private <T, K> T postJson(String url, ValueHolder<K> data,
                              ParameterizedTypeReference<T> responseType, Object... uriVariables) throws RestClientException {

        long start = System.currentTimeMillis();
        url = normalizeUri(host, url);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.parseMediaType("application/json; charset=UTF-8"));
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        HttpEntity<K> entity = new HttpEntity<>(data.getData(), headers);
        T body = doPostJson(url, responseType, entity, uriVariables);
        logger.info(String.format("post to %s consumed: %s", url, (System.currentTimeMillis() - start)));
        return body;
    }

    private <T, K> T doPostJson(String url, ParameterizedTypeReference<T> responseType, HttpEntity<K> entity, Object[] uriVariables) {
        return restTemplate.exchange(url,
                HttpMethod.POST,
                entity,
                responseType,
                uriVariables).getBody();
    }

    static class ValueHolder<T> {
        private T data;

        ValueHolder(T data) {
            this.data = data;
        }

        public T getData() {
            return data;
        }
    }

    private static ClientHttpRequestFactory getClientHttpRequestFactory() {
        int timeout = 30000;
        RequestConfig config = RequestConfig.custom()
                .setConnectTimeout(timeout)
                .setConnectionRequestTimeout(timeout)
                .setSocketTimeout(timeout)
                .build();

        CloseableHttpClient client = HttpClientBuilder
                .create()
                .setDefaultRequestConfig(config)
                .build();

        return new HttpComponentsClientHttpRequestFactory(client);
    }

    private static boolean isArray(Object obj) {
        return obj != null && obj.getClass().isArray();
    }

    private static List<String> extractList(Object val) {
        List<String> ret = new ArrayList<>();
        if (isArray(val)) {
            for (int i = 0, n = Array.getLength(val); i < n; i++) {
                Object o = Array.get(val, i);
                if (o != null) {
                    ret.add(o.toString());
                }
            }
        } else if (val instanceof List) {
            List list = (List) val;
            for (Object el : list) {
                if (el != null) {
                    ret.add(el.toString());
                }
            }
        } else if (val instanceof Set) {
            Set set = (Set) val;
            for (Object el : set) {
                if (el != null) {
                    ret.add(el.toString());
                }
            }
        }
        return ret;
    }
}
