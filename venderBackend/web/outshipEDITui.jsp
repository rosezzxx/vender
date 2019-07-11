<%-- 
    Document   : outshipEDITui
    Created on : 2019/7/9, 下午 04:52:20
    Author     : user
--%>

<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %> 
<%@include file="./utility/pageInit.jsp" %>  
<%@include file="./utility/Pagination.jsp" %> 


<%    String orderID = request.getParameter("orderID");

    //填空區一 ,請注意:設定程式選單的主題
    pgTitle = "出貨單明細";      // 作業名稱
    funcTitle = "";                           // 功能名稱
    pgURL = "outshipEDITui.jsp";        // 程式名稱   
    menuSno = "2";                     // 選單的群組之明細定義-請參考代碼自行修改各程式所屬的功能群組  
    maxPagelist = 5;
    /*填空區一二 ,功能連結宣告----------------------------*/

 /*---------------------------------------------------------------------*/
    //填空區三 ,請注意:開始設定本程式程式的查詢邏輯
    String mainSQL = "SELECT c.name1,b.amount,b.qty,b.total  FROM purchase a inner join purchase_list b on a.orderID=b.orderID inner join prod_base c on b.prodID=c.prodID  ";   // 預設查詢主體
    String countSQL = "SELECT count(*) as count  FROM purchase a inner join purchase_list b on a.orderID=b.orderID inner join prod_base c on b.prodID=c.prodID  ";   // 預設查詢主體的資料庫數量SQL  
    String defFilterSQLcomm = " WHERE a.orderID='" + orderID + "' and c.pdVendorID='"+sysuserID+"' ";     // 預設查詢-過濾主體的SQL  
    String verFilterSQL = " WHERE a.orderID='" + orderID + "' and c.pdVendorID='"+sysuserID+"'  order by orderID desc"; // 變化組合的查詢條件SQL   

    // 組合過濾條件 :不需異動
    sqlFilter = (searchkey.length() == 0) ? defFilterSQLcomm : verFilterSQL;
    System.out.println(sqlFilter);
    //取得主體資料庫資料數量 :不需異動
    ListResult dataCount = DBcomic.execSql(countSQL + sqlFilter);
    numOfDatacount = (Long) dataCount.getResult().get(0).get("count");
    // Pagenation 相關設定 1 :不需異動
    DbPagination pagination = DBcomic.getPagination(numOfDatacount, currentPage, maxPagelist);
    // 填空區四:  定義顯示主體的資料表結果名稱 範例 venders
    ListResult outships = DBcomic.execSql(mainSQL + sqlFilter + pagination.getDbLimit());
    // Pagenation 相關設定 2  :不需異動
    WebPagination rPagination = new Bootstrap4RangePagination(numOfDatacount, currentPage, maxPagelist);
    rPagination.setUrlPattern(pgURL + "?" + httpRequest.getNewParameters());

    Date orderDate ; //訂貨日期
    int recvAmount ; //單品金額
    String recvName = ""; //收貨人姓名
    String recvTel = ""; //收貨人電話
    String recvAddress = ""; //收貨人地址
    String recvareaNo = ""; //收貨人郵遞區號 
    String recvMemo = ""; //收貨人備註
    String invoiceType =""; //發票聯別 
    String invoiceSno =""; //發票統編 
    String invoiceTitle =""; //發票抬頭 
    String shipmentNo =""; //物流編號
 
   
    
    
    ListResult purchaseResult = DBcomic.execSql("select *  from purchase WHERE orderID='"+orderID+"' ");
    //numOfDatacount = (Long) purchaseResult.getResult().get(0).get("count");
    if (numOfDatacount == 0L) {
        // 無資料查詢  
        response.sendRedirect("./ErrorMessage.jsp?errorno=3&errorbackURL=outship.jsp");
        return;
    } else {
        orderDate=  (Date) purchaseResult.getResult().get(0).get("orderDate"); //訂貨日期
        recvAmount =(int) purchaseResult.getResult().get(0).get("recvAmount"); //應收總金額
        recvName=(String) purchaseResult.getResult().get(0).get("recvName"); //收貨人姓名
        recvTel=(String) purchaseResult.getResult().get(0).get("recvTel"); //收貨人電話
        recvAddress=(String) purchaseResult.getResult().get(0).get("recvAddress"); //收貨人地址
        recvareaNo=(String) purchaseResult.getResult().get(0).get("recvareaNo"); //收貨人郵遞區號
        recvMemo=(String) purchaseResult.getResult().get(0).get("recvMemo"); //收貨人備註
        invoiceType=(String) purchaseResult.getResult().get(0).get("invoiceType"); //發票聯別
        invoiceSno=(String) purchaseResult.getResult().get(0).get("invoiceSno"); //發票統編
        invoiceTitle=(String) purchaseResult.getResult().get(0).get("invoiceTitle"); //發票抬頭
        shipmentNo=(String) purchaseResult.getResult().get(0).get("shipmentNo"); //物流編號
        
    }


    String nextActionFunction="outshipEDITdata.jsp";

