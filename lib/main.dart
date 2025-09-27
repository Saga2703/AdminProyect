import 'package:appnativa/screens/login.dart';
import 'package:appnativa/screens/login2.dart';
import 'package:appnativa/screens/register.dart';
import 'package:appnativa/screens/welcomeScreen.dart';
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
      debugShowCheckedModeBanner: false,

      // Cambia la ruta inicial aquí
      initialRoute: '/welcomeScreen',

      // Define las rutas de la aplicación, incluyendo '/welcomeScreen'
      routes: {
        '/welcomeScreen': (context) => const WelcomeScreen(),
        '/register': (context) => const RegisterScreen(),
        '/login': (context) => const LoginScreen2(),
      },
    );
  }
}
