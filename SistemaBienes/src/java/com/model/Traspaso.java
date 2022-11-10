
package com.model;


public class Traspaso {
    
    private int idTraspaso;
    private int activo;
    private int encargadoNuevo;
    private int encargadoAnterior;
    private String fechaTraspaso;
    
    private String act;
    private String encargadoN;
    private String encargadoA;

    public Traspaso() {
    }

    public Traspaso(int idTraspaso, int activo, int encargadoNuevo, int encargadoAnterior, String fechaTraspaso) {
        this.idTraspaso = idTraspaso;
        this.activo = activo;
        this.encargadoNuevo = encargadoNuevo;
        this.encargadoAnterior = encargadoAnterior;
        this.fechaTraspaso = fechaTraspaso;
    }
    
    public Traspaso(int idTraspaso, String act, String encargadoN, String encargadoA, String fechaTraspaso) {
        this.idTraspaso = idTraspaso;
        this.act = act;
        this.encargadoN = encargadoN;
        this.encargadoA = encargadoA;
        this.fechaTraspaso = fechaTraspaso;
    }

    public int getIdTraspaso() {
        return idTraspaso;
    }

    public void setIdTraspaso(int idTraspaso) {
        this.idTraspaso = idTraspaso;
    }

    public int getActivo() {
        return activo;
    }

    public void setActivo(int activo) {
        this.activo = activo;
    }

    public int getEncargadoNuevo() {
        return encargadoNuevo;
    }

    public void setEncargadoNuevo(int encargadoNuevo) {
        this.encargadoNuevo = encargadoNuevo;
    }

    public int getEncargadoAnterior() {
        return encargadoAnterior;
    }

    public void setEncargadoAnterior(int encargadoAnterior) {
        this.encargadoAnterior = encargadoAnterior;
    }

    public String getFechaTraspaso() {
        return fechaTraspaso;
    }

    public void setFechaTraspaso(String fechaTraspaso) {
        this.fechaTraspaso = fechaTraspaso;
    }

    public String getAct() {
        return act;
    }

    public void setAct(String act) {
        this.act = act;
    }

    public String getEncargadoN() {
        return encargadoN;
    }

    public void setEncargadoN(String encargadoN) {
        this.encargadoN = encargadoN;
    }

    public String getEncargadoA() {
        return encargadoA;
    }

    public void setEncargadoA(String encargadoA) {
        this.encargadoA = encargadoA;
    }
    
    

    

}
