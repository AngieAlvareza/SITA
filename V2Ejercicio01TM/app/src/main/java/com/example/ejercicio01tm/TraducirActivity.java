package com.example.ejercicio01tm;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;

import com.google.mlkit.nl.translate.Translation;
import com.google.mlkit.nl.translate.Translator;
import com.google.mlkit.nl.translate.TranslatorOptions;

public class TraducirActivity extends AppCompatActivity {

    private EditText etInputText;
    private Button btnTranslate;
    private TextView tvTranslationResult;
    private Translator englishSpanishTranslator;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.traduccion);

        etInputText = findViewById(R.id.etInputText);
        btnTranslate = findViewById(R.id.btnTranslate);
        tvTranslationResult = findViewById(R.id.tvTranslationResult);

        // Configurar opciones para el traductor, aquí de Inglés a Español
        TranslatorOptions options = new TranslatorOptions.Builder()
                .setSourceLanguage("en")
                .setTargetLanguage("es")
                .build();
        englishSpanishTranslator = Translation.getClient(options);

        // Descargar el modelo de traducción si es necesario
        prepareModel();

        btnTranslate.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                translateText();
            }
        });
    }

    private void prepareModel() {
        englishSpanishTranslator.downloadModelIfNeeded()
                .addOnSuccessListener(unused -> btnTranslate.setEnabled(true))
                .addOnFailureListener(e -> tvTranslationResult.setText("Error al descargar el modelo de traducción."));
    }

    private void translateText() {
        String text = etInputText.getText().toString();
        englishSpanishTranslator.translate(text)
                .addOnSuccessListener(translation -> tvTranslationResult.setText(translation))
                .addOnFailureListener(e -> tvTranslationResult.setText("Error al traducir."));
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        englishSpanishTranslator.close(); // Libera recursos del traductor
    }
}
