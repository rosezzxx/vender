/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vender.category.view;

import com.vender.ListResult;
import com.vender.category.WebCategory;

/**
 * 用來產生 Bootstrap4 的 Navbar 選單
 * @author sam
 */
public class BootStrap4Navbar extends WebCategory {
    private boolean dropDown = false;

    public BootStrap4Navbar(ListResult dbResult) {
        super(dbResult);
    }

    /**
     * 用來產生 Bootstrap 4 的 Navbar 兩層選單
     * @param id 起始 id
     * @return 傳回 Navbar 選單字串
     */
    @Override
    public String buildCategory(int parent) {
        String html = "";
        if (parentCats.get(parent) != null) {
            for (int catId : parentCats.get(parent)) { // 對節點下面的所有子節點搜尋，所有子節點用陣列存放
                String act = (activeId == catId) ? " active" : "";  // 高亮判斷
                if (parentCats.get(catId) == null) { // 最後一個節點
                    if (dropDown == true) { // 如果是下拉選單直接印出連結，非下拉以 li 標籤印出
                        html += "<a class=\"dropdown-item\" href='" + categories.get(catId).get("category_link") + "'>" + categories.get(catId).get("category_name") + "</a> \n";
                    } else {
                        html += "<li class=\"nav-item" + act + "\">\n  <a class=\"nav-link\" href='" + categories.get(catId).get("category_link") + "'>" + categories.get(catId).get("category_name") + "</a>\n</li> \n";
                    }
                } else { // 有子節點，印出該節點並用遞迴往搜尋，並且收斂為 Navbar 的兩層選單
                    if (dropDown == true) { // Navbar 只支援兩層選單，二層以後也是直接印出連結
                        html += "<a class=\"dropdown-item\" href='" + categories.get(catId).get("category_link") + "'>" + categories.get(catId).get("category_name") + "</a> \n";
                        html += buildCategory(catId);   // 用遞迴往下一層搜尋
                    } else {
                        dropDown = true; // 有下拉選單，印出下拉選單結構，僅限第一層能有下拉選單
                        html += "<li class=\"nav-item dropdown" + act + "\">\n<a class=\"nav-link dropdown-toggle\" id=\"navbarDropdown\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\" href='" + categories.get(catId).get("category_link") + "'>" + categories.get(catId).get("category_name") + "</a> \n";
                        html += "<div class=\"dropdown-menu\" aria-labelledby=\"navbarDropdown\">\n";
                        html += buildCategory(catId);   // 用遞迴往下一層搜尋
                        html += "</div>\n</li>\n";
                        dropDown = false;
                    }
                }
            }
        }
        return html;
    }
}
