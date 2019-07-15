package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.util.*;
import java.util.Map;
import java.util.Date;
import com.vender.ListResult;
import com.vender.http.RequestParameters;
import com.vender.db.comicDb;
import com.vender.db.superDb;
import com.vender.web.Bootstrap4RangePagination;
import com.vender.web.WebPagination;
import com.vender.Pagination;
import com.vender.DbPagination;
import java.sql.*;

public final class outship_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList<String>(3);
    _jspx_dependants.add("/./utility/pageInit.jsp");
    _jspx_dependants.add("/./utility/Pagination.jsp");
    _jspx_dependants.add("/./utility/funcMenu.jsp");
  }

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html; charset=utf-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			"", true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

 
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

 /*-------------- pageInit.jsp 宣告之公用變數如下 -------------------*/
 /* 使用者過濾基本鍵值 :String searchkey                             */
 /* 使用者過濾條件使用變數 String sqlFilter                          */
 /* 使用者過取得資料數量變數 Long numOfDatacount =0L;                */
 /*----------------------------------------------------------------*/
 /* 請注意: 如果有其他參數，照樣要組合 verFilterSQL                  */
 /*-------------------------------------------------------------- -*/
//填空區一 ,請注意:設定程式選單的主題
    pgTitle = "出貨單維護";      // 作業名稱
    funcTitle = "";                  // 功能名稱
    pgURL = "outship.jsp";        // 程式名稱   
    menuSno = "2";                   // 選單的群組之明細定義-請參考代碼自行修改各程式所屬的功能群組  
    maxPagelist = 10;
 /*填空區一二 ,功能連結宣告----------------------------*/
    /*String addFuncDesc = "新增供應商資料";
    String addFunc = "register.jsp?Mode=1";*/
    String editFuncDesc = "&nbsp;查看";
    String editFunc = "outshipEDITui.jsp?orderID=";
    String deletFuncDesc = "&nbsp;刪除";
    String deletFunc = "outshipDELETEui.jsp?orderID=";

