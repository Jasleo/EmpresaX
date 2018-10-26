<%@page import="model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

        <div class="modal fade" id ="tableArea" role="dialog">
            <div class="container">
                <h4>Listado de Areas</h4>
                <button class='btn btn-sm btn-success' onclick='showNewArea();'>Agregar Areas</button>
                <table id="myTable" class="table table-striped table-sm">
                    <thead>
                        <tr>
                            <td>ID</td>
                            <td>Nombre</td>
                            <td>Acción</td>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>

            <div class="modal fade" id="modalNuevaArea" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="tituloModal">Nueva Area</h4>
                        </div>
                        <div class="modal-body">
                            <label>Nombre: <input type="text" class="form-control" id="txtArea"></label>
                            <div class="modal-footer">
                                <button class="btn btn-success" onclick="crearArea()">Guardar</button>
                                <button class="btn btn-primary" data-dismiss="modal" onclick="limpiarCampos()">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="modalEditarArea" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="tituloModal">Editar Area</h4>
                        </div>
                        <div class="modal-body">
                            <label>Nombre: <input type="text" class="form-control" id="txtAreaE"></label>
                            <input type="hidden" id="idAreaHidden">
                            <div class="modal-footer">
                                <button class="btn btn-success" onclick="editarArea()">Guardar</button>
                                <button class="btn btn-primary" data-dismiss="modal" onclick="limpiarCampos()">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>




        </div>

        <div class= "modal fade" id = "tableTrabajador">
            <div class="container">
                <h3>Listado de Trabajador</h3>
                <button class='btn btn-sm btn-success' onclick='agregarTraba();'>Agregar Trabajador</button>
                <table id="myTable" class="table table-striped table-sm">
                    <thead>
                        <tr>
                            <td>ID</td>
                            <td>Nombre</td>
                            <td>Apellido</td>
                            <td>Area</td>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>

            <div class="modal fade " id="modalNuevoTrabajador" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="tituloModal">Nuevo Trabajador</h4>
                        </div>
                        <div class="modal-body">
                            <label>Nombre: <input type="text" class="form-control" id="txtNombre"></label>
                            <label>Apellido: <input type="text" class="form-control" id="txtApellido"></label>
                            <label>Area: <input type="text" class="form-control" id="txtArea"></label>
                            <div class="modal-footer">
                                <button class="btn btn-success" onclick="crearTraba()">Guardar</button>
                                <button class="btn btn-primary" data-dismiss="modal" onclick="limpiarCampos()">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <br>
        <br>
        <br>
        <br>
        <button class="btn btn-primary" onclick="logout();">logout</button>

        <script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <script src="js/jquery.dataTables.min.js" type="text/javascript"></script>
        <script src="js/popper.min.js" type="text/javascript"></script>
        <script src="js/sweetalert.min.js" type="text/javascript"></script>


        <script>

            $(document).ready(function () {
                cargaDatosArea();
            });

            function showTableArea() {
                $("#tableArea").modal("show");
            }

            function limpiarCampos() {
                document.getElementById('txtArea').value = '';
            }

            function cargaDatosArea() {
                $.ajax({
                    url: './viewArea.do',
                    type: "POST",
                    data: {
                    },
                    dataType: 'json',
                    success: function (datos) {
                        dibujaTablaArea(datos);
                    }
                });
            }

            function showNewArea() {
                // abrir ventana modal datos en blanco
                $("#modalNuevaArea").modal("show");
            }

            function crearArea() {
                //variables para todos los datos del nuevo producto
                // ajax para crear nuevo producto (insert)
                var are = $("#txtArea").val();
                if (are.length == 0) {
                    swal("Error, debe ingresar area.");
                    return;
                }
                // asumimos que no hay errores
                $.ajax({
                    url: './createArea.do',
                    type: "POST",
                    dataType: "text",
                    data: {
                        accion: "crearArea",
                        are: are,
                    },
                    success: function (datos) {
                        console.log(datos);
                        cargaDatosArea();
                    }
                });
                $("#modalNuevaArea").modal("hide");
                cargaDatosArea();
                $("#txtArea").val("");
            }

            function editarShowArea(id) {
                // abrir ventana modal con los datos del producto
                // llamamos a la función que guarda modificación
                $("#modalEditarArea").modal("show");
                $("#idArea").html("ID Area: " + id);
                $("#idAreaHidden").val(id);

                $.ajax({
                    url: './updateArea.do',
                    type: "POST",
                    data: {
                        accion: "traerArea",
                        id: id
                    },
                    dataType: 'json',
                    success: function (data) {
                        $("#txtAreaE").val(data.nombre);
                    }
                });
            }

            function editarArea() {
                // cargar los datos del producto a editar (desde el formulario del modal)
                // ajax para guardar edición

                var are = $("#txtAreaE").val();
                var id = $("#idAreaHidden").val();
                if (are.length == 0) {
                    swal("Error", "debe ingresar dato.", "error");
                    return;
                }
                swal({
                    title: "Advertencia",
                    text: "Está seguro que desea editar el area id:" + id,
                    icon: "warning",
                    buttons: ['No', 'Si, Editar'],
                    dangerMode: true,
                }).then((willDelete) => {
                    if (willDelete) {
                        $.ajax({
                            url: './updateArea.do',
                            type: "POST",
                            dataType: "text",
                            data: {
                                accion: "editarArea",
                                id: id,
                                are: are,
                            },
                            success: function (datos) {
                                console.log(datos);
                                cargaDatosArea();
                                $("#modalEditarArea").modal("hide");
                                $("#idAreaHidden").val("");
                                swal("Correcto!", "Area modificada !", "success");
                            }
                        });
                    }
                });
            }

            function eliminarArea(id) {
                swal({title: "Advertencia",
                    text: "Está seguro que desea eliminar el id del area: " + id,
                    icon: "warning",
                    buttons: ['No', 'Si, Eliminar'],
                    dangerMode: true,
                }).then((willDelete) => {
                    if (willDelete) {
                        // AJAX para eliminar el producto
                        // mensaje al usuario
                        $.ajax({
                            url: './deleteArea.do',
                            type: "POST",
                            dataType: "html",
                            data: {
                                accion: "eliminarArea",
                                id: id
                            },
                            success: function (datos) {
                                cargaDatosArea();
                                swal("Correcto!", "Area eliminada !", "success");
                            }
                        });
                    }
                });
            }

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

            function dibujaTablaArea(datos) {
                $('#myTable').DataTable().destroy();
                $('#myTable').DataTable({
                    dom: 'frtip',
                    "autowidth": true,
                    data: datos,
                    columns: [
                        {data: "id"},
                        {data: "nombre"},
                        {data: "id",
                            render: function (data, type, row, meta) {
                                var botones = "<button class='btn btn-sm btn-primary' onclick='editarShowArea(" + data + ");'> Editar</button>";
                                botones += "<button class='btn btn-sm btn-danger' onclick='eliminarArea(" + data + ");'> Eliminar</button>";
                                return botones;
                            }
                        }
                    ],
                    "language": {
                        "sProcessing": "Procesando...",
                        "sLengthMenu": "Mostrar _MENU_ registros",
                        "sZeroRecords": "No se encontraron resultados",
                        "sEmptyTable": "Ningún dato disponible en esta tabla",
                        "sInfo": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                        "sInfoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
                        "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
                        "sInfoPostFix": "",
                        "sSearch": "Buscar:",
                        "sUrl": "",
                        "sInfoThousands": ",",
                        "sLoadingRecords": "Cargando...",
                        "oPaginate": {
                            "sFirst": "Primero",
                            "sLast": "Último",
                            "sNext": "Siguiente",
                            "sPrevious": "Anterior"
                        },
                        "oAria": {
                            "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
                            "sSortDescending": ": Activar para ordenar la columna de manera descendente"
                        }
                    }
                });
            }




        </script>





    </body>
</html>
