import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mathya/Screen_Grades/Grades_pages.dart';
import 'package:mathya/Screen_Login/Login.dart';
import 'package:mathya/Screen_Operation/OperationView.dart';
import 'package:mathya/Screen_Operation/home_page.dart';
import 'package:mathya/Screen_Profile/profile_pages.dart';
import 'package:mathya/Screen_PrivacyPolicy/Screen_PrivacyPolicy.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';  // Variable para almacenar el nombre del usuario

  // Lista de imágenes
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
  void initState() {
    super.initState();
    _loadUserName();
  }

  // Función para cargar el nombre de usuario desde SharedPreferences
  _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('nombreUsuario') ?? '';  // Si no existe, se asigna una cadena vacía
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF7CDA54),
      drawer: Drawer(
        backgroundColor: Color(0xFFFFF5DE),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF7CDA54),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
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
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Encabezado con el nombre de usuario y la imagen
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

            // Cuerpo principal con bienvenida y carrusel de operaciones
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'hola ',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          userName,  // Aquí mostramos el nombre del usuario
                          style: const TextStyle(
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

                    // Carrusel de imágenes de operaciones matemáticas
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OperationView(operation: operations[index]),
                              ),
                            );
                          },
                          child: Container(
                            width: screenWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.greenAccent,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(image, fit: BoxFit.cover),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 140),

                    // Botones de acción
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
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
                            );
                          },
                          child: const Text(
                            'Política de Privacidad',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text('2024 - Todos los derechos reservados.'),
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