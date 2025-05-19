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
import org.josepirir.bean.TipoProducto;
import org.josepirir.db.Conexion;
import org.josepirir.system.Principal;

public class TipoProductoController implements Initializable{
    private Principal escenarioPrincipal;
    
    private enum operaciones{NUEVO,ELIMINAR,EDITAR,GUARDAR,CANCELAR,NINGUNO}
    private operaciones tipoOperacion = operaciones.NINGUNO;
    private ObservableList<TipoProducto> listaTipoProducto;
    
    @FXML private TableView tblTipoProducto;
    
    @FXML private TextField txtCodigoTipoProducto;
    @FXML private TextField txtDescripcion;
    
    @FXML private TableColumn colCodigoTipoProducto;
    @FXML private TableColumn colDescripcion;
    
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
    
    
    
    @Override
    public void initialize(URL location, ResourceBundle resources) {
        cargarDatos();
    }
    
    public void seleccionarElemento(){
        
    }
    
    public void cargarDatos(){
        tblTipoProducto.setItems(getTipoProducto());
        colCodigoTipoProducto.setCellValueFactory(new PropertyValueFactory<TipoProducto,Integer>("codigoTipoProducto"));
        colDescripcion.setCellValueFactory(new PropertyValueFactory<TipoProducto,Integer>("descripcion"));
    }
    
    public ObservableList<TipoProducto> getTipoProducto(){
        ArrayList<TipoProducto> lista=new ArrayList<>();
        try{
            PreparedStatement procedimiento=Conexion.getInstance().getConexion().prepareCall("{call sp_ListarTipoProducto}");
            ResultSet resultado=procedimiento.executeQuery();
            while(resultado.next()){
                lista.add(new TipoProducto(resultado.getInt("codigoTipoProducto"),
                    resultado.getString("descripcion")));
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return listaTipoProducto = FXCollections.observableArrayList(lista);
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
        TipoProducto registro = new TipoProducto();
        registro.setDescripcion(txtDescripcion.getText());
        try{
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_AgregarTipoProducto(?)}");
            procedimiento.setString(1, registro.getDescripcion());
            listaTipoProducto.add(registro);
            procedimiento.executeQuery();
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
                if(tblTipoProducto.getSelectionModel().getSelectedItem()!=null){
                    int respuesta = JOptionPane.showConfirmDialog(null,  "¿Está seguro de eliminar el registro?","Eliminar Cliente", JOptionPane.YES_NO_OPTION,JOptionPane.QUESTION_MESSAGE);
                    if(respuesta==JOptionPane.YES_OPTION){
                        try{
                            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_EliminarTipoProducto(?)}");
                            procedimiento.setInt(1, ((TipoProducto)tblTipoProducto.getSelectionModel().getSelectedItem()).getCodigoTipoProducto());
                            procedimiento.execute();
                            listaTipoProducto.remove(tblTipoProducto.getSelectionModel().getSelectedIndices());
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
        txtCodigoTipoProducto.setEditable(false);
        txtDescripcion.setEditable(false);
    }    
    
    public void activarControles(){
        txtCodigoTipoProducto.setEditable(true);
        txtDescripcion.setEditable(true);
    }
    
    public void limpiarControles(){
        txtCodigoTipoProducto.clear();
        txtDescripcion.clear();
    }
    
    public Principal getEscenarioPrincipal() {
        return escenarioPrincipal;
    }

    public void setEscenarioPrincipal(Principal escenarioPrincipal) {
        this.escenarioPrincipal = escenarioPrincipal;
    }
    
}

    
    
