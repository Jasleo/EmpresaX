package model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Data {

    private final Conexion con;
    private ResultSet rs;
    private String query;

    public Data() throws SQLException, ClassNotFoundException {
        con = new Conexion(
                "localhost",
                "bdEmpresa",//nombre BD
                "root",
                "12345"//Password
        );
    }

    //CREAR DATOS
    public void crearArea(Area ar) throws SQLException {
        query = "INSERT INTO area VALUE(null,'" + ar.getNombre() + "')";
        con.ejecutar(query);
    }

    public void crearTrabajador(Trabajador tra) throws SQLException {
        query = "INSERT INTO trabajador "
                + "VALUE (null,'" + tra.getRut() + "' ,'" + tra.getNombre() + "' "
                + ",'" + tra.getApellido() + "' ,'" + tra.getAreaFk() + "')";

        con.ejecutar(query);
    }

    public void crearProducto(Producto pr) throws SQLException {
        query = "INSERT INTO producto VALUE(null,'" + pr.getNombre() + "','" + pr.getCantidad() + "','" + pr.getPrecio() + "')";
        con.ejecutar(query);
    }

    //LEER DATOS
    public List<Area> getArea() throws SQLException, Exception {
        List<Area> list = new ArrayList<>();

        query = "SELECT * FROM area;";
        rs = con.ejecutarSelect(query);

        Area are;

        while (rs.next()) {
            are = new Area();
            are.setId(rs.getInt(1));
            are.setNombre(rs.getString(2));
            list.add(are);
        }

        con.close();
        return list;

    }

    public Area getAreaId(String idArea) throws SQLException {
        Area obj = new Area();
        query = "SELECT * FROM area WHERE id = " + idArea + ";";
        rs = con.ejecutarSelect(query);
        if (rs.next()) {
            obj.setId(rs.getInt(1));
            obj.setNombre(rs.getString(2));
        }
        con.close();
        return obj;
    }

    /////////////////////////
    public List<Trabajador> getTrabajador() throws SQLException {
        List<Trabajador> list = new ArrayList<>();

        query = "SELECT * FROM trabajador;";
        rs = con.ejecutarSelect(query);

        Trabajador tra;

        while (rs.next()) {
            tra = new Trabajador();
            tra.setId(rs.getInt(1));
            tra.setRut(rs.getString(2));
            tra.setNombre(rs.getString(3));
            tra.setApellido(rs.getString(4));
            tra.setAreaFk(rs.getInt(5));
            list.add(tra);
        }
        con.close();

        return list;
    }

    public Trabajador getTrabajadorById(String idTraba) throws SQLException {
        Trabajador newTra = new Trabajador();
        query = "SELECT * FROM trabajador;";
        rs = con.ejecutarSelect(query);

        if (rs.next()) {
            newTra = new Trabajador();
            newTra.setId(rs.getInt(1));
            newTra.setRut(rs.getString(2));
            newTra.setNombre(rs.getString(3));
            newTra.setApellido(rs.getString(4));
            newTra.setAreaFk(rs.getInt(5));
        }
        con.close();

        return newTra;
    }

    ///////////////////////////
    public List<TrabajadorArea> getTrabajadorArea() throws SQLException {
        List<TrabajadorArea> list = new ArrayList<>();

        query = "SELECT * FROM datos_persona;";
        rs = con.ejecutarSelect(query);

        TrabajadorArea traA;

        while (rs.next()) {
            traA = new TrabajadorArea();
            traA.setId(rs.getInt(1));
            traA.setRut(rs.getString(2));
            traA.setNombre(rs.getString(3));
            traA.setApellido(rs.getString(4));
            traA.setAreaFk(rs.getString(5));
            list.add(traA);
        }

        con.close();

        return list;
    }

    public TrabajadorArea getTrabajadorAreaId(String idTrabaja) throws SQLException {
        TrabajadorArea traA = new TrabajadorArea();

        query = "SELECT * FROM datos_persona WHERE id = " + idTrabaja + ";";
        rs = con.ejecutarSelect(query);

        if (rs.next()) {
            traA.setId(rs.getInt(1));
            traA.setRut(rs.getString(2));
            traA.setNombre(rs.getString(3));
            traA.setApellido(rs.getString(4));
            traA.setAreaFk(rs.getString(5));
        }
        con.close();

        return traA;
    }
  ///////////////////////////

    public List<Producto> getProducto() throws SQLException {
        List<Producto> list = new ArrayList<>();

        query = "SELECT * FROM pruducto;";
        rs = con.ejecutarSelect(query);

        Producto pr;

        while (rs.next()) {
            pr = new Producto();
            pr.setId(rs.getInt(1));
            pr.setNombre(rs.getString(2));
            pr.setCantidad(rs.getInt(3));
            pr.setPrecio(rs.getInt(4));
            list.add(pr);
        }
        con.close();

        return list;
    }

    public Producto getProductoById(String id) throws SQLException {
        Producto obj = new Producto();
        query = "SELECT * FROM producto WHERE id = " + id + ";";
        rs = con.ejecutarSelect(query);
        if (rs.next()) {
            obj.setId(rs.getInt(1));
            obj.setNombre(rs.getString(2));
            obj.setCantidad(rs.getInt(3));
            obj.setPrecio(rs.getInt(4));
        }
        con.close();
        return obj;
    }

    //UPDATE
    public void updateArea(Area a) throws SQLException {
        query = "UPDATE  area SET nombreA = '" + a.getNombre() + "' WHERE id = " + a.getId() + ";";
        con.ejecutar(query);
    }

    public void updateProducto(Producto pr) throws SQLException {
        query = "UPDATE  producto SET nombre = '" + pr.getNombre()+ "', cantidad = " + pr.getCantidad()+ ""
                + ", precio = " + pr.getPrecio() + " "
                + "WHERE id = " + pr.getId() + "";
        con.ejecutar(query);
    }
    
    //ELIMINAR
    public void deleteArea(int idArea) throws SQLException {
        query = "DELETE FROM area WHERE id = " + idArea + "";
        con.ejecutar(query);
    }

    public void deleteTrabajador(int idTrabajador) throws SQLException {
        query = "DELETE FROM trabajador WHERE id = " + idTrabajador + "";
        con.ejecutar(query);
    }
    
    public void deleteProducto(int idProducto) throws SQLException {
        query = "DELETE FROM producto WHERE id = " + idProducto + "";
        con.ejecutar(query);
    }
}
