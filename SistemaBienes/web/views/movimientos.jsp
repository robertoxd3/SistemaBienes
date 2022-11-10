
<%@page import="com.model.Usuario"%>
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
<!--Main layout-->
<main style="margin-top: 58px">
    <div class="container pt-4">
        <h1 class="display-5">Traspaso</h1>
        <p class="lead">Seleccione un empleado y eliga el activo que desea traspasar .</p>
        <br>
             <form  method="GET" name="frmBienes" id="frmBienes">
            <label for="cmbEncargado" class="form-label">Seleccione un encargado para ver los bienes que este posee.</label>
            <select name="cmbEncargado" id="cmbEncargado" class="form-select" aria-label="Default select example" onchange="getval(this);">
                <option value="0" selected>Seleccione un Empleado...</option>
                <c:forEach items="${empleados}" var="emp">
                      <option value="${emp.idEmpleado}">${emp.apellidos}</option>
                 </c:forEach>
            </select>
             </form>
            
             <div id="tablaBienes" >
                 
             </div>
        
             <!-- Modal -->
        <div class="modal fade" id="ModalTraspaso" tabindex="-1" aria-labelledby="ModalTraspasoLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                     <div class="modal-header">
                        <h5 class="modal-title">Traspaso de bienes</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                      </div>
                    <div class="modal-body">
                        <form action="/traspasoController" method="POST" name="frmTra" id="frmTra" enctype="multipart/form-data">

                            <div class="myform ">
                                <input  type="hidden" value="0" name="idBien"/>
                                <h4 class="text-center">Creación de nuevo traspaso</h4>
                                 <label for="cmbEncargadoAnterior" class="form-label">Encargado Actual: </label>
                                <select  name="cmbEncargadoAnterior" id="cmbEncargadoAnterior" class="form-select" aria-label="Default select example" required>
                                   <c:forEach items="${empleados}" var="emp">
                                        <option value="${emp.idEmpleado}">${emp.apellidos}</option>
                                   </c:forEach>
                                </select>
                                 <label for="cmbEncargadoNuevo" class="form-label">Encargado Nuevo: </label>
                                 <select name="cmbEncargadoNuevo" id="cmbEncargadoNuevo" class="form-select" aria-label="Default select example" required>
                                    <c:forEach items="${empleados}" var="emp">
                                        <option value="${emp.idEmpleado}">${emp.apellidos}</option>
                                    </c:forEach>
                                </select>
                                 <button type="button" id="btnGuardar" name="btnGuardar" class="btn btn-dark mt-3">Guardar</button>

                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
    </div>
    <script>
        
        function cargar( activo, encargadoAnterior)
            {
                   $('#cmbEncargadoAnterior ').prop('disabled', true);
                    document.frmTra.idBien.value = activo;
                    document.frmTra.cmbEncargadoAnterior.value = encargadoAnterior;
                   // document.frmTra.cmbEncargadoNuevo.value = estado;
                     //alert("id: "+activo+ "encargado ant"+encargadoAnterior);
            }
            
        function cargarSelect() {
    $.ajax({
    url: '${pageContext.request.contextPath}/traspasoController?accion=cargarSelect',
            method: 'POST',
            type: 'POST',

            success: function (data) {
             //console.log(data);
            }
    });
    }
    
    function getval(sel)
    {
        if(sel.value!==0){
           bienes(sel.value);
        }else{
            alert("Seleccione un empleado!");
        }
       
    }
    
    function insertar() {
    $.ajax({
    type: "POST",
            url: "${pageContext.request.contextPath}/traspasoController?accion=insertar",
            async: true,
            data: {
                    activo:   document.frmTra.idBien.value,
                    cmbEncargadoAnterior:   document.frmTra.cmbEncargadoAnterior.value,
                    cmbEncargadoNuevo:  document.frmTra.cmbEncargadoNuevo.value,
 

            },
            //Si recibe respuesta del servlet
            success: function (data) {
            console.log("Respuesta: " + data);
                    if (data == "exito") {
            Swal.fire({
            position: "center",
                    icon: "success",
                    title: "Traspaso realizado correctamente",
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
                        parent.location.href = "movimientos.jsp"
             }, 1800);

            },
            error: function (jqXHR, textStatus, errorThrown) {
            console.log("No hay respuesta del server, Error: " + textStatus);
            },
    })
    };


    
     function bienes(id) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/traspasoController",
            async: true,
            data: {
                accion: "getActivoId",
                idEncargado: id,
            },
            dataType: 'text',
            //Si recibe respuesta del servlet
            success: function (data) {
                //console.log("Respuesta: " + data);
                    $("#tablaBienes").empty();
                    $("#tablaBienes").append(data);

            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("No hay respuesta del server, Error: " + textStatus);
            },
        });
    }
    
    
     $(document).ready( cargarSelect());
    $(document).ajaxComplete( cargarSelect());
    
        $(document).ready(function () {
         
       
        
           //btn guardar
         $("#btnGuardar").on("click", function (e) {
            insertar();
            });
        });
    </script>
    <!--Container-->
</main>
<!--Main layout-->



<% } else {
         //response.sendRedirect("../index.jsp");
        response.sendError(response.SC_FORBIDDEN, "Pagina no autorizada");
    }
%>

<jsp:include page='footer.jsp'/>
