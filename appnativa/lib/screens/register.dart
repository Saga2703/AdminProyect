import 'package:appnativa/settings/custom_scaffold.dart';
import 'package:flutter/material.dart';

// No es necesario importar 'dart:io' y 'dart:typed_data' si no se usan.
// Tampoco se usa LoginScreen aquí, se navega por ruta nombrada.

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formSignupKey = GlobalKey<FormState>();

  // <-- BUENA PRÁCTICA: Agregamos controladores para poder leer los datos
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _githubController = TextEditingController();
  final _phoneController = TextEditingController();
  
  // <-- LÓGICA MEJORADA: El checkbox debería empezar desmarcado
  bool _agreePersonalData = false;
  // <-- UX MEJORADA: Para ocultar/mostrar la contraseña
  bool _isPasswordObscured = true;

  @override
  void dispose() {
    // <-- BUENA PRÁCTICA: Liberar los controladores
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _githubController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // --- Funciones de Validación (con Null Safety corregido) ---

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    // <-- CORRECCIÓN: Usamos '??' para evitar el error si el email es nulo
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Por favor ingresa un email válido';
    }
    return null;
  }

  String? validatePhone(String? phone) {
    RegExp phoneRegex = RegExp(r'^(?:[+0]9)?[0-9]{10}$'); // <-- Ajustado a 10 dígitos comúnmente
    final isPhoneValid = phoneRegex.hasMatch(phone ?? '');
    if (!isPhoneValid) {
      return 'Por favor ingresa un número de teléfono válido';
    }
    return null;
  }
  
  String? hasValidUrl(String? url) {
    // <-- CORRECCIÓN: 'new' es obsoleto y el patrón se puede mejorar
    RegExp regExp = RegExp(
        r'^(?:http|https)://(?:www\.)?github\.com/([a-zA-Z0-9_-]+)/?$',
        caseSensitive: false); // <-- Regex más específico para un perfil de GitHub

    // <-- CORRECCIÓN: Manejo de nulos más seguro y limpio
    if (url == null || url.isEmpty) {
      return 'Por favor ingresa tu URL de GitHub';
    } else if (!regExp.hasMatch(url)) {
      return 'Por favor ingresa una URL de GitHub válida';
    }
    return null;
  }

  String? validatePassword(String? password) {
    // <-- CORRECCIÓN: Lógica simplificada y segura
    if (password == null || password.isEmpty) {
      return 'Por favor ingresa una contraseña';
    }
    RegExp regex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!.,@#\$&*~]).{6,}$');
    if (!regex.hasMatch(password)) {
      return 'Debe tener Mín/Mayús, número, símbolo y 6+ chars.';
    }
    return null;
  }

  // <-- REFACTORIZACIÓN: Función para no repetir el InputDecoration
  InputDecoration _buildInputDecoration(String label, String hint, {Widget? suffixIcon}) {
    return InputDecoration(
      label: Text(label),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black26),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(10),
      ),
      suffixIcon: suffixIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(height: 1),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignupKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // <-- ERROR CRÍTICO CORREGIDO: Todos los campos del formulario deben ir DENTRO de esta lista 'children'
                      Text(
                        'Registro',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                      const SizedBox(height: 40.0),

                      // Nombre completo
                      TextFormField(
                        controller: _fullNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu nombre completo';
                          }
                          return null;
                        },
                        decoration: _buildInputDecoration('Nombre completo', 'Ingresa tu nombre completo'),
                      ),
                      const SizedBox(height: 25.0),

                      // Email
                      TextFormField(
                        controller: _emailController,
                        validator: validateEmail,
                        decoration: _buildInputDecoration('Email', 'Ingresa tu Email'),
                      ),
                      const SizedBox(height: 25.0),

                      // Contraseña
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _isPasswordObscured, // <-- UX MEJORADA
                        validator: validatePassword,
                        decoration: _buildInputDecoration(
                          'Contraseña',
                          'Ingresa tu contraseña',
                          // <-- UX MEJORADA: Icono para mostrar/ocultar contraseña
                          suffixIcon: IconButton(
                            icon: Icon(_isPasswordObscured ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isPasswordObscured = !_isPasswordObscured;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0),

                      // Github
                      TextFormField(
                        controller: _githubController,
                        validator: hasValidUrl,
                        decoration: _buildInputDecoration('GitHub', 'Ingresa tu perfil de GitHub'),
                      ),
                      const SizedBox(height: 25.0),

                      // Teléfono
                      TextFormField(
                        controller: _phoneController,
                        validator: validatePhone,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: _buildInputDecoration('Teléfono', 'Ingresa tu teléfono'),
                      ),
                      const SizedBox(height: 25.0),

                      // Checkbox
                      Row(
                        children: [
                          Checkbox(
                            value: _agreePersonalData,
                            onChanged: (bool? value) {
                              setState(() {
                                // <-- CORRECCIÓN: Manejo de nulo seguro
                                _agreePersonalData = value ?? false;
                              });
                            },
                            activeColor: Colors.deepPurple,
                          ),
                          // <-- Para que el texto se ajuste si no cabe en una línea
                          const Expanded(
                            child: Text.rich(
                              TextSpan(
                                text: 'Acepto el uso de mis ',
                                style: TextStyle(color: Colors.black45),
                                children: [
                                  TextSpan(
                                    text: 'datos personales',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25.0),

                      // Botón de Registrarse
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // <-- MEJORA: Comprobamos nulabilidad antes de validar
                            if (_formSignupKey.currentState?.validate() ?? false) {
                              if (_agreePersonalData) {
                                // Si todo es válido, aquí puedes leer los datos:
                                print('Nombre: ${_fullNameController.text}');
                                print('Email: ${_emailController.text}');

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Procesando datos...')),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Por favor acepta el tratamiento de datos')),
                                );
                              }
                            }
                          },
                          child: const Text('Registrarse'),
                        ),
                      ),
                      const SizedBox(height: 30.0),

                      // Navegación a Login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '¿Ya tienes una cuenta? ',
                            style: TextStyle(color: Colors.black45),
                          ),
                          GestureDetector(
                            onTap: () {
                              // <-- BUENA PRÁCTICA: Usar rutas nombradas
                              Navigator.pushNamed(context, '/login');
                            },
                            child: const Text(
                              'Iniciar Sesión',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ], // <-- FIN DE LA LISTA 'children'
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}