/*---------------------------------------------------------------------*/
    //填空區三 ,請注意:開始設定本程式程式的查詢邏輯
    
    //取得參數值
    String pdVenderID = request.getParameter("pdVenderID");
    
    System.out.println("pdVenderID="+sysuserID);
    
    String mainSQL = "SELECT distinct a.orderID,a.orderDate,a.recvName,a.recvAddress,a.recvTel,a.traceStatus,c.pdVendorID FROM purchase a inner join purchase_list b on a.orderID=b.orderID inner join prod_base c on b.prodID=c.prodID   "; // 預設查詢主體
    String countSQL = "SELECT count(distinct a.orderID) as count FROM purchase a inner join purchase_list b on a.orderID=b.orderID inner join prod_base c on b.prodID=c.prodID "; // 預設查詢主體的資料庫數量SQL  
    String defFilterSQLcomm = " WHERE c.pdVendorID='"+sysuserID+"' order by a.orderID ";     // 預設查詢-過濾主體的SQL  
    String verFilterSQL = "     WHERE c.pdVendorID='"+sysuserID+"' order by a.orderID "; // 變化組合的查詢條件SQL           
     
    
    // 組合過濾條件 :不需異動
    sqlFilter = (searchkey.length() == 0) ? defFilterSQLcomm : verFilterSQL;
    //取得主體資料庫資料數量 :不需異動
    ListResult dataCount = DBcomic.execSql(countSQL + sqlFilter);
    numOfDatacount = (Long) dataCount.getResult().get(0).get("count");
    // Pagenation 相關設定 1 :不需異動
    DbPagination pagination = DBcomic.getPagination(numOfDatacount, currentPage, maxPagelist);
    // 填空區四:  定義顯示主體的資料表結果名稱 範例 venders
    ListResult outships = DBcomic.execSql(mainSQL + sqlFilter + pagination.getDbLimit());
    // Pagenation 相關設定 2  :不需異動
    WebPagination rPagination = new Bootstrap4RangePagination(numOfDatacount, currentPage,maxPagelist);
    rPagination.setUrlPattern(pgURL + "?" + httpRequest.getNewParameters());
    
    


      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("     <head>\n");
      out.write("        <meta charset=\"UTF-8\">\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=no\">\n");
      out.write("        <meta name=\"keywords\" content=\"comics, webtoon, manga\">\n");
      out.write("\n");
      out.write("        <title>超樂漫畫 ★供應商管理系統</title>\n");
      out.write("\n");
      out.write("        <link rel=\"stylesheet\" href=\"assets/css/bootstrap.css\">\t    \n");
      out.write("        <link rel=\"stylesheet\" href=\"assets/css/main.css\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"assets/css/owl.carousel.css\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"assets/css/owl.transitions.css\"> \n");
      out.write("        <link rel=\"stylesheet\" href=\"assets/css/font-awesome.css\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"assets/css/fontawesome/css/all.min.css\">\n");
      out.write("\n");
      out.write("    </head>\n");
      out.write("    <body class=\"book-home bg-gray\">\n");
      out.write("        <header class=\"header-style-1\">\n");
      out.write("            <div class=\"top-bar animate-dropdown\">\n");
      out.write("                <div class=\"container\">\n");
      out.write("                    <div class=\"header-top-inner\">\n");
      out.write("                        <div class=\"cnt-account\">\n");
      out.write("                            <ul class=\"list-unstyled\">\n");
      out.write("\n");
      out.write("                                <li><a href=\"login.jsp\"><i class=\"icon fa fa-lock\"></i>登出</a></li>\n");
      out.write("                            </ul>\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("                        <div class=\"clearfix\"></div>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <div class=\"main-header\">\n");
      out.write("                <div class=\"container\">\n");
      out.write("                    <div class=\"row\">\n");
      out.write("                        <div class=\"col-xs-12 col-sm-12 col-md-3 logo-holder\">\n");
      out.write("                            <a href=\"http://books.ubn.net/super8/web/index.jsp\"\">\t\n");
      out.write("                                <img src=\"assets/img/logo.png\" alt=\"logo\"/>\n");
      out.write("                            </a>\n");
      out.write("                        </div>\n");
      out.write("                        <div class=\"col-xs-12 col-sm-12 col-md-4 \">\n");
      out.write("                            <h2 class=\"form-login-heading\" style=\"color:red\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      out.print(pgTitle);
      out.write("</h2>\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("            <div class=\"header-nav animate-dropdown\">\n");
      out.write("                <div class=\"container\">\n");
      out.write("                    <div class=\"yamm navbar navbar-default\" role=\"navigation\">\n");
      out.write("                        <div class=\"navbar-header\">\n");
      out.write("                            <button data-target=\"#mc-horizontal-menu-collapse\" data-toggle=\"collapse\" class=\"navbar-toggle collapsed\" type=\"button\">\n");
      out.write("                                <span class=\"sr-only\">Toggle navigation</span>\n");
      out.write("                                <span class=\"icon-bar\"></span>\n");
      out.write("                                <span class=\"icon-bar\"></span>\n");
      out.write("                                <span class=\"icon-bar\"></span>\n");
      out.write("                            </button>\n");
      out.write("                        </div>\n");
      out.write("                        <div class=\"nav-bg-class\">\n");
      out.write("                            <div class=\"navbar-collapse collapse\" id=\"mc-horizontal-menu-collapse\">\n");
      out.write("                                <div class=\"nav-outer\">\n");
      out.write("                                    <ul class=\"nav navbar-nav\">\n");
      out.write("                                        <!-- 勿刪除   -->\n");
      out.write("                                        <!-- 固定位置縱橫選單   Begin 勿刪除 --> \n");
      out.write("                                        ");

                      
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
                        
 if (menuSno.equals("1"))  {  
      out.write("\r\n");
      out.write("                                     <a href=\"");
      out.print(vender_func.get("funcURL")+"?pdVenderID="+sysuserID );
      out.write("\"><i class=\"fa fa-sign-out\">&nbsp;");
      out.print(vender_func.get("funcdesc") );
      out.write("</i></a>\r\n");
      out.write("                              ");
 } else if (menuSno.equals("2"))  { 
      out.write("\r\n");
      out.write("                                     <a href=\"");
      out.print(vender_func.get("funcURL") );
      out.write("\"><i class=\"fa fa-sign-out\">&nbsp;");
      out.print(vender_func.get("funcdesc") );
      out.write("</i></a>\r\n");
      out.write("                               ");
} else { 
      out.write("\r\n");
      out.write("                                       <a href=\"");
      out.print(vender_func.get("funcURL"));
      out.write("\"><i class=\"fa fa-sign-out\">&nbsp;");
      out.print(vender_func.get("funcdesc") );
      out.write("</i></a>\r\n");
      out.write("                               ");
} 
      out.write("\r\n");
      out.write(" \r\n");
      out.write("\r\n");
      out.write("                         </li> \r\n");
      out.write("                     ");

                           }
                        }  
                     
      out.write("  \n");
      out.write("\n");
      out.write("                                    </ul>\n");
      out.write("                                </div>\n");
      out.write("                            </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("        </header>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("        <div class=\"body-content\">\t\n");
      out.write("            <div class=\"container\"> \n");
      out.write("                <div class=\"row\"><div class=\"col-sm-6\"></div><br/></div>\n");
      out.write("                <div class=\"row mt\">\n");
      out.write("                    <div class=\"col-lg-12\">\n");
      out.write("                        <div class=\"content-panel\">\n");
      out.write("\n");
      out.write("                            <form class=\"form-inline\">\n");
      out.write("                                <div class=\"form-group\">\n");
      out.write("                                    資料共 <span class=\"badge bg-success\" style=\"font-size:20px;\">");
      out.print("" + numOfDatacount);
      out.write("</span> 筆  \n");
      out.write("\n");
      out.write("                                    <input type=\"text\" value=\"");
      out.print(searchkey);
      out.write("\" placeholder=\"請填入關鍵字\" name=\"searchkey\" id=\"search\" class=\"form-control\" size=\"30\">\n");
      out.write("                                </div> \n");
      out.write("\n");
      out.write("                                \n");
      out.write("\n");
      out.write("\n");
      out.write("                                <div class=\"btn-group pull-right mr-20\">\n");
      out.write("                                    <button type=\"button\" class=\"btn btn-theme03\">供應商分類查詢</button>\n");
      out.write("                                    <button type=\"button\" class=\"btn btn-theme03 dropdown-toggle\" data-toggle=\"dropdown\">\n");
      out.write("                                        <span class=\"caret\"></span>\n");
      out.write("                                        <span class=\"sr-only\">Toggle Dropdown</span>\n");
      out.write("                                    </button>\n");
      out.write("                                    \n");
      out.write("                                          <ul class=\"dropdown-menu\" role=\"menu\">\n");
      out.write("                                                <li><a href=\"venderList.jsp\">全部</a></li>\n");
      out.write("                                                    ");
 // defcode 進入資料載入..... 
                                                               commSQL = "SELECT * FROM defcode where   codeType='W' and      sno>0   ";
                                                               ListResult companyTypeLists = DBcomic.execSql(commSQL );
                                                                for (Map companyTypeList : companyTypeLists.getResult()) { 
                                                    
      out.write("\n");
      out.write("                                                <li><a href=\"venderList.jsp?companyType=");
      out.print(companyTypeList.get("codeType") );
      out.print(companyTypeList.get("sno"));
      out.write("\" >");
      out.print(companyTypeList.get("codedesc"));
      out.write("</a></li>\t\n");
      out.write("                                                    ");

                                                        }
                                                    
      out.write(" \n");
      out.write("\n");
      out.write("\n");
      out.write("                                            </ul>\n");
      out.write("                                    \n");
      out.write("                                </div> \n");
      out.write("                            </form> \n");
      out.write("                            <section id=\"no-more-tables\">\n");
      out.write("                                <table class=\"table table-bordered table-striped table-condensed cf\">\n");
      out.write("                                    <thead class=\"cf\">\n");
      out.write("                                        <tr>\n");
      out.write("                                            <th>No.</th>\n");
      out.write("                                            <th>訂單編號</th>\n");
      out.write("                                            <th>訂單日期</th>                                            \n");
      out.write("                                            <th>收件人</th>\n");
      out.write("                                            <th>地址</th>\n");
      out.write("                                            <th>聯絡電話</th>\n");
      out.write("                                            <th>狀態</th>\n");
      out.write("                                            <th>異動</th>\n");
      out.write("                                        </tr>\n");
      out.write("                                    </thead>\n");
      out.write("                                    <tbody>\n");
      out.write("                                        ");

                                            // 計算起始序號 ，選擇欄位
                                            Long i = (Long) rPagination.getOffset() + 1;
                                            //  填空區五:  DBgrid 填充區開始，請注意.....
                                            for (Map outship : outships.getResult()) {
                                        
      out.write("\n");
      out.write("                                        <tr>\n");
      out.write("                                            <td data-title=\"序\"> ");
      out.print( i++);
      out.write("</td>\n");
      out.write("                                            <td data-title=\"訂單編號\">");
      out.print(outship.get("orderID").toString().replace(searchkey, "<span class=\"text-danger\">" + searchkey + "</span>"));
      out.write(" </td>\n");
      out.write("                                            <td data-title=\"訂單日期\">");
      out.print(outship.get("orderDate"));
      out.write("</td>\n");
      out.write("                                            <td data-title=\"收件人\">");
      out.print(outship.get("recvName").toString().replace(searchkey, "<span class=\"text-danger\">" + searchkey + "</span>"));
      out.write("</td>\n");
      out.write("                                            <td data-title=\"地址\">");
      out.print(outship.get("recvAddress"));
      out.write(" </td>\n");
      out.write("                                            <td data-title=\"聯絡電話\">");
      out.print(outship.get("recvTel").toString().replace(searchkey, "<span class=\"text-danger\">" + searchkey + "</span>"));
      out.write(" </td>                                                            \n");
      out.write("                                            <td data-title=\"狀態\">\n");
      out.write("                                               ");
 String sta= outship.get("traceStatus").toString();  
      out.write("\n");
      out.write("                                               <select>\n");
      out.write("                                                   ");
 // defcode 進入資料載入..... 
                                                        commSQL = "SELECT * FROM defcode where  codeType='D' and   sno>0   ";
                                                        ListResult defcode__D = DBcomic.execSql(commSQL );
                                                        for (Map defcode_D : defcode__D.getResult()) {
                                                           
                                                            if(sta.equals(defcode_D.get("codeType")+""+defcode_D.get("sno"))){
                                                                
                                                    
      out.write("\n");
      out.write("                                                                <option value=\"");
      out.print(defcode_D.get("codeType") );
      out.print(defcode_D.get("sno"));
      out.write("\" selected>");
      out.print(defcode_D.get("codedesc") );

                                                            }else{ 
                                                    
      out.write("\n");
      out.write("                                                                <option value=\"");
      out.print(defcode_D.get("codeType") );
      out.print(defcode_D.get("sno"));
      out.write('"');
      out.write('>');
      out.print(defcode_D.get("codedesc") );

                                                            }
                                                        }
                                                    
      out.write(" \n");
      out.write("                                                                                                       \n");
      out.write("                                                </select>\n");
      out.write("                                            </td>\n");
      out.write("                                            \n");
      out.write("                                            <td data-title=\"異動\"> \n");
      out.write("                                                <div>\n");
      out.write("                                                    <a class=\"btn btn-primary btn-sm\" role=\"button\" href=\"");
      out.print(editFunc);
      out.print(outship.get("orderID"));
      out.write("\"><i class=\"fas fa-pen\"></i>");
      out.print(editFuncDesc);
      out.write("</a>\n");
      out.write("                                                    <a class=\"btn btn-danger btn-sm\" role=\"button\"  href=\"");
      out.print(deletFunc);
      out.print(outship.get("orderID"));
      out.write("\"><i class=\"fas fa-trash-alt\"></i>");
      out.print(deletFuncDesc);
      out.write("</a>\n");
      out.write("\n");
      out.write("                                                </div>\n");
      out.write("                                            </td>\n");
      out.write("                                        </tr>\n");
      out.write("                                        ");
     }  
      out.write(" \n");
      out.write("\n");
      out.write("                                    </tbody>\n");
      out.write("                                </table>\n");
      out.write("                            </section>\n");
      out.write("                                        \n");
      out.write("                                  \n");
      out.write("                            <div class=\"pages text-center\">\n");
      out.write("                                <div class=\"btn-group\"> \n");
      out.write("\n");
      out.write("                                    ");
 if (rPagination.getEndPage() > 1) {
      out.write("\n");
      out.write("                                    <nav aria-label=\"Page navigation  \">\n");
      out.write("                                        <ul class=\"pagination\"> \n");
      out.write("                                                <li class=\"page-item\"><a class=\"page-link\" href=\"");
      out.print(rPagination.getPrevPagesUrl());
      out.write("\"><i class=\"fas fa-angle-double-left\"></i></a></li>  \n");
      out.write("                                            <li class=\"page-item\"><a class=\"page-link\" href=\"");
      out.print(rPagination.getPrevUrl());
      out.write("\"><i class=\"fas fa-angle-left\"></i></a></li>\n");
      out.write("                                                    ");
 for (Map pageRow : rPagination.getPages().getResult()) {
      out.write("\n");
      out.write("                                            <li class=\"page-item ");
      out.print(pageRow.getOrDefault("active", ""));
      out.write("\" ><a class=\"page-link\" href=\"");
      out.print(pageRow.get("url"));
      out.write('"');
      out.write('>');
      out.print(pageRow.get("page"));
      out.write("</a></li>\n");
      out.write("                                                ");
 }
      out.write("\n");
      out.write("                                            <li class=\"page-item\"><a class=\"page-link\" href=\"");
      out.print(rPagination.getNextUrl());
      out.write("\"><i class=\"fas fa-angle-right\"></i></i></a></li>\n");
      out.write("                                            <li class=\"page-item\"><a class=\"page-link\" href=\"");
      out.print(rPagination.getNextPagesUrl());
      out.write("\"><i class=\"fas fa-angle-double-right\"></i></a></li>\n");
      out.write("                                        </ul>\n");
      out.write("                                    </nav>\n");
      out.write("                                    ");
 }
      out.write("      \n");
      out.write("\n");
      out.write("                                </div>      \t\t\t\t\n");
      out.write("                            </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("                        </div><!-- /content-panel -->\n");
      out.write("                    </div><!-- /col-lg-12 -->\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <div class=\"footer text-center\">\n");
      out.write("            <div class=\"container\">\n");
      out.write("                <img src=\"assets/img/sofunlogo.png\" width=\"150\" height=\"117\" alt=\"logo\"/>\n");
      out.write("                <div class=\"gray\"><a href=\"about.html\">關於我們</a> ｜ <a href=\"announce.html\">最新公告</a> ｜ <a href=\"terms.html\">使用條款</a> ｜ <a href=\"ppolicy.html\">隱私權政策</a> ｜ <a href=\"faq.html\">常見問題</a> ｜ <a href=\"coo.html\">合作洽詢</a> ｜ <a href=\"sitemap.html\">網站地圖</a>\n");
      out.write("                    <ul class=\"social-footer list-unstyled list-inline\">\n");
      out.write("                        <li><a href=\"https://zh-tw.facebook.com/gsicomic/\" target=\"_blank\"><i class=\"fab fa-facebook\"></i></a></li>\n");
      out.write("                        <li><a href=\"https://www.youtube.com/channel/UC5ctKL6753xEbfzrc7xqnwA\" target=\"_blank\"><i class=\"fab fa-youtube\"></i></a></li>\n");
      out.write("                    </ul> \n");
      out.write("                    <p>Copyright © Linfinity Inc. All Rights Reserved. 領飛無限 著作權所有</p>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <script src=\"assets/js/jquery-1.11.1.min.js\"></script>\n");
      out.write("\n");
      out.write("        <script src=\"assets/js/bootstrap.min.js\"></script>\n");
      out.write("\n");
      out.write("        <script src=\"assets/js/bootstrap-hover-dropdown.min.js\"></script>\n");
      out.write("        <script src=\"assets/js/owl.carousel.min.js\"></script>\n");
      out.write("\n");
      out.write("        <script src=\"assets/js/echo.min.js\"></script>\n");
      out.write("        <script src=\"assets/js/jquery.easing-1.3.min.js\"></script>\n");
      out.write("        <script src=\"assets/js/bootstrap-slider.min.js\"></script>\n");
      out.write("        <script src=\"assets/js/jquery.rateit.min.js\"></script>\n");
      out.write("        <script type=\"text/javascript\" src=\"assets/js/lightbox.min.js\"></script>\n");
      out.write("        <script src=\"assets/js/bootstrap-select.min.js\"></script>\n");
      out.write("        <script src=\"assets/js/wow.min.js\"></script>\n");
      out.write("        <script src=\"assets/js/scripts.js\"></script>\n");
      out.write("\n");
      out.write("\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
