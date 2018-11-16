<%@page import="model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Página Interior</title>
        <link rel="stylesheet" href="css/bootstrap.min.css" >
        <link href="css/jquery.dataTables.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/navbar.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <h1></h1>

        <%
            HttpSession objSession = request.getSession(false);
            String name;
            if (objSession == null || !request.isRequestedSessionIdValid()) {
                response.sendRedirect("index.jsp");
            } else {
                Usuario usu = (Usuario) objSession.getAttribute("usuario");
                name = usu.getNombre();
            }
        %>

        <nav class="navbar navbar-expand-sm bg-light navbar-light">
            <ul>
                <a class="navbar-brand"> Bienvenido: 
                    <%
                        Usuario usu = (Usuario) objSession.getAttribute("usuario");
                        out.print(usu.getNombre());
                    %>
                </a>
            </ul>

            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="#">Link</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Link</a>
                </li>
            </ul>
            <div class="navbar-header">
                <a class="navbar-brand">
                    <button class="btn btn-primary" onclick="logout();">logout</button>
                </a>
            </div>
        </nav>

        <script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <script src="js/popper.min.js" type="text/javascript"></script>

        <script src="js/sweetalert.min.js" type="text/javascript"></script>


        <script>

                        $(document).ready(function () {
                            cargaDatosArea();
                        });


                        function logout() {
                            $.ajax({
                                url: './LogoutUser.do',
                                type: "POST",
                                async: false,
                                data: {
                                    accion: "logout"
                                },
                                dataType: 'html',
                                success: function (datos) {
                                    $(location).attr("href", "index.jsp");
                                }
                            });
                        }


        </script>





    </body>
</html>
