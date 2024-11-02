import 'package:flutter/material.dart';
import 'package:mathya/Screen_Grades/Grades_pages.dart';
import 'package:mathya/Screen_Home/home.dart';
import 'package:mathya/Screen_Login/Login.dart';
import 'package:mathya/Screen_Operation/home_page.dart';

class PageProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Menú desplegable 
      drawer: Drawer(
        backgroundColor: Color(0xFFFFF5DE),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[

            // Encabezado del menú
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF7CDA54),
              ),

              // Margenes especificas al encabezado de el menu 
              child: Transform.translate(
                offset: const Offset(-8.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.black, size: 30),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Mathya',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Lista de elementos del menu
            Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.home, color: Colors.black, size: 30),
                  title: Text('Inicio'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()), 
                    ); 
                  },
                ),
                ListTile(
                  leading: Icon(Icons.my_library_add, color: Colors.black, size: 30),
                  title: Text('Temáticas'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()), 
                    ); 
                  },
                ),
                ListTile(
                  leading: Icon(Icons.grade, color: Colors.black, size: 30),
                  title: Text('Calificaciones'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PageGrades()), 
                    ); 
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.black, size: 30),
                  title: Text('Cerrar Sesión'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()), 
                    );
                  }
                ),
              ],
            ),
          ],
        ),
      ),
      
      backgroundColor: const Color.fromRGBO(255, 245, 222, 1),
      // botón del menú
      body: Stack(
        children: [
          Positioned(
            top: 15,
            left: 10,
            child: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu, color: Colors.black, size: 30),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente los botones
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.grey.withOpacity(0.5), // Sombra
                          blurRadius: 10.0, // Desenfoque de la sombra
                          offset: const Offset(4.0, 4.0), // Desplazamiento de la sombra
                        ),
                        const Shadow(
                          color: Colors.grey, // Sombra adicional para el efecto lift
                          blurRadius: 3.0,
                          offset: Offset(-2.0, -2.0),
                        ),
                      ],
                    ),
                    children: const [
                      TextSpan(
                        text: 'HOLA ',
                        style: TextStyle(
                          color: Colors.black, // Color negro para "HOLA"
                        ),
                      ),
                      TextSpan(
                        text: 'ANA', // Texto en color personalizado
                        style: TextStyle(
                        color: Colors.redAccent, // Color para "ANA"
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Fields('Usuario'),
                const SizedBox(height: 5),
                Fields('Nombre'),
                const SizedBox(height: 5),
                Fields('Apellido'),
                const SizedBox(height: 5),
                Fields('Edad'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding Fields(String nameField) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: nameField,
          labelStyle: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
            borderSide: const BorderSide(
              color: Colors.grey, // Color del borde al estar enfocado
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
            borderSide: const BorderSide(
              color: Colors.white, // Color del borde cuando está habilitado
              width: 2.0,
            ),
          ),
          filled: true, // Rellenar el fondo
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(20.0),
        ),
      ),
    );
  }
}