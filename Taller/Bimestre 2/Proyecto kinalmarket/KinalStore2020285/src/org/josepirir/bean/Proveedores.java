package org.josepirir.bean;

public class Proveedores {
    private int codigoProveedor;
    private String NITProveedor;
    private String nombresProveedor;
    private String apellidosProveedor;
    private String direccionProveedor;
    private String razonSocial;
    private String contactoProveedor;
    private String paginaWeb;
    
    
    public Proveedores(){}
    
    public Proveedores(int codigoProveedor,String NITProveedor,String nombresProveedor,String apellidosProveedor,String direccionProveedor,String razonSocial,String contactoProveedor,String paginaWeb){
    this.codigoProveedor = codigoProveedor;
    this.NITProveedor = NITProveedor;
    this.nombresProveedor = nombresProveedor;
    this.direccionProveedor = direccionProveedor;
    this.razonSocial = razonSocial;
    this.contactoProveedor = contactoProveedor;
    this.paginaWeb = paginaWeb;
    }

    public int getCodigoProveedor() {
        return codigoProveedor;
    }

    public void setCodigoProveedor(int codigoProveedor) {
        this.codigoProveedor = codigoProveedor;
    }

    public String getNITProveedor() {
        return NITProveedor;
    }

    public void setNITProveedor(String NITProveedor) {
        this.NITProveedor = NITProveedor;
    }

    public String getNombresProveedor() {
        return nombresProveedor;
    }

    public void setNombresProveedor(String nombresProveedor) {
        this.nombresProveedor = nombresProveedor;
    }

    public String getApellidosProveedor() {
        return apellidosProveedor;
    }

    public void setApellidosProveedor(String apellidosProveedor) {
        this.apellidosProveedor = apellidosProveedor;
    }

    public String getDireccionProveedor() {
        return direccionProveedor;
    }

    public void setDireccionProveedor(String direccionProveedor) {
        this.direccionProveedor = direccionProveedor;
    }

    public String getRazonSocial() {
        return razonSocial;
    }

    public void setRazonSocial(String razonSocial) {
        this.razonSocial = razonSocial;
    }

    public String getContactoProveedor() {
        return contactoProveedor;
    }

    public void setContactoProveedor(String contactoProveedor) {
        this.contactoProveedor = contactoProveedor;
    }

    public String getPaginaWeb() {
        return paginaWeb;
    }

    public void setPaginaWeb(String paginaWeb) {
        this.paginaWeb = paginaWeb;
    }
    
}

