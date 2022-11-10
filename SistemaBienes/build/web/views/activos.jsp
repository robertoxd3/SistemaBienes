<%@page import="com.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.model.Activo"%>
<%@page import="com.dao.DaoActivo"%>
<%@page import="java.util.List"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<jsp:include page='nav.jsp'/>


<%
    DaoActivo daoA = new DaoActivo();
%>
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
    .dataTables_length{
        margin-bottom: 10px;
    }
    .dataTables_filter{
        margin-bottom: 10px;
    }
    .error{
        color: red;
    }

    .img-custom{
        width: 250px; 
        height: 250px;
    }
    @media (max-width: 575px) {
        .img-custom{
            width: 100%; 
            height: 100%;
        }
    }

</style>

<!--Main layout-->
<main style="margin-top: 58px">
    <div class="container pt-4">
        <h1 class="display-5">Activos</h1>
        <span class="lead">Estos son todos los activos fijos que estan registradas por la empresa, tiene la opcion de agregar, modificar y eliminar</span>
        <!-- Button trigger modal -->
        <div class="d-flex justify-content-end ">
            <button id="btnNuevo" type="button" class="btn btn-success " data-bs-toggle="modal" data-bs-target="#ModalPropiedad">
                <i class="fa-soli--d fa-plus"></i> Agregar
            </button>
        </div>
        
         <div class="d-flex justify-content-start ">
            <button id="btnVista" type="button" class="btn btn-primary btn-sm me-2" onclick="card()">
                <i class="fa-solid fa-eye"></i> Card
            </button>
            <button id="btnVista2" type="button" class="btn btn-info btn-sm" onclick="tablaNormal()">
                <i class="fa-solid fa-eye"></i> Tabla
            </button>
        </div>

        <hr>
        <div id="tablaHtml" >

        </div>

        <div class=" table-responsive  mt-3" id="tablaNormal">
            <table style="background-color: #CCD1D1" class="table table-default table-hover animate__animated animate__fadeInLeft animate__delay-0.5s " id="tabla">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Foto</th>
                        <th>Serial</th>
                        <th>Nombre</th>
                        <th>Descripcion</th>
                        <th>Propiedad</th>
                        <th>Encargado</th>
                        <th>fechaCompra</th>
                        <th>Estado</th>
                        <th>Categoria</th>
                        <th>Cantidad</th>
                        <th class="td-center">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Activo> lista = daoA.getActivos();
                        for (Activo act : lista) {
                            String apellidos = daoA.getEmpleadoByID(act.getEncargado());
                            String propiedad = daoA.getPropiedadByID(act.getPropiedad());
                    %>

                    <tr>
                        <td> <%=act.getCodigo()%></td>
                        <td> <img src="../assets/activos/<%=act.getFoto()%>" class="rounded-start"  style="width: 100px; height: 100px" alt="propiedad"></td>
                        <td> <%=act.getSerial()%></td>
                        <td> <%=act.getNombre()%></td>
                        <td> <%=act.getDescripcion()%></td>
                        <td> <%=propiedad%></td>
                        <td> <%=apellidos%></td>
                        <td> <%=act.getFechaCompra()%></td>
                        <td> <%=act.getEstado()%></td>
                        <td> <%=act.getCategoria()%></td>
                        <td> <%=act.getCantidad()%></td>
                        <td class="td-center">
                            <a data-bs-toggle="modal" data-bs-target="#ModalPropiedad" name="btnEdit" href="#" onclick="javascript:cargar(<%=act.getCodigo()%>, '<%=act.getSerial()%>', '<%=act.getNombre()%>', '<%=act.getDescripcion()%>', <%=act.getPropiedad()%>,<%=act.getEncargado()%>, '<%=act.getFechaCompra()%>', '<%=act.getEstado()%>','<%=act.getCategoria()%>',<%=act.getCantidad()%>, '<%=act.getFoto()%>')" class=" btn btn-secondary rounded-lg borrar" data-toggle="tooltip" title="Modificar" data-placement="bottom"><i class="fa-solid fa-pen-to-square"></i></a> 
                            <a  name="btnDelete" onclick="javascript:eliminar(<%=act.getCodigo()%>, '<%=act.getNombre()%>')" href="#" class="btn btn-danger rounded-lg borrar2" data-toggle="tooltip" title="Eliminar" data-placement="bottom"><i class="fa-solid fa-trash"></i></a>
                            <a  target="_blank" href="reporte2.jsp?id=<%=act.getCodigo()%>" class="btn btn-info  rounded-lg borrar3" data-toggle="tooltip" title="Reporte" data-placement="bottom"><i class="fa-solid fa-file-pdf"></i></a>
                        </td>

                    </tr>
                    <%}%>
                </tbody>
            </table>
        </div>
                
                
        <div class="row mt-2" id="tablaCard">
            <%
                        for (Activo act : lista) {
                            String apellidos = daoA.getEmpleadoByID(act.getEncargado());
                            String propiedad = daoA.getPropiedadByID(act.getPropiedad());
            %>

            <div class="col-lg-3 col-md-4 col-sm-6 col-12">
                <div class="card h-100 w-100">
                    <img src="../assets/activos/<%=act.getFoto()%>" class="rounded-start img-fluid img-custom" alt="propiedad">
                    <div class="card-body">
                        <h5 class="card-title"><%=act.getNombre()%></h5>
                        <span class="card-text"><b>Serial:</b> <%=act.getSerial()%></span><br>
                        <span class="card-text "><b>Descripción:</b> <%=act.getDescripcion()%></span><br>
                        <span class="card-text "><b>Propiedad:</b> <%=propiedad%></span><br>
                        <span class="card-text "><b>Encargado:</b> <%=apellidos%></span><br>
                        <span class="card-text "><b>Fecha Compra:</b> <%=act.getFechaCompra()%></span><br>
                        <span class="card-text "><b>Estado:</b> <%=act.getEstado()%></span><br>
                        <span class="card-text "><b>Categoria:</b> <%=act.getCategoria()%></span><br>
                        <span class="card-text "><b>Cantidad:</b> <%=act.getCantidad()%></span><br>
                            <a data-bs-toggle="modal" data-bs-target="#ModalPropiedad" name="btnEdit" href="#" onclick="javascript:cargar(<%=act.getCodigo()%>, '<%=act.getSerial()%>', '<%=act.getNombre()%>', '<%=act.getDescripcion()%>', <%=act.getPropiedad()%>,<%=act.getEncargado()%>, '<%=act.getFechaCompra()%>', '<%=act.getEstado()%>','<%=act.getCategoria()%>',<%=act.getCantidad()%>, '<%=act.getFoto()%>')" class=" btn btn-secondary rounded-lg borrar" data-toggle="tooltip" title="Modificar" data-placement="bottom"><i class="fa-solid fa-pen-to-square"></i></a> 
                            <a  name="btnDelete" onclick="javascript:eliminar(<%=act.getCodigo()%>, '<%=act.getNombre()%>')" href="#" class="btn btn-danger rounded-lg borrar2" data-toggle="tooltip" title="Eliminar" data-placement="bottom"><i class="fa-solid fa-trash"></i></a>
                            <a  target="_blank" href="reporte2.jsp?id=<%=act.getCodigo()%>" class="btn btn-info  rounded-lg borrar3" data-toggle="tooltip" title="Reporte" data-placement="bottom"><i class="fa-solid fa-file-pdf"></i></a>
                    </div>

                </div>
            </div>
            <%}%>
        </div>         



        <!-- Modal -->
        <div class="modal fade" id="ModalPropiedad" tabindex="-1" aria-labelledby="ModalPropiedadLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">

                    <div class="modal-body">
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        <form action="/activoController" method="POST" name="frmAct" id="frmAct" enctype="multipart/form-data">
                            <div class="d-flex justify-content-end">
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="myform ">
                                
                                <input type="hidden" value="0" name="codigo"/>
                                <h3 class="text-center">Mantenimiento Activo</h3>
                                <label for="txtSerial" class="form-label">Serial:</label>
                                <input type="text" id="txtSerial" name="txtSerial" class="form-control" placeholder="Serial"  />
                                <label for="txtNombre" class="form-label">Nombre:</label>
                                <input type="text" id="txtNombre" name="txtNombre" class="form-control" placeholder="Nombre"  />
                                <label for="txtDescripcion" class="form-label">Descripcion: </label>
                                <input type="text" id="txtDescripcion" name="txtDescripcion" class="form-control" placeholder="Descripcion"  />
                                <label for="cmbPropiedad" class="form-label">Propiedad: </label>
                                <select name="cmbPropiedad" id="cmbPropiedad" class="form-select" aria-label="Default select example">
                                    <c:forEach items="${propiedades}" var="pro">
                                        <option value="${pro.idPropiedad}">${pro.nombre}</option>
                                    </c:forEach>
                                </select>
                                
                                 <label for="cmbEncargado" id="labelcmbEncargado" class="form-label" >Encargados: </label>
                                <select name="cmbEncargado" id="cmbEncargado" class="form-select" aria-label="Default select example">
                                    <c:forEach items="${empleados}" var="emp">
                                        <option value="${emp.idEmpleado}">${emp.apellidos}</option>
                                    </c:forEach>
                                </select>
                        
                                
                                <label for="fechaCompra" class="form-label">Fecha Compra: </label>
                                <input type="date" id="fechaCompra" name="fechaCompra" class="form-select"
                                       value="2022-10-24"
                                       min="2000-01-01" />

                                <label for="cmbEstado" class="form-label">Estado: </label>
                                <select name="cmbEstado" id="cmbEstado" class="form-select" aria-label="Default select example">
                                    <option value="Usado" selected>Usado</option>
                                    <option value="Nuevo">Nuevo</option>
                                    <option value="De Fabrica">De Fabrica</option>
                                </select>
                                
                                <label for="cmbCategoria" class="form-label">Categoria: </label>
                                <select name="cmbCategoria" id="cmbCategoria" class="form-select" aria-label="Default select example">
                                    <option value="Bienes inmuebles" selected>Bienes inmuebles</option>
                                    <option value="Maquinaria">Maquinaria</option>
                                    <option value="Vehiculos">Vehículos</option>
                                    <option value="Herramientas">Herramientas</option>
                                    <option value="Equipos tecnologicos">Equipos tecnologicos</option>
                                    <option value="Materiales de oficina">Materiales de oficina</option>
                                </select>
                                
                                <label for="cantidad" class="form-label">Cantidad:</label>
                                <input type="number" id="cantidad" name="cantidad" class="form-control" placeholder="Cantidad" required="" />

                                <label for="foto" class="form-label">Ingrese una Imagen: </label>
                                <input id="ajaxfile" type="file" class="form-control" name="file" required/>
                                <span ><b>Nota: </b>Para cambiar el encargado debe de iniciar un traspaso.</span>
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
            function cargar(codigo, serial, nombre, descripcion, propiedad, encargado, fechaCompra, estado,categoria,cantidad, foto)
            {
            document.frmAct.codigo.value = codigo;
                    document.frmAct.txtSerial.value = serial;
                    document.frmAct.txtNombre.value = nombre;
                    document.frmAct.txtDescripcion.value = descripcion;
                    document.frmAct.cmbPropiedad.value = propiedad;
                    document.frmAct.cmbEncargado.value = encargado;
                    document.frmAct.fechaCompra.value = fechaCompra;
                    document.frmAct.cmbEstado.value = estado;
                    document.frmAct.cmbCategoria.value = categoria;
                    document.frmAct.cantidad.value = cantidad;
            }


    function insertar(nombreArchivo) {
    $.ajax({
    type: "POST",
            url: "${pageContext.request.contextPath}/activoController",
            async: true,
            data: {
            accion: "insertar",
                    codigo:  document.frmAct.codigo.value,
                    txtSerial:  document.frmAct.txtSerial.value,
                    txtNombre:  document.frmAct.txtNombre.value,
                    txtDescripcion:  document.frmAct.txtDescripcion.value,
                    cmbPropiedad: document.frmAct.cmbPropiedad.value,
                    cmbEncargado: document.frmAct.cmbEncargado.value,
                    fechaCompra: document.frmAct.fechaCompra.value,
                    cmbEstado: document.frmAct.cmbEstado.value,
                    cmbCategoria: document.frmAct.cmbCategoria.value,
                    cantidad: document.frmAct.cantidad.value,
                    foto: nombreArchivo
            },
            //Si recibe respuesta del servlet
            success: function (data) {
            console.log("Respuesta: " + data);
                    if (data == "exito") {
            Swal.fire({
            position: "center",
                    icon: "success",
                    title: "Activo almacenada correctamente",
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
    })
    }


    function modificar(nombreArchivo) {
    $.ajax({
    type: "POST",
            url: "${pageContext.request.contextPath}/activoController",
            async: true,
            data: {
            accion: "modificar",
                    codigo:  document.frmAct.codigo.value,
                    txtSerial:  document.frmAct.txtSerial.value,
                    txtNombre:  document.frmAct.txtNombre.value,
                    txtDescripcion:  document.frmAct.txtDescripcion.value,
                    cmbPropiedad: document.frmAct.cmbPropiedad.value,
                    cmbEncargado: document.frmAct.cmbEncargado.value,
                    fechaCompra: document.frmAct.fechaCompra.value,
                    cmbEstado: document.frmAct.cmbEstado.value,
                    cmbCategoria: document.frmAct.cmbCategoria.value,
                    cantidad: document.frmAct.cantidad.value,
                    foto: nombreArchivo
            },
            //Si recibe respuesta del servlet
            success: function (data) {
            console.log("Respuesta: " + data);
                    if (data == "exito") {
            Swal.fire({
            position: "center",
                    icon: "success",
                    title: "Activo modificado correctamente",
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
    })
    }

    //SI le da format con netbeans en eliminar se mueve la linea 237 => a = > lo cual el sweet alert deja de funcionar
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
            url: "${pageContext.request.contextPath}/activoController",
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
                    title: "Activo eliminado correctamente",
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
            parent.location.href = "activos.jsp"
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

    $("#frmAct").validate({
    rules: {
            txtSerial: {required: true},
            txtNombre: {required: true},
            txtDescripcion: {required: true},
            cmbPropiedad: {required: true},
            cmbEncargado: {required: true},
            fechaCompra: {required: true},
            file: {required: true},
            cmbEstado: {required: true},
            cmbCategoria: {required: true},
            cantidad: {required: true},
    },
            messages: {
            txtNombre: "El campo es obligatorio.",
            txtSerial: "El campo es obligatorio.",
            txtNombre: "El campo es obligatorio.",
            txtDescripcion: "El campo es obligatorio.",
            cmbPropiedad: "El campo es obligatorio.",
            cmbEncargado: "El campo es obligatorio.",
            fechaCompra: "El campo es obligatorio.",
            file: "",
            cmbEstado: "El campo es obligatorio.",
            cmbCategoria: "El campo es obligatorio.",
            cantidad: "El campo es obligatorio.",
            },
            submitHandler: function () {
            //Ejecutamos primero la subida de la imagen dentro de la funcion despues hace el insertar.
            uploadFile(opcion);
                    setTimeout(function () {
                    parent.location.href = "activos.jsp"
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

     function card(){
    $("#tablaCard").show();
    $("#tablaNormal").hide();
    }
    
    function tablaNormal(){
    $("#tablaNormal").show();
    $("#tablaCard").hide();
    }

    async function uploadFile(opcion) {
    let result
            let formData = new FormData();
            formData.append("file", ajaxfile.files[0]);
            try {
            result = await $.ajax({
            url: '${pageContext.request.contextPath}/activoController?accion=upload',
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
            })
                    /*Una vez movemos la foto a la carpeta deseada insertamos y le mandamos como parametro el nombre del archivo que lo
                     devuelve el servlet.*/
                    console.log(result)
                    if (opcion == "insertar") {
            //Ejecutamos primero la subida de la imagen dentro de la funcion despues hace el insertar.
            insertar(result);
            } else if (opcion == "modificar") {
            modificar(result);
            }

            }
    catch (error) {
    console.error(error)
    }
    }

    function cargarSelect() {
    $.ajax({
    url: '${pageContext.request.contextPath}/activoController?accion=cargarSelect',
            method: 'POST',
            type: 'POST',
            data: frmAct.serialize,
            success: function (data) {
            // console.log(data);
            }
    });
    }
    
    $(document).ready( cargarSelect());
    $(document).ajaxComplete( cargarSelect());
    
    
    $(document).ready(function () {
    $("#tablaCard").hide();
    cargarSelect();
            //console.log(request.getAttribute("propiedades"));
            var opcion = "";
            tablaDinamica();
            $("#btnNuevo").on("click", function () {
    $("#btnModificar").hide();
            $("#btnGuardar").show();
            $("#frmAct")[0].reset();
            $("#labelcmbEncargado").show();
            $("#cmbEncargado").show();
    });
            //btn guardar
            $("#btnGuardar").on("click", function (e) {
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
    $("#cmbEncargado").hide();
    $("#labelcmbEncargado").hide();
            $("#btnModificar").show();
    });
            //btn Eliminar MODAL
            $('[name="btnDelete"]').on("click", function () {
    $("#btnGuardar").hide();
            $("#btnModificar").show();
    });
    });

</script>

<% if(usuario.getTipo()==1){
		
	}else if(usuario.getTipo()==2){
		out.println("<script>$('#btnNuevo').hide(); $('.borrar').hide(); $('.borrar2').hide(); $('.borrar3').hide(); </script>");
	} else{
           out.println("<script> $('.borrar2').hide();  </script>");
        }
%>


<% } else {
         response.sendError(response.SC_FORBIDDEN, "Pagina no autorizada");
         //response.sendRedirect("../index.jsp");
    }
%>

<jsp:include page='footer.jsp'/>