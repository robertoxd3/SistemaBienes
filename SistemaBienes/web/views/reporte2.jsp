<%@page import="com.model.Usuario"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager" %>
<%@page import="net.sf.jasperreports.*"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
         if (session.getAttribute("usuario") != null || session.getAttribute("gerente") != null) {
        Usuario usuario = null;
        if (session.getAttribute("usuario") != null) {
            usuario = (Usuario) session.getAttribute("usuario");
        } else {
            usuario = (Usuario) session.getAttribute("gerente");
        }
        
        %>
        <%
            if(request.getParameter("id")!=null){
            int id= Integer.parseInt(request.getParameter("id"));
            
            Connection cn;
                Class.forName("com.mysql.jdbc.Driver");
                cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bienes", "root", "");
	
            File reportFile = new File(application.getRealPath("reportes/reporteTraspasos.jasper"));
            Map parameters = new HashMap();
              

            //parameters.put("nombre_del_parametro_jasper", "valor que se manda");
            parameters.put("id",id);
            
            
            byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, cn);
            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream outputStream = response.getOutputStream();
            outputStream.write(bytes, 0, bytes.length);
            outputStream.flush();
            outputStream.close();
            
            } else{
             out.print("<h1>Id no fue seleccionado, intente de nuevo</h1>");
            }

        %>
        
         <% } else {
        response.sendError(response.SC_FORBIDDEN, "Pagina no autorizada");
    }
    %>

    </body>
</html>