
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
import org.josepirir.bean.Proveedores;
import org.josepirir.db.Conexion;
import org.josepirir.system.Principal;



public class ProveedorController implements Initializable{
    private Principal escenarioPrincipal;
 
    private enum operaciones{NUEVO,ELIMINAR,EDITAR,GUARDAR,CANCELAR,NINGUNO}
    private operaciones tipoOperacion=operaciones.NINGUNO;
    private ObservableList<Proveedores> listaProveedor;
    
    @FXML private TextField txtCodigoProveedor;
    @FXML private TextField txtNITProveedor;
    @FXML private TextField txtNombresProveedor;
    @FXML private TextField txtApellidosProveedor;
    @FXML private TextField txtDireccionProveedor;
    @FXML private TextField txtRazonSocial;
    @FXML private TextField txtContactoProveedor;
    @FXML private TextField txtPaginaWeb;
    
    @FXML private TableView tblProveedores;
    
    @FXML private TableColumn colCodigoProveedor;
    @FXML private TableColumn colNITProveedor;
    @FXML private TableColumn colNombresProveedor;
    @FXML private TableColumn colApellidosProveedor;
    @FXML private TableColumn colDireccionProveedor;
    @FXML private TableColumn colRazonSocial;
    @FXML private TableColumn colContactoProveedor;
    @FXML private TableColumn colPaginaWeb;
    
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
    public void initialize(URL location, ResourceBundle resources){
        cargarDatos();
    }    
    
    
    public void seleccionarElemento(){
        
    }
    
    public void cargarDatos(){
        tblProveedores.setItems(getProveedor());
        colCodigoProveedor.setCellValueFactory(new PropertyValueFactory<Proveedores,Integer>("codigoProveedor"));
        colNITProveedor.setCellValueFactory(new PropertyValueFactory<Proveedores,Integer>("NITProveedor"));
        colNombresProveedor.setCellValueFactory(new PropertyValueFactory<Proveedores,Integer>("nombresProveedor"));
        colApellidosProveedor.setCellValueFactory(new PropertyValueFactory<Proveedores,Integer>("apellidosProveedor"));
        colDireccionProveedor.setCellValueFactory(new PropertyValueFactory<Proveedores,Integer>("direccionProveedor"));
        colRazonSocial.setCellValueFactory(new PropertyValueFactory<Proveedores,Integer>("razonSocial"));
        colContactoProveedor.setCellValueFactory(new PropertyValueFactory<Proveedores,Integer>("contactoProveedor"));
        colPaginaWeb.setCellValueFactory(new PropertyValueFactory<Proveedores,Integer>("paginaWeb"));
    }
    
    public ObservableList<Proveedores> getProveedor(){
        ArrayList<Proveedores> lista=new ArrayList<Proveedores>();
        try{
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_ListarProveedores}");
            ResultSet resultado = procedimiento.executeQuery();
            while(resultado.next()){
                lista.add(new Proveedores(resultado.getInt("codigoProveedor"),
                resultado.getString("NITProveedor"),
                resultado.getString("nombresProveedor"),
                resultado.getString("apellidosProveedor"),
                resultado.getString("direccionProveedor"),
                resultado.getString("razonSocial"),
                resultado.getString("contactoProveedor"),
                resultado.getString("paginaWeb")));
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return listaProveedor = FXCollections.observableArrayList(lista);
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
                imgEliminar.setImage(new Image("/org/josepirir/image/guardar.png"));
                tipoOperacion=operaciones.GUARDAR;
            break;
            case GUARDAR:
                guardar();
                limpiarControles();
                desactivarControles();
                btnNuevo.setText("Guardar");
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
        Proveedores registro = new Proveedores();
        registro.setNITProveedor(txtNITProveedor.getText());
        registro.setNombresProveedor(txtNombresProveedor.getText());
        registro.setApellidosProveedor(txtApellidosProveedor.getText());
        registro.setDireccionProveedor(txtDireccionProveedor.getText());
        registro.setRazonSocial(txtRazonSocial.getText());
        registro.setContactoProveedor(txtContactoProveedor.getText());
        registro.setPaginaWeb(txtPaginaWeb.getText());
        try{
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_AgregarProveedor(?,?,?,?,?,?,?)}");
            procedimiento.setString(1, registro.getNITProveedor());
            procedimiento.setString(2, registro.getNombresProveedor());
            procedimiento.setString(3, registro.getApellidosProveedor());
            procedimiento.setString(4, registro.getDireccionProveedor());
            procedimiento.setString(5, registro.getRazonSocial());
            procedimiento.setString(6, registro.getContactoProveedor());
            procedimiento.setString(7, registro.getPaginaWeb());
            procedimiento.execute();
            listaProveedor.add(registro);
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
                if(tblProveedores.getSelectionModel().getSelectedItem()!=null){
                    int respuesta = JOptionPane.showConfirmDialog(null, "¿Está seguro de eliminar el registro?","Eliminar Cliente",JOptionPane.YES_NO_OPTION,JOptionPane.QUESTION_MESSAGE);
                    if(respuesta == JOptionPane.YES_OPTION){
                        try{
                            PreparedStatement procedimiento=Conexion.getInstance().getConexion().prepareCall("{call sp_EliminarProveedor(?)}");
                            procedimiento.setInt(1, ((Proveedores)tblProveedores.getSelectionModel().getSelectedItem()).getCodigoProveedor());
                            procedimiento.execute();
                            listaProveedor.remove(tblProveedores.getSelectionModel().getSelectedIndices());
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
        txtCodigoProveedor.setEditable(false);
        txtNITProveedor.setEditable(false);
        txtNombresProveedor.setEditable(false);
        txtApellidosProveedor.setEditable(false);
        txtDireccionProveedor.setEditable(false);
        txtRazonSocial.setEditable(false);
        txtContactoProveedor.setEditable(false);
        txtPaginaWeb.setEditable(false);
    }
    
    public void activarControles(){
        txtCodigoProveedor.setEditable(true);
        txtNITProveedor.setEditable(true);
        txtNombresProveedor.setEditable(true);
        txtApellidosProveedor.setEditable(true);
        txtDireccionProveedor.setEditable(true);
        txtRazonSocial.setEditable(true);
        txtContactoProveedor.setEditable(true);
        txtPaginaWeb.setEditable(true);
    }
    
    public void limpiarControles(){
        txtCodigoProveedor.clear();
        txtNITProveedor.clear();
        txtNombresProveedor.clear();
        txtApellidosProveedor.clear();
        txtDireccionProveedor.clear();
        txtRazonSocial.clear();
        txtContactoProveedor.clear();
        txtPaginaWeb.clear();
    }
    
    public Principal getEscenarioPrincipal(){
        return escenarioPrincipal;
    }
    
    public void setEscenarioPrincipal(Principal escenarioPrincipal){
        this.escenarioPrincipal = escenarioPrincipal;
    }
}
