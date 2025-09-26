// lib/screens/login_screen.dart

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  bool isValidating = false;

  @override
  void dispose() {
    _userController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final txtUser = TextFormField(
      controller: _userController,
      decoration: const InputDecoration(
        labelText: 'Correo Electrónico',
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        border: InputBorder.none,
      ),
    );

    final txtPwd = TextFormField(
      controller: _pwdController,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Contraseña',
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        border: InputBorder.none,
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              opacity: .5,
              fit: BoxFit.fill,
              image: AssetImage('assets/goku.jpg'),
            ),
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 100,
                child: Image.asset('assets/db.png', width: 200),
              ),
              Positioned(
                bottom: 150,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 140,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(111, 65, 158, 67),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      txtUser,
                      const Divider(color: Colors.white),
                      txtPwd,
                    ],
                  ),
                ),
              ),
              if (!isValidating)
                Positioned(
                  bottom: 90,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      print('Usuario: ${_userController.text}');
                      print('Contraseña: ${_pwdController.text}');

                      setState(() {
                        isValidating = true;
                      });

                      Future.delayed(const Duration(milliseconds: 3000)).then(
                        (value) {
                          // La lógica de login sigue igual, va al dashboard
                          Navigator.pushReplacementNamed(context, '/dashboard');
                        },
                      );
                    },
                    label: const Text('Validar Usuario'),
                    icon: const Icon(Icons.login),
                  ),
                ),
              
              // <-- CAMBIO PRINCIPAL: Añadimos un enlace para ir al registro
              if (!isValidating) // Lo ocultamos también si está cargando
                Positioned(
                  bottom: 40, // Posicionado más abajo que el botón principal
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "¿No tienes una cuenta? ",
                        style: TextStyle(
                          color: Colors.white, // Color que resalte en el fondo
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navegamos a la pantalla de registro
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text(
                          "Regístrate",
                          style: TextStyle(
                            color: Colors.amber, // Un color llamativo
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline, // Subrayado para que parezca un link
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // Mostramos el GIF de carga en el centro
              if (isValidating)
                const Center(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Image(image: AssetImage('assets/loading.gif')),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}