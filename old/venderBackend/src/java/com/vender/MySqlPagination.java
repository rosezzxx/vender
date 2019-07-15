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
public class MySqlPagination extends DbPagination {
    
    public MySqlPagination(long total, long page, long limit) {
        super(total, page, limit);
    }
    
    /**
     *
     * @return 取得 MySQL 分頁字串
     */
    public String getDbLimit() {
        String limitString;
        
        limitString = (getTotal() > 0 ) ? " LIMIT " + getOffset() + ", " + getLimit() : " LIMIT 1";
        return limitString;
    }
}
