<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%
    
     String errorno=(String)request.getParameter("errorno"); 

     String errordesc="";
        if (errorno==null) errorno="1"; 
        if (errorno.equals("1"))      errordesc="帳號密碼輸入錯誤，請重新輸入" ;
        else if (errorno.equals("2")) errordesc="你沒有權限使用此後台管理系統，請詢問後台管理員" ;
        else if (errorno.equals("3")) errordesc="資料庫無法開啟，請詢問後台管理員" ; 
        else if (errorno.equals("4")) errordesc="使用者登録時間逾期..." ;
        else if (errorno.equals("5")) errordesc="無法驗證使用者帳密資訊" ;
        else errordesc="使用者登録時間逾期..." ; 

%>    
  
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Dashboard">

    <title>超樂漫畫後台管理系統</title>

    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="assets/css/style.css" rel="stylesheet">
    <link href="assets/css/style-responsive.css" rel="stylesheet">
    <link href="assets/css/table-responsive.css" rel="stylesheet"> 
  </head> 

  <body>

	  	  <div id="login-page">
	  	<div class="container">
	  	
		      <form class="form-login" method="post"   name="fmLogin" action="../super8Web/loginDispatch.jsp"> 
		        <h2 class="form-login-heading">漫畫管理-供應商系統</h2>
		        <div class="login-wrap">
		            
					
		             <label class="checkbox text-center" >
                                 <a   href="./login.jsp"> 
                                     <div id="errormess"><%=errordesc%> </div></a> 
		            </label>

		
		        </div>
		
		          
		
		      </form>	  	
	  	
	  	</div>
	  </div>





    <script src="assets/js/jquery.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="assets/js/jquery.backstretch.min.js"></script>
    <script>
        $.backstretch("assets/img/login-bg.jpg", {speed: 500});
	</script> 
	

	
	 

  </body>
</html>

 
