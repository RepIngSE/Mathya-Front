import 'package:flutter/material.dart';
import 'Screen_Login/login.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Elimina el banner de depuración
      debugShowCheckedModeBanner: false, 

      // LoginPage será la pantalla principal al iniciar la app

      home: Login(), 
    );
  }
}
