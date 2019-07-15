/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vender;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author sam
 */
public class ListResult {
    protected List<Map<String, Object>> result;
    protected String sqlMessage;
    protected String errorMessage = null;
    
    /**
     * 初始化內部物件，給予空值
     */
    public ListResult(){
            // 初始化 result
            Map<String, Object> row = new HashMap<>();
            result = new ArrayList<>();
            result.add(row);
    }
    
    /**
     * 設定 SQL 語法
     * @param sql 儲存執行的 SQL 語法
     */
    public void setSqlMessage(String sql) {
        sqlMessage = sql;
    }
    
    
    /**
     * 取得 SQL 語法
     * @return 傳回執行的 SQL 語法
     */
    public String getSqlMessage() {
        return sqlMessage;
    }
    
    /**
     * 設定物件內 result
     * @param result
     */
    public void setResult (List<Map<String, Object>> result) {
        this.result = result;
    }
    
    /**
     * 以 key, valuse 設定物件內 result
     * @param key
     * @param value
     */
    public void setResult (String key, Object value) {
        result.get(0).put(key, value);
    }
    
    /**
     * 取得物件內 result 
     * @return 
     */
    public List<Map<String, Object>> getResult () {
        return this.result;
    }
    
    /**
     * 設定錯誤訊息
     * @param errorMessage
     */
    public void setErrorMessage (String errorMessage) {
        this.errorMessage = errorMessage;
    }
    
    /**
     * 取得錯誤訊息
     * @return
     */
    public String getErrorMessage () {
        return this.errorMessage;
    }
    
    /**
     * 取得 Map 物件
     * @return 傳回 Map 物件
     */
    public Map<String, Object> getMap() {
        Map<String, Object> cell = new HashMap<>();
        return cell;
    }
    
    /**
     * 將 result 轉換成 JOSN 格式
     * @return 傳回 JSON 格式字串
     */
    public JSONArray getJsonResult()
    {       
        JSONArray jsonArray = new JSONArray();
        for (Map<String, Object> map : result) {
            JSONObject json_obj = new JSONObject();
            for (Map.Entry<String, Object> entry : map.entrySet()) {
                String key = entry.getKey();
                Object value = entry.getValue();
                try {
                    json_obj.put(key,value);
                } catch (JSONException e) {
                    errorMessage = e.getMessage();
                }                           
            }
            jsonArray.put(json_obj);
        }
        return jsonArray;
    }
}
