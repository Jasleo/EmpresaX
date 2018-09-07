<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Empresa X</title>
        <link rel="stylesheet" href="css/bootstrap.min.css" >
        <link href="css/jquery.dataTables.min.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div class="container">
            <h1>Listado de Trabajador</h1>
            <button class='btn btn-sm btn-success' onclick='agregar();'>Agregar Trabajador</button>
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
                function limpiarCampos(){
                    document.getElementById('txtNombre').value = ''
                    document.getElementById('txtApellido').value = ''
                    document.getElementById('txtArea').value = ''
                }
                
                
                function eliminar(id) {
                    if (confirm("Está seguro que desea eliminar el id: " + id)) {
                        // AJAX para eliminar el producto
                        // mensaje al usuario
                        cargaDatos();
                    }
                }
                function editar(id) {
                    // abrir ventana modal con los datos del producto
                    // llamamos a la función que guarda modificación
                }
                function agregar() {
                    $("#modalNuevoTrabajador").modal("show");
                    // abrir ventana modal datos en blanco
                    // llamamos a la función que crea producto
                }

                function crearTraba() {
                    //variables para todos los datos del nuevo producto
                    // ajax para crear nuevo producto (insert)
                    var cat = $("#txtNombre").val();
                    var prod = $("#txtApellido").val();
                    var precio = $("#txtArea").val();
                    if(cat.length == 0){
                        swal("Error, debe ingresar nombre.");
                        return;
                    }
                    if(prod.length == 0){
                        swal("Error, debe ingresar nombre de apellido.");
                        return;
                    }if(precio.length == 0){
                        swal("Error, debe ingresar area.");
                        return;
                    }
                    
                    $("#modalNuevoTrabajador").modal("hide");
                    cargaDatos();
                }
                function editarProducto() {
                    // cargar los datos del producto a editar (desde el formulario del modal)
                    // ajax para guardar edición
                    cargaDatos();
                }
                function dibujaTabla(datos) {
                    $('#myTable').DataTable().destroy();
                    $('#myTable').DataTable({
                        dom: 'frtip',
                        "autowidth": true,
                        data: datos,
                        columns: [
                            {data: "id", },
                            {data: "nombre"},
                            {data: "apellido"},
                            {data: "area"},
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
                function cargaDatos() {
                    $.ajax({
                        url: './Calculadora',
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