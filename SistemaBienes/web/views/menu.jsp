
<%@page import="com.model.Activo"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.DaoEmpleado"%>
<%@page import="com.dao.DaoTraspaso"%>
<%@page import="com.dao.DaoActivo"%>
<%@page import="com.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.dao.DaoPropiedad"%>
<%@page import="com.dao.DaoUsuario"%>
<%@ page import="java.util.*,java.sql.*" %>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>
<!DOCTYPE html>
<jsp:include page='nav.jsp'/>
<%
    DaoPropiedad daoP = new DaoPropiedad();
    DaoActivo daoA = new DaoActivo();
    DaoTraspaso daoT = new DaoTraspaso();
    DaoUsuario daoU = new DaoUsuario();
    DaoEmpleado daoE = new DaoEmpleado();
    int countPropiedades = daoP.getPropiedadesCount();
    int countUsuarios = daoU.getUsuariosCount();
    int countActivos = daoA.getActivosCount();
    int countTraspasos = daoT.getTraspasosCount();
    int countEmpleados = daoE.getEmpleadosCount();

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
    
    .graficosStyle {
        width:100%;
        max-width: 30rem;
        height: 300px;
    }
    @media (max-width: 575px) {
        .graficosStyle{
            width: 100%; 
            height: 100%;
        }
    }
</style>

<!--Main layout-->
<main style="margin-top: 58px">
    <div class="container pt-4">
        <h1 class="display-5 animate__animated animate__backInLeft">Bienvenido  <%= usuario.getNombre()%> </h1>

        <div class="row text-center text-lg-start animate__animated animate__backInLeft">

            <div class="col-lg-3 col-md-4 col-6" >
                <a href="propiedad.jsp" class="d-block mb-4 h-100">
                    <div class="card text-white mb-3" style="max-width: 18rem; background-color: #2C3E50;"  id="cardCustom" >
                        <div class="card-header text-center">Propiedades</div>
                        <div class="card-body text-center">
                            <span class="card-text"> <i class="fa-solid fa-building fa-3x"></i></span><br>
                            <p class=" badge badge-info card-text"><%=countPropiedades%></p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-4 col-6">
                <a href="activos.jsp" class="d-block mb-4 h-100">
                    <div class="card text-white mb-3" style="max-width: 18rem; background-color: #2C3E50;">
                        <div class="card-header text-center">Activos</div>
                        <div class="card-body text-center">
                            <span class="card-text"><i class="fa-solid fa-warehouse fa-3x"></i></span><br>
                            <p class=" badge badge-info card-text"><%=countActivos%></p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-4 col-6" id="traspasoMenu">
                <a href="movimientoLista.jsp" class="d-block mb-4 h-100">
                    <div class="card text-white mb-3" style="max-width: 18rem; background-color: #1F618D;">
                        <div class="card-header text-center">Traspaso</div>
                        <div class="card-body text-center">
                            <span class="card-text"><i class="fa-solid fa-shuffle fa-3x"></i></span><br>
                            <p class=" badge badge-info card-text"><%=countTraspasos%></p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-4 col-6" id="usuariosMenu">
                <a href="usuarios.jsp" class="d-block mb-4 h-100">
                    <div class="card text-white mb-3" style="max-width: 18rem; background-color: #1F618D;">
                        <div class="card-header text-center">Usuarios</div>
                        <div class="card-body text-center">
                            <span class="card-text"><i class="fa-solid fa-users fa-3x"></i></span><br>
                            <p class=" badge badge-info card-text"><%=countUsuarios%></p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-4 col-6">
                <a href="reporteMenu.jsp" class="d-block mb-4 h-100">
                    <div class="card text-white mb-3" style="max-width: 18rem; background-color: #616A6B;">
                        <div class="card-header text-center">Reportes</div>
                        <div class="card-body text-center">
                            <span class="card-text"><i class="fa-solid fa-file-pdf fa-3x"></i></span><br>
                            <p class=" badge badge-info card-text">2</p>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-lg-3 col-md-4 col-6" id="empleadosMenu">
                <a href="empleados.jsp" class="d-block mb-4 h-100">
                    <div class="card text-white mb-3" style="max-width: 18rem; background-color: #616A6B;">
                        <div class="card-header text-center">Empleados</div>
                        <div class="card-body text-center">
                            <span class="card-text"><i class="fa-solid fa-people-group fa-3x"></i></span><br>
                            <p class=" badge badge-info card-text"><%=countEmpleados%></p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-4 col-6">
                <a href="perfil.jsp" class="d-block mb-4 h-100">
                    <div class="card text-white mb-3" style="max-width: 18rem; background-color: #616A6B;">
                        <div class="card-header text-center">Mi Perfil</div>
                        <div class="card-body text-center">
                            <span class="card-text"><i class="fa-solid fa-address-card fa-3x"></i></span><br>
                            <p class=" badge badge-info card-text">Información</p>
                        </div>
                    </div>
                </a>
            </div>
        </div>



        <h6 class="display-5 ">Gráficos</h6>                
        <div class="row">
            <span>Activos por Categoria</span>
            <div class=" col-md-6 col-12 py-3">
                <div id="chartContainer" class="graficosStyle">

                </div>    
            </div>
            <div class=" col-md-6 col-12 py-3">
                <div id="chartContainer2" class="graficosStyle">

                </div>    
            </div>
        </div>     

    </div>
    <!--Container-->
