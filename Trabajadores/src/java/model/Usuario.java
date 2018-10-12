package model;

public class Usuario {

    private int id;
    private String rut;
    private String username;
    private String nombre;
    private String pass;

    public Usuario(int id, String rut, String username, String nombre, String pass) {
        this.id = id;
        this.rut = rut;
        this.username = username;
        this.nombre = nombre;
        this.pass = pass;
    }

    public Usuario() {
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRut() {
        return rut;
    }

    public void setRut(String rut) {
        this.rut = rut;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }
    
    
}
