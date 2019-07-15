/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vender.http;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.StringJoiner;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author sam
 */
public class RequestParameters {

    protected Map<String, String[]> requestParameters;
    protected Map<String, String[]> newParameters;
    protected Map<String, String[]> defaultParameters;

    /**
     * 複製 request 參數到字典
     *
     * @param request
     */
    public RequestParameters(HttpServletRequest request) {
        requestParameters = new HashMap<>();

        request.getParameterMap().entrySet().forEach((entry) -> {
            requestParameters.put(entry.getKey(), entry.getValue());
        });

        newParameters = new HashMap<>(requestParameters); // 複製一份，所有異動都在此屬性處理
        defaultParameters = new HashMap<>();
    }

    /**
     * 取得該鍵值的字串陣列數量
     *
     * @param key
     * @return 傳回整數值
     */
    public int getSize(String key) {
        String[] Values = requestParameters.get(key);
        return (Values != null) ? Values.length : 0;
    }

    /**
     * 取得該鍵值單一參數
     *
     * @param key
     * @return 傳回字串
     */
    public String get(String key) {
        return getValues(key)[0];
    }

    /**
     * 取得該鍵值所有參數
     *
     * @param key
     * @return 字串陣列
     */
    public String[] getValues(String key) {
        String value[] = requestParameters.get(key);
        if (value == null) {
            String defaultValue[] = defaultParameters.get(key);
            value = (defaultValue == null) ? new String[]{""} : defaultValue;
        }
        return value;
    }

    /**
     * 取得該鍵值單一參數，轉型為 Long，若轉型失敗傳回 0
     *
     * @param key
     * @return 傳回 Long 型別的參數
     */
    public Long getLong(String key) {
        Long value = 0L;
        String strValue = getValues(key)[0];
        if (isNumberic(strValue)) {
            value = Long.parseLong(strValue);
        }
        return value;
    }

    /**
     * 設定新的參數陣列，若原本有會覆蓋，沒有則新增，所有異動不影響經由 HttpServletRequest 取得的參數
     *
     * @param key
     * @param value
     */
    public void set(String key, String[] value) {
        newParameters.put(key, value);
    }

    /**
     * 設定新的參數，若原本有會覆蓋，沒有則新增，所有異動不影響經由 HttpServletRequest 取得的參數
     *
     * @param key
     * @param value
     */
    public void set(String key, String value) {
        String tempValue[] = new String[]{value};  // 放到陣列裡面
        newParameters.put(key, tempValue);
    }

    public void setDefaultValues(String key, String[] value) {
        defaultParameters.put(key, value);
    }

    public void setDefault(String key, String value) {
        String tempValue[] = new String[]{value};
        defaultParameters.put(key, tempValue);
    }

    /**
     * 移除參數，所有異動不影響經由 HttpServletRequest 取得的參數
     *
     * @param key
     */
    public void remove(String key) {
        newParameters.remove(key);
    }

    /**
     * 傳回異動後的 url 參數字串
     *
     * @return 字串
     */
    public String getNewParameters() {
        StringJoiner urlParamters = new StringJoiner("&");
        for (Map.Entry<String, String[]> entry : newParameters.entrySet()) {
            for (String value : entry.getValue()) {
                if (!value.equals(""))  // 空值不處理
                    urlParamters.add(urlEncode(entry.getKey()) + "=" + urlEncode(value));
            }
        }
        return urlParamters.toString();
    }

    /**
     * 進行 urlencode 以在 url 傳遞特殊字串的陣列
     *
     * @param values 要進行編碼的陣列
     * @return 傳回編碼後的陣列
     */
    public String[] urlEncode(String[] values) {
        String[] urlEncodeValues = new String[values.length];
        for (int i = 0; i < values.length; i++) {
            try {
                urlEncodeValues[i] = URLEncoder.encode(values[i], "UTF-8"); // 進行轉碼
            } catch (UnsupportedEncodingException e) {
                urlEncodeValues[i] = "";    // 轉碼失敗存入空字串
            }
        }
        return urlEncodeValues;
    }

    /**
     * 進行 urlencode 以在 url 傳遞特殊字串
     *
     * @param value 要進行 urlencode 的字串
     * @return 傳回編碼後的 urlencode 字串
     */
    public String urlEncode(String value) {
        String[] tempValues = new String[]{value};  // 轉成陣列
        return urlEncode(tempValues)[0];            //非遞迴
    }

    protected boolean isNumberic(String value) {
        return value.matches("-?\\d+(\\.\\d+)?");
    }
}
