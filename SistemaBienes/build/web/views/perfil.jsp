<%@page import="java.util.List"%>
<%@page import="com.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.dao.DaoPropiedad"%>
<%@page import="com.dao.DaoUsuario"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<jsp:include page='nav.jsp'/>
<%

    if (session.getAttribute("usuario") != null || session.getAttribute("vendedor") != null || session.getAttribute("gerente") != null) {

        Usuario usuario = null;
        if (session.getAttribute("usuario") != null) {
            usuario = (Usuario) session.getAttribute("usuario");
        } else if (session.getAttribute("vendedor") != null) {
            usuario = (Usuario) session.getAttribute("vendedor");
        } else {
            usuario = (Usuario) session.getAttribute("gerente");
        }
%>


<style>

    #cardCustom:hover  {
        animation-name: slideInUp;
        background: #1F618D
    }
</style>


<!--Main layout-->
<main style="margin-top: 58px">
    <section style="background-color: #eee;">
        <div class="container py-5">
            <div class="row">
                <div class="col-lg-4">
                    <div class="card mb-4">
                        <div class="card-body text-center">
                            <img src="../assets/avatar.png" alt="avatar"
                                 class="rounded-circle img-fluid" style="width: 150px;">
                            <h5 class="my-3"> <%= usuario.getNombre()%></h5>          
                            <% if (usuario.getTipo() == 1) {
                                    out.println("<p class='text-muted mb-1'>Tipo Usuario: Administrador</p>");
                                } else if (usuario.getTipo() == 2) {
                                    out.println("<p class='text-muted mb-1'>Tipo Usuario: Vendedor</p>");
                                } else {
                                    out.println("<p class='text-muted mb-1'>Tipo Usuario: Gerente</p>");
                                }
                            %>
                        </div>
                    </div>

                </div>
                <div class="col-lg-8">
                    <div class="card mb-4">
                        <div class="card-body">
                            <form   method="POST" name="frmPerfil" id="frmPerfil" >
                                 <input type="hidden" value="<%= usuario.getIdUsuario()%>" name="idUsuario"/>
                                <div class="row">

                                    <div class="col-sm-3">
                                        <p class="mb-0">Nombre</p>
                                    </div>
                                    <div class="col-sm-9">
                                        <input type="text" id="txtNombre" name="txtNombre" value="<%= usuario.getNombre()%>" class="form-control text-muted mb-0"  required=""/>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <p class="mb-0">Contraseña</p>
                                    </div>
                                    <div class="col-sm-9">
                                        <input type="text" id="txtClave" name="txtClave" value="<%= usuario.getClave()%>" class="form-control text-muted mb-0"  required=""/>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <p class="mb-0">Tipo de usuario</p>
                                    </div>
                                    <div class="col-sm-9">
                                        <input type="number" id="txtTipo" name="txtTipo" value="<%= usuario.getTipo()%>" class="form-control text-muted mb-0"  required=""/>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <p class="mb-0">Estado</p>
                                    </div>
                                    <div class="col-sm-9">
                                        <input type="text" id="txtEstado" name="txtEstado" value="<%= usuario.getEstado()%>" class="form-control text-muted mb-0"  required=""/>
                                    </div>
                                </div>
                                    
                                    <div class="row">
                                    <div class="col-sm-6">
                                        <button type="submit" id="btnActualizar" name="btnActualizar" class="btn btn-dark mt-3 ">Actualizar</button>
                                    </div>
                                    <div class="col-sm-6">
                                        <p class="mt-3">¡ Al Actualizar deberá iniciar sesión de nuevo !</p>
                                    </div>
                                </div>

                            </form>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>
    <!--Container-->
</main>
<!--Main layout-->

<script>
    
    function validar() {

        $("#frmPerfil").validate({
            rules: {
                idUsuario: {required: true},
                txtNombre: {required: true},
                txtClave: {required: true},
                txtTipo: {required: true},
                txtEstado: {required: true},
            },
            messages: {
                idUsuario: "El campo es obligatorio.",
                txtNombre: "El campo es obligatorio.",
                txtClave: "El campo es obligatorio.",
                txtTipo: "El campo es obligatorio.",
                txtEstado: "El campo es obligatorio.",
            },
            submitHandler: function () {
                modificar();
            },
        });
    }
   
    
    function modificar() {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/usuarioController",
            async: true,
            data: {
                accion: "modificarPerfil",
                idUsuario: document.frmPerfil.idUsuario.value,
                txtNombre: document.frmPerfil.txtNombre.value,
                txtClave: document.frmPerfil.txtClave.value,
                txtTipo: document.frmPerfil.txtTipo.value,
                txtEstado: document.frmPerfil.txtEstado.value,
            },
            dataType: 'text',
            //Si recibe respuesta del servlet
            success: function (data) {
                console.log("Respuesta: " + data);
                if (data == "exito") {
                    parent.location.href = "${pageContext.request.contextPath}/index.jsp"

                } else {
                    Swal.fire({
                        icon: "error",
                        title: "Oops...",
                        text: "Algo salio mal!",
                        showConfirmButton: false,
                        timer: 1800,
                    });
                }
                setTimeout(function () {
                        parent.location.href = "${pageContext.request.contextPath}/views/perfil.jsp"
                    }, 1800);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("No hay respuesta del server, Error: " + textStatus);
            },
        });
    }
    
   
    
    function cargarUsuario() {

        $.ajax({
            url: '${pageContext.request.contextPath}/usuarioController?accion=cargarUsuario',
            method: 'POST',
            type: 'POST',
            success: function (data) {
                console.log(data);
            }
        });
    }

    $(document).ready(function () {
    cargarUsuario();
            $('#txtTipo').prop("readonly", true);
            $('#txtEstado').prop("readonly", true);
                        //btn guardar
        $("#btnActualizar").on("click", function () {
            validar();
        });
    
        });
    
            $(document).ajaxComplete(cargarUsuario());
</script>


<% } else {
        //response.sendError(response.SC_FORBIDDEN, "Pagina no autorizada");
        response.sendRedirect("../index.jsp");
    }
%>

<jsp:include page='footer.jsp'/>
