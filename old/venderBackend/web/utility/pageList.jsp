 <%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %> 

<%-- 
    Document   : pageList.jsp
    Created on : 2019/3/11, 下午 05:57:49
    Author     : Aiwa.wu
--%> 
<%
    /*
                   <div class="pages text-center">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-default">第一頁</button>
                                    <button type="button" class="btn btn-default">2</button>
                                    <button type="button" class="btn btn-default">3</button>
                                    <button type="button" class="btn btn-default">4</button>
                                    <button type="button" class="btn btn-default">5</button>
                                    <button type="button" class="btn btn-default">最末頁</button>
                                </div>      				
                            </div>
    */
 %>

 
 
 <div class="pages text-center">
                        <div class="btn-group"> 
                            
                           <% if (rPagination.getEndPage() > 1) {%>
                                <nav aria-label="Page navigation  ">
                                    <ul class="pagination">
                                        <li class="page-item"><a class="page-link" href="<%=rPagination.getPrevPagesUrl()%>"> <i class="fa fa-angle-double-left"></i></a></li>
                                        <li class="page-item"><a class="page-link" href="<%=rPagination.getPrevUrl()%>"> <i class="fa fa-angle-left"></i></a></li>
                            <% for (Map pageRow : rPagination.getPages().getResult()) {%>
                                        <li class="page-item <%=pageRow.getOrDefault("active", "")%>" ><a class="page-link" href="<%=pageRow.get("url")%>"><%=pageRow.get("page")%></a></li>
                            <% } %>
                                        <li class="page-item"><a class="page-link" href="<%=rPagination.getNextUrl()%>"> <i class="fa fa-angle-right"></i></i></a></li>
                                        <li class="page-item"><a class="page-link" href="<%=rPagination.getNextPagesUrl()%>"><i class="fa fa-angle-double-right"></i></a></li>
                                    </ul>
                                </nav>
                            <% } %>      
                             
                        </div>      				
                        </div>