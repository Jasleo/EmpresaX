<%@page contentType="text/html" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    </head>
    <body id="LoginForm">
        <div class="container">
            <div class="text-center" >
                <h1 class="form-heading">Administrador</h1>
                <div class="login-form">
                    <div class="main-div">
                        <div class="panel" >
                            <h2>Admin Login</h2>
                        </div>
                        <div class="container">
                            <div id="Login" style="margin:auto;width:400px">
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <input type="text" class="form-control" id="inputUsuario" placeholder="Nombre Usuario">
                                    </div>
                                </div>

                                <div class="form-group" >
                                    <div class="col-sm-12">
                                        <input type="password" class="form-control" id="inputPassword" placeholder="Password">
                                    </div>
                                </div>
                                <button class="btn btn-primary" onclick="iniciarSesion()">Login</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <script src="js/sweetalert.min.js" type="text/javascript"></script>


    <script>
                                    function iniciarSesion() {
                                        var inputUsuario = $("#inputUsuario").val();
                                        var inputPassword = $("#inputPassword").val();
                                        $("#txtAlerta").hide();
                                        // asumimos que no hay errores
                                        $.ajax({
                                            url: './loginUser.do',
                                            type: "POST",
                                            data: {
                                                accion: "login",
                                                inputUsuario: inputUsuario,
                                                inputPassword: inputPassword,
                                            },
                                            dataType: 'html',
                                            async: false,
                                            success: function (datos) {
                                                console.log(datos);
                                                if (datos == "OK") {
                                                    $(location).attr("href", "inicio.jsp");
                                                } else {
                                                    swal({
                                                        type: 'error',
                                                        title: 'Oops...',
                                                        text: 'Verifique Usuario y/o Contraseña',
                                                        footer: '<a href>Why do I have this issue?</a>'
                                                    })

                                                }
                                            }
                                        });
                                    }



    </script>


</body>
</html>