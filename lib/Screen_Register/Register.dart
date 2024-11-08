import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathya/Screen_Login/Login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MathyaOnset extends StatefulWidget {
  const MathyaOnset({super.key});

  @override
  _MathyaOnsetState createState() => _MathyaOnsetState();
}

class _MathyaOnsetState extends State<MathyaOnset> {
  bool _obscurePassword = true;

  // Controladores para capturar los valores de los campos de entrada
  final TextEditingController nombresController = TextEditingController();
  final TextEditingController apellidosController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController edadController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Función asincrónica para enviar los datos al backend
  Future<void> registrarUsuario() async {
    final url = Uri.parse("https://mathya-back-2.onrender.com/register");

    // Datos a enviar en la solicitud
    final body = json.encode({
      "nombre": nombresController.text,
      "apellido": apellidosController.text,
      "correo": correoController.text,
      "edad": int.tryParse(edadController.text) ?? 0,
      "password": passwordController.text,
    });

    try {
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('¡Registro exitoso!')),
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error en el registro. Intenta nuevamente.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en la conexión.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFFFF5DE),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.8,
              width: screenWidth,
              decoration: const BoxDecoration(
                color: Color(0xFF7CDA54),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 70),
                  const Text(
                    'Bienvenido',
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Color.fromARGB(255, 155, 154, 154),
                          offset: Offset(3, 3),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildTextField('Nombres', controller: nombresController),
                  _buildTextField('Apellidos', controller: apellidosController),
                  _buildTextField('Correo', controller: correoController),
                  _buildNumericTextField('Edad', controller: edadController, isNumeric: true),
                  _buildPasswordTextField('Contraseña', controller: passwordController),
                ],
              ),
            ),
            Container(
              height: screenHeight * 0.2,
              width: screenWidth,
              color: Color(0xFFFFF5DE),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: registrarUsuario, // Llama a la función de registro
                        child: const Text(
                          'Registrate',
                          style: TextStyle(fontSize: 20),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: const Text(
                      '¿Ya tienes cuenta?',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Función para crear los text fields de texto
  Widget _buildTextField(String hintText, {required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // Función para crear los text fields numéricos
  Widget _buildNumericTextField(String hintText, {required TextEditingController controller, bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: TextField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        inputFormatters: isNumeric
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ]
            : null,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // Función para crear un campo de texto para la contraseña
  Widget _buildPasswordTextField(String hintText, {required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: TextField(
        controller: controller,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                color: const Color.fromARGB(255, 11, 54, 1),
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
