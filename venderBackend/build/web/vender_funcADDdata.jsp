<%-- 
    Document   : vender_funcADDdata
    Created on : 2019/7/9, 下午 04:02:14
    Author     : user
--%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@include file="./utility/updateData.jsp" %>
<%    //填空區一 ,請注意:設定程式選單的主題
    pgTitle = "供應商後台功能選單";      // 作業名稱
    funcTitle = "新增";                           // 功能名稱
    pgURL = "vender_funcADDdata.jsp";        // 程式名稱  
    menuSno = "2";                     // 選單的群組之明細定義-請參考代碼自行修改各程式所屬的功能群組  
    /*填空區一二 ,功能連結宣告----------------------------*/
    String backFuncDesc = "&nbsp;回供應商後台功能選單設定";
    String backFunc = "vender_func.jsp?txTOPAGE=1";
    String backFunc1Desc = "&nbsp;繼續新增供應商後台功能選單";
    String backFunc1 = "vender_funcADDui.jsp";
    String SaveMessage = "";

    // 需要修改的部分 --begin
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
    
    if(createDate==null)createDate="0000-00-00";
    if(planDate==null)createDate="0000-00-00";
    if(finishDate==null)createDate="0000-00-00";
    
    commSQL = "INSERT INTO vender_func (sno,  funcdesc  ,funcURL ,funcYN ,isOK ,writer ,createDate ,planDate ,finishDate ,onLine,pgDesc ,pgcount ,finishRate,level)";
    commSQL = commSQL + "VALUES(" + DBcomic.psString(sno) + ", " + DBcomic.psString(funcdesc) + ", " + DBcomic.psString(funcURL) + ", " + DBcomic.psString(funcYN) + ", " + DBcomic.psString(isOK) + ", " + DBcomic.psString(writer) + ", " + DBcomic.psString(createDate) + ", " + DBcomic.psString(planDate) + ", " + DBcomic.psString(finishDate) + ", " + DBcomic.psString(onLine) + ", " + DBcomic.psString(pgDesc) + ", " + DBcomic.psString(pgcount) + ", " + DBcomic.psString(finishRate) + ", " + DBcomic.psString(level) + ");";

    ListResult insertResult = DBcomic.UpdatePsSql(commSQL);
    if (insertResult.getErrorMessage() == null) {
        SaveMessage = pgTitle + "-" + funcTitle + insertResult.getResult().get(0).get("count") + " 筆  成功  !!";
    } else {
        SaveMessage = pgTitle + "-" + funcTitle + " 失敗  !! 失敗原因:" + insertResult.getErrorMessage()+commSQL;
    }
%>

<!DOCTYPE html>
<html lang="zh-Hant-TW">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
        <meta name="keywords" content="comics, webtoon, manga">

        <title>超樂漫畫 ★供應商後台功能選單</title>

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
                            <h2 class="form-login-heading" style="color:red">供應商管理系統</h2>
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
