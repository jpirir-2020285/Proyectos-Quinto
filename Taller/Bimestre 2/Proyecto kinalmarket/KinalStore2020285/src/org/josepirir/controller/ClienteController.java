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
import org.josepirir.bean.Clientes;
import org.josepirir.db.Conexion;
import org.josepirir.system.Principal;



public class ClienteController implements Initializable{
    private Principal escenarioPrincipal;
    
    private enum operaciones{NUEVO,ELIMINAR,EDITAR,GUARDAR,CANCELAR,NINGUNO}
    private operaciones tipoOperacion=operaciones.NINGUNO;
    private ObservableList<Clientes> listaCliente;
    
    @FXML private TextField txtCodigoCliente;
    @FXML private TextField txtNITCliente;
    @FXML private TextField txtNombresCliente;
    @FXML private TextField txtApellidosCliente;
    @FXML private TextField txtDireccionCliente;
    @FXML private TextField txtTelefonoCliente;
    @FXML private TextField txtCorreoCliente;
    
    @FXML private TableView tblClientes;
    
    @FXML private TableColumn colCodigoCliente;
    @FXML private TableColumn colNITCliente;
    @FXML private TableColumn colNombresCliente;
    @FXML private TableColumn colApellidosCliente;
    @FXML private TableColumn colDireccionCliente;
    @FXML private TableColumn colTelefonoCliente;
    @FXML private TableColumn colCorreoCliente;
    
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
        tblClientes.setItems(getCliente());
        colCodigoCliente.setCellValueFactory(new PropertyValueFactory<Clientes,Integer>("codigoCliente"));
        colNITCliente.setCellValueFactory(new PropertyValueFactory<Clientes,Integer>("NITCliente"));
        colNombresCliente.setCellValueFactory(new PropertyValueFactory<Clientes,Integer>("nombresCliente"));
        colApellidosCliente.setCellValueFactory(new PropertyValueFactory<Clientes,Integer>("apellidosCliente"));
        colDireccionCliente.setCellValueFactory(new PropertyValueFactory<Clientes,Integer>("direccionCliente"));
        colTelefonoCliente.setCellValueFactory(new PropertyValueFactory<Clientes,Integer>("telefonoCliente"));
        colCorreoCliente.setCellValueFactory(new PropertyValueFactory<Clientes,Integer>("correoCliente"));
    }
    
    
    public ObservableList<Clientes> getCliente(){
        ArrayList<Clientes> lista=new ArrayList<Clientes>();
        try{
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_ListarClientes}");
            ResultSet resultado = procedimiento.executeQuery();
            while(resultado.next()){
                lista.add(new Clientes(resultado.getInt("codigoCliente"),
                    resultado.getString("NITCliente"),
                    resultado.getString("nombresCliente"),
                    resultado.getString("apellidosCliente"),
                    resultado.getString("direccionCliente"),
                    resultado.getString("telefonoCliente"),
                    resultado.getString("correoCliente")));
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return listaCliente = FXCollections.observableArrayList(lista);
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
        Clientes registro = new Clientes();
//       registro.setCodigoCliente(Integer.parseInt(txtCodigoCliente.getText()));
        registro.setNITCliente(txtNITCliente.getText());
        registro.setNombresCliente(txtNombresCliente.getText());
        registro.setApellidosCliente(txtApellidosCliente.getText());
        registro.setDireccionCliente(txtDireccionCliente.getText());
        registro.setTelefonoCliente(txtTelefonoCliente.getText());
        registro.setCorreoCliente(txtCorreoCliente.getText());
        try{
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_AgregarCliente(?,?,?,?,?,?)}");
            procedimiento.setString(1, registro.getNITCliente());
            procedimiento.setString(2, registro.getNombresCliente());
            procedimiento.setString(3, registro.getApellidosCliente());
            procedimiento.setString(4, registro.getDireccionCliente());
            procedimiento.setString(5, registro.getTelefonoCliente());
            procedimiento.setString(6, registro.getCorreoCliente());
            procedimiento.execute();
            listaCliente.add(registro);
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
                if(tblClientes.getSelectionModel().getSelectedItem()!=null){
                    int respuesta = JOptionPane.showConfirmDialog(null, "¿Está seguro de eliminar el registro?","Eliminar Cliente",JOptionPane.YES_NO_OPTION,JOptionPane.QUESTION_MESSAGE);
                    if(respuesta==JOptionPane.YES_OPTION){
                        try{
                            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{Call sp_EliminarCliente(?)}");
                            procedimiento.setInt(1, ((Clientes)tblClientes.getSelectionModel().getSelectedItem()).getCodigoCliente());
                            procedimiento.execute();
                            listaCliente.remove(tblClientes.getSelectionModel().getSelectedIndices());
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
        txtCodigoCliente.setEditable(false);
        txtNITCliente.setEditable(false);
        txtNombresCliente.setEditable(false);
        txtApellidosCliente.setEditable(false);
        txtDireccionCliente.setEditable(false);
        txtTelefonoCliente.setEditable(false);
        txtCorreoCliente.setEditable(false);
    }
    
    public void activarControles(){
        txtCodigoCliente.setEditable(true);
        txtNITCliente.setEditable(true);
        txtNombresCliente.setEditable(true);
        txtApellidosCliente.setEditable(true);
        txtDireccionCliente.setEditable(true);
        txtTelefonoCliente.setEditable(true);
        txtCorreoCliente.setEditable(true);
    }
    
    public void limpiarControles(){
        txtCodigoCliente.clear();
        txtNITCliente.clear();
        txtNombresCliente.clear();
        txtApellidosCliente.clear();
        txtDireccionCliente.clear();
        txtTelefonoCliente.clear();
        txtCorreoCliente.clear();
    }
    
    public Principal getEscenarioPrincipal() {
        return escenarioPrincipal;
    }

    public void setEscenarioPrincipal(Principal escenarioPrincipal) {
        this.escenarioPrincipal = escenarioPrincipal;
    }
}
