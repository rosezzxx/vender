/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vender.db;

import com.vender.ListResult;
import com.vender.MySqlDb;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author sam
 */
public class comicDb extends MySqlDb {

    public comicDb() {
        String jndiDataSource = "java:comp/env/jdbc/comicdb";
        super.setDataSource(jndiDataSource);
    }
    
     /**
     * @取得table 資料的count  專用功能 
     * @param1  String tableName
     * @param2  String filter 
     * @return  count 
     */   

public String CheckUserValid( String account,String password)
    {
         String res="No staff";
         String dbpassword="";
         ListResult  results;
          if (account==null || password==null)    return res;
          
     String commSQL="select * from vender  where  email= '"+escapeString(account)+"'; ";
    
   
            results= execSql(commSQL);
        
            if (results.getErrorMessage() != null)  
            {
                 System.out.println("results.getErrorMessage()=="+results.getErrorMessage());
                 return res;
            }
            else   
                for (Map result : results.getResult()) {
                       dbpassword=(String)result.get("password");
                     
                       if (dbpassword.equals(escapeString(password)))
                       {
                        
                          res=""+(int)result.get("pdVenderID");
                      
                          
                       }  
                       else
                           res="No staff";
                }      
          return res;
    } 


    public Long   getTableCount(  String tableName ,String filter )
    {    
        Long res=0L;
        ListResult tbcounts;
        
        String commSQL="SELECT count(*) as count  FROM "+tableName  ;
        if (filter!=null || filter.length()>0) 
                   commSQL=commSQL+filter ;   
     //  System.out.println("getTableCount -->commSQL=="+commSQL); 
        tbcounts= execSql(commSQL);
        
        if (tbcounts.getErrorMessage() != null)  
        {
             System.out.println("tbcounts.getErrorMessage()=="+tbcounts.getErrorMessage());
             res=0L;
        }
       else
            for (Map tbcount : tbcounts.getResult()) {
                    res = (Long) tbcount.get("count"); 
            }        
        return res; 
    }   
 /**
     * @from comic_func  專用 取得 功能代碼說明
     * @param funcID  ==> funcID  
     * @return  description
     */   
    
    public String getcomic_funcDescByItemID(  String funcID)
    {        
        String res = "";	 // 為了不讓搜尋不到的都反映出一個空白的String 
     

        ListResult comic_funcs;
        comic_funcs = execSql("SELECT funcdesc FROM comic_func WHERE funcID=  "+ funcID+ "  ;    ");   
       
        if (comic_funcs.getErrorMessage() == null) {
                for (Map  comic_func :  comic_funcs.getResult()) {
                    res = (String)  comic_func.get("funcdesc");
                }
            } else {
                res =  comic_funcs.getErrorMessage();
            }
        if (res==null) res="";
        return res; 
                 
    }     
    
    
    
    
 /**
     * @from item_setup  專用 取得 群組代碼說明
     * @param groupType  ==> groupType  
     * @return  description
     */   
    
    public String getItemtypeGroupDescByItemID(  String itemID)
    {        
        String res = "";	 // 為了不讓搜尋不到的都反映出一個空白的String 
     

        ListResult itemtype_setups;
       itemtype_setups = execSql("SELECT description FROM itemtype_setup WHERE ItemID=  "+ itemID+ "  ;    ");   // escapeString() 避免 SQL Injection
        
         
        
        if (itemtype_setups.getErrorMessage() == null) {
                for (Map  itemtype_setup :  itemtype_setups.getResult()) {
                    res = (String)  itemtype_setup.get("description");
                }
            } else {
                res =  itemtype_setups.getErrorMessage();
            }
        if (res==null) res="";
        return res; 
                 
    }  
    /**
     * @from defcode 專用 取得 代碼說明
     * @param codeTypesno  ==> codeType  
     * @return  codedesc
     */   
    
    public String getCodeDescFromGroup(  String codeType)
    {        
        String res = "";	 // 為了不讓搜尋不到的都反映出一個空白的String 
     

        ListResult defcodes;
        defcodes = execSql("SELECT codedesc FROM defcode WHERE codeType= '"+escapeString(codeType)+"' and sno=0 ;    ");   // escapeString() 避免 SQL Injection
            if (defcodes.getErrorMessage() == null) {
                for (Map defcode : defcodes.getResult()) {
                    res = (String) defcode.get("codedesc");
                }
            } else {
                res = defcodes.getErrorMessage();
            }
        if (res==null) res="";
        return res; 
                 
    }  
    
    
    /**
     * @from defcode 專用 取得 代碼說明
     * @param codeTypesno  ==> codeType + sno
     * @return  codedesc
     */   
    
