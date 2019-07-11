/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vender;

/**
 *
 * @author sam
 */
public interface DbUtilities {

    /**
     * 過濾 SQL 特殊字元，避免 SQL Injection
     * @param noneEscapeString
     * @return 傳回處理過的字串
     */
    public String escapeString(String noneEscapeString);

    /**
     * 將字串編碼為 HTML 格式
     * @param htmlContent
     * @return 傳回編碼後的字串
     */
    public String encodeForHtml(String htmlContent);

    /**
     * 傳回資料庫分頁物件
     * @return DbPagination 物件
     */
    public DbPagination getPagination();
    
    /**
     * 傳回資料庫分頁物件
     * @param total 資料總筆數
     * @param page 目前頁碼
     * @param limit 每頁幾筆
     * @return DbPagination 物件
     */
    public DbPagination getPagination(long total, long page, long limit);
}
