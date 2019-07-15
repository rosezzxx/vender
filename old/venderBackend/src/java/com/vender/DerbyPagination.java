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
public class DerbyPagination extends DbPagination {

    public DerbyPagination(long total, long page, long limit) {
        super(total, page, limit);
    }

    @Override
    public String getDbLimit() {
        String limitString;
        
        limitString = (getTotal() > 0 ) ? " OFFSET " + getOffset() + " ROWS FETCH NEXT " + getLimit() + " ROWS ONLY" : " FETCH FIRST ROW ONLY";
        return limitString;
    }
}