</main>
<!--Main layout-->


<script>
            
 google.charts.load('current', {packages: ['corechart','bar']});
            google.charts.setOnLoadCallback(draw);
    google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
          
           $.ajax({
                    type: "GET",
                    url: "${pageContext.request.contextPath}/GraficosController",
                    dataType: 'JSON',
                    //Si recibe respuesta del servlet
                    success: function (result) {
                        console.log("JsonGet:"+result+ result.nombre);
                        
                        var data = new google.visualization.DataTable();
                    data.addColumn('string', 'Fecha');
                    data.addColumn('number', 'Cantidad');
                    
                    dataArray= [];
                    $.each(result, function (i,obj){
                       dataArray.push([obj.fechaCompra, obj.cantidad]) 
                    });
                    
                    data.addRows(dataArray);
                    // Instantiate and draw the chart.
                          var options = {
                        chart: {
                          title: 'Cantidad de activo por fecha',
                          subtitle: 'Últimos 5 cantidad de activos ingresados por fecha',
                        }
                      };

                      var chart = new google.charts.Bar(document.getElementById('chartContainer2'));

                      chart.draw(data, google.charts.Bar.convertOptions(options));
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log("No hay respuesta del server, Error: " + textStatus);
                    },
                });
      }
      
            
      function draw(){
         
        $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/GraficosController",
                    dataType: 'JSON',
                    //Si recibe respuesta del servlet
                    success: function (result) {
                        console.log("Json:"+result);
                        var data = new google.visualization.DataTable();
                    data.addColumn('string', 'Activo');
                    data.addColumn('number', 'Percentage');
                    
                    dataArray= [];
                    $.each(result, function (i,obj){
                       dataArray.push([obj.categoria, obj.cantidad]) 
                    });
                    
                    var options = {
                        chart: {
                          title: 'Activos por Categoria',
                          subtitle: 'Cantidad de activos por categoria',
                        }
                      };
                    
                    data.addRows(dataArray);
                    // Instantiate and draw the chart.
                    var chart = new google.visualization.PieChart(document.getElementById('chartContainer'));
                    chart.draw(data, null);
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log("No hay respuesta del server, Error: " + textStatus);
                    },
                });
    }      
            
            
    $(document).ready(function () {
    draw();
    drawChart();
    });

</script>

<% if(usuario.getTipo()==1){
		
	}else if(usuario.getTipo()==2){
		out.println("<script> $('#usuariosMenu').hide(); $('#empleadosMenu').hide(); $('#traspasoMenu').hide();  </script>");
	} else{
           out.println("<script> $('#usuariosMenu').hide();   </script>");
        }
%>

<% } else {
        response.sendError(response.SC_FORBIDDEN, "Pagina no autorizada");
       // response.sendRedirect("../index.jsp");
    }
%>
<jsp:include page='footer.jsp'/>
