import 'package:flutter/material.dart';
import 'package:mathya/Screen_Grades/Grades_pages.dart';
import 'package:mathya/Screen_Home/home.dart';
import 'package:mathya/Screen_Login/Login.dart';
import '../widgets_operation/operation_button.dart';
import './OperationView.dart'; // Importar la vista de operación

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _navigateToOperation(BuildContext context, String operation) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OperationView(operation: operation)),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

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
              // Márgenes específicos al encabezado del menú 
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

            // Lista de elementos del menú
            Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.account_circle, color: Colors.black, size: 30),
                  title: Text('Perfil'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PageGrades()), 
                    ); 
                  },
                ),
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
      body: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF7ED957), // Color de fondo
        ),
        child: Stack( // Usar Stack para superponer los widgets
          children: [
            // Título grande
            Positioned(
              top: 70, // Ajusta la posición vertical según lo necesites
              left: 120, // Ajusta la posición horizontal para que no esté centrado
              child: Text(
                'Actividades',
                style: TextStyle(
                  fontSize: screenHeight * 0.04,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Roboto',
                ),
              ),
            ),

            // Botón del menú
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

            // Botones largos uno debajo del otro
            Positioned(
              top: 200, // Ajusta la posición para que no se superponga con el título
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OperationButton(
                      label: 'Suma',
                      onPressed: () => _navigateToOperation(context, 'Suma'),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    OperationButton(
                      label: 'Resta',
                      onPressed: () => _navigateToOperation(context, 'Resta'),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    OperationButton(
                      label: 'Multiplicación',
                      onPressed: () => _navigateToOperation(context, 'Multiplicación'),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    OperationButton(
                      label: 'División',
                      onPressed: () => _navigateToOperation(context, 'División'),
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
