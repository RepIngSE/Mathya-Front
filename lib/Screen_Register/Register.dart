// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathya/Screen_Login/Login.dart';

class MathyaOnset extends StatefulWidget {
  const MathyaOnset({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MathyaOnsetState createState() => _MathyaOnsetState();
}

class _MathyaOnsetState extends State<MathyaOnset> {

  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context){
    // Obtener el tamaño total de la pantalla
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: Color(0xFFFFF5DE),
      body:SingleChildScrollView(
        child: Column (
          children: [

            // Creación del componenete de color verde con los campos necesarios dentro de el
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
                // Creación del titulo de la pantalla ("Bienvenido")

                children: [
                  SizedBox(height: 70), 
                  const Text(
                    'Bienvenido',
                    style: TextStyle(
                      fontSize: 45, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.white,

                      // Efecto de sombra para el titulo
                      shadows:[
                        Shadow(
                          blurRadius: 5.0,
                          color: Color.fromARGB(255, 155, 154, 154),
                          offset: Offset(3, 3)
                        )
                      ]
                    ), 
                  ),

                  // Creación de los text Field para el registro 
                  const SizedBox(height: 30),
                  _buildTextField('Nombres'),
                  _buildTextField('Apellidos'),
                  _buildTextField('Usuario'),
                  _buildNumericTextField('Edad', isNumeric: true),
                  _buildPasswordTextField('Contraseña'),
                ],
              )
            ),

            // Creación de contenedor piel 
            Container(
              height: screenHeight * 0.2,
              width: screenWidth,
              color: Color(0xFFFFF5DE),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Botón Registrarse
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Mostrar mensaje de registro exitoso
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                '¡Registro exitoso!',
                                style: TextStyle(color: Colors.white), 
                              ),
                              backgroundColor: Colors.green, 
                              duration: const Duration(seconds: 3), 
                            ),
                          );

                          // Esperar un tiempo antes de redirigir al login
                          Future.delayed(const Duration(seconds: 3), () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()), 
                            );
                          });
                        },
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
          ]
        ),
      ),
    );
  }

// Función para crear los text fields de Texto 
Widget _buildTextField(String hintText, {bool isPassword = false}){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    child: TextField(
      obscureText: isPassword,
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

 // Función para crear los text fields numericos 
Widget _buildNumericTextField(String hintText, {bool isPassword = false, bool isNumeric = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    child: TextField(
      obscureText: isPassword,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      inputFormatters: isNumeric ? <TextInputFormatter>[
        // Permite solo el digito de números 
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(2),
      ] : null,
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
  Widget _buildPasswordTextField(String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: TextField(
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),

          // Carcteristicas del icono para ver u ocultar contraseña 
          suffixIcon: Padding( 
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                color: const Color.fromARGB(255, 11, 54, 1),
              ),
              onPressed: () {

                // Cambia el estado de la visibilidad de la contraseña
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




