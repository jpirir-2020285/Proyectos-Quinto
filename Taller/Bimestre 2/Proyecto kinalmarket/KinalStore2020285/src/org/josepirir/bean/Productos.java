
package org.josepirir.bean;

public class Productos {
    private int codigoProducto;
    private String descripcionProducto;
    private float precioUnitario;
    private float precioDocena;
    private float precioMayor;
    private String imagenProducto;
    private int existencia;
    private int codigoTipoProducto;
    private int codigoProveedor;
    
    public Productos(){
        
    } 

    public Productos(int codigoProducto, String descripcionProducto, float precioUnitario, float precioDocena, float precioMayor, String imagenProducto, int existencia, int codigoTipoProducto, int codigoProveedor) {
        this.codigoProducto = codigoProducto;
        this.descripcionProducto = descripcionProducto;
        this.precioUnitario = precioUnitario;
        this.precioDocena = precioDocena;
        this.precioMayor = precioMayor;
        this.imagenProducto = imagenProducto;
        this.existencia = existencia;
        this.codigoTipoProducto = codigoTipoProducto;
        this.codigoProveedor = codigoProveedor;
    }

    public int getCodigoProducto() {
        return codigoProducto;
    }

    public void setCodigoProducto(int codigoProducto) {
        this.codigoProducto = codigoProducto;
    }

    public String getDescripcionProducto() {
        return descripcionProducto;
    }

    public void setDescripcionProducto(String descripcionProducto) {
        this.descripcionProducto = descripcionProducto;
    }

    public float getPrecioUnitario() {
        return precioUnitario;
    }

    public void setPrecioUnitario(float precioUnitario) {
        this.precioUnitario = precioUnitario;
    }

    public float getPrecioDocena() {
        return precioDocena;
    }

    public void setPrecioDocena(float precioDocena) {
        this.precioDocena = precioDocena;
    }

    public float getPrecioMayor() {
        return precioMayor;
    }

    public void setPrecioMayor(float precioMayor) {
        this.precioMayor = precioMayor;
    }

    public String getImagenProducto() {
        return imagenProducto;
    }

    public void setImagenProducto(String imagenProducto) {
        this.imagenProducto = imagenProducto;
    }

    public int getExistencia() {
        return existencia;
    }

    public void setExistencia(int existencia) {
        this.existencia = existencia;
    }

    public int getCodigoTipoProducto() {
        return codigoTipoProducto;
    }

    public void setCodigoTipoProducto(int codigoTipoProducto) {
        this.codigoTipoProducto = codigoTipoProducto;
    }

    public int getCodigoProveedor() {
        return codigoProveedor;
    }

    public void setCodigoProveedor(int codigoProveedor) {
        this.codigoProveedor = codigoProveedor;
    }
    
    
    
}
