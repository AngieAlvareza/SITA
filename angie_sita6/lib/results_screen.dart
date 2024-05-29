import 'package:flutter/material.dart';
import 'dart:math';

// Función para calcular la distancia utilizando la fórmula de Haversine
double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double R = 6371; // Radio de la tierra en km
  final double dLat = (lat2 - lat1) * pi / 180;
  final double dLon = (lon2 - lon1) * pi / 180;
  final double a =
      sin(dLat / 2) * sin(dLat / 2) +
          cos(lat1 * pi / 180) * cos(lat2 * pi / 180) *
              sin(dLon / 2) * sin(dLon / 2);
  final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return R * c; // Distancia en km
}

// Función para estimar el tiempo de viaje
double estimateTravelTime(double distance) {
  const double averageSpeed = 30; // km/h
  return distance / averageSpeed; // tiempo en horas
}

const Map<String, List<double>> locationsCoordinates = {
  "Alto Selva Alegre": [-16.3869, -71.5196],
  "Arequipa": [-16.4090, -71.5375],
  "Cayma": [-16.3726, -71.5476],
  "Cerro Colorado": [-16.3539, -71.5625],
  "Characato": [-16.4744, -71.4896],
  "Chiguata": [-16.4633, -71.4067],
  "Jacobo Hunter": [-16.4378, -71.5561],
  "José Luis Bustamante y Rivero": [-16.4291, -71.5298],
  "La Joya": [-16.4892, -71.7333],
  "Mariano Melgar": [-16.4054, -71.5112],
  "Miraflores": [-16.3967, -71.5208],
  "Mollebaya": [-16.5289, -71.4433],
  "Paucarpata": [-16.4160, -71.4824],
  "Pocsi": [-16.5558, -71.4642],
  "Polobaya": [-16.5931, -71.4589],
  "Quequeña": [-16.5033, -71.4575],
  "Sabandía": [-16.4544, -71.4833],
  "Sachaca": [-16.4247, -71.5694],
  "San Juan de Siguas": [-16.2936, -72.0078],
  "San Juan de Tarucani": [-16.4519, -71.2047],
  "Santa Isabel de Siguas": [-16.3806, -72.0311],
  "Santa Rita de Siguas": [-16.3372, -72.0525],
  "Socabaya": [-16.4439, -71.5417],
  "Tiabaya": [-16.4547, -71.5889],
  "Uchumayo": [-16.4192, -71.6064],
  "Vitor": [-16.3800, -71.7231],
  "Yanahuara": [-16.3928, -71.5367],
  "Yarabamba": [-16.5450, -71.5139],
  "Yura": [-16.3006, -71.6675]
};

// Lista de empresas de buses
const List<String> busCompanies = [
  "C3 TransCayma",
  "C7 AqpMasivo",
  "C9 3 de Octubre",
  "C4 Unión AQP",
  "C10 MegaBus",
  "C2 Cerro Colorado",
  "C9- Correcaminos",
  "C11 COTUM",
  "C5 Mariano Melgar",
  "C6 Miguel Grau"
];

class ResultsScreen extends StatelessWidget {
  final String destination;
  final String startingPoint;
  final String description;

  ResultsScreen({
    required this.destination,
    required this.startingPoint,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    // Obtener coordenadas de las ubicaciones
    final startCoords = locationsCoordinates[startingPoint]!;
    final destCoords = locationsCoordinates[destination]!;

    // Calcular la distancia
    final distancia = calculateDistance(
      startCoords[0],
      startCoords[1],
      destCoords[0],
      destCoords[1],
    ).toStringAsFixed(2);

    // Estimar el tiempo de viaje
    final double travelTimeHours = estimateTravelTime(double.parse(distancia));
    final int travelTimeMinutes = (travelTimeHours * 60).round();

    // Seleccionar aleatoriamente una empresa de buses
    final random = Random();
    final String busCompany = busCompanies[random.nextInt(busCompanies.length)];

    // Simulando otros datos para mostrar
    final String horarioSalida = "08:00 AM";

    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados del viaje'),
        backgroundColor: Colors.blueGrey.withOpacity(1),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/bus6.jpg', // Asegúrate de que esta ruta sea correcta
            fit: BoxFit.cover,
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Distancia entre los puntos: $distancia km',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Ruta a tomar: ${busCompany}',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Horario de salida del transporte: $horarioSalida',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Tiempo estimado del viaje: $travelTimeMinutes minutos',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Regresar'),
                    ),
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
