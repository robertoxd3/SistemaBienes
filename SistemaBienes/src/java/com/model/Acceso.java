/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.model;

/**
 *
 * @author RobertoPC
 */
public class Acceso {
    private int idAcceso ;
    private int idUsuario ;
    private String accion;
    private String fecha ;

    public Acceso(int idAcceso, int idUsuario, String accion, String fecha) {
        this.idAcceso = idAcceso;
        this.idUsuario = idUsuario;
        this.accion = accion;
        this.fecha = fecha;
    }

    public Acceso() {
    }
    
    

    public int getIdAcceso() {
        return idAcceso;
    }

    public void setIdAcceso(int idAcceso) {
        this.idAcceso = idAcceso;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getAccion() {
        return accion;
    }

    public void setAccion(String accion) {
        this.accion = accion;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }
    
    

}
