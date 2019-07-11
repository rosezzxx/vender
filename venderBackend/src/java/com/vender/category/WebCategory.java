/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vender.category;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.vender.ListResult;
import com.vender.factory.ObjectFactory;
import java.util.StringJoiner;

/**
 *
 * @author sam
 */
public abstract class WebCategory {

    /**
     * 資料庫結果集
     */
    protected List<Map<String, Object>> result;
    
    /**
     * 錯誤訊息
     */
    protected String errorMessage;

    /**
     * 以節點 id 作為 key ，以找尋該節點資料
     */
    protected Map<Integer, Map<String, Object>> categories;

    /**
     * 以父節點分類，將節點 ID 放在 list 中
     */
    protected Map<Integer, List<Integer>> parentCats;

    /**
     * 用以標示運作中的 id
     */
    protected int activeId;

    /**
     * 節點路徑結果，在建立時期，當成堆疊使用
     */
    private List<Map<String, Object>> pathResult;

    /**
     * 物件工廠，由此取得 ListResult 實體
     */    
    ObjectFactory listResultFactory;

    public WebCategory(ListResult dbResult) {
        result = dbResult.getResult();
        errorMessage = dbResult.getErrorMessage();
        categories = new HashMap<>();
        parentCats = new HashMap<>();
        listResultFactory = new ObjectFactory();
    }

    /**
     * 計算節點以及樹狀結構
     */
    protected void init() {
        for (Map<String, Object> row : result) {
            int parentId = (int) row.get("parent_id");
            categories.put((int) row.get("category_id"), row);  // 將節點 id 作為 key ，然後把內容放到 HashMap

            if (parentCats.get(parentId) == null) {  // 若陣列不存在，產生新陣列放到以父節點為 key 的 HashMap
                parentCats.put(parentId, new ArrayList<Integer>());
            }
            parentCats.get(parentId).add((int) row.get("category_id")); // 將相同一父節點的 id，加到 ArrayList
        }
    }

    /**
     * 此方法必須繼承後重新改寫，以遞迴搜尋所有節點，直接產生 HTML 輸出
     *
     * @param parent 起始 id
     * @return 傳回 HTML 字串
     */
    public abstract String buildCategory(int parent);

    /**
     * 將起始 id 以及要搜尋的 id 所經過的節點放到 pathResult 中 
     * @param parent 起始 id
     * @param searchId 搜尋 id
     * @param level 等級
     * @return 傳回是否找到節點，找到傳回 true
     */
    protected boolean findPath(int parent, int searchId, int level) {
        boolean found = false;
        if (found == false) {
            if (parentCats.get(parent) != null) {
                for (int catId : parentCats.get(parent)) {
                    if (found == false) {
                        if (catId == searchId) { // 找到節點
                            pathResult.add(categories.get(catId)); // 加入陣列(push)
                            return true;
                        }
                        if (parentCats.get(catId) != null) {
                            pathResult.add(categories.get(catId)); // 有子節點往下找
                            if (found = findPath(catId, searchId, ++level)) {
                                level--;    // 用來記數陣列頂端，把陣列當成堆疊使用
                            } else {
                                pathResult.remove(--level); // 刪除未找到的底端節點(pop)
                            }
                        }
                    }
                }
            }
        }
        return found;
    }

    /**
     * 傳回路徑陣列，若找不到傳回 0
     * @param parent 要取得路徑的起始 id
     * @param id 要取得最終路徑的 id ，該 id 必須在 parent 之下
     * @return 將結果傳回 ListResult 物件，不包含自己
     */
    public ListResult getPath(int parent, int id) {
        ListResult categoryPath = listResultFactory.getListResult();
        pathResult = new ArrayList<>();
        try {
            if (parentCats.isEmpty()) { // 計算節點字典以及樹狀結構字典
                init();
            }
            if (findPath(parent, id, 0)) { // 用遞回取得節點路徑，放到 pathResult 內
                categoryPath.setResult(pathResult); // 寫到 ListResult
            } else {
                errorMessage = "Can not create path";   // 若找不到路徑寫入錯誤訊息
                categoryPath.setResult("category_id", 0); // 傳回最頂層節點 category_id=0 
            }
        } catch (Exception e) {
            errorMessage = e.getMessage();
        }
        categoryPath.setErrorMessage(errorMessage);
        return categoryPath;
    }

    /**
     * 傳回所有節點完整路徑
     *
     * @param splitChar 分割路徑的字串或字元
     * @return 傳回 ListResult 結果
     */
    public ListResult getAllPath(String separatedString) {
        ListResult allCategoriesPath = listResultFactory.getListResult();
        List<Map<String, Object>> allPathResult = new ArrayList<>();
        try {
            if (parentCats.isEmpty()) { // 計算節點字典以及樹狀結構字典
                init();
            }
            for (Map<String, Object> item : result) {   // 由結果集取出節點
                int itemId = (int) item.get("category_id");    // 取得 category_id
                ListResult itemPathResult = getPath(0, itemId); // 取得該 id 路徑

                StringJoiner pathName = new StringJoiner(separatedString);  // 組合路徑
                for (Map<String, Object> path : itemPathResult.getResult()) {
                    pathName.add((String) path.get("category_name"));
                }

                Map<String, Object> nodePath = new HashMap<>();
                nodePath.put("path", pathName.toString());
                nodePath.put("category_id", itemId);
                allPathResult.add(nodePath);
                allCategoriesPath.setResult(allPathResult); // 寫到 ListResult
            }
        } catch (Exception e) {
            errorMessage = e.getMessage();
        }
        allCategoriesPath.setErrorMessage(errorMessage);
        return allCategoriesPath;
    }

    /**
     *
     * @param id 起始 id
     * @param active 高亮度的 id
     * @return
     */
    public String getHtml(int id, int active) {
        activeId = active;
        try {
            if (parentCats.isEmpty()) { // 計算節點字典以及樹狀結構字典
                init();
            }
            return buildCategory(id);   // 必須繼承後寫出繪製 HTML 的方法
        } catch (Exception e) {
            errorMessage = e.getMessage();
            return errorMessage;
        }
    }
}