/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.josepirir.system;

import java.io.IOException;
import java.io.InputStream;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.fxml.JavaFXBuilderFactory;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;
import org.josepirir.controller.CargoEmpleadoController;
import org.josepirir.controller.ClienteController;
import org.josepirir.controller.MenuPrincipalController;
import org.josepirir.controller.ProgramadorController;
import org.josepirir.controller.ProveedorController;
import org.josepirir.controller.TipoProductoController;

/**
 *
 * @author informatica
 */
public class Principal extends Application {
    private final String PAQUETE_VISTA = "/org/josepirir/view/";
    private Stage escenarioPrincipal;
    private Scene escena;
    
    @Override
    public void start(Stage escenarioPrincipal) throws IOException {
        this.escenarioPrincipal = escenarioPrincipal;
        this.escenarioPrincipal.setTitle("KinalStore 2024");
        menuPrincipal();
        escenarioPrincipal.show();
    }

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        launch(args);
    }
    // no va 
    public void menuPrincipal(){
        try{
            MenuPrincipalController vistaMenuPrincipal = (MenuPrincipalController) cambiarEscena("MenuPrincipalView.fxml",400,400);
            vistaMenuPrincipal.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaCliente(){
        try{
            ClienteController vistaCliente = (ClienteController)cambiarEscena("ClienteView.fxml",1000,400);
            vistaCliente.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaProveedor(){
        try{
            ProveedorController vistaProveedor = (ProveedorController)cambiarEscena("ProveedorView.fxml",1000,400);
            vistaProveedor.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaCargoEmpleado(){
        try{
            CargoEmpleadoController vistaCargoEmpleado = (CargoEmpleadoController) cambiarEscena("CargoEmpleadoView.fxml",1000,400);
            vistaCargoEmpleado.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaTipoProducto(){
        try{
            TipoProductoController vistaTipoProducto = (TipoProductoController) cambiarEscena("TipoProductoView.fxml",1000,400);
            vistaTipoProducto.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaProgramador(){
        try{
            ProgramadorController vistaProgramador = (ProgramadorController)cambiarEscena("ProgramadorView.fxml",540,360);
            vistaProgramador.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public Initializable cambiarEscena(String fxml, int ancho, int alto) throws IOException{
        Initializable resultado = null;
        FXMLLoader cargadorFXML = new FXMLLoader();
        InputStream archivo = Principal.class.getResourceAsStream(PAQUETE_VISTA+fxml);
        cargadorFXML.setBuilderFactory(new JavaFXBuilderFactory());
        cargadorFXML.setLocation(Principal.class.getResource(PAQUETE_VISTA+fxml));
        escena = new Scene((AnchorPane)cargadorFXML.load(archivo),ancho,alto);
        escenarioPrincipal.setScene(escena);
        escenarioPrincipal.sizeToScene();
        resultado = (Initializable)cargadorFXML.getController();
        
        return resultado;
    }
}
