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
                "bdAlmaAstrologia",//nombre BD
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

    //LEER DATOS
    public List<Area> getArea() throws SQLException {
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

    //UPDATE
    public void updateArea(int idArea, Area a) throws SQLException {
        query = "UPDATE  area SET nombre = '" + a.getNombre() + "' WHERE id = " + idArea + "";
        con.ejecutar(query);
    }

    public void updateTrabajador(int idArea, Trabajador tra) throws SQLException {
        query = "UPDATE  trabajador SET nombre = '" + tra.getRut()+ "', '" + tra.getNombre()+ "' ,'" + tra.getApellido()+ "' "
                + "'" + tra.getAreaFk()+ "'"
                + "WHERE id = " + idArea + "";
        con.ejecutar(query);
    }

    //ELIMINAR
    public void deleteArea (int idArea) throws SQLException {
        query = "DELETE FROM area WHERE id = " + idArea + "";
        con.ejecutar(query);
    }

    public void deleteTrabajador(int idTrabajador) throws SQLException {
        query = "DELETE FROM trabajador WHERE id = " + idTrabajador + "";
        con.ejecutar(query);
    }
}
