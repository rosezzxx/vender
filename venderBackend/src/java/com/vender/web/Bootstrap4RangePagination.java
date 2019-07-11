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
import com.vender.factory.ObjectFactory;

/**
 *
 * @author sam
 */
public class Bootstrap4RangePagination extends WebPagination{
    private long pageRange;

    public Bootstrap4RangePagination() {
        pageRange = 10;
    }
    
    public Bootstrap4RangePagination(long total, long page, long limit) {
        super(total, page, limit);
        pageRange = 10;
    }
    
    public Bootstrap4RangePagination(long total, long page, long limit, long pageRange) {
        super(total, page, limit);
        this.pageRange = pageRange;
    }
    
    public void setPageRange (long pageRange) {
        this.pageRange = pageRange;
    }
    
    /**
     *
     * @return  取得前面多頁的 URL ，頁數由 pageRange 決定
     */
    @Override
    public String getPrevPagesUrl() {
        long prevPage = getPage() - pageRange;
        long PrevPageFirst = prevPage - (prevPage % pageRange) + 1;
        return getUrl(PrevPageFirst);
    }
    
    /**
     *
     * @return  取得後面多頁的 URL ，頁數由 pageRange 決定
     */
    @Override
    public String getNextPagesUrl() {
        long nextPage = (getPage() + pageRange);
        long nextPageFirst = nextPage - (nextPage % pageRange) + 1;
        long endPage = getEndPage();
        if (nextPageFirst > endPage) {
            nextPageFirst = getEndPage();
        }
        return getUrl(nextPageFirst);
    }
    
    /**
     *
     * @return ListResult 頁碼結果集
     */
    @Override
    public ListResult getPages () {
        long currentPage = getPage();
        long tempPage = getPage() - 1;
        long endPage = getEndPage();
        long rangeStart = tempPage / pageRange * pageRange + 1;
        long rangeEnd = rangeStart + pageRange - 1;
        if (rangeEnd > endPage) {
            rangeEnd = endPage;
        }
        
        ObjectFactory listResultFactory = new ObjectFactory();
        ListResult pagesListResult = listResultFactory.getListResult();
        List<Map<String, Object>> list = new ArrayList<>();
        for (long i = rangeStart; i <= rangeEnd; i++) {
            Map<String, Object> map = pagesListResult.getMap();
            map.put("page", i);
            map.put("url", getUrl(i));
            if (i == currentPage) {
                map.put("active", "active");
            }
            list.add(map);
        }
        pagesListResult.setResult(list);
        
        return pagesListResult;
    }
}
