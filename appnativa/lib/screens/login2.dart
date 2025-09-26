import 'package:flutter/material.dart';

// Reutilizamos la misma paleta de colores para mantener la consistencia
const Color kDarkGreen = Color(0xFF0A5C48);
const Color kLightGreen = Color(0xFFC4E4C6);
const Color kBackgroundGreen = Color(0xFFF0F7F1);
const Color kGreyText = Color(0xFFB0D0B2);

class LoginScreen2 extends StatefulWidget {
  const LoginScreen2({super.key});

  @override
  State<LoginScreen2> createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {
  final _formLoginKey = GlobalKey<FormState>();

  // Controladores para los campos de inicio de sesión
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordObscured = true;

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Función reutilizada para decorar los campos de texto
  InputDecoration _buildInputDecoration({
    required String hintText,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: kDarkGreen.withOpacity(0.6)),
      filled: true,
      fillColor: kLightGreen,
      contentPadding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide.none,
      ),
      suffixIcon: suffixIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundGreen,
      body: SafeArea(
        child: Column(
          children: [
            // --- SECCIÓN SUPERIOR PERSONALIZADA (con orden invertido) ---
            _buildTopBar(),

            // --- SECCIÓN DEL FORMULARIO ---
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                decoration: const BoxDecoration(
                  color: kDarkGreen,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formLoginKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40.0),
                        const Text(
                          'Inicia\nsesion',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Inicia sesion para continuar',
                          style: TextStyle(color: kGreyText, fontSize: 16),
                        ),
                        const SizedBox(height: 40.0),

                        // Campo Nombre
                        const Text('NOMBRE', style: TextStyle(color: kGreyText, letterSpacing: 1.2)),
                        const SizedBox(height: 8.0),
                        TextFormField(
                          controller: _nameController,
                          style: const TextStyle(color: kDarkGreen, fontWeight: FontWeight.bold),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa tu nombre';
                            }
                            return null;
                          },
                          decoration: _buildInputDecoration(hintText: 'Anahi Ramirez'),
                        ),
                        const SizedBox(height: 25.0),
                        
                        // Campo Contraseña
                        const Text('CONTRASEÑA', style: TextStyle(color: kGreyText, letterSpacing: 1.2)),
                        const SizedBox(height: 8.0),
                        TextFormField(
                          controller: _passwordController,
                          style: const TextStyle(color: kDarkGreen, fontWeight: FontWeight.bold),
                          obscureText: _isPasswordObscured,
                          validator: (value) {
                             if (value == null || value.isEmpty) {
                              return 'Por favor ingresa tu contraseña';
                            }
                            return null;
                          },
                          decoration: _buildInputDecoration(
                            hintText: '******',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordObscured ? Icons.visibility : Icons.visibility_off,
                                color: kDarkGreen.withOpacity(0.6),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordObscured = !_isPasswordObscured;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 40.0),

                        // Botón de Iniciar Sesión
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formLoginKey.currentState?.validate() ?? false) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Iniciando sesión...')),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kLightGreen,
                              foregroundColor: kDarkGreen,
                              padding: const EdgeInsets.symmetric(vertical: 18.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            child: const Text(
                              'Iniciar sesion',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30.0),

                        // Enlace para ir a la pantalla de Registro
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                             onTap: () {
                                // Navegar a la pantalla de registro (asegúrate de tener una ruta llamada '/register')
                                Navigator.pushNamed(context, '/register');
                             },
                            child: const Text.rich(
                              TextSpan(
                                text: '¿No tienes una cuenta? ',
                                style: TextStyle(color: kGreyText),
                                children: [
                                  TextSpan(
                                    text: 'Registrate aqui',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kLightGreen,
                                      decoration: TextDecoration.underline,
                                      decorationColor: kLightGreen,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                         const SizedBox(height: 30.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para construir la barra superior (con el orden de los elementos cambiado)
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu, color: kDarkGreen, size: 30),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: kDarkGreen,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Hola!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                // Reemplaza esto con tu logo
                Image.asset('assets/2.png', height: 24, width: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}