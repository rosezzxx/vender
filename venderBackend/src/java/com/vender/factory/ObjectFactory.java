/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vender.factory;

import com.vender.CaseInsensitiveListResult;
import com.vender.ListResult;

/**
 * 物件工廠，用來產生所需要的物件
 * @author sam
 */
public class ObjectFactory {
    static String resultList;
    public ObjectFactory() {
        resultList = "CaseInsensitiveListResult";
    }

    public ListResult getListResult() { // 未帶參數，使用 CaseInsensitiveListResult
        return getListResult ("default");
    }

    public ListResult getListResult(String listResultType) {
        ListResult newResultList;
        if (!listResultType.equals("default")) {
            resultList = listResultType;
        }

        switch (resultList) {
            case "ListResult" :
                newResultList = new ListResult();
                break;
            case "CaseInsensitiveListResult" :
            default : 
                newResultList =  new CaseInsensitiveListResult();
        }
        return newResultList;
    }
}
