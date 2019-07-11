/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vender.category.view;

import com.vender.ListResult;
import com.vender.category.WebCategory;

/**
 * 用來產生無限級數的 Category
 *
 * @author sam
 */
public class StandardCategory extends WebCategory {

    public StandardCategory(ListResult dbResult) {
        super(dbResult);
    }

    /**
     * 用來產生使用 ur, li 的無限級數 category
     *
     * @author sam
     */
    @Override
    public String buildCategory(int parent) {
        String html = "";
        if (parentCats.get(parent) != null) {
            html += "<ul>\n";
            for (int catId : parentCats.get(parent)) {  // 對節點下面的所有子節點搜尋，所有子節點用陣列存放
                String act = (activeId == catId) ? "active" : ""; // 比對成功，對該節點 css 設定為 active
                if (parentCats.get(catId) == null) { // 最後一個節點
                    html += "<li class=\"" + act + "\">\n  <a href=\"" + categories.get(catId).get("category_link") + "\">" + categories.get(catId).get("category_name") + " (" + categories.get(catId).get("category_id") + ")</a>\n</li> \n";
                }
                if (parentCats.get(catId) != null) { // 有子節點，印出該節點並用遞迴往下找
                    html += "<li class=\"" + act + "\">\n  <a href=\"" + categories.get(catId).get("category_link") + "\">" + categories.get(catId).get("category_name") + " (" + categories.get(catId).get("category_id") + ")</a>\n";
                    html += buildCategory(catId);   // 遞迴往下繼續找
                    html += "</li>\n";
                }
            }
            html += "</ul>\n";
        }
        return html;
    }
}
