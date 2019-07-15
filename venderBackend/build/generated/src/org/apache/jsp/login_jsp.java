package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

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

      out.write("\r\n");
      out.write(" \r\n");
      out.write("  \r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html lang=\"en\">\r\n");
      out.write("  <head>\r\n");
      out.write("    <meta charset=\"utf-8\">\r\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n");
      out.write("    <meta name=\"description\" content=\"\">\r\n");
      out.write("    <meta name=\"author\" content=\"Dashboard\">\r\n");
      out.write("\r\n");
      out.write("    <title>超樂漫畫-供應商管理系統</title>\r\n");
      out.write("\r\n");
      out.write("    <link href=\"assets/css/bootstrap.css\" rel=\"stylesheet\">\r\n");
      out.write("    <link href=\"assets/font-awesome/css/font-awesome.css\" rel=\"stylesheet\" />\r\n");
      out.write("    <link href=\"assets/css/style.css\" rel=\"stylesheet\">\r\n");
      out.write("    <link href=\"assets/css/style-responsive.css\" rel=\"stylesheet\">\r\n");
      out.write("    <link href=\"assets/css/table-responsive.css\" rel=\"stylesheet\"> \r\n");
      out.write("  </head> \r\n");
      out.write("\r\n");
      out.write("  <body>\r\n");
      out.write("\r\n");
      out.write("\t  \t  <div id=\"login-page\">\r\n");
      out.write("\t  \t<div class=\"container\">\r\n");
      out.write("\t  \t\r\n");
      out.write("\t\t      <form class=\"form-login\" method=\"post\"   name=\"fmLogin\" action=\"signOn.jsp\"> \r\n");
      out.write("\t\t        <h2 class=\"form-login-heading\">超樂漫畫-供應商管理系統</h2>\r\n");
      out.write("\t\t        <div class=\"login-wrap\">\r\n");
      out.write("                            <input type=\"hidden\" name=\"mode\" value=\"0\">\r\n");
      out.write("\t\t            <input type=\"text\"  name=\"txAccount\" id=\"txAccount\" class=\"form-control\" placeholder=\"User ID\"  required autofocus>\r\n");
      out.write("                            \r\n");
      out.write("\t\t            <br>\r\n");
      out.write("\t\t            <input type=\"password\" name=\"txPassword\" id=\"txPassword\" class=\"form-control\" required  placeholder=\"Password\"><br>\r\n");
      out.write("\r\n");
      out.write("\t\t            <button class=\"btn btn-theme02 btn-block\"    name=\"Submit\" type=\"submit\" ><i class=\"fa fa-lock\"></i>&ensp;登入</button><br>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t             <label class=\"checkbox text-center\">\t\t              \r\n");
      out.write("\t\t              <a data-toggle=\"modal\" href=\"login.jsp#myModal\"> 忘記密碼？</a>\t\r\n");
      out.write("                              &nbsp;&nbsp;&nbsp;&nbsp;<a   href=\"register.jsp\"> 註冊申請</a>\r\n");
      out.write("\t\t            </label>\r\n");
      out.write("                                                        \r\n");
      out.write("\t\t\r\n");
      out.write("\t\t        </div>\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t          <!-- Modal -->\r\n");
      out.write("\t\t          <div aria-hidden=\"true\" aria-labelledby=\"myModalLabel\" role=\"dialog\" tabindex=\"-1\" id=\"myModal\" class=\"modal fade\">\r\n");
      out.write("\t\t              <div class=\"modal-dialog\">\r\n");
      out.write("\t\t                  <div class=\"modal-content\">\r\n");
      out.write("\t\t                      <div class=\"modal-header\">\r\n");
      out.write("\t\t                          <button type=\"button\"   onclick=\"checkUser()\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">&times;</button>\r\n");
      out.write("\t\t                          <h4 class=\"modal-title\">忘記密碼？</h4>\r\n");
      out.write("\t\t                      </div>\r\n");
      out.write("\t\t                      <div class=\"modal-body\">\r\n");
      out.write("\t\t                          <h4>請聯絡 漫畫後台管理員電話(02)xxxxxxxx</h4>\t\t\r\n");
      out.write("\t\t                      </div>\r\n");
      out.write("\t\t                  </div>\r\n");
      out.write("\t\t              </div>\r\n");
      out.write("\t\t          </div> \r\n");
      out.write("                          \r\n");
      out.write("\t\t          <!-- modal -->\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t      </form>\t  \t\r\n");
      out.write("\t  \t\r\n");
      out.write("\t  \t</div>\r\n");
      out.write("\t  </div> \r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("    <script src=\"assets/js/jquery.js\"></script>\r\n");
      out.write("    <script src=\"assets/js/bootstrap.min.js\"></script>\r\n");
      out.write("    <script type=\"text/javascript\" src=\"assets/js/jquery.backstretch.min.js\"></script>\r\n");
      out.write("    <script>\r\n");
      out.write("        $.backstretch(\"assets/img/login-bg.jpg\", {speed: 500});\r\n");
      out.write("\t</script>  \r\n");
      out.write("\t \r\n");
      out.write("\r\n");
      out.write("  </body>\r\n");
      out.write("</html>\r\n");
      out.write("\r\n");
      out.write(" \r\n");
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
