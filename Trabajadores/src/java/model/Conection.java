package model;

import Utils.Convertor;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;

public class Conection {
    private Connection conexion;
    
    
    public Conection() {
        try {
            this.conexion = this.getStatementLocal();
        } catch (SQLException ex) {
            Logger.getLogger(Conection.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Connection getStatementLocal() throws SQLException {
        Connection c = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException cnfe) {
            System.err.println("Couldnt find driver class:");
            cnfe.printStackTrace();
        }
        try {
            c = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "root");
        } catch (SQLException se) {
            System.out.println("Couldnt connect: print out a stack trace and exit.");
            se.printStackTrace();
            System.exit(1);
        }
        return c;
    }

    public ResultSet Select(String sql) throws SQLException {
        Statement stat;
        ResultSet res;
        stat = this.conexion.createStatement();
        res = stat.executeQuery(sql);
        return res;
    }
    public JSONArray SelectJson(String sql) throws SQLException, Exception{
        Convertor x = new Convertor();
        return x.convertResultSetIntoJSON(this.Select(sql));
    }
    public void Ejecuta(String sql) throws SQLException{
        Statement stat;
        stat = this.conexion.createStatement();
        stat.executeQuery(sql);
    }
}
