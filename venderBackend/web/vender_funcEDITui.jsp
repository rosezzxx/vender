<%-- 
    Document   : vender_funcEDITui
    Created on : 2019/7/9, 下午 04:59:49
    Author     : user
--%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@include file="./utility/pageInit.jsp" %>
<%   
    //填空區一 ,請注意:設定程式選單的主題
    pgTitle = "供應商後台功能選單";               // 作業名稱
    funcTitle = "更新";                                // 功能名稱
    pgURL = "vender_funcEDITui.jsp";                                    // 程式名稱   
    menuSno = "2";                            // 選單的群組之明細定義-請參考代碼自行修改各程式所屬的功能群組  
    String nextActionFunction = "vender_funcEDITdata.jsp";
    
    //取得參數值
    int sno = 0;
    String funcdesc = "";
    String funcURL = "";
    String funcYN = "";
    String isOK = "";
    String writer = "";
    String createDate = "";
    String planDate = "";
    String finishDate = "";
    String onLine = "";
    String pgDesc = "";
    int pgcount = 0;
    int finishRate = 0;
    int level = 0;
    String funcID = request.getParameter("funcID");
    String editMode = request.getParameter("editMode");

    if (editMode.equals("D")) {
        funcTitle = "刪除";
    }

    ListResult defcodeResult = DBcomic.execSql("SELECT *,count(*) as count FROM vender_func where  funcID=" + funcID);
    numOfDatacount = (Long) defcodeResult.getResult().get(0).get("count");
    if (numOfDatacount == 0L) {
        // 無資料查詢  
        response.sendRedirect("./ErrorMessage.jsp?errorno=3&errorbackURL=vender_func.jsp");
        return;
    } else {
        sno = (Integer) defcodeResult.getResult().get(0).get("sno");
        funcdesc = (String) defcodeResult.getResult().get(0).get("funcdesc");
        funcURL = (String) defcodeResult.getResult().get(0).get("funcURL");
        funcYN = (String) defcodeResult.getResult().get(0).get("funcYN");
        isOK = (String) defcodeResult.getResult().get(0).get("isOK");
        writer = (String) defcodeResult.getResult().get(0).get("writer");
        createDate = (String) defcodeResult.getResult().get(0).get("createDate");
        planDate = (String) defcodeResult.getResult().get(0).get("planDate");
        finishDate = (String) defcodeResult.getResult().get(0).get("finishDate");
        onLine = (String) defcodeResult.getResult().get(0).get("onLine");
        pgDesc = (String) defcodeResult.getResult().get(0).get("pgDesc");
        pgcount = (Integer) defcodeResult.getResult().get(0).get("pgcount");
        finishRate = (Integer) defcodeResult.getResult().get(0).get("finishRate");
        level = (Integer) defcodeResult.getResult().get(0).get("level");
    }
%>
<!DOCTYPE html>
<html lang="zh-Hant-TW">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
        <meta name="keywords" content="comics, webtoon, manga">

        <title>超樂漫畫 ★   供應商後台功能選單</title>

        <link rel="stylesheet" href="assets/css/bootstrap.css">
        <link rel="stylesheet" href="assets/css/main.css">
        <link rel="stylesheet" href="assets/css/owl.carousel.css">
        <link rel="stylesheet" href="assets/css/owl.transitions.css">
        <link rel="stylesheet" href="assets/font-awesome/css/all.min.css">      
        <link rel="stylesheet" href="assets/font-awesome/css/font-awesome.css"/>


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
                            <a href="http://books.ubn.net/super8/web/index.jsp">
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
                <h3><%=pgTitle%> <i class="fa fa-angle-right"></i>&nbsp; <%=funcTitle%></h3>
                <div class="form-panel">
                    <form class="form-horizontal style-form" method="post"   name="fm"  action="<%=nextActionFunction%>">
                        <div class="auth-page">
                            <div class="row mt"> 
                                <input type="hidden"  name="funcID"  value="<%=funcID%>" >
                                <input type="hidden"  name="editMode"  value="<%=editMode%>" >
                                <div class="form-group">
                                    <label class="col-sm-4 col-sm-6 control-label">排序順序 *</label>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control" name="sno"  value="<%=sno%>" required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 col-sm-6 control-label">功能說明 *</label>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control" name="funcdesc"  value="<%=funcdesc%>" required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 col-sm-6 control-label">連結程式 *</label>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control" name="funcURL"  value="<%=funcURL%>" required> 
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 col-sm-6 control-label">是否使用</label>
                                    <div class="col-sm-6">
                                        <select class="form-control" name="funcYN">
                                            <option value="Y" <%if(funcYN.equals("Y")) out.println("selected='true'");%>>是</option>
                                            <option value="N" <%if(funcYN.equals("N")) out.println("selected='true'");%>>否</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 col-sm-6 control-label">程式是否完成</label>
                                    <div class="col-sm-6">
                                        <select class="form-control" name="isOK">
                                            <option value="Y" <%if(isOK.equals("Y")) out.println("selected='true'");%>>是</option>
                                            <option value="N" <%if(isOK.equals("N")) out.println("selected='true'");%>>否</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 col-sm-6 control-label">程式負責人</label>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control"  name="writer" value="<%=writer%>"  required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 col-sm-6 control-label">開始撰寫日期</label>
                                    <div class="col-sm-6">
                                        <input type="date" class="form-control"  name="createDate" value="<%=createDate%>"  required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 col-sm-6 control-label">預計完成日期</label>
                                    <div class="col-sm-6">
                                        <input type="date" class="form-control"  name="planDate" value="<%=planDate%>"  required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 col-sm-6 control-label">實際完成日期</label>
                                    <div class="col-sm-6">
                                        <input type="date" class="form-control"  name="finishDate" value="<%=finishDate%>"  required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 col-sm-6 control-label">是否上線</label>
                                    <div class="col-sm-6">
                                        <select class="form-control" name="onLine">
                                            <option value="Y" <%if(onLine.equals("Y")) out.println("selected='true'");%>>是</option>
                                            <option value="N" <%if(onLine.equals("N")) out.println("selected='true'");%>>否</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 col-sm-6 control-label">相關程式說明</label>
                                    <div class="col-sm-6">
                                        <textarea  rows="10" name="pgDesc" class="form-control" required><%=pgDesc%></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 col-sm-6 control-label">	含相關程式總計程式</label>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control"  name="pgcount" value="<%=pgcount%>"  required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 col-sm-6 control-label">完成進度</label>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control"  name="finishRate" value="<%=finishRate%>"  required>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 col-sm-6 control-label">使用者</label>
                                    <div class="col-sm-6">
                                        <select class="form-control" name="level">
                                            <option value="0" <%if(level==0) out.println("selected='true'");%>>一般使用者</option>
                                            <option value="5" <%if(level==5) out.println("selected='true'");%>>使用管理者</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                </div>
                <div class="row text-center wow fadeInUp">
                    <div class="outer-ss">
                        <a href="javascript: document.fm.submit();" class="btn btn-pink"  ><i class="fa fa-check"> </i>&ensp;確認</a>
                        <a href="javascript: history.back();" class="btn btn-black"><i class="fa fa-sign-out"></i>&ensp;返回</a>
                    </div>     
                </div>
                </form>
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