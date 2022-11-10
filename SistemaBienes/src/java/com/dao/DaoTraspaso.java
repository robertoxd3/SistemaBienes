/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.model.Acceso;
import com.model.Activo;
import com.model.Traspaso;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author RobertoPC
 */
public class DaoTraspaso extends Conexion{
    
     public String getActivoId(int idEncargado) throws SQLException {
        ResultSet rs;
        Activo act;
        String html;
        List<Activo> list = new ArrayList();
        try {
            this.conectar();
            Statement stmt = this.getCon().createStatement();
            String sql = " select * from activo where encargado="+idEncargado+";";
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
            
            html  = "<div class='table-responsive'>";
            html += "<table class='table table-success  table-hover table-sm' id='tabla'> <thead>";
            html += "<th>codigo</th><th>nombre</th><th>foto</th><th>descripcion</th><th>propiedad</th><th>encargado</th><th>fechaCompra</th><th>Acciones</th> </thead><tbody>";
            for (Activo activo : list) {
             html += "<tr>";
             html += "<td>" + activo.getCodigo()+"</td>";
             html +=  "<td> <img src=../assets/activos/"+activo.getFoto()+" class='rounded-start'  style='width: 100px; height: 100px' alt='propiedad'></td>";
             html += "<td>" + activo.getNombre()+"</td>";
             html += "<td>" + activo.getDescripcion()+"</td>";
             html += "<td>" + activo.getPropiedad()+"</td>";
             html += "<td>" + activo.getEncargado()+"</td>";
             html += "<td>" + activo.getFechaCompra()+"</td>";
             html += "<td> <a name='btnTraspaso' data-bs-toggle=\"modal\" data-bs-target=\"#ModalTraspaso\" onclick='javascript:cargar("+activo.getCodigo()+" , "+activo.getEncargado()+");' href='#' class='btn btn-success rounded-lg' data-toggle='tooltip' title='Traspaso' data-placement='bottom'><i class='fa-solid fa-plus'></i></a>";
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
     
      public List<Traspaso> getTraspasos() throws SQLException {
        ResultSet rs;
        Traspaso tra;
        List<Traspaso> list = new ArrayList();
        try {
            this.conectar();
            Statement stmt = this.getCon().createStatement();
            String sql = "select t.idTraspaso,a.nombre as activo, e.nombres as encargadoNuevo, emp.nombres as encargadoAnterior, t.fechaTraspaso from traspaso t "
                   +"INNER JOIN empleado e on t.encargadoNuevo = e.idEmpleado "
                    +"INNER JOIN empleado emp on t.encargadoAnterior = emp.idEmpleado "
                    +"INNER JOIN activo a on t.activo = a.codigo; ";
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                tra = new Traspaso(
                        rs.getInt("idTraspaso"),
                        rs.getString("activo"),
                        rs.getString("encargadoNuevo"),
                        rs.getString("encargadoAnterior"),
                        rs.getString("fechaTraspaso"));
                list.add(tra);
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return list;
    }
     
     
     public String AddTraspaso(Traspaso tra) throws SQLException {
        try {
            this.conectar();
            String sql = "insert into traspaso values (null,?,?,?,?);";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, tra.getActivo());
            pre.setInt(2, tra.getEncargadoNuevo());
            pre.setInt(3, tra.getEncargadoAnterior());
            pre.setString(4, tra.getFechaTraspaso());
            pre.executeUpdate();
            return "exito";
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }
     
     
     public int getTraspasosCount() throws SQLException {
        ResultSet rs;
         int numActivos=0;
        try {
            this.conectar();
            Statement stmt = this.getCon().createStatement();
            String sql = "SELECT Count(*) AS numTraspaso FROM traspaso; ";
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                numActivos = rs.getInt("numTraspaso");
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return numActivos;
    }
    
}
