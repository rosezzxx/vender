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
public class superDb extends MySqlDb {

    public superDb() {
        String jndiDataSource = "java:comp/env/jdbc/super8db";
        super.setDataSource(jndiDataSource);
    }
    
     /**
     * @取得是否為總管理處的Admin 
     * @param1  String account
     * @param2  String password 
     * @return  res = Y or N 
     */   

    public String CheckAdminUserValid( String account,String password)
    {
         String res="N";
         String dbpassword="";
         String level="0";
         ListResult  results;
          if (account==null || password==null)    return res;
          
          String commSQL="select * from sysuser where deleteYN='N' and account= '"+escapeString(account)+"'; ";
          
            results= execSql(commSQL);
        
            if (results.getErrorMessage() != null)  
            {
                 System.out.println("aiwa--->results.getErrorMessage()=="+results.getErrorMessage());
                 return res;
            }
            else   
                for (Map result : results.getResult()) {
                       dbpassword=(String)result.get("password");
                       if (dbpassword.equals(escapeString(password)))
                       {
                           if ( ((int)result.get("level"))==9)     res="Y"; 
                       }  
                }      
          return res;
    } 
}
