package com.example.ejercicio01tm;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Spinner;
import android.widget.EditText;
import android.widget.Button;
import android.widget.Toast;


import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;

import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

public class MainActivity extends AppCompatActivity {
    Spinner spinPuntoInicio, spinDestino;
    EditText txtDescripcion;
    Button btnRegistrar, btnBuscar;
    private DatabaseReference Buses;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        spinPuntoInicio = findViewById(R.id.spinPuntoInicio);
        spinDestino = findViewById(R.id.spinDestino);
        txtDescripcion = findViewById(R.id.txtDescripcion);
        btnRegistrar = findViewById(R.id.btnRegistrar);
        btnBuscar = findViewById(R.id.btnBuscar);  // Inicialización del botón Buscar.

        Buses = FirebaseDatabase.getInstance().getReference("Buses");

        btnRegistrar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                registrarRuta();
            }
        });

        // Configuración del OnClickListener para el botón Buscar Ruta
        btnBuscar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(MainActivity.this, ResultadosActivity.class);
                if (spinPuntoInicio.getSelectedItem() != null && spinDestino.getSelectedItem() != null) {
                    intent.putExtra("puntoInicio", spinPuntoInicio.getSelectedItem().toString());
                    intent.putExtra("destino", spinDestino.getSelectedItem().toString());
                    startActivity(intent);
                } else {
                    Toast.makeText(MainActivity.this, "Debe seleccionar los puntos de inicio y destino", Toast.LENGTH_SHORT).show();
                }
            }
        });

    }

    public void registrarRuta() {
        String puntoInicio = spinPuntoInicio.getSelectedItem().toString();
        String destino = spinDestino.getSelectedItem().toString();
        String descripcion = txtDescripcion.getText().toString();

        if (!puntoInicio.isEmpty() && !destino.isEmpty() && !descripcion.isEmpty()) {
            String id = Buses.push().getKey();
            Bus ruta = new Bus(id, puntoInicio, destino, descripcion);
            Buses.child("Rutas").child(id).setValue(ruta);
            Toast.makeText(this, "Ruta Registrada", Toast.LENGTH_LONG).show();
        } else {
            Toast.makeText(this, "Debe introducir todos los detalles de la ruta", Toast.LENGTH_LONG).show();
        }
    }
}
