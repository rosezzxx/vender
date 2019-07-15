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
public abstract class DbPagination extends Pagination {
    public DbPagination(long total, long page, long limit) {
        super(total, page, limit);
    }
    abstract public String getDbLimit();
}
