import 'package:flutter/material.dart';
import 'package:mathya/Screen_Home/home.dart';
import 'package:mathya/Screen_Register/Register.dart';
import 'package:mathya/Screen_ForgotPassword/forgot_password_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double paddingValue = screenWidth * 0.07;
    final double paddingAlto = screenHeight * 0.04;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFFFF5DE),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                color: Colors.transparent,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipOval(
                      child: Container(
                        color: const Color(0xFF7ED957),
                        width: MediaQuery.of(context).size.height * 0.25,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Image.asset(
                          'assets/images/Login.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Color(0xFF7ED957),
                ),
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: paddingValue,
                      top: paddingAlto,
                      right: paddingValue,
                      bottom: paddingAlto),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Hola',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 5.0,
                                color: Colors.black,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: 'Correo electrónico',
                          labelStyle: const TextStyle(color: Colors.grey),
                          floatingLabelStyle: const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Contraseña',
                          labelStyle: const TextStyle(color: Colors.grey),
                          floatingLabelStyle: const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ForgotPasswordPage(),
                              ),
                            );
                          },
                          child: const Text(
                            '¿Olvidaste tu contraseña?',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF000000),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _login,
                          child: _isLoading
                              ? CircularProgressIndicator(color: Colors.black)
                              : Text('Iniciar sesión'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MathyaOnset()),
                          );
                        },
                        child: const Text(
                          '¿No tienes cuenta? Registrate',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Función asincrona para conectar al backend
  Future<void> _login() async {
  setState(() {
    _isLoading = true;
  });

  final String username = _usernameController.text.trim();
  final String password = _passwordController.text.trim();

  if (username.isEmpty || password.isEmpty) {
    setState(() {
      _isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Por favor ingrese el correo y la contraseña')),
    );
    return;
  }

  final url = Uri.parse('https://mathya-back-2.onrender.com/login');

  try {
    final response = await http.post(
      url,
      body: jsonEncode({'correo': username, 'password': password}),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data is Map<String, dynamic> && data.containsKey("nombre")) {
        // Caso cuando la respuesta es un mapa con el nombre
        String nombreUsuario = data["nombre"];
        int idUser = data["id_usuario"];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('nombreUsuario', nombreUsuario);
        await prefs.setInt('idUser', idUser);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else if (data is List && data.isNotEmpty && data[0] is Map<String, dynamic>) {
        // Caso cuando la respuesta es una lista de mapas
        Map<String, dynamic> firstItem = data[0];
        if (firstItem.containsKey("nombre")) {
          String nombreUsuario = firstItem["nombre"];
          int idUser = firstItem["id_usuario"];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('nombreUsuario', nombreUsuario);
          await prefs.setInt('idUser', idUser);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('El primer elemento de la lista no contiene el nombre')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Estructura de respuesta inesperada del servidor')),
        );
      }
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credenciales incorrectas')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error en el servidor')),
      );
    }
  } catch (e) {
    setState(() {
      _isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}}