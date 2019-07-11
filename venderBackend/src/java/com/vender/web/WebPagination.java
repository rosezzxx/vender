/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vender.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import com.vender.ListResult;
import com.vender.Pagination;
import com.vender.factory.ObjectFactory;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

/**
 *
 * @author sam
 */
public class WebPagination extends Pagination {
    private final String placeHolder = "(:pg:)";
    private String urlPattern;
    
    public WebPagination() {
    }
    
    public WebPagination(long total, long page, long limit) {
        super(total, page, limit);
    }

    /**
     *
     * @param urlPattern 傳入網址樣板，(:pg:) 會被頁碼取代，如 page=(:pg:)  
     */
    public void setUrlPattern(String urlPattern) {
        this.urlPattern = urlPattern;
    }
    
    /**
     *
     * @param page 取得某頁的 URL
     * @return 傳回代換成頁碼的字串或空字串""
     */
    protected String getUrl(long page) {
        String placeHolderUrlEncode;
        try {
            placeHolderUrlEncode = URLEncoder.encode(placeHolder, "UTF-8"); // 進行轉碼
        } catch (UnsupportedEncodingException e) {
            placeHolderUrlEncode = "";    // 轉碼失敗存入空字串
        }
        String urltemp = (page > 0) ? urlPattern.replace(placeHolderUrlEncode, Long.toString(page)) : "";
        return (page > 0) ? urltemp.replace(placeHolder, Long.toString(page)) : "";
    }
    
    /**
     *
     * @return  取得目前頁碼的 URL
     */
    public String getPageUrl(){
        return getUrl(getPage());
    }
    
    /**
     *
     * @return  取得前一頁 URL
     */
    public String getPrevUrl() {
        return getUrl(getPrev());
    }
    
    /**
     *
     * @return  取得後一頁 URL
     */
    public String getNextUrl() {
        return getUrl(getNext());
    }
    
        /**
     *
     * @return  取得前面多頁 URL ，在此傳回第一頁
     */
    public String getPrevPagesUrl() {
        return getUrl(1);
    };
    
    /**
     *
     * @return  取得後面多頁 URL ，在此傳回最後一頁
     */
    public String getNextPagesUrl() {
        return getUrl(getEndPage());
    };
    
    /**
     *
     * @return  取得最末頁 URL
     */
    public String getLastUrl() {
        return getUrl(getEndPage());
    }
    
    /**
     *
     * @return ListResult 頁碼結果集
     */
    public ListResult getPages () {
        long endPage = getEndPage() + 1;
        ObjectFactory listResultFactory = new ObjectFactory();
        ListResult pagesListResult = listResultFactory.getListResult();
        List<Map<String, Object>> list = new ArrayList<>();
        for (long i = 1; i < endPage; i++) {
            Map<String, Object> map = pagesListResult.getMap();
            map.put("page", i);
            map.put("url", getUrl(i));
            list.add(map);
        }
        pagesListResult.setResult(list);
        
        return pagesListResult;
    }
}
