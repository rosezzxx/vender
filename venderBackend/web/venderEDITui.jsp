<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@include file="./utility/pageInit.jsp" %>

<%-- 
    Document   : venderEDITui.jsp
    Created on : 2019/4/11, 下午 02:02:44
    Author     : user
--%>
<%    //取得參數值
    String pdVenderID = request.getParameter("pdVenderID");
    String Mode =  request.getParameter("Mode");
    
     if (Mode==null)        
     {    
         Mode="0";  //代表非系統使用者
         menuSno = "1";
     }
    else      
      menuSno = "1";
    String Password = "";
    String Name = "";
    String Email = "";
    String Mobilno = "";
    String AreaNo = "";
    String Address = "";
    String UniformNo = "";
    String CompanyName = "";
    String CompanyType = "";

    String vender_select="";
    if(pdVenderID!=null){
        vender_select="SELECT   password,name,email,mobilno,areano,address,uniformno,companyname,companyType,count(*) as count FROM vender where  pdVenderID="+pdVenderID;
    }else{
        vender_select="SELECT   password,name,email,mobilno,areano,address,uniformno,companyname,companyType,count(*) as count FROM vender where  pdVenderID="+sysuserID;
    }
    
    ListResult defcodeResult = DBcomic.execSql(vender_select);
    numOfDatacount = (Long) defcodeResult.getResult().get(0).get("count");
    if (numOfDatacount == 0L) {
        // 無資料查詢  
        response.sendRedirect("./ErrorMessage.jsp?errorno=3&errorbackURL=defcodeADDui_1.jsp");
        return;
    } else {
        Password = (String) defcodeResult.getResult().get(0).get("password");
        Name = (String) defcodeResult.getResult().get(0).get("name");
        Email = (String) defcodeResult.getResult().get(0).get("email");
        Mobilno = (String) defcodeResult.getResult().get(0).get("mobilno");
        AreaNo = (String) defcodeResult.getResult().get(0).get("areano");
        Address = (String) defcodeResult.getResult().get(0).get("address");
        UniformNo = (String) defcodeResult.getResult().get(0).get("uniformno");
        CompanyName = (String) defcodeResult.getResult().get(0).get("companyname");
        CompanyType = (String) defcodeResult.getResult().get(0).get("companyType");
    }

%>
<!DOCTYPE html>
<html lang="zh-Hant-TW">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
        <meta name="keywords" content="comics, webtoon, manga">

        <title>超樂漫畫 ★   供應商基本資料修正</title>

        <link rel="stylesheet" href="assets/css/bootstrap.css">
        <link rel="stylesheet" href="assets/css/main.css">
        <link rel="stylesheet" href="assets/css/owl.carousel.css">
        <link rel="stylesheet" href="assets/css/owl.transitions.css">

        <link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">
        <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />


    </head>
    <%        String nextActionFunction = "venderEDITdata.jsp";

    %>
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
                            <h2 class="form-login-heading" style="color:red">供應商管理系統 </h2>
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
                    <div class="col-sm-6"><br/></div>
                </div>
                <div class="form-panel">
                    <form class="form-horizontal style-form" method="post"   name="fm"  action="<%=nextActionFunction%>">
                        <div class="auth-page">
                            <div class="row mt"> 
                                <div class="col-sm-6"> 
                                    <div class="form-group">
                                        <label class="col-sm-4 col-sm-6 control-label">帳號(電子信箱) *</label>
                                        <div class="col-sm-6"> 
                                            <input type="hidden"  name="pdVenderID"  value="<%=pdVenderID%>" >
                                            <input type="hidden"  name="Mode"  value="<%=Mode%>" >
                                            <input type="text" class="form-control" name="Email"  value="<%=Email%>" required>
                                        </div>

                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 col-sm-6 control-label">密碼 *</label>
                                        <div class="col-sm-6">
                                            <input type="text" class="form-control" name="Password"  value="<%=Password%>" required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 col-sm-6 control-label">公司名稱 *</label>
                                        <div class="col-sm-6">
                                            <input type="text" class="form-control" name="CompanyName"  value="<%=CompanyName%>" required> 
                                        </div>
                                    </div>
                                    <div class="form-group">

                                        <label class="col-sm-4 col-sm-6 control-label">公司統一編號 *</label>
                                        <div class="col-sm-6">
                                            <input type="text" class="form-control"  name="UniformNo" value="<%=UniformNo%>"  required>
                                        </div>
                                    </div>
                                    <div class="form-group">

                                        <label class="col-sm-4 col-sm-6 control-label">供應商類型*</label>
                                        <div class="col-sm-6">
                                            <select class="form-control" name="CompanyType">
                                                <option value="W1" selected="true">漫畫出版商</option>
                                                <option value="W2">周邊商品供應商</option>
                                                <option value="W3">圖書出版社</option>
                                                <option value="W4">其他</option>
                                            </select>
                                        </div>
                                    </div>


                                </div>


                                <div class="col-sm-6">


                                    <div class="form-group">
                                        <label class="col-sm-4 col-sm-6 control-label">供應商聯絡人 *</label>
                                        <div class="col-sm-6">
                                            <input type="text" class="form-control" name="Name" value="<%=Name%>"  required>
                                        </div>
                                    </div>
                                    <div class="form-group">

                                        <label class="col-sm-4 col-sm-6 control-label">供應商聯絡電話 *</label>
                                        <div class="col-sm-6">
                                            <input type="text" class="form-control" name="Mobilno" value="<%=Mobilno%>"   required>
                                        </div>
                                    </div>
                                    <div class="form-group">

                                        <label class="col-sm-4 col-sm-6 control-label">郵遞區號 *</label>
                                        <div class="col-sm-6">
                                            <input type="text" class="form-control" name="AreaNo"  value="<%=AreaNo%>" required>
                                        </div>
                                    </div>
                                    <div class="form-group">                                       

                                        <label class="col-sm-4 col-sm-6 control-label">供應商地址 *</label>
                                        <div class="col-sm-6">
                                            <input type="text" class="form-control"  name="Address" value="<%=Address%>"  required>
                                        </div>
                                    </div>

                                </div>

                            </div>
                        </div>
                        <div class="row text-center wow fadeInUp">
                            <div class="outer-ss">
                                <a href="#" class="btn btn-black"><i class="fa fa-pencil-square-o"></i>&ensp;重填</a>
                                <a href="javascript: document.fm.submit();" class="btn btn-pink"  ><i class="fa fa-check"> </i>&ensp;確認</a>
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