<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
 <%@page import="com.vender.db.superDb"%>
<%@page import="com.vender.db.comicDb"%>
<%@page import="com.vender.ListResult"%>
<%@page import="java.util.List,java.util.Map"%> 
<% 
      String txAccount="";
      String txPassword="";
      String pgName="signOn.jsp";
     
       ListResult  venderResults;
       String  successURL="venderEDITui.jsp";
     //  String  successURL="authorize_form.html";
      String rolelevel="";
    
     
      
        txAccount=(String)request.getParameter("txAccount");  
        txPassword =(String)request.getParameter("txPassword"); 
     
     
     
     
     if (txAccount==null || txPassword==null )  
     {
        response.sendRedirect("./ErrorLogin.jsp"); 
        return;   
      }    
 
     String  commSQL="";
      
     String  Checkresult="";
     String  username="";      // 使用者名稱
     String  userID="";            // 使用者ID
     
      String  userLevel="0";   // 使用者的權限層級 0:一般使用者    9:系統管理者
     
      superDb DBsuper = new superDb();
      comicDb DBcomic = new comicDb();
     
      Checkresult=DBsuper.CheckAdminUserValid( txAccount,txPassword);   
      if (DBsuper.CheckAdminUserValid( txAccount,txPassword).equals("Y"))
      {    
                userLevel="9"; 
                session.setAttribute("account",txAccount);
                session.setAttribute("password",txPassword);  
                session.setAttribute("username","系統管理員");  
                session.setAttribute("sysuserID","");  
                session.setAttribute("userLevel",userLevel);  
                session.setAttribute("menumode",userLevel);   
              
                response.sendRedirect("venderList.jsp" ); 
      }
      else
      {
             Checkresult=DBcomic.CheckUserValid( txAccount,txPassword);
      }
      
      if (Checkresult.equals("No staff"))
      {
        response.sendRedirect("./ErrorLogin.jsp?errorno=1"); 
        return;   
      }   
      else
      {   
          if (Checkresult==null)  
          {
              response.sendRedirect("./ErrorLogin.jsp?errorno=5"); 
             return;   
          }
          commSQL="SELECT * FROM  vender  where    pdVenderID= "+Checkresult+" ; "; 
          
          venderResults=DBcomic.execSql( commSQL);
          if (venderResults.getErrorMessage() == null) {
                List<Map<String, Object>> venderResult =  venderResults.getResult();
                for (Map<String, Object> vender : venderResult) {  
                    username= (String)vender.get("name");             // 使用者姓名 
                    rolelevel=   vender.get("level").toString();                       // 使用者層級
                    userID= vender.get("pdVenderID").toString();       // 使用者ID
                                           // 使用者的權限層級 0:一般使用者  
                 } 
                 session.setAttribute("account",txAccount);
                 session.setAttribute("password",txPassword);  
                 session.setAttribute("username",username);  
                 session.setAttribute("sysuserID",userID);  
                 session.setAttribute("userLevel" ,rolelevel);   //  2019-04-11 新增使用者權限 
                 session.setAttribute("menumode",userLevel);   
                 response.sendRedirect(successURL+"?pdVenderID="+userID); 
          }
          else {
                  out.println( "【問題來自於: "+pgName+"】: "+venderResults.getErrorMessage());
                 
           } 
         
      }    

%>  
 