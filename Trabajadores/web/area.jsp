<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>EmpresaX/Areas</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <div class="container">
            <h1>Listado de Areas</h1>
            <button class='btn btn-sm btn-success' onclick='agregar();'>Agregar Trabajador</button>
            <table id="myTable" class="table table-striped table-sm">
                <thead>
                    <tr>
                        <td>ID</td>
                        <td>Nombre</td>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
        <div class="modal fade " id="modalNuevaArea" role="dialog">
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


        <div class="modal fade " id="modalEditarArea" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="tituloModal">Editar Area</h4>
                    </div>
                    <div class="modal-body">
                        <label>Nombre: <input type="text" class="form-control" id="txtArea"></label>
                        <div class="modal-footer">
                            <button class="btn btn-success" onclick="editarArea()">Guardar</button>
                            <button class="btn btn-primary" data-dismiss="modal" onclick="limpiarCampos()">Cerrar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </body>

    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js" ></script>
    <script src="js/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="js/sweetalert.min.js" type="text/javascript"></script>

    <script>
                                $(document).ready(function () {
                                cargaDatos();
                                });
                                function limpiarCampos() {
                                document.getElementById('txtArea').value = ''
                                }

                                function eliminar(id) {
                                swal({
                                title: "Advertencia",
                                        text: "Está seguro que desea eliminar el id: " + id,
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
                                        cargaDatos();
                                        swal("Correcto!", "Area eliminada !", "success");
                                        }
                                });
                                }
                                });
                                }

                                function editar(id) {
                                // abrir ventana modal con los datos del producto
                                // llamamos a la función que guarda modificación

                                $("#modalEditarArea").modal("show");
                                $("#idArea").html("ID Producto: " + id);
                                $("#idAreaHidden").val(id);
                                $.ajax({
                                url: './updateArea',
                                        type: "POST",
                                        data: {
                                        accion: "traerArea",
                                                id: id
                                        },
                                        dataType: 'json',
                                        success: function (data) {
                                        $("#txtAreaE").val(data.categoria);
                                        }
                                });
                                }

                                function agregar() {
                                $("#modalNuevaArea").modal("show");
                                // abrir ventana modal datos en blanco
                                // llamamos a la función que crea producto
                                }
                                
                                //
                                //
                                function crearArea() {
                                //variables para todos los datos del nuevo producto
                                // ajax para crear nuevo producto (insert)
                                var cat = $("#txtArea").val();
                                if (cat.length == 0) {
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
                                                cat: cat,
                                        },
                                        success: function (datos) {
                                        console.log(datos);
                                        cargaDatos();
                                        }
                                });
                                $("#modalNuevaArea").modal("hide");
                                cargaDatos();
                                $("#txtArea").val("");
                                }

                                function editarArea() {
                                // cargar los datos del producto a editar (desde el formulario del modal)
                                // ajax para guardar edición

                                var cat = $("#txtAreaE").val();
                                var id = $("#idAreaHidden").val();
                                if (cat.length == 0) {
                                swal("Error", "debe ingresar editar.", "error");
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
                                                cat: cat,
                                        },
                                        success: function (datos) {
                                        console.log(datos);
                                        cargaDatos();
                                        $("#modalEditarArea").modal("hide");
                                        $("#txtAreaE").val("");
                                        swal("Correcto!", "Area modificada !", "success");
                                        }
                                });
                                }
                                });
                                }
                                //
                                //
                                function dibujaTabla(datos) {
                                $('#myTable').DataTable().destroy();
                                $('#myTable').DataTable({
                                dom: 'frtip',
                                        "autowidth": true,
                                        data: datos,
                                        columns: [
                                        {data: "id", },
                                        {data: "area"},
                                                render: function (data, type, row, meta) {
                                                var botones = "<button class='btn btn-sm btn-primary' onclick='editar(" + data + ");'>Editar</button>";
                                                botones += "<button class='btn btn-sm btn-danger' onclick='eliminar(" + data + ");'>Eliminar</button>";
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

                                function cargaDatos() {
                                $.ajax({
                                url: './viewArea.do',
                                        type: "POST",
                                        data: {
                                        },
                                        dataType: 'json',
                                        success: function (datos) {
                                        dibujaTabla(datos);
                                        }
                                });
                                }
    </script>

</html>
