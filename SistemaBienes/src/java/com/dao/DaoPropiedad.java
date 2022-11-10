
package com.dao;

import com.model.Propiedad;
import com.model.Usuario;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


public class DaoPropiedad extends Conexion{
    public List<Propiedad> getPropiedad() throws SQLException {
        ResultSet rs;
        Propiedad pro;
        List<Propiedad> list = new ArrayList();
        try {
            this.conectar();
            Statement stmt = this.getCon().createStatement();
            String sql = " select * from propiedad \n";
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                pro = new Propiedad(
                        rs.getInt("idPropiedad"),
                        rs.getString("nombre"),
                        rs.getString("direccion"),
                        rs.getString("telefono"),
                        rs.getString("foto"),
                        rs.getString("estado"));
                list.add(pro);
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return list;
    }
    
     public int getPropiedadesCount() throws SQLException {
        ResultSet rs;
         int numPropiedad=0;
        try {
            this.conectar();
            Statement stmt = this.getCon().createStatement();
            String sql = "SELECT Count(*) AS numPropiedad FROM propiedad; ";
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                numPropiedad = rs.getInt("numPropiedad");
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return numPropiedad;
    }
   
    
     public String AddPropiedad(Propiedad pro) throws SQLException {
        try {
            this.conectar();
            String sql = "insert into propiedad values (null,?,?,?,?,?);";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setString(1, pro.getNombre());
            pre.setString(2, pro.getDireccion());
            pre.setString(3, pro.getTelefono());
            pre.setString(4, pro.getFoto());
            pre.setString(5, pro.getEstado());
            pre.executeUpdate();
            return "exito";
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }
     
     public String UpdatePropiedad(Propiedad pro) throws SQLException {
        try {
            this.conectar();
            String sql = "update propiedad set nombre = ?, direccion = ?, telefono = ? , foto = ?, estado = ? where idPropiedad = ?;";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setString(1, pro.getNombre());
            pre.setString(2, pro.getDireccion());
            pre.setString(3, pro.getTelefono());
            pre.setString(4, pro.getFoto());
            pre.setString(5, pro.getEstado());
            pre.setInt(6, pro.getIdPropiedad());
            pre.executeUpdate();
            return "exito";
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }

    public String deletePropiedad(Propiedad pro) throws SQLException {
        try {
            this.conectar();
            String sql = "delete from propiedad where idPropiedad = ?;";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, pro.getIdPropiedad());
            pre.executeUpdate();
            return "exito";
            
        } catch (SQLException e) {
            throw e;
            
        } finally {
            this.desconectar();
        }
    }
}
