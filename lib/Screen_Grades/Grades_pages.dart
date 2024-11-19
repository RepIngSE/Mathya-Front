import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mathya/Screen_Home/home.dart';
import 'package:mathya/Screen_Login/Login.dart';
import 'package:mathya/Screen_Operation/home_page.dart';
import 'package:mathya/Screen_Profile/profile_pages.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PageGrades extends StatefulWidget {

  final String titulo;

  PageGrades({this.titulo = ''});

  @override
  _PageGrade createState() => _PageGrade();
}


class _PageGrade extends State<PageGrades> {
  int userId = 0;
  final int maxEvaluaciones = 1;
  int completedModulSuma = 0;
  int completedModulResta = 0;
  int completedModulMulti = 0;
  int completedModulDivision = 0;
  double progress = 0.0;

  // Variables para almacenar las evaluaciones realizadas
  int evaluationsSuma = 0;
  int evaluationsResta = 0;
  int evaluationsMultiplicacion = 0;
  int evaluationsDivision = 0;

  int sumaCount = 0;
  int restaCount = 0;
  int multiCount = 0;
  int divisionCount = 0;

  void  initState(){
    super.initState();
    //_updateProgress();
    _fetchResults();
  }

   // Función para obtener los resultados desde la API
  Future<void> _fetchResults() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() { 
      userId = prefs.getInt('idUser') ?? 0;  // Recupera el ID del usuario de SharedPreferences
    }); // ID del usuario
    
    final response = await http.get(Uri.parse('https://mathya-back-2.onrender.com/resultados/usuarios/$userId'));

    if (response.statusCode == 200) {
      List<dynamic> results = json.decode(response.body);
      _processResults(results);
    } else {
      print("Error al obtener los resultados");
    }
  }


  // Procesar los resultados obtenidos
  void _processResults(List<dynamic> results) {
    

    for (var result in results) {
      int puntaje = result['puntaje'];
      int idModulo = result['id_modulo'];

      if (puntaje >= 80) {
        // Aumentamos el contador solo si el puntaje es 80 o mayor
        if (idModulo == 1) sumaCount++; // Suma
        if (idModulo == 2) restaCount++; // Resta
        if (idModulo == 3) multiCount++; // Multiplicación
        if (idModulo == 4) divisionCount++; // División
      }
    }

    setState(() {
      if (sumaCount >= 1 ){
        completedModulSuma = 1;
      }
      if (restaCount >= 1 ){
        completedModulResta = 1;
      }
      if (multiCount >= 1 ){
        completedModulMulti = 1;
      }
      if (divisionCount >= 1 ){
        completedModulDivision = 1;
      }


      evaluationsSuma = results.where((r) => r['id_modulo'] == 1).length;
      evaluationsResta = results.where((r) => r['id_modulo'] == 2).length;
      evaluationsMultiplicacion = results.where((r) => r['id_modulo'] == 3).length;
      evaluationsDivision = results.where((r) => r['id_modulo'] == 4).length;

      progress = _calculateProgress();
    });
  }

  // Calcular el progreso total
  double _calculateProgress() {
    int totalAprobadas = completedModulSuma + completedModulResta + completedModulMulti + completedModulDivision;
    return totalAprobadas / (maxEvaluaciones * 4); // maxEvaluaciones es 4 y hay 4 módulos
  }

  // Función para mostrar los resultados de cada operación
  Widget inputs(String operation, int valor, int evaluaciones) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = MediaQuery.of(context).size.width;
        double buttonWidth = screenWidth * 0.8;

        return Center(
          child: Container(
            width: buttonWidth,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  operation,
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  '$valor',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        );
      },
    );
  } 

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
      body: Stack(
        children: [
          // Título grande
          Positioned(
            top: 80, 
            left: 130,
            child: Text(
              'Matemáticas',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.03,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 0, 0, 0),
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
                icon: const Icon(Icons.menu, color: Colors.black, size: 30),
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // Abre el Drawer
                },
              ),
            ),
          ),

          // Contenido principal con progreso y botones
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente los botones
              children: [
                const SizedBox(height: 150),
                Stack(
                  alignment: Alignment.center, // Centrar el contenido del Stack
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      child: CircularProgressIndicator(
                        value: progress, // Progreso actual
                        valueColor: const AlwaysStoppedAnimation<Color>(Color.fromRGBO(57, 181, 74, 1)),
                        strokeWidth: 20.0, // Grosor de la barra
                        backgroundColor: const Color.fromRGBO(126, 217, 87, 1), // Color de fondo del indicador
                      ),
                    ),
                    Text(
                      '${(progress * 100).round()}%', // Mostrar porcentaje
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                Expanded(
                  child: Container(
                    height: 5,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(126, 217, 87, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        inputs('Suma', sumaCount, evaluationsSuma),
                        const SizedBox(height: 15),
                        inputs('Resta', restaCount, evaluationsResta),
                        const SizedBox(height: 15),
                        inputs('Multiplicación', multiCount, evaluationsMultiplicacion),
                        const SizedBox(height: 15),
                        inputs('División', divisionCount, evaluationsDivision),
                                
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}