
package com.dao;

import com.model.Activo;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


public class DaoActivo extends Conexion{
        public List<Activo> getActivos() throws SQLException {
        ResultSet rs;
        Activo act;
        List<Activo> list = new ArrayList();
        try {
            this.conectar();
            Statement stmt = this.getCon().createStatement();
            String sql = " select * from activo \n";
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                act = new Activo(
                        rs.getInt("codigo"),
                        rs.getString("serial"),
                        rs.getString("nombre"),
                        rs.getString("descripcion"),
                        rs.getInt("propiedad"),
                        rs.getInt("encargado"),
                        rs.getDate("fechaCompra"),
                        rs.getString("estado"),
                        rs.getString("categoria"),
                        rs.getInt("cantidad"),
                        rs.getString("foto"));
                list.add(act);
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return list;
    }
        
         public int getActivosCount() throws SQLException {
        ResultSet rs;
         int numActivos=0;
        try {
            this.conectar();
            Statement stmt = this.getCon().createStatement();
            String sql = "SELECT Count(*) AS numActivos FROM activo; ";
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                numActivos = rs.getInt("numActivos");
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return numActivos;
    }
    

    
     public String AddActivo(Activo act) throws SQLException {
        try {
            this.conectar();
            String sql = "insert into activo values (null,?,?,?,?,?,?,?,?,?,?);";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setString(1, act.getSerial());
            pre.setString(2, act.getNombre());
            pre.setString(3, act.getDescripcion());
            pre.setInt(4, act.getPropiedad());
            pre.setInt(5, act.getEncargado());
            pre.setDate(6, act.getFechaCompra());
            pre.setString(7, act.getEstado());
            pre.setString(8, act.getCategoria());
            pre.setInt(9, act.getCantidad());
            pre.setString(10, act.getFoto());
            pre.executeUpdate();
            return "exito";
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }
     
     public String UpdateActivo(Activo act) throws SQLException {
        try {
            this.conectar();
            String sql = "update activo set serial = ?, nombre = ?, descripcion = ? , propiedad = ?, encargado = ?, fechaCompra = ?, estado = ?, categoria = ?, cantidad = ?, foto = ? where codigo=? ";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setString(1, act.getSerial());
            pre.setString(2, act.getNombre());
            pre.setString(3, act.getDescripcion());
            pre.setInt(4, act.getPropiedad());
            pre.setInt(5, act.getEncargado());
            pre.setDate(6, act.getFechaCompra());
            pre.setString(7, act.getEstado());
            pre.setString(8, act.getCategoria());
            pre.setInt(9, act.getCantidad());
            pre.setString(10, act.getFoto());
            pre.setInt(11, act.getCodigo());
            pre.executeUpdate();
            return "exito";
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }
     
      public String UpdateActivoTraspaso(Activo act) throws SQLException {
        try {
            this.conectar();
            String sql = "update activo set encargado = ? where codigo=? ";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, act.getEncargado());
            pre.setInt(2, act.getCodigo());
            pre.executeUpdate();
            return "exito";
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }

    public String deleteActivo(Activo act) throws SQLException {
        try {
            this.conectar();
            String sql = "delete from activo where codigo = ?;";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, act.getCodigo());
            pre.executeUpdate();
            return "exito";
            
        } catch (SQLException e) {
            throw e;
            
        } finally {
            this.desconectar();
        }
    }
    
     public String getEmpleadoByID(int idEmpleado) throws SQLException {
        ResultSet rs;
         String apellidos="";
        try {
            
            this.conectar();
            Statement stmt = this.getCon().createStatement();
            String sql = "SELECT * from empleado where idEmpleado="+idEmpleado;
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                apellidos = rs.getString("apellidos");
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return apellidos;
    }
     
      public String getPropiedadByID(int idPropiedad) throws SQLException {
        ResultSet rs;
         String apellidos="";
        try {
            
            this.conectar();
            Statement stmt = this.getCon().createStatement();
            String sql = "SELECT * from propiedad where idPropiedad="+idPropiedad;
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                apellidos = rs.getString("nombre");
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return apellidos;
    }
      
      
      
      
       public List<Activo> getActivosGrafico() throws SQLException {
        ResultSet rs;
        Activo act;
        List<Activo> list = new ArrayList();
        try {
            this.conectar();
            Statement stmt = this.getCon().createStatement();
            String sql = " select * from activo ORDER BY codigo DESC LIMIT 5; \n";
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                act = new Activo(
                        rs.getInt("codigo"),
                        rs.getString("serial"),
                        rs.getString("nombre"),
                        rs.getString("descripcion"),
                        rs.getInt("propiedad"),
                        rs.getInt("encargado"),
                        rs.getDate("fechaCompra"),
                        rs.getString("estado"),
                        rs.getString("categoria"),
                        rs.getInt("cantidad"),
                        rs.getString("foto"));
                list.add(act);
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return list;
    }
       
       
       
       
        public List<Activo> getActivosGraficoPastel() throws SQLException {
        ResultSet rs;
        Activo act;
        List<Activo> list = new ArrayList();
        try {
            this.conectar();
            Statement stmt = this.getCon().createStatement();
            String sql = " SELECT codigo,serial,nombre,descripcion,propiedad,encargado,fechaCompra,estado,foto, "
                    + " SUM(cantidad) as cantidad, categoria FROM activo GROUP BY categoria; \n";
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                act = new Activo(
                        rs.getInt("codigo"),
                        rs.getString("serial"),
                        rs.getString("nombre"),
                        rs.getString("descripcion"),
                        rs.getInt("propiedad"),
                        rs.getInt("encargado"),
                        rs.getDate("fechaCompra"),
                        rs.getString("estado"),
                        rs.getString("categoria"),
                        rs.getInt("cantidad"),
                        rs.getString("foto"));
                list.add(act);
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return list;
    }
    
    
    
}
