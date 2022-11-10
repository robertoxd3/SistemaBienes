<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.model.Usuario"%>
<%@page import="com.dao.DaoUsuario"%>
<%@page import="java.util.List"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<jsp:include page='nav.jsp'/>


<%
    DaoUsuario daoU = new DaoUsuario();
%>
<%
     if (session.getAttribute("usuario") != null) {
    //if (session.getAttribute("vendedor") != null) {
    Usuario usuario=(Usuario)session.getAttribute("usuario"); 
%>
<style>
    .dataTables_length{
        margin-bottom: 10px;
    }
    .dataTables_filter{
        margin-bottom: 10px;
    }
</style>

<!--Main layout-->
<main style="margin-top: 58px">
    <div class="container pt-4">
        <h1 class="display-5">Usuarios</h1>
        <span class="lead">Estos son todos los usuarios registrados en el sistema, se puede ver los accesos de todos los usuarios en la plataforma , además, tiene la opcion de agregar, modificar y eliminar</span>
        <!-- Button trigger modal -->
        <div class="d-flex justify-content-end ">
            <button id="btnNuevo" type="button" class="btn btn-success " data-bs-toggle="modal" data-bs-target="#ModalUsuarios">
                <i class="fa-soli--d fa-plus"></i> Agregar
            </button>
        </div>

        <hr>
        <div id="tablaHtml" >

        </div>

        <div class=" table-responsive  mt-3">
            <table class="table table-hover animate__animated animate__fadeInLeft animate__delay-0.5s " style="background-color: #FDEBD0" id="tabla">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Usuario</th>
                        <th>Clave</th>
                        <th>Tipo</th>
                        <th>Estado</th>
                        <th>Creación</th>
                        <th class="td-center">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Usuario> lista = daoU.getUsuario();
                        for (Usuario usu : lista) {
                    %>
                    <tr>
                        <td> <%=usu.getIdUsuario()%></td>
                        <td> <%=usu.getNombre()%></td>
                        <td> <%=usu.getClave()%></td>
                        <td> <%=usu.getTipo()%></td>
                        <td> <%=usu.getEstado()%></td>
                        <td> <%=usu.getCreado_en()%></td>
                        <td class="td-center">
                            <a data-bs-toggle="modal" data-bs-target="#ModalUsuarios" name="btnEdit" href="#" onclick="javascript:cargar(<%=usu.getIdUsuario()%>, '<%=usu.getNombre()%>', '<%=usu.getClave()%>', <%=usu.getTipo()%>, '<%=usu.getEstado()%>', '<%=usu.getCreado_en()%>')" class=" btn btn-secondary rounded-lg" data-toggle="tooltip" title="Modificar" data-placement="bottom"><i class="fa-solid fa-pen-to-square"></i></a> 
                            <a  name="btnDelete" onclick="javascript:eliminar(<%=usu.getIdUsuario()%>, '<%=usu.getNombre()%>')" href="#" class="btn btn-danger rounded-lg" data-toggle="tooltip" title="Eliminar" data-placement="bottom"><i class="fa-solid fa-trash"></i></a>
                            <a  name="btnAccesos" data-bs-toggle="modal" data-bs-target="#ModalAccesos" onclick="javascript:accesos(<%=usu.getIdUsuario()%>)" href="#" class="btn btn-info rounded-lg" data-toggle="tooltip" title="Acessos" data-placement="bottom"><i class="fa-solid fa-user"></i></a>
                        </td>

                    </tr>
                    <%}%>
                </tbody>
            </table>
        </div>


        <!-- Modal -->
        <div class="modal fade" id="ModalUsuarios" tabindex="-1" aria-labelledby="ModalUsuariosLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body">
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        <form action="/usuarioController" method="POST" name="frmUsu" id="frmUsu">
                            <div class="d-flex justify-content-end">
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="myform ">
                                <input type="hidden" value="0" name="idUsuario"/>
                                <h1 class="text-center">Mantenimiento Usuario</h1>
                                <label for="txtNombre" class="form-label">Nombre Usuario:</label>
                                <input type="text" id="txtPoliza" name="txtNombre" class="form-control" placeholder="Nombre"  />
                                <label for="txtClave" class="form-label">Clave:</label>
                                <input type="text" id="txtClave" name="txtClave" class="form-control" placeholder="Contraseña"  />
                                <label for="cmbTipo" class="form-label">Rol de usuario</label>
                                <select name="cmbTipo" id="cmbTipo" class="form-select" aria-label="Default select example">
                                    <option value="1" selected>Administrador</option>
                                    <option value="2">Vendedor</option>
                                    <option value="3">Gerente</option>
                                </select>
                                <label for="cmbEstado" class="form-label">Estado</label>
                                <select name="cmbEstado" id="cmbEstado" class="form-select" aria-label="Default select example">
                                    <option value="Activo" selected>Activo</option>
                                    <option value="Desactivado">Desactivado</option>
                                     <option value="Revision">Revision</option>
                                </select>
                                <button type="submit" id="btnModificar" name="btnModificar" class="btn btn-dark mt-3">Modificar</button>
                                <button type="submit" id="btnGuardar" name="btnGuardar" class="btn btn-dark mt-3">Guardar</button>

                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
<!--Main layout-->

     <!-- Modal -->
        <div class="modal fade" id="ModalAccesos" tabindex="-1" aria-labelledby="ModalAccesosLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                     <div class="modal-header">
                        <h5 class="modal-title">Accesos</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                      </div>
                    <div class="modal-body">
                        <div id="tablaAcceso" >

                        </div>
                    </div>
                </div>
            </div>
        </div>

<script>
    function cargar(idUsuario, nombre, clave, tipo, estado)
    {
        document.frmUsu.idUsuario.value = idUsuario;
        document.frmUsu.txtNombre.value = nombre;
        document.frmUsu.txtClave.value = clave;
        document.frmUsu.cmbTipo.value = tipo;
        document.frmUsu.cmbEstado.value = estado;
    }

    function insertar() {
        var d = new Date();
        var fecha = d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate();
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/usuarioController",
            async: true,
            data: {
                accion: "insertar",
                idUsuario: document.frmUsu.idUsuario.value,
                txtNombre: document.frmUsu.txtNombre.value,
                txtClave: document.frmUsu.txtClave.value,
                cmbTipo: document.frmUsu.cmbTipo.value,
                cmbEstado: document.frmUsu.cmbEstado.value,
                creado_en: fecha,
            },
            dataType: 'text',
            //Si recibe respuesta del servlet
            success: function (data) {
                console.log("Respuesta: " + data);
                if (data == "exito") {
                    Swal.fire({
                        position: "center",
                        icon: "success",
                        title: "Usuario almacenado correctamente",
                        showConfirmButton: false,
                        timer: 1800,
                    });
                } else {
                    Swal.fire({
                        icon: "error",
                        title: "Oops...",
                        text: "Algo salio mal!",
                        showConfirmButton: false,
                        timer: 1800,
                    });
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("No hay respuesta del server, Error: " + textStatus);
            },
        });
    }

    function modificar() {
        var d = new Date();
        var fecha = d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate();
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/usuarioController",
            async: true,
            data: {
                accion: "modificar",
                idUsuario: document.frmUsu.idUsuario.value,
                txtNombre: document.frmUsu.txtNombre.value,
                txtClave: document.frmUsu.txtClave.value,
                cmbTipo: document.frmUsu.cmbTipo.value,
                cmbEstado: document.frmUsu.cmbEstado.value,
                creado_en: fecha,
            },
            dataType: 'text',
            //Si recibe respuesta del servlet
            success: function (data) {
                console.log("Respuesta: " + data);
                if (data == "exito") {
                    Swal.fire({
                        position: "center",
                        icon: "success",
                        title: "Usuario modificado correctamente",
                        showConfirmButton: false,
                        timer: 1800,
                    });
                } else {
                    Swal.fire({
                        icon: "error",
                        title: "Oops...",
                        text: "Algo salio mal!",
                        showConfirmButton: false,
                        timer: 1800,
                    });
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("No hay respuesta del server, Error: " + textStatus);
            },
        });
    }
    
    
    function accesos(idusuario) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/usuarioController",
            async: true,
            data: {
                accion: "acceso",
                idUsuario: idusuario,
            },
            dataType: 'text',
            //Si recibe respuesta del servlet
            success: function (data) {
                //console.log("Respuesta: " + data);
                    $("#tablaAcceso").empty();
                    $("#tablaAcceso").append(data);

            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("No hay respuesta del server, Error: " + textStatus);
            },
        });
    }


    function eliminar(idUsuario, nombre)
    {
        Swal.fire({
        title: "Quieres eliminar al usuario con nombre " + nombre + " con codigo: " + idUsuario + "?",
           text: "Al eliminar un usuario tambien se borraran sus accesos al sistema, intente desactivarlo si desea mantener esa info del usuario.",
                showCancelButton: true,
                confirmButtonText: "Si",
        }).then((result) => {
        if (result.isConfirmed) {

            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/usuarioController",
                async: true,
                data: {
                    accion: "eliminar",
                    codigo: idUsuario,
                },
                dataType: 'text',
                //Si recibe respuesta del servlet
                success: function (data) {
                    console.log("bien: " + data);
                    if (data == "exito") {
                        Swal.fire({
                            position: "center",
                            icon: "success",
                            title: "Usuario eliminado correctamente",
                            showConfirmButton: false,
                            timer: 1800,
                        });
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
                        parent.location.href = "usuarios.jsp"
                    }, 1800);
                },
                //Si no hay respuesta del server
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("No hay respuesta del server, Error: " + textStatus);
                },
            });
        }
        }
        );
    }

    function validar(opcion) {

        $("#frmUsu").validate({
            rules: {
                txtNombre: {required: true },
                txtClave: {required: true},
                cmbTipo: {required: true},
                cmbEstado: {required: true},
            },
            messages: {
                txtNombre: "El campo es obligatorio.",
                txtClave: "El campo es obligatorio. xd",
                cmbTipo: "El campo es obligatorio.",
                cmbEstado: "El campo es obligatorio.",
              
            },
            submitHandler: function () {
                if (opcion == "insertar") {
                    insertar();
                } else if (opcion == "modificar") {
                    modificar();
                }
                setTimeout(function () {
                    parent.location.href = "usuarios.jsp"
                }, 1800);
            },
        });
    }

    function tablaDinamica()
    {
        $("#tabla").DataTable({
            searching: true,
             language: {
            url: 'https://cdn.datatables.net/plug-ins/1.12.1/i18n/es-ES.json'
        },
            order: [], //Initial no order.
        });
    }

    $(document).ready(function () {
        var opcion = "";
        tablaDinamica();
        $("#btnNuevo").on("click", function () {
            $("#btnModificar").hide();
            $("#btnGuardar").show();
            $("#frmUsu")[0].reset();
        });
        //btn guardar
        $("#btnGuardar").on("click", function () {
            opcion = "insertar";
            validar(opcion);
        });
        //btn modificar
        $("#btnModificar").on("click", function () {
            opcion = "modificar";
            validar(opcion);
        });
        //btn Modificar MODAL
        $('[name="btnEdit"]').on("click", function () {
            $("#btnGuardar").hide();
            $("#btnModificar").show();
        });
        //btn Eliminar MODAL
        $('[name="btnDelete"]').on("click", function () {
            $("#btnGuardar").hide();
            $("#btnModificar").show();
        });
    });

</script>


<% } else {
         //response.sendRedirect("../index.jsp");
        response.sendError(response.SC_FORBIDDEN, "Pagina no autorizada");
    }
%>

<jsp:include page='footer.jsp'/>