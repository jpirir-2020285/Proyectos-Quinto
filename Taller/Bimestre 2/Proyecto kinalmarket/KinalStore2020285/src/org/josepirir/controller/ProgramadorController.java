package org.josepirir.controller;

import java.net.URL;
import java.util.ResourceBundle;
import javafx.fxml.Initializable;
import org.josepirir.system.Principal;


public class ProgramadorController implements Initializable{
    private Principal escenarioPrincipal;
    
    public void menuPrincipal(){
        escenarioPrincipal.menuPrincipal();
    }
    
    @Override
    public void initialize(URL location, ResourceBundle resources) {
        
    }

    public Principal getEscenarioPrincipal() {
        return escenarioPrincipal;
    }

    public void setEscenarioPrincipal(Principal escenarioPrincipal) {
        this.escenarioPrincipal = escenarioPrincipal;
    }
    
}
