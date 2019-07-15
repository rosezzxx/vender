<%-- 
    Document   : vender_funcEDITdata
    Created on : 2019/7/9, 下午 05:28:19
    Author     : user
--%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@include file="./utility/updateData.jsp" %>
<%    /*-------------- pageInit.jsp 宣告之公用變數如下 -----------------------*/
 /*  使用者過濾基本鍵值 :String searchkey                                */
 /* 使用者過濾條件使用變數 String sqlFilter                             */
 /* 使用者過取得資料數量變數 Long numOfDatacount =0L;                   */
 /*-------------------------------------------------------------------*/
 /* 請注意: 如果有其他參數，照樣要組合 verFilterSQL                      */
 /*-------------------------------------------------------------------*/
    //填空區一 ,請注意:設定程式選單的主題
    pgTitle = "供應商後台功能選單";               // 作業名稱
    funcTitle = "更新";                                // 功能名稱
    pgURL = "vender_funcEDITdata.jsp";                                    // 程式名稱   
    menuSno = "2";                            // 選單的群組之明細定義-請參考代碼自行修改各程式所屬的功能群組  

    String backFuncDesc = "&nbsp;回供應商後台功能選單設定";
    String backFunc = "vender_func.jsp?txTOPAGE=1";

    /*---------------------------------------------------------------------*/
    //取得參數值
    String SaveMessage = "";

    String editMode = request.getParameter("editMode");
    String funcID = request.getParameter("funcID");
    String sno = request.getParameter("sno");
    String funcdesc = request.getParameter("funcdesc");
    String funcURL = request.getParameter("funcURL");
    String funcYN = request.getParameter("funcYN");
    String isOK = request.getParameter("isOK");
    String writer = request.getParameter("writer");
    String createDate = request.getParameter("createDate");
    String planDate = request.getParameter("planDate");
    String finishDate = request.getParameter("finishDate");
    String onLine = request.getParameter("onLine");
    String pgDesc = request.getParameter("pgDesc");
    String pgcount = request.getParameter("pgcount");
    String finishRate = request.getParameter("finishRate");
        String level = request.getParameter("level");

    if (editMode.equals("D")) {
        funcTitle = "刪除";
        commSQL = "DELETE FROM  vender_func ";
        commSQL = commSQL + "WHERE  funcID =  " + DBcomic.psString(funcID) + " ;";    // 刪除所有的類別
        ListResult deleteResult = DBcomic.UpdatePsSql(commSQL);
        if (deleteResult.getErrorMessage() == null) {
            SaveMessage = pgTitle + "-" + funcTitle + deleteResult.getResult().get(0).get("count") + "筆  成功  !!";
        } else {
            SaveMessage = pgTitle + "-" + funcTitle + " 失敗  !! 失敗原因:" + deleteResult.getErrorMessage();
        }
    } else {
        commSQL = "UPDATE vender_func SET sno=" + DBcomic.psString(sno) + ", ";
        commSQL = commSQL + "funcdesc=" + DBcomic.psString(funcdesc) + ", ";
        commSQL = commSQL + "funcURL=" + DBcomic.psString(funcURL) + ", ";
        commSQL = commSQL + "funcYN=" + DBcomic.psString(funcYN) + ", ";
        commSQL = commSQL + "isOK=" + DBcomic.psString(isOK) + ", ";
        commSQL = commSQL + "writer=" + DBcomic.psString(writer) + ", ";
        commSQL = commSQL + "createDate=" + DBcomic.psString(createDate) + ", ";
        commSQL = commSQL + "planDate=" + DBcomic.psString(planDate) + ", ";
        commSQL = commSQL + "finishDate=" + DBcomic.psString(finishDate) + ",  ";
        commSQL = commSQL + "onLine=" + DBcomic.psString(onLine) + ", ";
        commSQL = commSQL + "pgDesc=" + DBcomic.psString(pgDesc) + ",  ";
        commSQL = commSQL + "pgcount=" + DBcomic.psString(pgcount) + ", ";
        commSQL = commSQL + "finishRate=" + DBcomic.psString(finishRate) + ", ";
        commSQL = commSQL + "level=" + DBcomic.psString(level) + "  ";
        commSQL = commSQL + "WHERE  funcID=" + DBcomic.psString(funcID);

        ListResult updateResult = DBcomic.UpdatePsSql(commSQL);
        if (updateResult.getErrorMessage() == null) {
            SaveMessage = pgTitle + "-" + funcTitle + updateResult.getResult().get(0).get("count") + " 筆  成功  !!";
        } else {
            SaveMessage = pgTitle + "-" + funcTitle + " 失敗  !! <br/>" + "失敗原因:" + updateResult.getErrorMessage();
        }
    }

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