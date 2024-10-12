import 'package:flutter/material.dart';
import 'package:mathya/Screen_Register/Register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                color: Colors.transparent, // Color de fondo del contenedor
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0), // Ajusta el padding según sea necesario
                    child: ClipOval(
                      child: Container(
                        color: const Color(0xFF7ED957), // Color del círculo
                        width: MediaQuery.of(context).size.height * 0.25, // Usa un porcentaje del alto del contenedor
                        height: MediaQuery.of(context).size.height * 0.25, // Asegúrate de que la altura sea igual al ancho
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 4, 
              child: Container(
                decoration: const BoxDecoration( borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Color(0xFF7ED957),
              ),
                width: double.infinity, 
                
                child: Padding(
                  padding: EdgeInsets.only( left: paddingValue, 
                  top: paddingAlto, right: paddingValue, bottom: paddingAlto),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text( 'Hola',
                          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows:[
                              Shadow(
                                blurRadius: 5.0,
                                color: Colors.black,
                                offset: Offset(2, 2)
                              )
                          ]),
                        ),
                      ),
                      
                      SizedBox(height: screenHeight * 0.04), 

                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: 'Usuario',
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

                      /*
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text( '¿Olvidaste tu contraseña?',
                          style: TextStyle(fontSize: 20,
                            color: Color(0xFF000000),
                            ),
                        ),
                      ),
                      */
                      SizedBox(height: screenHeight * 0.04),

                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _login,
                          child: Text('Iniciar sesión'),
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

                )
              ),
            ),
          ],
        ),
      ),
    );
  }
void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Aquí puedes agregar la lógica para manejar el inicio de sesión
    print('Username: $username');
    print('Password: $password');
  }

}