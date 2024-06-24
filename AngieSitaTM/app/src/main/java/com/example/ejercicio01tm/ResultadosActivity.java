package com.example.ejercicio01tm;

import android.os.Bundle;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;

import java.util.Arrays;
import java.util.List;
import java.util.Random;

import static com.example.ejercicio01tm.CoordenadasDistritos.coordenadas;

public class ResultadosActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.resultados);

        String puntoInicio = getIntent().getStringExtra("puntoInicio");
        String destino = getIntent().getStringExtra("destino");

        double[] coordsInicio = coordenadas.get(puntoInicio);
        double[] coordsDestino = coordenadas.get(destino);

        double distancia = calcularDistancia(coordsInicio[0], coordsInicio[1], coordsDestino[0], coordsDestino[1]);

        TextView tvDistancia = findViewById(R.id.tvDistancia);
        tvDistancia.setText("Distancia entre 2 rutas: " + String.format("%.2f km", distancia));

        double tiempoEnHoras = distancia / 25;
        int tiempoEnMinutos = (int) (tiempoEnHoras * 60);

        TextView tvDuracion = findViewById(R.id.tvDuracion);
        tvDuracion.setText("Duración en Bus: " + tiempoEnMinutos + " minutos");

        // Selección aleatoria de la ruta de bus
        List<String> rutas = Arrays.asList(
                "15 de Agosto S.A.", "24 De Diciembre S.R.L.", "3 de Octubre S.A.", "6 de Diciembre S.A.",
                "Alborada Transasil S.A.", "Alto la Luna S.A", "Amaru Sociedad Anonima", // ... continuar con más nombres
                "Virgen De Polanco S.A.", "Volant Bus S.A.", "Waldos Inversiones Scrl.", "Cotum B", "Zamacola S.A."
        );
        Random random = new Random();
        String rutaSeleccionada = rutas.get(random.nextInt(rutas.size()));

        TextView tvRuta = findViewById(R.id.tvRuta);
        tvRuta.setText("Ruta que debe tomar: " + rutaSeleccionada);
    }

    private double calcularDistancia(double lat1, double lon1, double lat2, double lon2) {
        double radioTierra = 6371; // Radio de la Tierra en kilómetros
        double dLat = Math.toRadians(lat2 - lat1);
        double dLon = Math.toRadians(lon2 - lon1);
        lat1 = Math.toRadians(lat1);
        lat2 = Math.toRadians(lat2);

        double a = Math.sin(dLat/2) * Math.sin(dLat/2) +
                Math.sin(dLon/2) * Math.sin(dLon/2) * Math.cos(lat1) * Math.cos(lat2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        return radioTierra * c;
    }
}
