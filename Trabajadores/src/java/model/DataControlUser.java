package model;

import java.sql.ResultSet;
import java.sql.SQLException;

public class DataControlUser {

    private final Conexion con;
    private ResultSet rs;
    private String query;

    public DataControlUser() throws SQLException, ClassNotFoundException {
        con = new Conexion(
                "localhost",
                "bdEmpresa",//nombre BD
                "root",
                ""//Password
        );
    }

    public Usuario getUsuario(String userName, String pass) throws SQLException {
        Usuario u = null;

        rs = con.ejecutarSelect("SELECT * FROM "
                + "usuario WHERE rut = '" + userName + "' AND pass = '"+ pass +"' ");

        if (rs.next()) {
            u = new Usuario();

            u.setId(rs.getInt(1));
            u.setRut(rs.getString(2));
            u.setUsername(rs.getString(3));
            u.setNombre(rs.getString(4));
            u.setPass(rs.getString(5));
        }

        con.close();

        return u;
    }

}
