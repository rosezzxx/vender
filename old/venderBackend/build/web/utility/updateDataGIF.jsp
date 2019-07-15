<%-- 
    用於有圖檔上傳與資料異動的PageInit
    Document   : updateDataGIF.jsp
    Created on : 2019/4/15, 上午 11:01:40
    Author     : user
--%>

<%@ page contentType="text/html; charset=utf-8" language="java" 
         import="java.util.*" 
         import="java.util.Map"
         import="java.util.Date"
         import="java.io.File"
         import="com.oreilly.servlet.MultipartRequest"
         errorPage="" %>  
<%@page trimDirectiveWhitespaces="true"%>  
<%@page import="javax.sql.DataSource"%>
<%@ page import="java.util.*,javax.naming.*,java.sql.*" %>
<%@ page import="com.mysql.cj.*"%>
<%@ page import="java.util.List,java.util.Map"%>
<%@ page import="org.apache.commons.dbutils.BasicRowProcessor,org.apache.commons.dbutils.handlers.MapListHandler"%>
<%@page import="com.vender.ListResult"%>
<%@page import="com.vender.http.RequestParameters"%>
<%@page import="com.vender.db.comicDb"%>
<%@page import="com.vender.DbConnector"%>
 <%@page import="com.vender.db.superDb"%>


<% 
           request.setCharacterEncoding("utf-8");      
           comicDb DBcomic  = new comicDb();  
           superDb DBsuper = new superDb(); 
    
    
            String systemTitle="超樂漫畫-供應商管理系統";
            String funcTitle="";
            String pgTitle="";
            String pgURL=""; 
            String  menuSno="1";                                         
            String commSQL="";
            String commSQLcount="";
           
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