    public String getCodeDescStr(  String codeTypesno)
    {        
        String res = "";	 // 為了不讓搜尋不到的都反映出一個空白的String 
        String codeType=null;
        int len=0;
        String sno=""; 
        if (codeTypesno==null ) return res;
        codeType=codeTypesno.substring(0, 1); 
        len=codeTypesno.trim().length();
        sno=codeTypesno.trim().substring(1, len);   

        ListResult defcodes;
        defcodes = execSql("SELECT codedesc FROM defcode WHERE codeType= '"+escapeString(codeType)+"' and sno= "+sno+"  and sno >0 ");   // escapeString() 避免 SQL Injection
            if (defcodes.getErrorMessage() == null) {
                for (Map defcode : defcodes.getResult()) {
                    res = (String) defcode.get("codedesc");
                }
            } else {
                res = defcodes.getErrorMessage();
            }
        if (res==null) res="";
        return res; 
                 
    }  
     /**
     * @from defcode 專用 取得 代碼說明
     * @param codeTypesno  ==> codeType + sno
     * @return  Showclass 
     */   
    
    public String getShowclassStr(  String codeTypesno)   
    {        
        String res = "";	 // 為了不讓搜尋不到的都反映出一個空白的String   
        String codeType=null;
        int len=0;
        String sno=""; 
        if (codeTypesno==null ) return res;
        codeType=codeTypesno.substring(0, 1); 

        len=codeTypesno.trim().length();
        sno=codeTypesno.trim().substring(1, len); 

        ListResult defcodes;
        defcodes = execSql("SELECT codedesc FROM defcode WHERE codeType= '"+escapeString(codeType)+"' and sno= "+sno+"  and sno >0 ");   // escapeString() 避免 SQL Injection
            if (defcodes.getErrorMessage() == null) {
                for (Map defcode : defcodes.getResult()) {
                    res = (String) defcode.get("showClass");
                }
            } else {
                  res = defcodes.getErrorMessage();
            }
        if (res==null) res="";
        return res; 
                 
    }  

    /**
     * @from defcode 專用 取得 代碼說明
     * @param codeID  ==> codeType + sno
     * @return  codedesc
     */  
    public String getCodeDescByCodeID(  String codeID)
    {        
        String res = "";	 // 為了不讓搜尋不到的都反映出一個空白的String 
      
        if (codeID==null ) return res;
         

        ListResult defcodes;
        defcodes = execSql("SELECT codedesc FROM defcode WHERE codeID= "+codeID);   // escapeString() 避免 SQL Injection
            if (defcodes.getErrorMessage() == null) {
                for (Map defcode : defcodes.getResult()) {
                    res = (String) defcode.get("codedesc");
                }
            } else {
                res = defcodes.getErrorMessage();
            }
        if (res==null) res="";
        return res;  
    }   
   
    /**
     * @from defcode 專用 取得 代碼說明
     * @param codeType  ==> codeType   代碼類別
     * @param sno  ==> sno    代碼序號
     * @return  codedesc
     */  
    public String getCodeDesc(  String codeType,String sno)
    {        
        String res = "";	 // 為了不讓搜尋不到的都反映出一個空白的String 
       
        if (codeType==null ) return res;  
        ListResult defcodes;
        defcodes = execSql("SELECT codedesc FROM defcode WHERE codeType= '"+escapeString(codeType)+"' and sno= "+sno+"  and sno >0 ");   // escapeString() 避免 SQL Injection
            if (defcodes.getErrorMessage() == null) {
                for (Map defcode : defcodes.getResult()) {
                    res = (String) defcode.get("codedesc");
                }
            } else {
                res = defcodes.getErrorMessage();
            }
        if (res==null) res="";
        return res;  
    }   


     /**
     * @from defcode 專用 取得 AD 代碼說明
     * @param codeID  ==> codeType + sno
     * @return  codedesc
     */  
    public String getADCodeDescStr(  String codeTypesno)   //AD代碼專用
    {        
        String res = "";	 // 為了不讓搜尋不到的都反映出一個空白的String 
        String codeType=null;
        int len=0;
        String sno=""; 
        if (codeTypesno==null ) return res;
        codeType=codeTypesno.substring(0, 1); 
        len=codeTypesno.trim().length();
        sno=codeTypesno.trim().substring(1, len);   

        ListResult defcodes;
        defcodes = execSql("SELECT codedesc FROM defcode WHERE codeType= 'AD' and sno= "+sno+"  and sno >0 ");   // escapeString() 避免 SQL Injection
            if (defcodes.getErrorMessage() == null) {
                for (Map defcode : defcodes.getResult()) {
                    res = (String) defcode.get("codedesc");
                }
            } else {
                res = defcodes.getErrorMessage();
            }
        if (res==null) res="";
        return res; 
    } 

  /**
     * 取得使用者列表
     * @return
     */
    public ListResult getDefcodes () {
        ListResult defcodeResult;
        defcodeResult = execSql("SELECT * FROM defcode");
/*
        if (usersResult.getErrorMessage() != null) {
            Map<String, Object> row = new HashMap<>();
            row.put("userName", (Object) "");
            row.put("apiKey", (Object) "");
            row.put("memo", (Object) "");
            List<Map<String, Object>> users = new ArrayList<>();
            users.add(row);
            usersResult.setResult(users);
        }
*/       
        return defcodeResult;
    }
    


 
}
