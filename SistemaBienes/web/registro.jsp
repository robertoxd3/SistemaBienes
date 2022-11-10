<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Sistema Bienes</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
        <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

        <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.12.1/js/dataTables.bootstrap4.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
         <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js" integrity="sha512-rstIgDs0xPgmG6RX1Aba4KV5cWJbAMcvRCVmglpam9SoHZiUCyQVDdH2LPlxoHtrv17XWblE/V/PP+Tr04hbtA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

    </head>

    <body >


        <style>

            body {
                padding: 0;
                margin: 0;
                color: white;
                height: 100vh;
                font-family: "Nunito Sans";
            }

            .form-control {
                line-height: 2;
            }

            .bg-custom {
                background-color: #212F3D;
            }

            .btn-custom:hover {
                background-color: #33313f;
                color: #fff;
            }

            a{
                text-decoration: none;
            }

            @media(max-width: 932px) {
                .display-none {
                    display: none !important;
                }
            }
        </style>
    </head>
<body>
    <div class="row m-0 " style="height: 100vh;">
        
        <div class="col p-0 bg-custom d-flex justify-content-center align-items-center flex-column w-100">
            <div class="tab-content w-75" id="pills-tabContent">
                <div class="tab-pane fade show active " id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab" tabindex="0">
                    <form action="/loginController"  method="POST" name="registroForm" id="registroForm" >
                        <div class="d-flex align-items-center mb-3 pb-1">
                            <i class="fas fa-cubes fa-2x me-3" style="color: #ff6219;"></i>
                            <span class="h1 fw-bold mb-0">Sistema Bienes</span>
                        </div>

                        <h5 class="fw-normal mb-3 pb-3" style="letter-spacing: 1px;">Inicia sesión en tu cuenta</h5>

                        <div class="form-outline mb-4">
                            <label class="form-label" for="txtNombre">Nombre de Usuario</label>
                            <input type="text" id="txtNombre" name="txtNombre" class="form-control"  required=""/>
                        </div>
                        
                        <div class="form-outline mb-4">
                            <label class="form-label" for="txtClave">Contraseña</label>
                            <input type="password" id="txtClave" name="txtClave" class="form-control" required=""/>
                        </div>

                        <div class="form-outline mb-4">
                            <label class="form-label" for="txtClaveRepetida">Repita Contraseña</label>
                            <input type="password" id="txtClaveRepetida" name="txtClaveRepetida" class="form-control" required=""/>
                        </div>
                        
                         <div class="form-outline mb-4">
                                <label for="cmbTipo" class="form-label">Tipo de usuario: </label>
                                <select name="cmbTipo" id="cmbTipo" class="form-select" aria-label="Default select example">
                                    <option value="1" selected>Administrador</option>
                                    <option value="2">Vendedor</option>
                                    <option value="3">Gerente</option>
                                </select>
                        </div>

                        <div class="pt-1 mb-4 ">
                            <button type="submit" id="btnRegistro" onclick="validar()" class="btn btn-outline-info w-100 text-white">Registrarse</button>
                        </div>

                        <p class="mb-2 pb-lg-2 text-center" style="color: #BFC9CA;">¿Ya tienes cuenta? <a href="index.jsp" class="">Inicia sesión acá</a></p>
                    </form>
                </div>
            </div>
        </div>
        <div class="col p-0 text-center d-flex justify-content-center align-items-center display-none">
            <img src="assets/Login3.svg" class="w-100">
        </div>
    </div>

    <script>
        
         function validar() {

    $("#registroForm").validate({
    rules: {
              txtNombre: {required:true},
              txtClave: {required:true,minlength:3 },
              txtClaveRepetida: {required:true,equalTo:"#txtClave" },
              cmbTipo: {required:true}
    },
            messages: {
            txtNombre: "El campo es obligatorio.",
            txtClave: "El campo es obligatorio. contraseñas deben ser igual. mayor que 3 digitos",
            txtClaveRepetida: "El campo es obligatorio. contraseñas deben ser igual. mayor que 3 digitos",
            cmbTipo: "El campo es obligatorio.",
            },
            submitHandler: function () {
                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/loginController",
                    data: {
                        accion: "nuevoUsuario",
                        nombre: document.registroForm.txtNombre.value,
                        clave: document.registroForm.txtClave.value,
                        tipo: document.registroForm.cmbTipo.value,
                    },
                    dataType: 'text',
                    //Si recibe respuesta del servlet
                    success: function (data) {
                        console.log("Respuesta: " + data);
                        if (data == "exito") {
                            Swal.fire({
                                position: "center",
                                icon: "success",
                                title: "Usuario Registrado correctamente",
                                text: 'Se revisará su usuario manualmente y se activará su cuenta',
                                showConfirmButton: false,
                                timer: 2400,
                            });
                        } else {
                            Swal.fire({
                                icon: "error",
                                title: "Oops...",
                                text: "Algo salio mal!",
                                showConfirmButton: false,
                                timer: 2400,
                            });
                        }
                        
                          setTimeout(function () {
                         window.location.replace("index.jsp");
                    }, 2400);
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log("No hay respuesta del server, Error: " + textStatus);
                    },
                });
           
            },
    });
    }
    
     $("#btnRegistro").on("click", function (e) {
    validar();
    });
        
    </script>




    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>

</body>

</html>
