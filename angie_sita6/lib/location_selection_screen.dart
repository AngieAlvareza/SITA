import 'package:flutter/material.dart';

class LocationSelectionScreen extends StatefulWidget {
  final String type;

  LocationSelectionScreen({required this.type});

  @override
  _LocationSelectionScreenState createState() => _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  final List<String> locations = [
    "Alto Selva Alegre",
    "Arequipa",
    "Cayma",
    "Cerro Colorado",
    "Characato",
    "Chiguata",
    "Jacobo Hunter",
    "José Luis Bustamante y Rivero",
    "La Joya",
    "Mariano Melgar",
    "Miraflores",
    "Mollebaya",
    "Paucarpata",
    "Pocsi",
    "Polobaya",
    "Quequeña",
    "Sabandía",
    "Sachaca",
    "San Juan de Siguas",
    "San Juan de Tarucani",
    "Santa Isabel de Siguas",
    "Santa Rita de Siguas",
    "Socabaya",
    "Tiabaya",
    "Uchumayo",
    "Vitor",
    "Yanahuara",
    "Yarabamba",
    "Yura"
  ];

  String? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona un lugar'),
        backgroundColor: Colors.blueGrey.withOpacity(1), // Cambia este color según el color de home_screen
        elevation: 0, // Elimina la sombra del AppBar si lo deseas
        iconTheme: IconThemeData(color: Colors.white), // Cambia el color de los iconos del AppBar a blanco
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/bus6.jpg', // Asegúrate de que esta ruta sea correcta
            fit: BoxFit.cover,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Fondo blanco para el DropdownButtonFormField
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white, // Asegura que el fondo del dropdown sea blanco
                        labelText: 'Selecciona un lugar',
                        border: OutlineInputBorder(),
                      ),
                      value: selectedLocation,
                      items: locations.map((String location) {
                        return DropdownMenuItem<String>(
                          value: location,
                          child: Text(location),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedLocation = newValue;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (selectedLocation != null) {
                        Navigator.pop(context, selectedLocation);
                      }
                    },
                    child: Text('Confirmar'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
