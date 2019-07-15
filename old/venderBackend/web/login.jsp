<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
 
  
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Dashboard">

    <title>超樂漫畫-供應商管理系統</title>

    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="assets/css/style.css" rel="stylesheet">
    <link href="assets/css/style-responsive.css" rel="stylesheet">
    <link href="assets/css/table-responsive.css" rel="stylesheet"> 
    
    
  </head> 

  <body>

	  	  <div id="login-page">
	  	<div class="container">
	  	
		      <form class="form-login" method="post"     name="fmLogin" action="signOn.jsp"> 
		        <h2 class="form-login-heading">超樂漫畫-供應商管理系統</h2>
		        <div class="login-wrap">
                            <input type="hidden" name="mode" value="0">
		            <input type="text"  name="txAccount" id="txAccount" class="form-control" placeholder="User ID"  required autofocus>
                            
		            <br>
		            <input type="password" name="txPassword" id="txPassword" class="form-control" required  placeholder="Password"><br>

		            <button class="btn btn-theme02 btn-block"    name="Submit" type="submit"  ><i class="fa fa-lock"></i>&ensp;登入</button><br>
					
		             <label class="checkbox text-center">		              
		              <a data-toggle="modal" href="login.jsp#myModal"> 忘記密碼？</a>	
                              &nbsp;&nbsp;&nbsp;&nbsp;<a   href="register.jsp"> 註冊申請</a>
		            </label>
                                                        
		
		        </div>
		
		          <!-- Modal -->
		          <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
		              <div class="modal-dialog">
		                  <div class="modal-content">
		                      <div class="modal-header">
		                          <button type="button"   onclick="checkUser()" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                          <h4 class="modal-title">忘記密碼？</h4>
		                      </div>
		                      <div class="modal-body">
		                          <h4>請聯絡 漫畫後台管理員電話(02)xxxxxxxx</h4>		
		                      </div>
		                  </div>
		              </div>
		          </div> 
                          
		          <!-- modal -->
		
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

 
