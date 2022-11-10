
package com.model;


public class Propiedad {
    private int idPropiedad;
    private String nombre;
    private String direccion;
    private String telefono;
    private String foto;
    private String estado;

    public Propiedad(int idPropiedad, String nombre, String direccion, String telefono, String foto, String estado) {
        this.idPropiedad = idPropiedad;
        this.nombre = nombre;
        this.direccion = direccion;
        this.telefono = telefono;
        this.foto = foto;
        this.estado = estado;
    }

    public Propiedad() {
    }

    public int getIdPropiedad() {
        return idPropiedad;
    }

    public void setIdPropiedad(int idPropiedad) {
        this.idPropiedad = idPropiedad;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getFoto() {
        return foto;
    }

    public void setFoto(String foto) {
        this.foto = foto;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    
}
