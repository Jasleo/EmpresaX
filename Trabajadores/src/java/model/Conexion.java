package model;

import Utils.Convertor;
import java.sql.*; // pack
import java.util.List;
import org.json.JSONArray;

public class Conexion {

    private Connection con; // Establecer la conexión
    private Statement sen;  // Ejecutar consultas
    private ResultSet rs;   // Recorrer los resultados (Tabla)

    // localhost --> ip --> mysql --> afuera
    public Conexion(String server, String bd, String user, String pass) throws SQLException, ClassNotFoundException {
        String protocolo = "jdbc:mysql://";
        String lineaUser = "user=" + user;
        String lineaPass = "password=" + pass;

        String url = protocolo
                + server + "/"
                + bd + "?"
                + lineaUser + "&"
                + lineaPass;

        System.out.println(url);

        Class.forName("com.mysql.jdbc.Driver"); // jar, INCLUIR!!!!!
        con = DriverManager.getConnection(url);
    }

    /*
    consultas actualizan los datos --> delete, insert, update
    ver datos --> select
     */
    // insert, delete, update
    public void ejecutar(String query) throws SQLException {
        System.out.println(query);
        sen = con.createStatement();
        sen.executeUpdate(query);
        close();
    }

    // select
    public ResultSet ejecutarSelect(String query) throws SQLException {
        System.out.println(query);
        sen = con.createStatement();
        rs = sen.executeQuery(query);
        return rs;
    }

    public void close() throws SQLException {
        sen.close();
    }

    public JSONArray SelectJson(String sql) throws SQLException, Exception {
        Convertor x = new Convertor();
        return x.convertResultSetIntoJSON(this.ejecutarSelect(sql));
    }
    
    public JSONArray SelectJsonList(List list) throws SQLException, Exception {
        Convertor x = new Convertor();
        
        String lista = String.join(",", list);
        
        return x.convertResultSetIntoJSON(this.ejecutarSelect(lista));
    }


}
