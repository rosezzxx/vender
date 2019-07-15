<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %> 
<%@include file="./utility/pageInit.jsp" %>  
<%@include file="./utility/Pagination.jsp" %> 
<%-- 
    Document   : venderList
    Created on : 2019/4/11, 上午 11:00:40
    Author     : aiwa
--%>
<% /*-------------- pageInit.jsp 宣告之公用變數如下 -------------------*/
 /* 使用者過濾基本鍵值 :String searchkey                                            */
 /* 使用者過濾條件使用變數 String sqlFilter                                        */
 /* 使用者過取得資料數量變數 Long numOfDatacount =0L;          */
 /*--------------------------------------------------------------------*/
 /* 請注意: 如果有其他參數，照樣要組合 verFilterSQL                       */
 /*--------------------------------------------------------------------*/
    //填空區一 ,請注意:設定程式選單的主題
    pgTitle = "供應商資料維護";      // 作業名稱
    funcTitle = "";                           // 功能名稱
    pgURL = "venderList.jsp";        // 程式名稱   
    menuSno = "1";                     // 選單的群組之明細定義-請參考代碼自行修改各程式所屬的功能群組  
    maxPagelist=5;
    /*填空區一二 ,功能連結宣告----------------------------*/
    String addFuncDesc = "新增供應商資料";
    String addFunc = "register.jsp?Mode=1";
    String editFuncDesc = "&nbsp;修改";
    String editFunc = "venderEDITui.jsp?Mode=1&pdVenderID=";
    String deletFuncDesc = "&nbsp;刪除";
    String deletFunc = "./venderDELETEui.jsp?pdVenderID=";

    /*---------------------------------------------------------------------*/
    //填空區三 ,請注意:開始設定本程式程式的查詢邏輯
    String mainSQL = "SELECT * FROM vender ";                           // 預設查詢主體
    String countSQL = "SELECT count(*) AS count FROM vender  ";          // 預設查詢主體的資料庫數量SQL  
    String defFilterSQLcomm = "  order by createDate desc ";     // 預設查詢-過濾主體的SQL  
    String verFilterSQL = " WHERE    companyName  LIKE '%" + DBcomic.escapeString(searchkey) + "%' order by createDate desc"; // 變化組合的查詢條件SQL           
    // 組合過濾條件 :不需異動
    sqlFilter = (searchkey.length() == 0) ? defFilterSQLcomm : verFilterSQL;
    //取得主體資料庫資料數量 :不需異動
    ListResult dataCount = DBcomic.execSql(countSQL + sqlFilter);
    numOfDatacount = (Long) dataCount.getResult().get(0).get("count");
    // Pagenation 相關設定 1 :不需異動
    DbPagination pagination = DBcomic.getPagination(numOfDatacount, currentPage, maxPagelist);
    // 填空區四:  定義顯示主體的資料表結果名稱 範例 venders
    ListResult venders = DBcomic.execSql(mainSQL + sqlFilter + pagination.getDbLimit());
    // Pagenation 相關設定 2  :不需異動
    WebPagination rPagination = new Bootstrap4RangePagination(numOfDatacount, currentPage,maxPagelist);
    rPagination.setUrlPattern(pgURL + "?" + httpRequest.getNewParameters());
%>


