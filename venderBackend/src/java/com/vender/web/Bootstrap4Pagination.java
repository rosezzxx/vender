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
public class Bootstrap4Pagination extends WebPagination {
    
    public Bootstrap4Pagination() {
    }
    
    public Bootstrap4Pagination(long total, long page, long limit) {
        super(total, page, limit);
    }

    /**
     *
     * @return ListResult 頁碼結果集
     */
    @Override
    public ListResult getPages () {
        long page = getPage();
        long endPage = getEndPage() + 1;
        ObjectFactory listResultFactory = new ObjectFactory();
        ListResult pagesListResult = listResultFactory.getListResult();
        List<Map<String, Object>> list = new ArrayList<>();
        for (long i = 1; i < endPage; i++) {
            Map<String, Object> map = pagesListResult.getMap();
            map.put("page", i);
            map.put("url", getUrl(i));
            if (i == page) {
                map.put("active", "active");
            }
            list.add(map);
        }
        pagesListResult.setResult(list);
        
        return pagesListResult;
    }
}
