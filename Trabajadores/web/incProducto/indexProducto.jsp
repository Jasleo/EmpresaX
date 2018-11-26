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
                        <label>Nombre: <input type="text" class="form-control" id="txtProductoNombre"Ed></label>
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
                                
                                
                                
                                
        </script>





    </body>
</html>
