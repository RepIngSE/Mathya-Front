import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mathya/Screen_Grades/Grades_pages.dart';
import 'package:mathya/Screen_Login/Login.dart';
import 'package:mathya/Screen_Operation/OperationView.dart';
import 'package:mathya/Screen_Operation/home_page.dart';
import 'package:mathya/Screen_Profile/profile_pages.dart';
import 'package:mathya/Screen_PrivacyPolicy/Screen_PrivacyPolicy.dart';


// Pantalla principal de la aplicación
class HomeScreen extends StatelessWidget {
  final List<String> images = [
    'assets/images/Suma.jpg',
    'assets/images/Resta.jpg',
    'assets/images/Multiplicacion.jpg',
    'assets/images/Division.jpg'
  ];

  // Lista de operaciones 
  final List<String> operations = [
    'Suma',
    'Resta',
    'Multiplicación',
    'División'
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF7CDA54),

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
                  leading: Icon(Icons.account_circle, color: Colors.black, size: 30),
                  title: Text('Perfil'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PageProfile()), 
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

      // Contenedor principal con la pantalla de carrusel
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Contenedor verde 
            Container(
              height: screenHeight * 0.20,
              width: screenWidth,
              decoration: const BoxDecoration(
                color: Color(0xFF7CDA54),
              ),
              child: Stack(
                alignment: Alignment.bottomRight, 
                children: [
                  Positioned(
                    bottom: 0, 
                    right: 0, 
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/Home2.png',
                          fit: BoxFit.cover,
                          width: screenWidth * 0.6, 
                          height: screenHeight * 0.18, 
                        ),
                      ),
                    ),
                  ),

                  // botón del menú
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
                ],
              ),
            ),

            // Contenedor piel con redirecciones 
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Color(0xFFFFF5DE),
              ),
              height: screenHeight * 0.85, 
              width: screenWidth,
              child: Padding(
                padding: const EdgeInsets.all(20.0), 
                child: Column(
                  children: [
                    const SizedBox(height: 30), 
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'hola ',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Ana',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '¿Qué quieres aprender hoy?',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 60),

                    // Carrusel de imágenes
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 200.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        enableInfiniteScroll: true,
                        autoPlayInterval: const Duration(seconds: 3),
                      ),
                      items: images.asMap().entries.map((entry) {
                        int index = entry.key;
                        String image = entry.value;
                        return GestureDetector(
                          onTap: () {
                            // Navegación a la pantalla de operación correspondiente
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OperationView(operation: operations[index]),
                              ),
                            );
                          },

                          // Caracteristicas del carrusel de iamgenes 
                          child: Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.greenAccent,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(image, fit: BoxFit.cover),
                                ),
                              );
                            },
                          ),
                        );
                      }).toList(),
                    ),
                    
                    const SizedBox(height: 140),

                    // Contenedor de botones de redes sociales
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.play_circle_filled, size: 50, color: Colors.red),
                          onPressed: () {
                            // Acción al presionar el botón de video
                          },
                        ),
                        const SizedBox(width: 40),
                        IconButton(
                          icon: Icon(Icons.thumb_up, size: 50, color: Colors.blue),
                          onPressed: () {
                            // Acción al presionar el botón de like
                          },
                        ),
                        const SizedBox(width: 40),
                        IconButton(
                          icon: Icon(Icons.copyright, size: 50, color: Colors.black),
                          onPressed: () {
                            // Acción al presionar el botón de derechos
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Políticas de Privacidad
                   // Políticas de Privacidad
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            // Redirige a la página de Políticas de Privacidad
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PrivacyPolicyPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Políticas de Privacidad',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Divider(
                          thickness: 1,
                          color: Colors.black,
                          height: 20,
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Funcionalidad del carrusel de imagenes 
class DetailPage extends StatelessWidget {
  final String image;

  const DetailPage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de la imagen'),
      ),
      body: Center(
        child: Image.asset(image), 
      ),
    );
  }
}