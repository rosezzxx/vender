<%-- 
用於一般查詢的PageInit
    Document   : pageInit.jsp
    Created on : Mar 5, 2019, 9:51:11 AM
    Author     : aiwa.wu
--%> 
<%@ page contentType="text/html; charset=utf-8" language="java" 
         import="java.util.*" 
         import="java.util.Map"
         import="java.util.Date"
         errorPage="" %>  
         
<%@page trimDirectiveWhitespaces="true"%>  
<%@page import="com.vender.ListResult"%>
<%@page import="com.vender.http.RequestParameters"%>
<%@page import="com.vender.db.comicDb"%>
<%@page import="com.vender.db.superDb"%>   
 
<% 
         request.setCharacterEncoding("utf-8");     
        /* 取得參數資料*/
             RequestParameters httpRequest=new RequestParameters(request);
            httpRequest.setDefault("txTOPAGE", "1");
            httpRequest.set("txTOPAGE", "(:pg:)"); 
            // 設定parameter預設值
            httpRequest.setDefault("searchkey", "");    // 若 searchkey 抓不到，傳回空字串
            String searchkey = httpRequest.get("searchkey");
            String urlParameters = httpRequest.getNewParameters();  // 取得 URL Query Parameters
            
            
             String sqlFilter="";                   // 使用者過濾條件使用變數
             Long numOfDatacount =0L;  // 使用者過取得資料數量變數   

           comicDb DBcomic  = new comicDb(); 
            superDb DBsuper = new superDb(); 
    
            String systemTitle="超樂漫畫-供應商管理系統";
            String funcTitle="";
            String pgTitle="";
            String pgURL="";
            int  maxPagelist=10;
            String menuActive="class=\"active\"";     
            String menuFuncGroup="B1";                       
            String   menuFuncID="1";                            
            String  menuSno="1";                                         
            String commSQL="";
            String commSQLcount="";
            Calendar today=new GregorianCalendar();
            String Now=today.get(Calendar.YEAR)+"-"+(today.get(Calendar.MONTH)+1)+"-"+today.get(Calendar.DATE);
  
            Date  startTime=new Date(session.getCreationTime());
            Date  lastTime=new Date(session.getLastAccessedTime());
            Date  nowTime=new Date();
            long  nowSecond=nowTime.getTime();

            long  session_MaxInactiveInterval=session.getMaxInactiveInterval();
            long startSecond=startTime.getTime();
            long lastSecond=lastTime.getTime();
            long diffSecond=(nowSecond-lastSecond)/1000;   
            if (diffSecond>session_MaxInactiveInterval)  
            {  
             response.sendRedirect("./ErrorLogin.jsp?errorno=4");   
             return;
            } 

//----------Session Process ------ 
            String account    =(String)session.getAttribute("account");
            String password   =(String)session.getAttribute("password"); 
            String username   =(String)session.getAttribute("username");       
            String sysuserID   =(String)session.getAttribute("sysuserID");     
            String userLevel   =(String)session.getAttribute("userLevel");      


            
   // System.out.println("this is  read.Web username from super8 username=="+username);
   // System.out.println("this is  read.Web sysuserID from super8 sysuserID=="+sysuserID);
   // System.out.println("this is  read.Web username from super8 account=="+account); 
            

            session.setAttribute("account",account);
            session.setAttribute("password",password);  
            session.setAttribute("username",username);  
            session.setAttribute("sysuserID",sysuserID);   
             session.setAttribute("userLevel",userLevel);   
            String Checkresult=null; 

          if (DBsuper.CheckAdminUserValid( account,password).equals("N"))
          {   
               Checkresult=DBcomic.CheckUserValid( account,password);
               if (Checkresult.equals("No staff"))
               {
                     response.sendRedirect("./ErrorLogin.jsp?errorno=1");  
                     return;  
               }   
          } 
       
%>