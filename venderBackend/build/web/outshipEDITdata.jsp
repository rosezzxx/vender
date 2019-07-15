<%-- 
    Document   : outshipEDITdata
    Created on : 2019/7/11, 上午 11:59:12
    Author     : user
--%>

<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>

<%@include file="./utility/updateData.jsp" %>



<%
 /*-------------- pageInit.jsp 宣告之公用變數如下 -----------------------*/
 /*  使用者過濾基本鍵值 :String searchkey                                */
 /* 使用者過濾條件使用變數 String sqlFilter                             */
 /* 使用者過取得資料數量變數 Long numOfDatacount =0L;                   */
 /*-------------------------------------------------------------------*/
 /* 請注意: 如果有其他參數，照樣要組合 verFilterSQL                      */
 /*-------------------------------------------------------------------*/
    //填空區一 ,請注意:設定程式選單的主題
    pgTitle = "出貨單維護";               // 作業名稱
    funcTitle = "";                                // 功能名稱
    pgURL = "outshipEDITdata.jsp";                                    // 返回程式名稱   
    menuSno = "1";                            // 選單的群組之明細定義-請參考代碼自行修改各程式所屬的功能群組  

    /*---------------------------------------------------------------------*/
    //取得參數值
    String orderID = request.getParameter("orderID"); //訂單編號
    String shipmentNo = request.getParameter("shipmentNo"); //物流編號
    String shiporderDate = request.getParameter("shiporderDate"); //預計出貨日期
    String traceStatus = request.getParameter("traceStatus"); //出貨狀態
    String shipMemo = request.getParameter("shipMemo"); //出貨備註
    
    
    String recvName = request.getParameter("recvName"); //姓名    
    String recvTel = request.getParameter("recvTel"); //行動電話
    String recvareaNo = request.getParameter("recvareaNo"); //郵遞區號
    String recvAddress = request.getParameter("recvAddress"); //地址
    String recvMemo = request.getParameter("recvMemo"); //收貨人備註
    String invoiceType = request.getParameter("invoiceType"); //發票格式
    String invoiceSno = request.getParameter("invoiceSno"); //發票統編
    String invoiceTitle = request.getParameter("invoiceTitle"); //發票抬頭
    
    
    String Mode =  request.getParameter("Mode");
    
    
    String SaveMessage = "";
    String backFuncDesc = "返前頁";
    String backFunc = "outship.jsp ";
    
    
    String mainSQL = "select * from shiporder   ";   // 預設查詢主體
    String countSQL = "select count(*) from shiporder   ";   // 預設查詢主體的資料庫數量SQL  
    String defFilterSQLcomm = " where orderID='"+orderID+"' ";     // 預設查詢-過濾主體的SQL  
    String verFilterSQL = " where orderID='"+orderID+"' "; // 變化組合的查詢條件SQL   
    
    ListResult defcodeResult = DBcomic.execSql("select *,count(*) as count from shiporder  where orderID='"+orderID+"'  ");
    System.out.println("123==="+"select *,count(*) as count from shiporder  where orderID='"+orderID+"'  ");
    Long counn = (Long) defcodeResult.getResult().get(0).get("count");
    if (counn == 0) {
        // 無資料查詢  
         
       commSQL = "INSERT INTO `shiporder` (`shiporderID`, `orderID`, `shipNo`, `shiporderDate`, `traceStatus`, `pdVendorID`, `isOver`, `shipProdQty`, `shipProdTotalQty`, `payType`, `memID`, `recvName`, `areaNo`, `recvAddress`, `recvTel`, `recvMemo`, `noticeYN`, `shipMemo`) ";
       commSQL=commSQL+" VALUES (NULL, "+DBcomic.psString(orderID)+", '', "+DBcomic.psString(shiporderDate)+", "+DBcomic.psString(traceStatus)+", '"+ sysuserID +"', 'N', NULL, NULL, NULL, NULL, "+DBcomic.psString(recvName)+", "+DBcomic.psString(recvareaNo)+", "+DBcomic.psString(recvAddress)+", "+DBcomic.psString(recvTel)+", "+DBcomic.psString(recvMemo)+", NULL, "+DBcomic.psString(shipMemo)+")";
       
       ListResult insertResult = DBcomic.UpdatePsSql(commSQL);
        if (insertResult.getErrorMessage() == null) {
            SaveMessage = pgTitle + "-" + funcTitle + insertResult.getResult().get(0).get("count") + " 筆  成功  !!";
        } else {
            SaveMessage = pgTitle + "-" + funcTitle + " 失敗  !! <br/>" + "失敗原因:" + insertResult.getErrorMessage();
            
        }
       
       
    } else {
       commSQL = "UPDATE shiporder SET shiporderDate=" + DBcomic.psString(shiporderDate) + ",  traceStatus=" + DBcomic.psString(traceStatus) + ", shipMemo=" + DBcomic.psString(shipMemo) + "  ";
       commSQL = commSQL + " WHERE  orderID=" + DBcomic.psString(orderID)+" ; ";
       
        ListResult updateResult = DBcomic.UpdatePsSql(commSQL);
        if (updateResult.getErrorMessage() == null) {
            SaveMessage = pgTitle + "---" + funcTitle + updateResult.getResult().get(0).get("count") + " 筆  成功  !!";
        } else {
            SaveMessage = pgTitle + "-" + funcTitle + " 失敗  !! <br/>" + "失敗原因:" + updateResult.getErrorMessage();
            
        }
        
    }
    
    commSQL=" UPDATE `purchase` SET `shipmentNo` = "+DBcomic.psString(shipmentNo)+" ,  traceStatus=" + DBcomic.psString(traceStatus) + " WHERE `purchase`.`orderID` = '" + orderID + "' ;";
   
    
    ListResult updateResult = DBcomic.UpdatePsSql(commSQL);
    if (updateResult.getErrorMessage() == null) {
        SaveMessage = pgTitle + "---" + funcTitle + updateResult.getResult().get(0).get("count") + " 筆  成功  !!";
    } else {
        SaveMessage = pgTitle + "-" + funcTitle + " 失敗  !! <br/>" + "失敗原因:" + updateResult.getErrorMessage();
        
    }






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
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">

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
                                <img src="assets/img/logo.png" alt="logo" />
                            </a>
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-7 top-search-holder">
                            <h2 class="form-login-heading" style="color:red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;供應商管理系統</h2>
                        </div>

                    </div>
                </div>
            </div>


            <div class="header-nav animate-dropdown">
                <div class="container">
                    <div class="yamm navbar navbar-default" role="navigation">
                        <div class="navbar-header">
                            <button data-target="#mc-horizontal-menu-collapse" data-toggle="collapse"
                                    class="navbar-toggle collapsed" type="button">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                        </div>
                        <% System.out.println("Mode==="+Mode);
                            if (Mode != null ) {%>
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
                        <%}%>          
                    </div>
                </div>
            </div>

        </header>



        <div class="body-content">
            <div class="container">
                <div class="row">
                    <div class="col-sm-6"></div><br />
                </div>
                <div class="row mt">
                    <div class="col-lg-12">
                        <div class="form-panel">                
                            <h4 style="color: crimson" class="text-center txt-padding">
                                <%=SaveMessage%></h4>
                            <div><br/><br/><br/></div>
                            <div class="form-group add-task-row text-center">
                                <a class="btn btn-default" href="<%=backFunc%>"><i class="fa fa-reply "></i><%=backFuncDesc%></a>
                            </div> 

                        </div>
                    </div>
                </div> 



            </div>
        </div>

        <div class="footer text-center">
            <div class="container">
                <img src="assets/img/sofunlogo.png" width="150" height="117" alt="logo" />
                <div class="gray"><a href="about.html">關於我們</a> ｜ <a href="announce.html">最新公告</a> ｜ <a
                        href="terms.html">使用條款</a> ｜ <a href="ppolicy.html">隱私權政策</a> ｜ <a href="faq.html">常見問題</a> ｜ <a
                        href="coo.html">合作洽詢</a> ｜ <a href="sitemap.html">網站地圖</a>
                    <ul class="social-footer list-unstyled list-inline">
                        <li><a href="https://zh-tw.facebook.com/gsicomic/" target="_blank"><i
                                    class="fab fa-facebook"></i></a></li>
                        <li><a href="https://www.youtube.com/channel/UC5ctKL6753xEbfzrc7xqnwA" target="_blank"><i
                                    class="fab fa-youtube"></i></a></li>
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
