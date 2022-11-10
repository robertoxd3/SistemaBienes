
package com.model;

import java.sql.Date;

/**
 *
 * @author RobertoPC
 */
public class Activo {
    private int codigo;
    private String serial;
    private String nombre;
    private String descripcion;
    private int propiedad;
    private int encargado;
    private Date fechaCompra;
    private String estado;
    private String categoria;
    private int cantidad;
    private String foto;
    
    public Activo(int codigo, String serial, String nombre, String descripcion, int propiedad, int encargado, Date fechaCompra, String estado,String categoria, int cantidad, String foto) {
        this.codigo = codigo;
        this.serial = serial;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.propiedad = propiedad;
        this.encargado = encargado;
        this.fechaCompra = fechaCompra;        
        this.estado = estado;
        this.categoria = categoria;
        this.cantidad=cantidad;
        this.foto = foto;
    }

    public Activo() {
       
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getPropiedad() {
        return propiedad;
    }

    public void setPropiedad(int propiedad) {
        this.propiedad = propiedad;
    }

    public int getEncargado() {
        return encargado;
    }

    public void setEncargado(int encargado) {
        this.encargado = encargado;
    }

    public Date getFechaCompra() {
        return fechaCompra;
    }

    public void setFechaCompra(Date fechaCompra) {
        this.fechaCompra = fechaCompra;
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

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }
    

}
