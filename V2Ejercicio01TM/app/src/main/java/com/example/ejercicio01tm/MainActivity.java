package com.example.ejercicio01tm;

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
    Spinner spinPuntoInicio, spinDestino;  // Corregido para que ambos sean Spinners.
    EditText txtDescripcion;              // Declaración del EditText para la descripción.
    Button btnRegistrar;
    private DatabaseReference Buses;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        spinPuntoInicio = findViewById(R.id.spinPuntoInicio);
        spinDestino = findViewById(R.id.spinDestino);
        txtDescripcion = findViewById(R.id.txtDescripcion);  // Correcta inicialización de txtDescripcion.
        btnRegistrar = findViewById(R.id.btnRegistrar);

        Buses = FirebaseDatabase.getInstance().getReference("Buses");

        btnRegistrar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                registrarRuta();
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