%>
<!DOCTYPE html>
<html>
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

                            <form class="form-inline"  >         
                                <div class="alert alert-info" >
                                    <%
                                        out.println("訂單編號：" + orderID + "<br/>");
                                        out.println("訂單時間：" + orderDate + "<br/>");
                                        out.println("訂單合計：" + recvAmount);
                                    %>
                                </div>
                            </form>

                            <form class="form-inline">
                                <div class="form-group">
                                    資料共 <span class="badge bg-success" style="font-size:20px;"><%="" + numOfDatacount%></span> 筆  

                                </div> 


                                <div class="btn-group pull-right mr-20">
                                    <button type="button" class="btn btn-theme03">供應商分類查詢</button>
                                    <button type="button" class="btn btn-theme03 dropdown-toggle" data-toggle="dropdown">
                                        <span class="caret"></span>
                                        <span class="sr-only">Toggle Dropdown</span>
                                    </button>

                                    <ul class="dropdown-menu" role="menu">
                                        <li><a href="venderList.jsp">全部</a></li>
                                            <% // defcode 進入資料載入.....      commSQL = "SELECT * FROM defcode where   codeType='W' and      sno>0   ";
                                                ListResult companyTypeLists = DBcomic.execSql(commSQL);
                                                for (Map companyTypeList : companyTypeLists.getResult()) {
                                            %>
                                        <li><a href="venderList.jsp?companyType=<%=companyTypeList.get("codeType")%><%=companyTypeList.get("sno")%>" ><%=companyTypeList.get("codedesc")%></a></li>	
                                            <%
                                                }
                                            %> 


                                    </ul>

                                </div> 
                            </form> 
                            <section id="no-more-tables">
                                <table class="table table-bordered table-striped table-condensed cf">
                                    <thead class="cf">
                                        <tr>
                                            <th>No.</th>
                                            <th>產品名稱</th>
                                            <th>單品金額</th>
                                            <th>數量</th>
                                            <th>小計金額</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            // 計算起始序號 ，選擇欄位
                                            Long i = (Long) rPagination.getOffset() + 1;
                                            //  填空區五:  DBgrid 填充區開始，請注意.....
                                            for (Map outship : outships.getResult()) {
                                        %>
                                        <tr>
                                            <td data-title="序"> <%= i++%></td>
                                            <td data-title="產品名稱"><%=outship.get("name1")%> </td>
                                            <td data-title="單品金額"><%=outship.get("amount")%></td>
                                            <td data-title="數量"><%=outship.get("qty")%></td>
                                            <td data-title="小計金額"><%=outship.get("total")%> </td>

                                        </tr>
                                        <%}  %> 

                                    </tbody>
                                </table>
                            </section>
                                        
                            <form class="form-horizontal style-form" method="post"   name="fm"  action="<%=nextActionFunction%>">
                                <div class="form-group">
                                    <span class="badge bg-success" style="font-size:20px;">收件人資料</span><br/>
                                     <table  class="table table-bordered table-striped table-condensed cf">
                                         <tr>
                                            <td width="15%">姓名</td>
                                            <td><%=recvName%></td><input type="hidden" value="<%=recvName%>" name="recvName">
                                         </tr>
                                         <tr>
                                            <td>行動電話</td>
                                            <td><%=recvTel%></td><input type="hidden" value="<%=recvTel%>" name="recvTel">
                                         </tr>
                                         <tr>
                                            <td>郵遞區號</td>
                                            <td><%=recvareaNo%></td><input type="hidden" value="<%=recvareaNo%>" name="recvareaNo">
                                         </tr>
                                          <tr>
                                            <td>地址</td>
                                            <td><%=recvAddress%></td><input type="hidden" value="<%=recvAddress%>" name="recvAddress">
                                         </tr>
                                         <tr>
                                            <td>收貨人備註</td>
                                            <td><%=recvMemo%></td><input type="hidden" value="<%=recvMemo%>" name="recvMemo">
                                         </tr>
                                     </table>
                                </div>
                                 <div class="form-group">
                                    <span class="badge bg-success" style="font-size:20px;">發票資訊</span><br/>
                                     <table  class="table table-bordered table-striped table-condensed cf">
                                         <tr>
                                            <td width="15%">發票格式</td>
                                            <td><%=invoiceType%>聯</td><input type="hidden" value="<%=invoiceType%>" name="invoiceType">
                                         </tr>
                                         <tr>
                                            <td>發票統編</td>
                                            <td><%=invoiceSno%></td><input type="hidden" value="<%=invoiceSno%>" name="invoiceSno">
                                         </tr>
                                          <tr>
                                            <td>發票抬頭</td>
                                            <td><%=invoiceTitle%></td><input type="hidden" value="<%=invoiceTitle%>" name="invoiceTitle">
                                         </tr>
                                     </table>
                                </div>
                                <div class="form-group">
                                    <span class="badge bg-success" style="font-size:20px;">運送方式</span><br/>
                                     <table  class="table table-bordered table-striped table-condensed cf">
                                         <tr>
                                            <td width="15%">宅配</td>
                                         <input type="hidden" name="orderID" value="<%=orderID%>">
                                            <td>台灣黑貓宅急便（追蹤號碼：<input type="text" name="shipmentNo" value="<%=shipmentNo%>">）</td>
                                         </tr>
                                         
                                     </table>
                                </div>
                                         
                                <%
                                    
                                    ListResult shipsel = DBcomic.execSql("select * from shiporder  where orderID='"+ orderID +"'  ; " );
                                     
                                    Date shiporderDate ;
                                    shiporderDate=(Date) shipsel.getResult().get(0).get("shiporderDate"); //預計出貨日期
                                    String shipMemo="";
                                    shipMemo=(String) shipsel.getResult().get(0).get("shipMemo"); //出貨備註 

                                %>
                                 <div class="form-group">
                                    <span class="badge bg-success" style="font-size:20px;">出貨進度</span><br/>
                                     <table  class="table table-bordered table-striped table-condensed cf">
                                         <tr>
                                            <td width="15%">預計出貨日期</td>
                                            <td><input type="date" value="<%=shiporderDate%>" name="shiporderDate"></td>
                                         </tr>
                                          <tr>
                                            <td width="15%">出貨狀態</td>
                                            <td>
                                                 <% String sta= (String) purchaseResult.getResult().get(0).get("traceStatus"); %>
                                            <select name="traceStatus">
                                                   <% // defcode 進入資料載入..... 
                                                        commSQL = "SELECT * FROM defcode where  codeType='D' and   sno>0   ";
                                                        ListResult defcode__D = DBcomic.execSql(commSQL );
                                                        for (Map defcode_D : defcode__D.getResult()) {
                                                           
                                                            if(sta.equals(defcode_D.get("codeType")+""+defcode_D.get("sno"))){
                                                                
                                                    %>
                                                                <option value="<%=defcode_D.get("codeType") %><%=defcode_D.get("sno")%>" selected><%=defcode_D.get("codedesc") %>
                                                    <%
                                                            }else{ 
                                                    %>
                                                                <option value="<%=defcode_D.get("codeType") %><%=defcode_D.get("sno")%>"><%=defcode_D.get("codedesc") %>
                                                    <%
                                                            }
                                                        }
                                                    %> 
                                                                                                       
                                            </select>
                                            </td>
                                         </tr>
                                          <tr>
                                            <td width="15%">出貨備註</td>
                                            <td><textarea rows="5" cols="30" name="shipMemo"><%=shipMemo%></textarea></td>
                                         </tr>
                                     </table>
                                </div>       
                                
                                <div class="row text-center wow fadeInUp">
                                    <div class="outer-ss">
                                        <a href="javascript: document.fm.submit();" class="btn btn-pink"  ><i class="fa fa-check" > </i>&ensp;確認</a>
                                        <a href="javascript: history.back();" class="btn btn-pink"  ><i class="fa fa-sign-out" > </i>&ensp;返回</a>                                
                                    </div>     
                                </div>
                            </form>
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
