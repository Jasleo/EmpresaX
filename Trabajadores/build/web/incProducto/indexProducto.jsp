<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Producto</title>
        <link rel="stylesheet" href="css/bootstrap.min.css" >
        <link href="css/jquery.dataTables.min.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>

        <div class="container">
            <h1>Productos</h1>
            <button class='btn btn-sm btn-success' onclick='agregar();'>Agregar Producto</button>
            <table id="myTable" class="table table-striped table-sm">
                <thead>
                    <tr>
                        <td>ID</td>
                        <td>Nombre</td>
                        <td>Cantidad</td>
                        <td>Precio</td>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>

        <div class="modal fade " id="modalNuevoProducto" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="tituloModal">Nuevo Producto</h4>
                    </div>
                    <div class="modal-body">
                        <label>Nombre: <input type="text" class="form-control" id="txtProductoNombre"></label>
                        <label>Cantidad: <input type="text" class="form-control" id="txtProductoCantidad"></label>
                        <label>Precio: <input type="text" class="form-control" id="txtProductoPrecio"></label>
                        <div class="modal-footer">
                            <button class="btn btn-success" onclick="guardarProducto()">Guardar</button>
                            <button class="btn btn-primary" data-dismiss="modal" onclick="limpiarCampos()">Cerrar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalEditarProducto" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="tituloModal">Editar Producto</h4>
                    </div>
                    <div class="modal-body">
                        <label>Nombre: <input type="text" class="form-control" id="txtProductoNombreEd"></label>
                        <label>Cantidad: <input type="text" class="form-control" id="txtProductoCantidadEd"></label>
                        <label>Precio: <input type="text" class="form-control" id="txtProductoPrecioEd"></label>
                        <input type="hidden" id="idProductoHidden">
                        <div class="modal-footer">
                            <button class="btn btn-success" onclick="editarProducto()">Guardar</button>
                            <button class="btn btn-primary" data-dismiss="modal" onclick="limpiarCampos()">Cerrar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <script src="js/jquery.dataTables.min.js" type="text/javascript"></script>
        <script src="js/popper.min.js" type="text/javascript"></script>
        <script src="js/sweetalert.min.js" type="text/javascript"></script>

        <script>
                                $(document).ready(function () {
                                    cargaDatos();
                                });

                                function cargaDatos() {
                                    $.ajax({
                                        url: './viewProducto.do',
                                        type: "POST",
                                        data: {
                                        },
                                        dataType: 'json',
                                        success: function (datos) {
                                            dibujaTabla(datos);
                                        }
                                    });
                                }

                                function limpiarCampos() {
                                    document.getElementById('txtProductoNombre').value = '"';
                                    document.getElementById('txtProductoCantidad').value = '"';
                                    document.getElementById('txtProductoPrecio').value = '"';
                                }

                                function eliminar(id) {
                                    swal({title: "Advertencia",
                                        text: "Está seguro que desea eliminar el id del producto " + id,
                                        icon: "warning",
                                        buttons: ['No', 'Si, Eliminar'],
                                        dangerMode: true,
                                    }).then((willDelete) => {
                                        if (willDelete) {
                                            // AJAX para eliminar el producto
                                            // mensaje al usuario
                                            $.ajax({
                                                url: './deleteProducto.do',
                                                type: "POST",
                                                dataType: "html",
                                                data: {
                                                    accion: "eliminarProducto",
                                                    id: id
                                                },
                                                success: function (datos) {
                                                    cargaDatos();
                                                    swal("Correcto!", "Producto eliminada !", "success");
                                                }
                                            });
                                        }
                                    });
                                }

                                function editar(id) {
                                    // abrir ventana modal con los datos del producto
                                    // llamamos a la función que guarda modificación
                                    $("#modalEditarProducto").modal("show");
                                    $("#idProducto").html("ID Producto :" + id);
                                    $("#idProductoHidden").val(id);
                                    $.ajax({
                                        url: './updateProducto.do',
                                        type: "POST",
                                        data: {
                                            accion: "traerProducto",
                                            id: id
                                        },
                                        dataType: 'json',
                                        success: function (data) {
                                            $("#txtProductoNombreEd").val(data.nombre);
                                            $("#txtProductoCantidadEd").val(data.cantidad);
                                            $("#txtProductoPrecioEd").val(data.precio);
                                        }
                                    });
                                }

                                function editarProducto() {
                                    var nomEd = $("#txtProductoNombreEd").val();
                                    var canEd = $("#txtProductoCantidadEd").val();
                                    var preEd = $("#txtProductoPrecioEd").val();
                                    var id = $("#idProductoHidden").val();

                                    if (nomEd.length == 0 & canEd.length == 0 & preEd.length == 0) {
                                        swal("Error", "debe ingresar dato.", "error");
                                        return;
                                    }
                                    swal({
                                        title: "Advertencia",
                                        text: "Está seguro que desea editar el producto id:" + id,
                                        icon: "warning",
                                        buttons: ['No', 'Si, Editar'],
                                        dangerMode: true,
                                    }).then((willDelete) => {
                                        if (willDelete) {
                                            $.ajax({
                                                url: './updateProducto.do',
                                                type: "POST",
                                                dataType: "text",
                                                data: {
                                                    accion: "editarProducto",
                                                    id: id,
                                                    nomEd: nomEd,
                                                    canEd: canEd,
                                                    preEd: preEd,
                                                },
                                                success: function (datos) {
                                                    console.log(datos);
                                                    cargaDatos();
                                                    $("#modalEditarProducto").modal("hide");
                                                    $("#idProductoHidden").val("");
                                                    swal("Correcto!", "Area modificada !", "success");
                                                }
                                            });
                                        }
                                    });
                                }

                                function agregar() {
                                    $("#modalNuevaArea").modal("show");
                                }

                                function crearProducto() {
                                    var nom = $("#txtProductoNombre").val();
                                    var can = $("#txtProductoCantidad").val();
                                    var pre = $("#txtProductoPrecio").val();

                                    if (nom.length == 0 & can.length == 0 & pre.length == 0) {
                                        swal("Error", "debe ingresar dato.", "error");
                                        return;
                                    }
                                    // asumimos que no hay errores
                                    $.ajax({
                                        url: './createProducto.do',
                                        type: "POST",
                                        dataType: "text",
                                        data: {
                                            accion: "crearProducto",
                                            nom: nom,
                                            can: can,
                                            pre: pre,
                                        },
                                        success: function (datos) {
                                            console.log(datos);
                                            cargaDatos();
                                        }
                                    });
                                    $("#modalEditarProducto").modal("hide");
                                    cargaDatos();
                                    $("#txtProductoNombre").val("");
                                    $("#txtProductoCantidad").val("");
                                    $("#txtProductoPrecio").val("");
                                }
                                
                                function dibujaTabla(datos) {
                                    $('#myTable').DataTable().destroy();
                                    $('#myTable').DataTable({
                                        dom: 'frtip',
                                        "autowidth": true,
                                        data: datos,
                                        columns: [
                                            {data: "id"},
                                            {data: "nombre"},
                                            {data: "cantidad"},
                                            {data: "precio"},
                                            {data: "id",
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
                                
                                
                                
        </script>





    </body>
</html>
