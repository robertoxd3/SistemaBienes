
package com.dao;

import com.model.Empleado;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


public class DaoEmpleado extends Conexion{
    public List<Empleado> getEmpleados() throws SQLException {
        ResultSet rs;
        Empleado emp;
        List<Empleado> list = new ArrayList();
        try {
            this.conectar();
            Statement stmt = this.getCon().createStatement();
            String sql = " select * from empleado ";
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                emp = new Empleado(
                        rs.getInt("idEmpleado"),
                        rs.getString("nombres"),
                        rs.getString("apellidos"),
                        rs.getString("dui"),
                        rs.getString("area"));
                list.add(emp);
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return list;
    }

    public String AddEmpleado(Empleado emp) throws SQLException {
        try {
            this.conectar();
            String sql = "insert into empleado values (null,?,?,?,?);";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setString(1, emp.getNombres());
            pre.setString(2, emp.getApellidos());
            pre.setString(3, emp.getDui());
            pre.setString(4, emp.getArea());
            pre.executeUpdate();
            return "exito";
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }
    
    
    public String updateEmpleado(Empleado emp) throws SQLException {
        try {
            this.conectar();
            String sql = "update empleado set nombres = ?, apellidos = ?, dui = ? , area = ? where idEmpleado = ?;";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setString(1, emp.getNombres());
            pre.setString(2, emp.getApellidos());
            pre.setString(3, emp.getDui());
            pre.setString(4, emp.getArea());
            pre.setInt(5, emp.getIdEmpleado());
            pre.executeUpdate();
            return "exito";
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }
    
    
     public String deleteEmpleado(Empleado emp) throws SQLException {
        try {
            this.conectar();
            String sql = "delete from empleado where idEmpleado = ?;";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, emp.getIdEmpleado());
            pre.executeUpdate();
            return "exito";
            
        } catch (SQLException e) {
            throw e;
            
        } finally {
            this.desconectar();
        }
    }
     
      public int getEmpleadosCount() throws SQLException {
        ResultSet rs;
         int numActivos=0;
        try {
            this.conectar();
            Statement stmt = this.getCon().createStatement();
            String sql = "SELECT Count(*) AS numEmpleado FROM empleado; ";
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                numActivos = rs.getInt("numEmpleado");
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return numActivos;
    }
    
}
