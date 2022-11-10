package com.dao;

import com.model.Acceso;
import com.model.Usuario;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;


public class DaoUsuario extends Conexion{
    
     public Usuario identificar(Usuario user) throws Exception {
        Usuario usu = null;
        ResultSet rs;
          
        try {
            this.conectar();
            Statement stmt = this.getCon().createStatement();
             String sql = "select * FROM usuario where estado='Activo' and nombre= '" + user.getNombre()
                    + "' and clave='" + user.getClave()+ "'";  
            rs = stmt.executeQuery(sql);
            if (rs.next() == true) {
                usu = new Usuario();
                usu.setIdUsuario(rs.getInt("idUsuario"));
                usu.setNombre(user.getNombre());
                usu.setClave(rs.getString("clave"));
                usu.setTipo(rs.getInt("tipo"));
                usu.setEstado(rs.getString("estado"));
                
            }
            rs.close();
        } catch (Exception e) {
            System.out.println("Error" + e.getMessage());
        } finally {
            this.desconectar();
        }
        return usu;
    }
     
       public String addAcesso(int idusuario,String accion) throws SQLException {
           
        try {
            DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            Calendar cal = Calendar.getInstance();
            String date = dateFormat.format(Calendar.getInstance().getTime());
            this.conectar();
            String sql = "insert into acceso values (null,?,?,?);";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, idusuario);
            pre.setString(2, accion);
            pre.setString(3, date.toString());
            pre.executeUpdate();
            return "exito";
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }
       
        public String getAcceso(Usuario u) throws SQLException {
        ResultSet rs;
        Acceso acc;
        String html;
        List<Acceso> list = new ArrayList();
        try {
            this.conectar();
            Statement stmt = this.getCon().createStatement();
            String sql = " select * from acceso where idUsuario="+u.getIdUsuario();
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                acc = new Acceso(
                        rs.getInt("idAcceso"),
                        rs.getInt("idUsuario"),
                        rs.getString("accion"),
                        rs.getString("fecha"));
                list.add(acc);
            }
            
            html  = "<div class='table-responsive'>";
            html += "<table class='table table-primary  table-hover table-sm' id='tabla'> <thead>";
            html += "<th>IdAcceso</th><th>IdUsuario</th><th>Accion</th><th>Fecha</th> </thead><tbody>";
            for (Acceso acceso : list) {
             html += "<tr>";
             html += "<td>" + acceso.getIdAcceso()+"</td>";
             html += "<td>" + acceso.getIdUsuario()+"</td>";
             html += "<td>" + acceso.getAccion()+"</td>";
             html += "<td>" + acceso.getFecha()+"</td>";
                html += "</tr>";
            }
            html += "</tbody></table></div>";
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return html;
    }
    
    
    public List<Usuario> getUsuario() throws SQLException {
        ResultSet rs;
        Usuario usu;
        List<Usuario> list = new ArrayList();
        try {
            this.conectar();
            Statement stmt = this.getCon().createStatement();
            String sql = " select * from usuario \n";
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                usu = new Usuario(
                        rs.getInt("idUsuario"),
                        rs.getString("nombre"),
                        rs.getString("clave"),
                        rs.getInt("tipo"),
                        rs.getString("estado"),
                        rs.getString("creado_en"));
                list.add(usu);
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return list;
    }
    
    public List<Usuario> getUsuarioById(int id) throws SQLException {
        ResultSet rs;
        Usuario usu;
        List<Usuario> list = new ArrayList();
        try {
            this.conectar();
            Statement stmt = this.getCon().createStatement();
            String sql = " select * from usuario where idUsuario="+id+";";
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                usu = new Usuario(
                        rs.getInt("idUsuario"),
                        rs.getString("nombre"),
                        rs.getString("clave"),
                        rs.getInt("tipo"),
                        rs.getString("estado"),
                        rs.getString("creado_en"));
                list.add(usu);
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return list;
    }
    
    
     public String AddUsuario(Usuario usu) throws SQLException {
        try {
            this.conectar();
            String sql = "insert into usuario values (null,?,?,?,?,?);";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setString(1, usu.getNombre());
            pre.setString(2, usu.getClave());
            pre.setInt(3, usu.getTipo());
            pre.setString(4, usu.getEstado());
            pre.setString(5, usu.getCreado_en());
            pre.executeUpdate();
            return "exito";
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }

    public String updateUsuario(Usuario usu) throws SQLException {
        try {
            this.conectar();
            String sql = "update usuario set nombre = ?, clave = ?, tipo = ? , estado = ?, creado_en = ? where idUsuario = ?;";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
           pre.setString(1, usu.getNombre());
            pre.setString(2, usu.getClave());
            pre.setInt(3, usu.getTipo());
            pre.setString(4, usu.getEstado());
            pre.setString(5, usu.getCreado_en());
            pre.setInt(6, usu.getIdUsuario());
            pre.executeUpdate();
            return "exito";
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }
    
     public String updatePerfilUsuario(Usuario usu) throws SQLException {
        try {
            this.conectar();
            String sql = "update usuario set nombre = ?, clave = ?, tipo = ? , estado = ? where idUsuario = ?;";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
           pre.setString(1, usu.getNombre());
            pre.setString(2, usu.getClave());
            pre.setInt(3, usu.getTipo());
            pre.setString(4, usu.getEstado());
            pre.setInt(5, usu.getIdUsuario());
            pre.executeUpdate();
            return "exito";
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }

    public String deleteUsuario(Usuario usu) throws SQLException {
        try {
            this.conectar();
            String sql = "delete from usuario where idUsuario= ?; ";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, usu.getIdUsuario());
            pre.executeUpdate();
            return "exito";
            
        } catch (SQLException e) {
            throw e;
            
        } finally {
            this.desconectar();
        }
    }
    
     public int getUsuariosCount() throws SQLException {
        ResultSet rs;
         int numUsuario=0;
        try {
            this.conectar();
            Statement stmt = this.getCon().createStatement();
            String sql = "SELECT Count(*) AS numUsuario FROM usuario; ";
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                numUsuario = rs.getInt("numUsuario");
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return numUsuario;
    }
    
    
}
