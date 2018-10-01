package model;

public class Trabajador {

    private int id;
    private String rut;
    private String nombre;
    private String apellido;
    private int areaFk;
    
    public Trabajador() {
    }

    public Trabajador(int id, String rut, String nombre, String apellido, int areaFk) {
        this.id = id;
        this.rut = rut;
        this.nombre = nombre;
        this.apellido = apellido;
        this.areaFk = areaFk;
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

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public int getAreaFk() {
        return areaFk;
    }

    public void setAreaFk(int areaFk) {
        this.areaFk = areaFk;
    }
    
    
    




    
}
