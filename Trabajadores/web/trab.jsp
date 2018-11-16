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
                        <td>Rut</td>
                        <td>Nombre</td>
                        <td>Apellido</td>
                        <td>Area</td>
                        <td>Accion</td>
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
                        <label>Area: <input type="text" class="form-control" id="txtArea">
                            <select></select>
                        
                        </label>
                        <div class="modal-footer">
                            <button class="btn btn-success" onclick="crearTraba()">Guardar</button>
                            <button class="btn btn-primary" data-dismiss="modal" onclick="limpiarCampos()">Cerrar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalEditarTrabajador" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="tituloModal">Editar Trabajador</h4>
                    </div>
                    <div class="modal-body">
                        <label>Nombre: <input type="text" class="form-control" id="txtNombreEd"></label>
                        <label>Apellido: <input type="text" class="form-control" id="txtApellidoEd"></label>
                        <label>Area: <input type="text" class="form-control" id="txtAreaTrabEd"></label>
                        <input type="hidden" id="idTrabaHidden">
                        <div class="modal-footer">
                            <button class="btn btn-success" onclick="editarTrabajador())">Guardar</button>
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
                                    document.getElementById('txtNombre').value = ''
                                    document.getElementById('txtApellido').value = ''
                                    document.getElementById('txtArea').value = ''
                                }

                                function eliminar(id) {
                                    swal({title: "Advertencia",
                                        text: "Está seguro que desea eliminar el id del trabajador: " + id,
                                        icon: "warning",
                                        buttons: ['No', 'Si, Eliminar'],
                                        dangerMode: true,
                                    }).then((willDelete) => {
                                        if (willDelete) {
                                            // AJAX para eliminar el producto
                                            // mensaje al usuario
                                            $.ajax({
                                                url: './deleteTrabajador.do',
                                                type: "POST",
                                                dataType: "html",
                                                data: {
                                                    accion: "eliminarTrabajador",
                                                    id: id
                                                },
                                                success: function (datos) {
                                                    cargaDatos();
                                                    swal("Correcto!", "Trabajador eliminada !", "success");
                                                }
                                            });
                                        }
                                    });
                                }

                                function editar(id) {
                                    // abrir ventana modal con los datos del producto
                                    // llamamos a la función que guarda modificación
                                    $("#modalEditarTrabajador").modal("show");
                                    $("#idTrabajador").html("ID Trabajador: " + id);
                                    $("#idTrabaHidden").val(id);

                                    $.ajax({
                                        url: './updateTrabaja.do',
                                        type: "POST",
                                        data: {
                                            accion: "traerTrabajador",
                                            id: id
                                        },
                                        dataType: 'json',
                                        success: function (data) {
                                            $("#txtNombreEd").val(data.nombre);
                                            $("#txtApellidoEd").val(data.apellido);
                                            $("#txtAreaTrabEd").val(data.areaFk);
                                        }
                                    });


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

                                    if (are.length == 0) {
                                        swal("Error, debe ingresar area.");
                                        return;
                                    }
                                    // asumimos que no hay errores
                                    $.ajax({
                                        url: './createTrabajador.do',
                                        type: "POST",
                                        dataType: "text",
                                        data: {
                                            accion: "crearTraba",
                                            are: are,
                                        },
                                        success: function (datos) {
                                            console.log(datos);
                                            cargaDatos();
                                        }
                                    });

                                    $("#modalNuevoTrabajador").modal("hide");
                                    cargaDatos();
                                    limpiarCampos();
                                }

                                function editarTrabajador() {
                                    // cargar los datos del producto a editar (desde el formulario del modal)
                                    // ajax para guardar edición
                                    var nom = $("#txtNombreEd").val();
                                    var apell = $("#txtApellidoEd").val();
                                    var areTra = $("#txtAreaTrabEd").val();
                                    
                                    var id = $("#idTrabaHidden").val();
                                    if (are.length == 0) {
                                        swal("Error", "debe ingresar dato.", "error");
                                        return;
                                    }
                                    swal({
                                        title: "Advertencia",
                                        text: "Está seguro que desea editar el Trabajador id:" + id,
                                        icon: "warning",
                                        buttons: ['No', 'Si, Editar'],
                                        dangerMode: true,
                                    }).then((willDelete) => {
                                        if (willDelete) {
                                            $.ajax({
                                                url: './updateTrabaja.do',
                                                type: "POST",
                                                dataType: "text",
                                                data: {
                                                    accion: "editarTrabajador",
                                                    id: id,
                                                    nom: nom,
                                                    apell: apell,
                                                    areTra: areTr,
                                                },
                                                success: function (datos) {
                                                    console.log(datos);
                                                    cargaDatos();
                                                    $("#modalEditarTrabajador").modal("hide");
                                                    $("#idTrabaHidden").val("");
                                                    swal("Correcto!", "Trabajador modificada !", "success");
                                                }
                                            });
                                        }
                                    });
                                }

                                function dibujaTabla(datos) {
                                    $('#myTable').DataTable().destroy();
                                    $('#myTable').DataTable({
                                        dom: 'frtip',
                                        "autowidth": true,
                                        data: datos,
                                        columns: [
                                            {data: "id", },
                                            {data: "rut"},
                                            {data: "nombre"},
                                            {data: "apellido"},
                                            {data: "areaFk"},
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
                                        url: './viewTrabajadorArea.do',
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