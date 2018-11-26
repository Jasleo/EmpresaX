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
                "12345"//Password
        );
    }



    public Usuario getUsuario(String userName, String pass) throws SQLException {
        Usuario u = null;
        
        query = "SELECT * FROM usuario WHERE username = '" + userName + "' AND pass = '" + pass + "' ;";
        rs = con.ejecutarSelect(query);

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
