<%@page import="com.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.dao.DaoPropiedad"%>
<%@page import="com.dao.DaoUsuario"%>
<!DOCTYPE html>
<jsp:include page='nav.jsp'/>
<%
    if (session.getAttribute("usuario") != null || session.getAttribute("vendedor")!=null || session.getAttribute("gerente")!=null) {
       Usuario usuario = null;
          if (session.getAttribute("usuario") != null) {
                                     usuario = (Usuario) session.getAttribute("usuario");
                                } else if (session.getAttribute("vendedor") != null) {
                                     usuario = (Usuario) session.getAttribute("vendedor");
                                } else {
                                     usuario = (Usuario) session.getAttribute("gerente");
                                }
%>


<!--Main layout-->
<main style="margin-top: 58px">
    <div class="container pt-4">
        <h1 class="display-5 animate__animated animate__backInLeft">Reportes para <%= usuario.getNombre() %> </h1>

        <div class="row text-center text-lg-start animate__animated animate__backInLeft">
            <div class="col-lg-3 col-md-4 col-6"  id="reporteAdmin">
                <a  target="_blank" href="reporte1.jsp" class="d-block mb-4 h-100">
                    <div class="card text-white mb-3" style="max-width: 18rem; background-color: #2C3E50;"  id="cardCustom" >
                        <div class="card-header text-center">Reporte de accesos de usuarios</div>
                        <div class="card-body text-center">
                            <span class="card-text"> <i class="fa-solid fa-file-pdf fa-3x"></i></span><br>
                            <p class=" badge badge-info card-text">Reporte 1</p>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-lg-3 col-md-4 col-6">
                <a  target="_blank" href="reporte3.jsp" class="d-block mb-4 h-100">
                    <div class="card text-white mb-3" style="max-width: 18rem; background-color: #1F618D;">
                        <div class="card-header text-center">Reporte de activos totales</div>
                        <div class="card-body text-center">
                            <span class="card-text"><i class="fa-solid fa-file-pdf fa-3x"></i></span><br>
                            <p class=" badge badge-info card-text">Reporte 2</p>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>
    <!--Container-->
</main>
<!--Main layout-->

<% if(usuario.getTipo()==1){
		
	}else if(usuario.getTipo()==2){
		out.println("<script> $('#reporteAdmin').hide(); </script>");
	} else{
           out.println("<script> $('#reporteAdmin').hide();  </script>");
        }
%>

<% } else {
        response.sendError(response.SC_FORBIDDEN, "Pagina no autorizada");
        //response.sendRedirect("../index.jsp");
    }
%>

<jsp:include page='footer.jsp'/>
