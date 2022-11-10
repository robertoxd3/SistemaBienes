<%@page import="com.model.Empleado"%>
<%@page import="com.dao.DaoEmpleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.model.Usuario"%>
<%@page import="com.dao.DaoUsuario"%>
<%@page import="java.util.List"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<jsp:include page='nav.jsp'/>


<%
    DaoEmpleado daoE = new DaoEmpleado();
%>
<%
       if (session.getAttribute("usuario") != null || session.getAttribute("gerente") != null) {
        Usuario usuario = null;
        if (session.getAttribute("usuario") != null) {
            usuario = (Usuario) session.getAttribute("usuario");
        } else {
            usuario = (Usuario) session.getAttribute("gerente");
        }
%>
<style>
    .dataTables_length{
        margin-bottom: 10px;
    }
    .dataTables_filter{
        /* display: flex;
        align-items: center;
        justify-content: center;*/
        margin-bottom: 10px;
    }
</style>

<!--Main layout-->
<main style="margin-top: 58px">
    <div class="container pt-4">
        <h1 class="display-5">Empleados</h1>
        <span class="lead">Estos son todos los empleado registrados en el sistema, tiene la opcion de agregar, modificar y eliminar (Solo disponible para gerente y administrador)</span>
        <!-- Button trigger modal -->
        <div class="d-flex justify-content-end ">
            <button id="btnNuevo" type="button" class="btn btn-success " data-bs-toggle="modal" data-bs-target="#ModalEmpleado">
                <i class="fa-soli--d fa-plus"></i> Agregar
            </button>
        </div>

        <hr>


        <div class=" table-responsive  mt-3">
            <table class="table table-primary table-hover animate__animated animate__fadeInLeft animate__delay-0.5s " id="tabla">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombres</th>
                        <th>Apellidos</th>
                        <th>Dui</th>
                        <th>Area</th>
                        <th class="td-center">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Empleado> lista = daoE.getEmpleados();
                        for (Empleado emp : lista) {
                    %>
                    <tr>
                        <td> <%=emp.getIdEmpleado()%></td>
                        <td> <%=emp.getNombres()%></td>
                        <td> <%=emp.getApellidos()%></td>
                        <td> <%=emp.getDui()%></td>
                        <td> <%=emp.getArea()%></td>
                        <td class="td-center">
                            <a data-bs-toggle="modal" data-bs-target="#ModalEmpleado" name="btnEdit" href="#" onclick="javascript:cargar(<%=emp.getIdEmpleado()%>, '<%=emp.getNombres()%>', '<%=emp.getApellidos()%>','<%=emp.getDui()%>', '<%=emp.getArea()%>')" class=" btn btn-secondary rounded-lg" data-toggle="tooltip" title="Modificar" data-placement="bottom"><i class="fa-solid fa-pen-to-square"></i></a> 
                            <a  name="btnDelete" onclick="javascript:eliminar(<%=emp.getIdEmpleado()%>, '<%=emp.getNombres()%>')" href="#" class="btn btn-danger rounded-lg" data-toggle="tooltip" title="Eliminar" data-placement="bottom"><i class="fa-solid fa-trash"></i></a>
                           
                        </td>

                    </tr>
                    <%}%>
                </tbody>
            </table>
        </div>


        <!-- Modal -->
        <div class="modal fade" id="ModalEmpleado" tabindex="-1" aria-labelledby="ModalEmpleadoLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body">
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        <form action="/empleadoController" method="POST" name="frmEmp" id="frmEmp">
                            <div>
                                <div class="d-flex justify-content-end">
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                                <input type="hidden" value="0" name="idEmpleado"/>
                                <h3 class="text-center">Mantenimiento Empleado</h3>
                                <label for="txtNombres" class="form-label">Nombres:</label>
                                <input type="text" id="txtNombres" name="txtNombres" class="form-control" placeholder="Nombres"  />
                                <label for="txtApellidos" class="form-label">Apellidos:</label>
                                <input type="text" id="txtDui" name="txtApellidos" class="form-control" placeholder="Apellidos" />
                                
                               <label for="dui" class="form-label">Dui:</label>
                                <input type="text" id="dui" name="dui" class="form-control" placeholder="Dui"  />
                                
                                <label for="txtArea" class="form-label">Area:</label>
                                <input type="text" id="txtArea" name="txtArea" class="form-control" placeholder="Area" />

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



<script>
    function cargar(idEmpleado, nombres, apellidos, dui, area)
    {
        document.frmEmp.idEmpleado.value = idEmpleado;
        document.frmEmp.txtNombres.value = nombres;
        document.frmEmp.txtApellidos.value = apellidos;
        document.frmEmp.dui.value= dui;
        document.frmEmp.txtArea.value = area;
    }

    function insertar() {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/empleadoController",
            async: true,
            data: {
                accion: "insertar",
                idEmpleado: document.frmEmp.idEmpleado.value,
                txtNombres: document.frmEmp.txtNombres.value,
                txtApellidos: document.frmEmp.txtApellidos.value,
                dui: document.frmEmp.dui.value,
                txtArea: document.frmEmp.txtArea.value,
            },
            dataType: 'text',
            //Si recibe respuesta del servlet
            success: function (data) {
                console.log("Respuesta: " + data);
                if (data == "exito") {
                    Swal.fire({
                        position: "center",
                        icon: "success",
                        title: "Empleado almacenado correctamente",
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
                        parent.location.href = "empleados.jsp"
                    }, 1800);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("No hay respuesta del server, Error: " + textStatus);
            },
        });
    }

    function modificar() {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/empleadoController",
            async: true,
            data: {
                accion: "modificar",
                idEmpleado: document.frmEmp.idEmpleado.value,
                txtNombres: document.frmEmp.txtNombres.value,
                txtApellidos: document.frmEmp.txtApellidos.value,
                dui: document.frmEmp.dui.value,
                txtArea: document.frmEmp.txtArea.value,
            },
            dataType: 'text',
            //Si recibe respuesta del servlet
            success: function (data) {
                console.log("Respuesta: " + data);
                if (data == "exito") {
                    Swal.fire({
                        position: "center",
                        icon: "success",
                        title: "Empleado modificado correctamente",
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
                        parent.location.href = "empleados.jsp"
                    }, 1800);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("No hay respuesta del server, Error: " + textStatus);
            },
        });
    }


    function eliminar(id, nombre)
    {
        Swal.fire({
        title: "Quieres eliminar al usuario con nombre " + nombre + " con codigo: " + id + "?",
                showCancelButton: true,
                confirmButtonText: "Si",
        }).then((result) => {
        if (result.isConfirmed) {

            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/empleadoController",
                async: true,
                data: {
                    accion: "eliminar",
                    codigo: id,
                },
                dataType: 'text',
                //Si recibe respuesta del servlet
                success: function (data) {
                    console.log("bien: " + data);
                    if (data == "exito") {
                        Swal.fire({
                            position: "center",
                            icon: "success",
                            title: "Empleado eliminado correctamente",
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
    
     //mascaras
            document.getElementById('dui').addEventListener('input', function (e) {
                var x = e.target.value.replace(/\D/g, '').match(/(\d{0,8})(\d{0,1})/);
                e.target.value = x[1] + '-' + x[2]
            });
            
    function validar(opcion) {

        $("#frmEmp").validate({
            rules: {
                txtNombres: {required: true},
                txtApellidos: {required: true},
                dui: {required: true},
                txtArea: {required: true},
            },
            messages: {
                txtNombres: "El campo es obligatorio.",
                txtApellidos: "El campo es obligatorio.",
                dui: "El campo es obligatorio.",
                txtArea: "El campo es obligatorio.",
            },
            submitHandler: function () {
                if (opcion == "insertar") {
                    insertar();
                } else if (opcion == "modificar") {
                    modificar();
                }
                setTimeout(function () {
                    parent.location.href = "empleados.jsp"
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
            $("#frmEmp")[0].reset();
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
         response.sendError(response.SC_FORBIDDEN, "Pagina no autorizada");
         //response.sendRedirect("../index.jsp");
    }
%>

<jsp:include page='footer.jsp'/>