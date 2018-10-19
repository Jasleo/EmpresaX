<%@page import="model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>}
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Página Interior</title>
        <link rel="stylesheet" href="css/bootstrap.min.css" >
        <link href="css/jquery.dataTables.min.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <h1>Bienvenido</h1>
        <%
            HttpSession objSession = request.getSession(false);

            if (objSession == null || !request.isRequestedSessionIdValid()) {
                response.sendRedirect("index.jsp");
            } else {
                Usuario usu = (Usuario) objSession.getAttribute("usuario");
                out.print(usu.getNombre());
            }
        %>

        <br>
        <button class="btn btn-primary" onclick="logout();">logout</button>

        <script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <script src="js/sweetalert.min.js" type="text/javascript"></script>
        <script>
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
