<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %> 
  
                     <%
                      
                       ListResult  vender_funcResult = DBcomic.execSql( "select * from vender_func where  level="+userLevel+"  order by  sno;");
                       if (vender_funcResult.getErrorMessage() == null) {
                            List<Map<String, Object>> result =  vender_funcResult.getResult();
                            for (Map<String, Object>  vender_func : result) { 
                                if ((   vender_func.get("sno").toString()).equals(menuSno))  
                                {
                                      out.print("<li  class=\"active\">");  
                                 } 
                                 else
                                 { 
                                     out.print ("<li>");
                                 }   
                        %>
                              <% //if ((Integer)vender_func.get("sno")==1)  {  %>
                                     <!--<a href="<%=vender_func.get("funcURL")+"?pdVenderID="+sysuserID %>"><i class="fa fa-sign-out">&nbsp;<%=vender_func.get("funcdesc") %></i></a>-->
                               <%//} else {%>
                                       <a href="<%=vender_func.get("funcURL")%>"><i class="fa fa-sign-out">&nbsp;<%=vender_func.get("funcdesc") %></i></a>
                               <%//} %>
 

                         </li> 
                     <%
                           }
                        }  
                     %> 

 