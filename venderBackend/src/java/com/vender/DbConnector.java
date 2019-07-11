/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vender;

import org.owasp.esapi.ESAPI;

/**
 * 資料庫抽象類別
 * @author sam
 */
public abstract class DbConnector extends JndiDb implements DbUtilities{

    @Override
    public abstract String escapeString(String noneEscapeString);
    
    /**
     * 轉換 HTML 特殊字元
     * @param htmlContent 需要轉換的 HTML
     * @return 傳回轉換後的字串
     */
    public String encodeForHtml(String htmlContent) {
        return ESAPI.encoder().encodeForHTML(htmlContent);
    }

    @Override
    public abstract DbPagination getPagination();
    
    @Override
    public abstract DbPagination getPagination(long total, long page, long limit);
    
}
