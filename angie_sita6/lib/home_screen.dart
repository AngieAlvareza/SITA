import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'location_selection_screen.dart';
import 'results_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _startingPointController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _destinationController.dispose();
    _startingPointController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectLocation(BuildContext context, String type) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationSelectionScreen(type: type),
      ),
    );

    if (result != null) {
      setState(() {
        if (type == 'destination') {
          _destinationController.text = result;
        } else if (type == 'startingPoint') {
          _startingPointController.text = result;
        }
      });
    }
  }

  void _search() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(
          destination: _destinationController.text,
          startingPoint: _startingPointController.text,
          description: _descriptionController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SITA',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey.withOpacity(1),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.grey),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/bus6.jpg',
            fit: BoxFit.cover,
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '¡Inicio de sesión exitoso!',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _destinationController,
                    decoration: InputDecoration(
                      labelText: '¿A dónde quieres ir?',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white70,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.map),
                        onPressed: () => _selectLocation(context, 'destination'),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _startingPointController,
                    decoration: InputDecoration(
                      labelText: 'Punto de inicio',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white70,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.map),
                        onPressed: () => _selectLocation(context, 'startingPoint'),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Descripción',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _search,
                    child: Text('Buscar'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                            (Route<dynamic> route) => false,
                      );
                    },
                    child: Text('Cerrar Sesión'),
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