<!DOCTYPE html>
<html lang="zh-Hant-TW">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
        <meta name="keywords" content="comics, webtoon, manga">

        <title>超樂漫畫 ★供應商管理系統</title>

        <link rel="stylesheet" href="assets/css/bootstrap.css">	    
        <link rel="stylesheet" href="assets/css/main.css">
        <link rel="stylesheet" href="assets/css/owl.carousel.css">
        <link rel="stylesheet" href="assets/css/owl.transitions.css"> 
        <link rel="stylesheet" href="assets/css/font-awesome.css">
        <link rel="stylesheet" href="assets/css/fontawesome/css/all.min.css">

    </head>

    <body class="book-home bg-gray">
        <header class="header-style-1">
            <div class="top-bar animate-dropdown">
                <div class="container">
                    <div class="header-top-inner">
                        <div class="cnt-account">
                            <ul class="list-unstyled">

                                <li><a href="login.jsp"><i class="icon fa fa-lock"></i>登出</a></li>
                            </ul>
                        </div>


                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>

            <div class="main-header">
                <div class="container">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-3 logo-holder">
                            <a href="http://books.ubn.net/super8/web/index.jsp"">	
                                <img src="assets/img/logo.png" alt="logo"/>
                            </a>
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-4 ">
                            <h2 class="form-login-heading" style="color:red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=pgTitle%></h2>
                        </div>

                    </div>
                </div>
            </div>


            <div class="header-nav animate-dropdown">
                <div class="container">
                    <div class="yamm navbar navbar-default" role="navigation">
                        <div class="navbar-header">
                            <button data-target="#mc-horizontal-menu-collapse" data-toggle="collapse" class="navbar-toggle collapsed" type="button">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                        </div>
                        <div class="nav-bg-class">
                            <div class="navbar-collapse collapse" id="mc-horizontal-menu-collapse">
                                <div class="nav-outer">
                                    <ul class="nav navbar-nav">
                                        <!-- 勿刪除   -->
                                        <!-- 固定位置縱橫選單   Begin 勿刪除 --> 
                                        <%@include file="./utility/funcMenu.jsp" %>  

                                    </ul>
                                </div>
                            </div>


                        </div>
                    </div>
                </div>
            </div>

        </header>



        <div class="body-content">	
            <div class="container"> 
                <div class="row"><div class="col-sm-6"></div><br/></div>
                <div class="row mt">
                    <div class="col-lg-12">
                        <div class="content-panel">

                            <form class="form-inline">
                                <div class="form-group">
                                    資料共 <span class="badge bg-success" style="font-size:20px;"><%="" + numOfDatacount%></span> 筆  

                                    <input type="text" value="<%=searchkey%>" placeholder="請填入公司名稱關鍵字" name="searchkey" id="search" class="form-control" size="30">
                                </div> 

                                <a class="btn btn-theme04" role="button" href="<%=addFunc%>"><%=addFuncDesc%></a> 


                                <div class="btn-group pull-right mr-20">
                                    <button type="button" class="btn btn-theme03">供應商分類查詢</button>
                                    <button type="button" class="btn btn-theme03 dropdown-toggle" data-toggle="dropdown">
                                        <span class="caret"></span>
                                        <span class="sr-only">Toggle Dropdown</span>
                                    </button>
                                    
                                          <ul class="dropdown-menu" role="menu">
                                                <li><a href="venderList.jsp">全部</a></li>
                                                    <% // defcode 進入資料載入..... 
                                                               commSQL = "SELECT * FROM defcode where   codeType='W' and      sno>0   ";
                                                               ListResult companyTypeLists = DBcomic.execSql(commSQL );
                                                                for (Map companyTypeList : companyTypeLists.getResult()) { 
                                                    %>
                                                <li><a href="venderList.jsp?companyType=<%=companyTypeList.get("codeType") %><%=companyTypeList.get("sno")%>" ><%=companyTypeList.get("codedesc")%></a></li>	
                                                    <%
                                                        }
                                                    %> 


                                            </ul>
                                    
                                </div> 
                            </form> 
                            <section id="no-more-tables">
                                <table class="table table-bordered table-striped table-condensed cf" >
                                    <thead class="cf">
                                        <tr>
                                            <th>No.</th>
                                            <th>供應商公司名稱</th>
                                            <th>聯絡人</th>
                                            <th>聯絡電話</th>
                                            <th>聯絡電郵</th>
                                            <th>公司類別</th>
                                            <th>註冊日期</th>
                                            <th>狀態</th>
                                            <th>異動</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            // 計算起始序號 ，選擇欄位
                                            Long i = (Long) rPagination.getOffset() + 1;
                                            //  填空區五:  DBgrid 填充區開始，請注意.....
                                            for (Map vender : venders.getResult()) {
                                        %>
                                        <tr>
                                            <td data-title="序"> <%= i++%></td>
                                            <td data-title="供應商公司名稱"><%=vender.get("companyName").toString().replace(searchkey, "<span class=\"text-danger\">" + searchkey + "</span>")%> </td>
                                            <td data-title="聯絡人"><%=vender.get("name")%></td>
                                            <td data-title="聯絡電話"><%=vender.get("mobilno")%></td>
                                            <td data-title="聯絡電郵"><%=vender.get("email")%> </td>
                                            <td data-title="公司類別"><%=  DBcomic.getCodeDescStr(vender.get("companyType").toString() )  %></td>
                                                            
                                            <td data-title="註冊日期"><%=vender.get("createDate")%></td>
                                            <td data-title="狀態"><%=vender.get("status")%></td>
                                            <td data-title="異動"> 
                                                <div>
                                                    <a class="btn btn-primary btn-sm" role="button" href="<%=editFunc%><%=vender.get("pdVenderID")%>"><i class="fas fa-pen"></i><%=editFuncDesc%></a>
                                                    <a class="btn btn-danger btn-sm" role="button"  href="<%=deletFunc%><%=vender.get("pdVenderID")%>"><i class="fas fa-trash-alt"></i><%=deletFuncDesc%></a>

                                                </div>
                                            </td>
                                        </tr>
                                        <%     }  %> 

                                    </tbody>
                                </table>
                            </section>
                                        
                                  
                            <div class="pages text-center">
                                <div class="btn-group"> 

                                    <% if (rPagination.getEndPage() > 1) {%>
                                    <nav aria-label="Page navigation  ">
                                        <ul class="pagination"> 
                                                <li class="page-item"><a class="page-link" href="<%=rPagination.getPrevPagesUrl()%>"><i class="fas fa-angle-double-left"></i></a></li>  
                                            <li class="page-item"><a class="page-link" href="<%=rPagination.getPrevUrl()%>"><i class="fas fa-angle-left"></i></a></li>
                                                    <% for (Map pageRow : rPagination.getPages().getResult()) {%>
                                            <li class="page-item <%=pageRow.getOrDefault("active", "")%>" ><a class="page-link" href="<%=pageRow.get("url")%>"><%=pageRow.get("page")%></a></li>
                                                <% }%>
                                            <li class="page-item"><a class="page-link" href="<%=rPagination.getNextUrl()%>"><i class="fas fa-angle-right"></i></i></a></li>
                                            <li class="page-item"><a class="page-link" href="<%=rPagination.getNextPagesUrl()%>"><i class="fas fa-angle-double-right"></i></a></li>
                                        </ul>
                                    </nav>
                                    <% }%>      

                                </div>      				
                            </div>



                        </div><!-- /content-panel -->
                    </div><!-- /col-lg-12 -->
                </div>



            </div>
        </div>

        <div class="footer text-center">
            <div class="container">
                <img src="assets/img/sofunlogo.png" width="150" height="117" alt="logo"/>
                <div class="gray"><a href="about.html">關於我們</a> ｜ <a href="announce.html">最新公告</a> ｜ <a href="terms.html">使用條款</a> ｜ <a href="ppolicy.html">隱私權政策</a> ｜ <a href="faq.html">常見問題</a> ｜ <a href="coo.html">合作洽詢</a> ｜ <a href="sitemap.html">網站地圖</a>
                    <ul class="social-footer list-unstyled list-inline">
                        <li><a href="https://zh-tw.facebook.com/gsicomic/" target="_blank"><i class="fab fa-facebook"></i></a></li>
                        <li><a href="https://www.youtube.com/channel/UC5ctKL6753xEbfzrc7xqnwA" target="_blank"><i class="fab fa-youtube"></i></a></li>
                    </ul> 
                    <p>Copyright © Linfinity Inc. All Rights Reserved. 領飛無限 著作權所有</p>
                </div>
            </div>
        </div>

        <script src="assets/js/jquery-1.11.1.min.js"></script>

        <script src="assets/js/bootstrap.min.js"></script>

        <script src="assets/js/bootstrap-hover-dropdown.min.js"></script>
        <script src="assets/js/owl.carousel.min.js"></script>

        <script src="assets/js/echo.min.js"></script>
        <script src="assets/js/jquery.easing-1.3.min.js"></script>
        <script src="assets/js/bootstrap-slider.min.js"></script>
        <script src="assets/js/jquery.rateit.min.js"></script>
        <script type="text/javascript" src="assets/js/lightbox.min.js"></script>
        <script src="assets/js/bootstrap-select.min.js"></script>
        <script src="assets/js/wow.min.js"></script>
        <script src="assets/js/scripts.js"></script>


    </body>
</html>
