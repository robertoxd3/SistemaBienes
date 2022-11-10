package com.model;

public class Usuario {

    private int idUsuario;
    private String nombre;
    private String clave;
    private int tipo;
    private String estado;
    private String creado_en;

    public Usuario(int idUsuario, String nombre, String clave, int tipo, String estado, String creado_en) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.clave = clave;
        this.tipo = tipo;
        this.estado = estado;
        this.creado_en = creado_en;
    }

    public Usuario() {
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }

    public String getCreado_en() {
        return creado_en;
    }

    public void setCreado_en(String creado_en) {
        this.creado_en = creado_en;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    

}
