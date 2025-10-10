import 'package:flutter/material.dart';

// Paleta de colores
const Color kDarkGreen = Color(0xFF0A5C48);
const Color kLightGreen = Color(0xFFC4E4C6);
const Color kBackgroundGreen = Color(0xFFF0F7F1);

class PlantInfoScreen extends StatelessWidget {
  final String plantName;
  final String scientificName;
  final String description;
  final String watering;
  final String sunlight;
  final String temperature;
  final String imagePath; // Ruta o URL de imagen

  const PlantInfoScreen({
    super.key,
    required this.plantName,
    required this.scientificName,
    required this.description,
    required this.watering,
    required this.sunlight,
    required this.temperature,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundGreen,
      appBar: AppBar(
        title: const Text("Información de la Planta"),
        backgroundColor: kDarkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen de la planta
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                imagePath,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // Nombre de la planta
            Text(
              plantName,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: kDarkGreen,
              ),
            ),
            const SizedBox(height: 5),

            Text(
              scientificName,
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),

            // Descripción
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Text(
                description,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 16,
                  color: kDarkGreen,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Información detallada
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _infoCard(Icons.wb_sunny, "Luz", sunlight),
                _infoCard(Icons.opacity, "Riego", watering),
                _infoCard(Icons.thermostat, "Temperatura", temperature),
              ],
            ),

            const SizedBox(height: 40),

            // Botón para volver o guardar
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text("Volver"),
              style: ElevatedButton.styleFrom(
                backgroundColor: kDarkGreen,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para tarjetas pequeñas de información
  Widget _infoCard(IconData icon, String title, String value) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kLightGreen,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(icon, color: kDarkGreen, size: 30),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: kDarkGreen,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: kDarkGreen,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
