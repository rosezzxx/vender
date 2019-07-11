/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vender;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

/**
 * ANSI SQL 查詢後的欄位會自動轉成大寫，原有 Apache DbUtils 僅支援 Java 1.6 連帶並不支援 getOrDefault()
 * 方法， 因此呼叫 getOrDefault() 會使用父類別的方法，導致區分大小寫，此類別可解決此問題。
 *
 * @author sam
 */
public class CaseInsensitiveListResult extends ListResult {

    /**
     * CaseInsensitiveHashMap 是由 Apache DbUtils 所取得，加入了 getOrDefault() 方法
     */
    private class CaseInsensitiveHashMap extends LinkedHashMap<String, Object> {

        /**
         * The internal mapping from lowercase keys to the real keys.
         *
         * <p>
         * Any query operation using the key
         * ({@link #get(Object)}, {@link #containsKey(Object)}) is done in three
         * steps:
         * <ul>
         * <li>convert the parameter key to lower case</li>
         * <li>get the actual key that corresponds to the lower case key</li>
         * <li>query the map with the actual key</li>
         * </ul>
         * </p>
         */
        private final Map<String, String> lowerCaseMap = new HashMap<String, String>();

        /**
         * Required for serialization support.
         *
         * @see java.io.Serializable
         */
        private static final long serialVersionUID = -2848100435296897392L;

        /**
         * {@inheritDoc}
         */
        @Override
        public boolean containsKey(Object key) {
            Object realKey = lowerCaseMap.get(key.toString().toLowerCase(Locale.ENGLISH));
            return super.containsKey(realKey);
            // Possible optimisation here:
            // Since the lowerCaseMap contains a mapping for all the keys,
            // we could just do this:
            // return lowerCaseMap.containsKey(key.toString().toLowerCase());
        }

        /**
         * {@inheritDoc}
         */
        @Override
        public Object get(Object key) {
            Object realKey = lowerCaseMap.get(key.toString().toLowerCase(Locale.ENGLISH));
            return super.get(realKey);
        }

        @Override
        public Object getOrDefault(Object key, Object defaultValue) {
            Object realKey = lowerCaseMap.get(key.toString().toLowerCase(Locale.ENGLISH));
            Object value = super.get(realKey);
            return (value == null) ? defaultValue : value;
        }

        /**
         * {@inheritDoc}
         */
        @Override
        public Object put(String key, Object value) {
            /*
             * In order to keep the map and lowerCaseMap synchronized,
             * we have to remove the old mapping before putting the
             * new one. Indeed, oldKey and key are not necessaliry equals.
             * (That's why we call super.remove(oldKey) and not just
             * super.put(key, value))
             */
            Object oldKey = lowerCaseMap.put(key.toLowerCase(Locale.ENGLISH), key);
            Object oldValue = super.remove(oldKey);
            super.put(key, value);
            return oldValue;
        }

        /**
         * {@inheritDoc}
         */
        @Override
        public void putAll(Map<? extends String, ?> m) {
            for (Map.Entry<? extends String, ?> entry : m.entrySet()) {
                String key = entry.getKey();
                Object value = entry.getValue();
                this.put(key, value);
            }
        }

        /**
         * {@inheritDoc}
         */
        @Override
        public Object remove(Object key) {
            Object realKey = lowerCaseMap.remove(key.toString().toLowerCase(Locale.ENGLISH));
            return super.remove(realKey);
        }
    }

    public CaseInsensitiveListResult() {
        // 初始化 CaseInsensitiveListResult
        Map<String, Object> row = new CaseInsensitiveHashMap();
        result = new ArrayList<>();
        result.add(row);
    }

    /**
     * 設定物件內 result ，若型別為 Map<String, Object> ，轉換成 CaseInsensitiveHashMap
     *
     * @param result
     */
    @Override
    public void setResult(List<Map<String, Object>> result) {
        List<Map<String, Object>> newList;
        if (!result.isEmpty()) {
            String className = result.get(0).getClass().getSimpleName();
            if (!className.equals("CaseInsensitiveHashMap")) { // 若型別不是 CaseInsensitiveHashMap 進行轉型
                newList = new ArrayList<>();
                result.stream().map((values) -> {
                    CaseInsensitiveHashMap newValue = new CaseInsensitiveHashMap();
                    values.entrySet().forEach((entry) -> {
                        newValue.put(entry.getKey(), entry.getValue());
                    });
                    return newValue;
                }).forEachOrdered((newValue) -> {
                    newList.add(newValue);
                });
            } else {
                newList = result;
            }
        } else {
            newList = result;
        }
        this.result = newList;
    }

    /**
     * 取得 Map 物件
     * @return 傳回型別為 CaseInsensitiveHashMap 物件，
     */
    @Override
    public Map<String, Object> getMap() {
        Map<String, Object> cell = new CaseInsensitiveHashMap();
        return cell;
    }
}
