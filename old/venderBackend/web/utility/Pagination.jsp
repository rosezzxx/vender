<%-- 
    Document   : Pagination
    Created on : Mar 5, 2019, 9:51:11 AM
    Author     : Aiwa.wu
--%>
<%@page import="com.vender.web.Bootstrap4RangePagination"%> 
<%@page import="com.vender.web.WebPagination"%> 
<%@page import="com.vender.Pagination"%>
<%@page import="com.vender.DbPagination"%>
 
<%
    Long currentPage = Long.parseLong(httpRequest.get("txTOPAGE"));
    String ListPageNo ="";
    
    /* Page  
    
     Long numOfdefcodes=DBcomic.getTableCount(    "defcode" , sqlFilter  ); 
      String pageLimit=null;
      System.out.println("numOfdefcodes=="+Long.toString(numOfdefcodes));
      
    MySqlPagination pagination = new MySqlPagination(numOfdefcodes, currentPage, 10);
    pageLimit=pagination.getDbLimit(); 
    
     ListResult defcodes = DBcomic.execSql("SELECT * FROM defcode" + sqlFilter + pageLimit);
       WebPagination rPagination = new Bootstrap4RangePagination(numOfdefcodes, currentPage, 10);
       rPagination.setUrlPattern("testdefcode.jsp?txTOPAGE=(:pg:)" + urlParameters); 
    */
%>
 