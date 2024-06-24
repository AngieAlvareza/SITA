package com.example.ejercicio01tm;

public class Bus {
    String id, origen, destino, detalles;

    public Bus(String id, String origen, String destino, String detalles) {
        this.id = id;
        this.origen = origen;
        this.destino = destino;
        this.detalles = detalles;
    }
    public String getId() { return id; }
    public String getOrigen() { return origen; }
    public String getDestino() { return destino; }
    public String getDetalles() { return detalles; }
}
