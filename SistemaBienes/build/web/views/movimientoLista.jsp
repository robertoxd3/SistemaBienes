<%@page import="com.model.Usuario"%>
<%@page import="com.dao.DaoTraspaso"%>
<%@page import="com.model.Traspaso"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<jsp:include page='nav.jsp'/>
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
    DaoTraspaso daoT = new DaoTraspaso();
%>
<!--Main layout-->
<main style="margin-top: 58px">
    <div class="container pt-4">
        <h1 class="display-5">Traspaso </h1>
        <p class="lead">Historial de traspasos</p>
        <div class="d-flex justify-content-end ">
            <a class="btn btn-success " href="movimientos.jsp">
                <i class="fa-soli--d fa-plus"></i> Crear un nuevo traspaso
            </a>
        </div>
        <br>
            <div class=" table-responsive  mt-3">
            <table class="table table-primary table-hover animate__animated animate__fadeInLeft animate__delay-0.5s " id="tabla">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Activo</th>
                        <th>Encargado Anterior</th>
                        <th>Encargado Nuevo</th>
                        <th>Fecha Traspaso</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Traspaso> lista = daoT.getTraspasos();
                        for (Traspaso tra : lista) {
                    %>
                    <tr>
                        <td> <%=tra.getIdTraspaso()%></td>
                        <td> <%=tra.getAct()%></td>
                        <td> <%=tra.getEncargadoA()%></td>
                        <td> <%=tra.getEncargadoN()%></td>
                        <td> <%=tra.getFechaTraspaso()%></td>

                    </tr>
                    <%}%>
                </tbody>
            </table>
        </div>
        
    </div>

    <!--Container-->
</main>
<!--Main layout-->



<% } else {
        response.sendError(response.SC_FORBIDDEN, "Pagina no autorizada");
        //response.sendRedirect("../index.jsp");
    }
%>

<jsp:include page='footer.jsp'/>
