// lib/main.dart



// 1. IMPORTA AQUÍ TODAS TUS PANTALLAS
import 'package:appnativa/screens/login.dart';
import 'package:appnativa/screens/login2.dart';
import 'package:appnativa/screens/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nativa',
      debugShowCheckedModeBanner: false, // Quita la cinta de "Debug"

      // 2. DEFINE LA RUTA INICIAL
      // Esta es la pantalla que se mostrará al abrir la app.
      initialRoute: '/inicio',

      // 3. DEFINE TODAS LAS RUTAS DE TU APLICACIÓN
      // Es como un mapa que le dice a Flutter:
      // Cuando te pida la ruta '/', construye el widget HomeScreen.
      // Cuando te pida la ruta '/details', construye el widget DetailsScreen.
      routes: {
        '/inicio': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/login': (context) => const LoginScreen2(), // <-- Agrega aquí tu tercera pantalla
      },
    );
  }
}