
package org.josepirir.bean;


public class Clientes {
    private int codigoCliente;
    private String NITCliente;
    private String nombresCliente;
    private String apellidosCliente;
    private String direccionCliente;
    private String telefonoCliente;
    private String correoCliente;

    public Clientes(){    
    }
    
    public Clientes(int codigoCliente, String NITCliente, String nombreCliente, String apellidosCliente, String direccionCliente, String telefonoCliente, String correoCliente) {
        this.codigoCliente = codigoCliente;
        this.NITCliente = NITCliente;
        this.nombresCliente = nombreCliente;
        this.apellidosCliente = apellidosCliente;
        this.direccionCliente = direccionCliente;
        this.telefonoCliente = telefonoCliente;
        this.correoCliente = correoCliente;
    }

    public int getCodigoCliente() {
        return codigoCliente;
    }

    public void setCodigoCliente(int codigoCliente) {
        this.codigoCliente = codigoCliente;
    }

    public String getNITCliente() {
        return NITCliente;
    }

    public void setNITCliente(String NITCliente) {
        this.NITCliente = NITCliente;
    }

    public String getNombresCliente() {
        return nombresCliente;
    }

    public void setNombresCliente(String nombreCliente) {
        this.nombresCliente = nombreCliente;
    }

    public String getApellidosCliente() {
        return apellidosCliente;
    }

    public void setApellidosCliente(String apellidosCliente) {
        this.apellidosCliente = apellidosCliente;
    }

    public String getDireccionCliente() {
        return direccionCliente;
    }

    public void setDireccionCliente(String direccionCliente) {
        this.direccionCliente = direccionCliente;
    }

    public String getTelefonoCliente() {
        return telefonoCliente;
    }

    public void setTelefonoCliente(String telefonoCliente) {
        this.telefonoCliente = telefonoCliente;
    }

    public String getCorreoCliente() {
        return correoCliente;
    }

    public void setCorreoCliente(String correoCliente) {
        this.correoCliente = correoCliente;
    }
}
