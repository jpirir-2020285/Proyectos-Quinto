
package org.josepirir.controller;

import java.net.URL;
import java.util.ResourceBundle;
import javafx.fxml.Initializable;
import org.josepirir.system.Principal;


public class MenuPrincipalController implements Initializable{
    private Principal escenarioPrincipal;
    
    @Override
    public void initialize(URL location, ResourceBundle resources) {
        
    }
    
    public void menuPrincipal(){
        escenarioPrincipal.menuPrincipal();
    }
    
    public void ventanaCliente(){
        escenarioPrincipal.ventanaCliente();
    }
    
    public void ventanaProgramador(){
        escenarioPrincipal.ventanaProgramador();
    }
    
    public void ventanaProveedor(){
        escenarioPrincipal.ventanaProveedor();
    }
    
    public void ventanaCargoEmpleado(){
        escenarioPrincipal.ventanaCargoEmpleado();
    }
    
    public void ventanaTipoProducto(){
        escenarioPrincipal.ventanaTipoProducto();
    }
    
    public Principal getEscenarioPrincipal() {
        return escenarioPrincipal;
    }

    public void setEscenarioPrincipal(Principal escenarioPrincipal) {
        this.escenarioPrincipal = escenarioPrincipal;
    }
    
    
}
