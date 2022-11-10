    
<%@page import="com.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Sistema</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
        <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

        <!-- Font Awesome -->
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
            rel="stylesheet"
            />
        <!-- Google Fonts -->
        <link
            href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap"
            rel="stylesheet"
            />
        <!-- MDB -->
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.css"
            rel="stylesheet"
            />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css" />
        <!--DATA TABLE-->
        <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.12.1/js/dataTables.bootstrap4.min.js"></script>
        <!--FONT AWESOME-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <!--ANIMATE JS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js" integrity="sha512-rstIgDs0xPgmG6RX1Aba4KV5cWJbAMcvRCVmglpam9SoHZiUCyQVDdH2LPlxoHtrv17XWblE/V/PP+Tr04hbtA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
       <!--Graficos-->
         <script src="https://www.gstatic.com/charts/loader.js"></script>
    </head>
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
    <!--Main Navigation-->
    <header>
        <!-- Sidebar -->
        
        <nav
            id="sidebarMenu"
            class="collapse d-lg-block sidebar collapse bg-white"
            >
            <div class="position-sticky">
                <div class="list-group list-group-flush mx-3 mt-4">
                    <a
                        href="${pageContext.request.contextPath}/views/menu.jsp"
                        class="list-group-item list-group-item-action py-2 ripple active"
                        aria-current="true"
                        >
                        <i class="fas fa-tachometer-alt fa-fw me-3"></i
                        ><span>Inicio Dashboard</span>
                    </a>  
                    
                    <a
                        href="${pageContext.request.contextPath}/views/activos.jsp"
                        class="list-group-item list-group-item-action py-2 ripple"
                        >
                        <i class="fa-solid fa-warehouse fa-fw me-3"></i></i><span>Activos</span>
                    </a>

                    <a
                        href="${pageContext.request.contextPath}/views/propiedad.jsp"
                        class="list-group-item list-group-item-action py-2 ripple"
                        >
                        <i class="fas fa-building fa-fw me-3"></i><span>Propiedades</span>
                    </a>


                    <a
                        id="usuariosNav"
                       href="${pageContext.request.contextPath}/views/usuarios.jsp"
                        class="list-group-item list-group-item-action py-2 ripple"
                        >
                        <i class="fas fa-users fa-fw me-3"></i><span>Usuarios</span>
                    </a>

                    <a
                        id="empleadosNav"
                        href="${pageContext.request.contextPath}/views/empleados.jsp"
                        class="list-group-item list-group-item-action py-2 ripple"
                        >
                        <i class="fa-solid fa-users-gear me-3"></i><span>Empleados</span>
                    </a>

                    <a
                        href="${pageContext.request.contextPath}/views/reporteMenu.jsp"
                        class="list-group-item list-group-item-action py-2 ripple"
                        ><i class="fas fa-chart-line fa-fw me-3"></i
                        ><span>Reportes</span></a
                    >   
                    
                    <a
                            class="list-group-item list-group-item-action py-2 ripple"
                            href="#"
                            id="navbarDropdownMenuLink1"
                            role="button"
                            data-mdb-toggle="dropdown"
                            aria-expanded="false"
                            >
                            <i class="fa-solid fa-hand-holding-hand fa-fw me-3"></i><span>Traspasos</span>  
                        </a>
                        <ul
                            class="dropdown-menu dropdown-menu-end"
                            aria-labelledby="navbarDropdownMenuLink1"
                            >
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/views/movimientos.jsp"><i class="fa-solid fa-plus"></i> Nuevo</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/views/movimientoLista.jsp"><i class="fa-solid fa-file"></i> Historial</a></li> 
                        </ul>

                </div>
            </div>
        </nav>
        <!-- Sidebar -->

        <!-- Navbar -->
        <nav
            id="main-navbar"
            class="navbar navbar-expand-lg navbar-light bg-white fixed-top"
            >
            <!-- Container wrapper -->
            <div class="container-fluid mx-3">
                <!-- Toggle button -->
                <button
                    class="navbar-toggler"
                    type="button"
                    data-mdb-toggle="collapse"
                    data-mdb-target="#sidebarMenu"
                    aria-controls="sidebarMenu"
                    aria-expanded="false"
                    aria-label="Toggle navigation"
                    >
                    <i class="fas fa-bars"></i>
                </button>

                <!-- Brand -->
                <a class="navbar-brand" href="${pageContext.request.contextPath}/views/menu.jsp">
                    <img
                        src="${pageContext.request.contextPath}/assets/logo.png"
                        width="45"
                        height="40"
                        alt=""  
                        loading="lazy"
                        />
                    Sistema
                </a>


                <!-- Right links -->
                <ul class="navbar-nav ms-auto d-flex flex-row">

                    <!-- Avatar -->
                    <li class="nav-item dropdown">
                        <a
                            class="nav-link dropdown-toggle hidden-arrow d-flex align-items-center"
                            href="#"
                            id="navbarDropdownMenuLink"
                            role="button"
                            data-mdb-toggle="dropdown"
                            aria-expanded="false"
                            >
                            <img
                                src="${pageContext.request.contextPath}/assets/avatar.png"
                                class="rounded-circle"
                                height="35"
                                alt=""
                                loading="lazy"
                                />
                            <span class="ms-1 d-none d-sm-block"> <%= usuario.getNombre() %>  </span>
                               
                        </a>
                        <ul
                            class="dropdown-menu dropdown-menu-end"
                            aria-labelledby="navbarDropdownMenuLink"
                            >
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/views/perfil.jsp"><i class="fa-solid fa-address-card"></i> Mi perfil</a></li>
                            <li><a class="dropdown-item" href="#" id="cerrar"><i class="fa-solid fa-right-from-bracket"></i> Salir</a></li> 
                        </ul>
                    </li>
                </ul>
            </div>
            <!-- Container wrapper -->
        </nav>
        <!-- Navbar -->
    </header>
    <!--Main Navigation-->
    <script>
        $(document).ready(function () {
            $("#cerrar").on("click", function () {
                Swal.fire({
                title: "¿Seguro que quieres cerrar sesión?",
                        showCancelButton: true,
                        confirmButtonText: "Si",
                }).then((result) => {
                if (result.isConfirmed) {
                 $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/loginController",
                    data: {
                        accion: "salir",
                    },
                    dataType: 'text',
                    //Si recibe respuesta del servlet
                    success: function (data) {
                        console.log("Respuesta: " + data);
                         if (data == "OK") {
                            window.location.replace("${pageContext.request.contextPath}/index.jsp");
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log("No hay respuesta del server, Error: " + textStatus);
                    },
                });  //fin AJAX 
                }
                }
                );
            });
        });
    </script>
    
<% if(usuario.getTipo()==1){
		
	}else if(usuario.getTipo()==2){
		out.println("<script>$('#usuariosNav').hide(); $('#empleadosNav').hide(); $('#navbarDropdownMenuLink1').hide();  </script>");
	} else{
           out.println("<script>$('#usuariosNav').hide(); </script>");
        }
%>

<% } else {
        //response.sendError(response.SC_FORBIDDEN, "Pagina no autorizada");
       response.sendRedirect("../index.jsp");
    }
%>
