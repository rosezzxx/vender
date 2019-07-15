/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vender;

/**
 * 重要說明：因為 page 屬性需要設定範圍，因此都需要由 getPage() 來取得，不可直接存取 page 變數
 * @author sam
 */
public abstract class Pagination {
    private long total = 0;
    private long page = 1;
    private long limit = 10;
    
    /**
     * 有參數的建構子
     * @param total 總筆數
     * @param page  目前頁碼
     * @param limit 每頁筆數，如果為 0 使用預設
     */
    public Pagination(long total, long page, long limit) {
        this.total = total;
        setPage(page);
        setLimit(limit);
    }
    
    /**
     * 無參數的建構子
     */
    public Pagination() {
    }
    
    /**
     *
     * @param total 設定總筆數
     */
    final public void setTotal(long total) {
        this.total = total;
    }
    
    
    /**
     *
     * @param limit 設定每頁筆數
     */
    final public void setLimit(long limit) {
        this.limit = (limit < 1) ? this.limit : limit;
    }
    
    /**
     *
     * @param page  設定目前頁碼
     */
    final public void setPage (long page) {
        this.page = (page < 1) ? 1L : page;
    }
    
    /**
     *
     * @return 總筆數
     */
    final public long getTotal() {
        return total;
    }
    
    /**
     *
     * @return 傳回目前頁碼所在資料位置(偏移）
     */
    final public long getOffset() {
        long currentPage = getPage();        
        return (currentPage > 0 ) ? currentPage * limit - limit : 0;
    }
    
    /**
     *
     * @return 取得每頁筆數
     */
    final public long getLimit() {
        return limit;
    }
    
    /**
     *
     * @return 取得目前頁碼
     */
    final public long getPage() {
        long endPage = getEndPage();
        return (page < 1) ? 1L : (page > endPage) ? endPage : page;
    }
    
    /**
     *
     * @return 取得最末頁頁碼或總頁數
     */
    final public long getEndPage() {
        long endPage = (total / limit);
        return (total % limit) > 0 ? ++endPage : endPage;
    }
    
    /**
     *
     * @return 取得前一頁頁碼
     */
    final public long getPrev () {
        long currentPage = getPage();
        return (currentPage > 1) ? currentPage - 1 : 1L;
    }
    
    /**
     *
     * @return 取得後一頁頁碼
     */
    final public long getNext () {
        long currentPage = getPage();
        long endPage = getEndPage();
        return (currentPage < endPage) ? currentPage + 1 : endPage;
    }
}
