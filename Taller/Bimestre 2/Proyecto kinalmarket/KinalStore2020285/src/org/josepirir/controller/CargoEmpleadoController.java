
package org.josepirir.controller;

import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.ResourceBundle;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javax.swing.JOptionPane;
import org.josepirir.bean.CargoEmpleado;
import org.josepirir.db.Conexion;
import org.josepirir.system.Principal;


public class CargoEmpleadoController implements Initializable {
    private Principal escenarioPrincipal;
    
    private enum operaciones{NUEVO,ELIMINAR,EDITAR,GUARDAR,CANCELAR,NINGUNO}
    private operaciones tipoOperacion = operaciones.NINGUNO;
    private ObservableList<CargoEmpleado> listaCargoEmpleado;
    
    @FXML private TableView tblCargoEmpleado;
    
    @FXML private TextField txtCodigoCargoEmpleado;
    @FXML private TextField txtNombreCargo;
    @FXML private TextField txtDescripcionCargo;
    
    @FXML private TableColumn colCodigoCargoEmpleado;
    @FXML private TableColumn colNombreCargo;
    @FXML private TableColumn colDescripcionCargo;
    
    @FXML private Button btnNuevo;
    @FXML private Button btnEliminar;
    @FXML private Button btnEditar;
    @FXML private Button btnReporte;
    
    @FXML private ImageView imgNuevo;
    @FXML private ImageView imgEliminar;
    @FXML private ImageView imgEditar;
    @FXML private ImageView imgReporte;
    
    
    public void menuPrincipal(){
        escenarioPrincipal.menuPrincipal();
    }
    
    public void initialize(URL location, ResourceBundle resources){
        cargarDatos();
    }
    
    public void cargarDatos(){
        tblCargoEmpleado.setItems(getCargoEmpleado());
        colCodigoCargoEmpleado.setCellValueFactory(new PropertyValueFactory<CargoEmpleado,Integer>("codigoCargoEmpleado"));
        colNombreCargo.setCellValueFactory(new PropertyValueFactory<CargoEmpleado,Integer>("nombreCargo"));
        colDescripcionCargo.setCellValueFactory(new PropertyValueFactory<CargoEmpleado,Integer>("descripcionCargo"));
    }
    
    public ObservableList<CargoEmpleado> getCargoEmpleado(){
        ArrayList<CargoEmpleado> lista = new ArrayList<CargoEmpleado>();
        try{
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_ListarCargoEmpleados}");
            ResultSet resultado = procedimiento.executeQuery();
            while(resultado.next()){
                lista.add(new CargoEmpleado(resultado.getInt("codigoCargoEmpleado"),
                    resultado.getString("nombreCargo"),
                    resultado.getString("descripcionCargo")));
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return listaCargoEmpleado = FXCollections.observableArrayList(lista);
    }
    
    public void nuevo(){
        switch(tipoOperacion){
            case NINGUNO:
                activarControles();
                limpiarControles();
                btnNuevo.setText("Guardar");
                btnEliminar.setText("Cancelar");
                btnEditar.setDisable(true);
                btnReporte.setDisable(true);
                imgNuevo.setImage(new Image("/org/josepirir/image/guardar.png"));
                imgEliminar.setImage(new Image("/org/josepirir/image/cancelar.png"));
                tipoOperacion = operaciones.GUARDAR;
            break;    
            case GUARDAR:
                guardar();
                limpiarControles();
                desactivarControles();
                btnNuevo.setText("Nuevo");
                btnEliminar.setText("Eliminar");
                btnEditar.setDisable(false);
                btnReporte.setDisable(false);
                imgNuevo.setImage(new Image("/org/josepirir/image/Agregar.png"));
                imgEliminar.setImage(new Image("/org/josepirir/image/Eliminar.png"));
                tipoOperacion = operaciones.NINGUNO;
                cargarDatos();
            break;    
        }
    }
    
    public void guardar(){
        CargoEmpleado registro = new CargoEmpleado();
        registro.setNombreCargo(txtNombreCargo.getText());
        registro.setDescripcionCargo(txtDescripcionCargo.getText());
        try{
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_AgregarCargoEmpleado(?,?)}");
            procedimiento.setString(1, registro.getNombreCargo());
            procedimiento.setString(2, registro.getDescripcionCargo());
            procedimiento.execute();
            listaCargoEmpleado.add(registro);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void eliminar(){
        switch(tipoOperacion){
            case GUARDAR:
                limpiarControles();
                desactivarControles();
                btnNuevo.setText("Nuevo");
                btnEliminar.setText("Eliminar");
                btnEditar.setDisable(false);
                btnReporte.setDisable(false);
                imgNuevo.setImage(new Image("/org/josepirir/image/Agregar.png"));
                imgEliminar.setImage(new Image("/org/josepirir/image/Eliminar.png"));
                tipoOperacion = operaciones.NINGUNO;
            break;
            default:
                if(tblCargoEmpleado.getSelectionModel().getSelectedItem()!=null){
                    int respuesta = JOptionPane.showConfirmDialog(null, "¿Está seguro de eliminar el registro?", "Eliminar Cliente", JOptionPane.YES_NO_OPTION,JOptionPane.QUESTION_MESSAGE);
                    if(respuesta==JOptionPane.YES_OPTION){
                        try{
                            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{sp_EliminarCargoEmpleado(?)}");
                            procedimiento.setInt(1, ((CargoEmpleado)tblCargoEmpleado.getSelectionModel().getSelectedItem()).getCodigoCargoEmpleado());
                            procedimiento.execute();
                            listaCargoEmpleado.remove(tblCargoEmpleado.getSelectionModel().getSelectedIndices());
                            limpiarControles();
                            cargarDatos();
                        }catch(Exception e){
                            e.printStackTrace();
                        }
                    }
                }else{
                    JOptionPane.showMessageDialog(null, "Debe seleccionar un elemento");
                }
        }
    }
    
    
    public void desactivarControles(){
        txtCodigoCargoEmpleado.setEditable(false);
        txtNombreCargo.setEditable(false);
        txtDescripcionCargo.setEditable(false);
    }
    
    public void activarControles(){
        txtCodigoCargoEmpleado.setEditable(true);
        txtNombreCargo.setEditable(true);
        txtDescripcionCargo.setEditable(true);
    }
    
    public void limpiarControles(){
        txtCodigoCargoEmpleado.clear();
        txtNombreCargo.clear();
        txtDescripcionCargo.clear();
    }
    
    public Principal getEscenarioPrincipal(){
        return escenarioPrincipal;
    }
    
    public void setEscenarioPrincipal(Principal escenarioPrincipal){
        this.escenarioPrincipal = escenarioPrincipal;
    }
}
