<%@page import="com.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.model.Propiedad"%>
<%@page import="com.dao.DaoPropiedad"%>
<%@page import="java.util.List"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<jsp:include page='nav.jsp'/>


<%
    DaoPropiedad daoP = new DaoPropiedad();
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
        <h1 class="display-5">Propiedades</h1>
        <span class="lead">Estos son todos las propiedades registradas por la entidad, tiene la opcion de agregar, modificar y eliminar</span>
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
            <table class="table table-primary table-hover animate__animated animate__fadeInLeft animate__delay-0.5s " id="tabla">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Foto</th>
                        <th>Dirección</th>
                        <th>Teléfono</th>
                        <th>Estado</th>
                        <th class="td-center">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Propiedad> lista = daoP.getPropiedad();
                        for (Propiedad pro : lista) {
                    %>

                    <tr>
                        <td> <%=pro.getIdPropiedad()%></td>
                        <td> <%=pro.getNombre()%></td>
                        <td> <img src="../assets/propiedades/<%=pro.getFoto()%>" class="rounded-start"  style="width: 100px; height: 100px" alt="propiedad"></td>
                        <td> <%=pro.getDireccion()%></td>
                        <td> <%=pro.getTelefono()%></td>
                        <td> <%=pro.getEstado()%></td>
                        <td class="td-center">
                            <a data-bs-toggle="modal" data-bs-target="#ModalPropiedad" name="btnEdit" href="#" onclick="javascript:cargar(<%=pro.getIdPropiedad()%>, '<%=pro.getNombre()%>', '<%=pro.getDireccion()%>', '<%=pro.getTelefono()%>', '<%=pro.getFoto()%>', '<%=pro.getEstado()%>')" class=" btn btn-secondary rounded-lg borrar" data-toggle="tooltip" title="Modificar" data-placement="bottom"><i class="fa-solid fa-pen-to-square"></i></a> 
                            <a  name="btnDelete" onclick="javascript:eliminar(<%=pro.getIdPropiedad()%>, '<%=pro.getNombre()%>')" href="#" class="btn btn-danger rounded-lg borrar2" data-toggle="tooltip" title="Eliminar" data-placement="bottom"><i class="fa-solid fa-trash"></i></a>
                        </td>

                    </tr>
                    <%}%>
                </tbody>
            </table>
        </div>



            <div class="row" id="tablaCard">
            <%
                List<Propiedad> lista2 = daoP.getPropiedad();
                for (Propiedad pro : lista2) {
            %>

            <div class="col-lg-3 col-md-4 col-sm-6 col-12">
                <div class="card h-100 w-100">
                    <img src="../assets/propiedades/<%=pro.getFoto()%>" class="rounded-start img-fluid img-custom" alt="propiedad">
                    <div class="card-body">
                        <h5 class="card-title"><%=pro.getNombre()%></h5>
                        <span class="card-text"><b>Direccion: </b><%=pro.getDireccion()%></span><br>
                        <span class="card-text "><b>Teléfono: </b><%=pro.getTelefono()%></span><br>
                        <span class="card-text "><b>Estado: </b><%=pro.getEstado()%></span><br>
                        <a data-bs-toggle="modal" data-bs-target="#ModalPropiedad" name="btnEdit" href="#" onclick="javascript:cargar(<%=pro.getIdPropiedad()%>, '<%=pro.getNombre()%>', '<%=pro.getDireccion()%>', '<%=pro.getTelefono()%>', '<%=pro.getFoto()%>', '<%=pro.getEstado()%>')" class=" btn btn-secondary rounded-lg borrar" data-toggle="tooltip" title="Modificar" data-placement="bottom"><i class="fa-solid fa-pen-to-square"></i></a> 
                        <a  name="btnDelete" onclick="javascript:eliminar(<%=pro.getIdPropiedad()%>, '<%=pro.getNombre()%>')" href="#" class="btn btn-danger rounded-lg borrar2" data-toggle="tooltip" title="Eliminar" data-placement="bottom"><i class="fa-solid fa-trash"></i></a>
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
                        <form action="/propiedadController" method="POST" name="frmPro" id="frmPro" enctype="multipart/form-data">
                            <div class="d-flex justify-content-end">
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="myform ">
                                <input type="hidden" value="0" name="idPropiedad"/>
                                <h3 class="text-center">Mantenimiento Propiedades</h3>
                                <label for="txtNombre" class="form-label">Nombre:</label>
                                <input type="text" id="txtPoliza" name="txtNombre" class="form-control" placeholder="Nombre"  />
                                <label for="txtDireccion" class="form-label">Direccion: </label>
                                <input type="text" id="txtDireccion" name="txtDireccion" class="form-control" placeholder="Direccion"  />
                                <label for="txtTelefono" class="form-label">Telefono: </label>
                                <input type="text" id="txtTelefono" name="txtTelefono" class="form-control" placeholder="Telefono"  />
                                <label for="foto" class="form-label">Ingrese una Imagen: </label>
                                <input id="ajaxfile" type="file" class="form-control" name="file" required/>
                                <label for="cmbEstado" class="form-label">Estado: </label>
                                <select name="cmbEstado" id="cmbEstado" class="form-select" aria-label="Default select example">
                                    <option value="Disponible" selected>Disponible</option>
                                    <option value="No Disponible">No Disponible</option>
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

<script>
            function cargar(idPropiedad, nombre, direccion, telefono, foto, estado)
            {
            document.frmPro.idPropiedad.value = idPropiedad;
                    document.frmPro.txtNombre.value = nombre;
                    document.frmPro.txtDireccion.value = direccion;
                    document.frmPro.txtTelefono.value = telefono;
                    //document.frmPro.foto.value = foto;

                    document.frmPro.cmbEstado.value = estado;
            }


    function insertar(nombreArchivo) {
    $.ajax({
    type: "POST",
            url: "${pageContext.request.contextPath}/propiedadController",
            async: true,
            data: {
            accion: "insertar",
                    idPropiedad: document.frmPro.idPropiedad.value,
                    txtNombre: document.frmPro.txtNombre.value,
                    txtDireccion: document.frmPro.txtDireccion.value,
                    txtTelefono: document.frmPro.txtTelefono.value,
                    cmbEstado: document.frmPro.cmbEstado.value,
                    foto: nombreArchivo
            },
            //Si recibe respuesta del servlet
            success: function (data) {
            console.log("Respuesta: " + data);
                    if (data == "exito") {
            Swal.fire({
            position: "center",
                    icon: "success",
                    title: "Propiedad almacenada correctamente",
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
            url: "${pageContext.request.contextPath}/propiedadController",
            async: true,
            data: {
            accion: "modificar",
                    idPropiedad: document.frmPro.idPropiedad.value,
                    txtNombre: document.frmPro.txtNombre.value,
                    txtDireccion: document.frmPro.txtDireccion.value,
                    txtTelefono: document.frmPro.txtTelefono.value,
                    cmbEstado: document.frmPro.cmbEstado.value,
                    foto: nombreArchivo
            },
            //Si recibe respuesta del servlet
            success: function (data) {
            console.log("Respuesta: " + data);
                    if (data == "exito") {
            Swal.fire({
            position: "center",
                    icon: "success",
                    title: "Propiedad almacenado correctamente",
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
    function eliminar(idPropiedad, nombre)
    {
    Swal.fire({
    title: "Quieres eliminar al usuario con nombre " + nombre + " con codigo: " + idPropiedad + "?",
            showCancelButton: true,
            confirmButtonText: "Si",
    }).then((result) => {
    if (result.isConfirmed) {
    $.ajax({
    type: "POST",
            url: "${pageContext.request.contextPath}/propiedadController",
            async: true,
            data: {
            accion: "eliminar",
                    codigo: idPropiedad,
            },
            dataType: 'text',
            //Si recibe respuesta del servlet
            success: function (data) {
            console.log("bien: " + data);
                    if (data == "exito") {
            Swal.fire({
            position: "center",
                    icon: "success",
                    title: "Propiedad eliminado correctamente",
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
            parent.location.href = "propiedad.jsp"
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

    $("#frmPro").validate({
    rules: {
    txtNombre: {required: true},
            txtDireccion: {required: true},
            txtTelefono: {required: true},
            foto: {required: true},
            cmbEstado: {required: true},
    },
            messages: {
            txtNombre: "El campo es obligatorio.",
                    txtDireccion: "El campo es obligatorio.",
                    txtTelefono: "El campo es obligatorio.",
                    foto: "El campo es obligatorio.",
                    cmbEstado: "El campo es obligatorio.",
            },
            submitHandler: function () {
            //Ejecutamos primero la subida de la imagen dentro de la funcion despues hace el insertar.
            uploadFile(opcion);
                    setTimeout(function () {
                    parent.location.href = "propiedad.jsp"
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



    async function uploadFile(opcion) {
    let result
            let formData = new FormData();
            formData.append("file", ajaxfile.files[0]);
            try {
            result = await $.ajax({
            url: '${pageContext.request.contextPath}/propiedadController?accion=upload',
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
    
    function card(){
    $("#tablaCard").show();
    $("#tablaNormal").hide();
    }
    
    function tablaNormal(){
    $("#tablaNormal").show();
    $("#tablaCard").hide();
    }
    
      document.getElementById('txtTelefono').addEventListener('input', function (e) {
                var x = e.target.value.replace(/\D/g, '').match(/(\d{0,4})(\d{0,4})/);
                e.target.value = x[1] + '-' + x[2]
            });


    $(document).ready(function () {
        $("#tablaNormal").hide();
    var opcion = "";
            tablaDinamica();
            $("#btnNuevo").on("click", function () {
    $("#btnModificar").hide();
            $("#btnGuardar").show();
            $("#frmPro")[0].reset();
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
		out.println("<script> $('#btnNuevo').hide(); $('.borrar').hide(); $('.borrar2').hide();  </script>");
	} else{
           out.println("<script> $('.borrar').hide(); $('.borrar2').hide();  </script>");
        }
%>



<% } else {
        //response.sendRedirect("../index.jsp");
        response.sendError(response.SC_FORBIDDEN, "Pagina no autorizada");
    }
%>

<jsp:include page='footer.jsp'/>