import 'package:flutter/material.dart';
import 'package:mathya/Screen_Home/home.dart';
import 'package:mathya/Screen_Login/Login.dart';
import 'package:mathya/Screen_Operation/home_page.dart';
import 'package:mathya/Screen_Profile/profile_pages.dart';

class PageGrades extends StatefulWidget {
  //static final GlobalKey<_PageGrade> gradesKey = GlobalKey<_PageGrade>();
  final String titulo;
  //const PageGrades({Key? key}) : super(key: key);
  //PageGrades({super.key});
  PageGrades({this.titulo = ''});

  @override
  _PageGrade createState() => _PageGrade();
}


class _PageGrade extends State<PageGrades> {
  final int totalThemes = 4; // Total de temas
  final int modulesPerTheme = 4; // Módulos por tema // Total de módulos
  int completedModulSuma = 0; // Módul suma completados
  int completedModulResta = 0; // Módul resta completados
  int completedModulDivision = 0; // Módul division completados
  int completedModulMulti = 0; // Módul multiplicacion completados
  double progress = 0.0;
  void  initState(){
    super.initState();
    _updateProgress();
  }

  void _updateProgress() {
    // Aquí se implementa la lógica para actualizar el progreso según el avance del usuario
    // Por ejemplo, puedes llamar a este método cada vez que el usuario complete una parte de la evaluación
    if (widget.titulo == 'Suma'){
      setState(() {
        if (completedModulSuma < modulesPerTheme) {
          completedModulSuma++; // Incrementar módulos completados
          progress = completedModulSuma / (totalThemes * modulesPerTheme); // Calcular progreso
        }
        // Aumentar el progreso por un 10% por cada evaluación completada
      });
    }
    if (widget.titulo == 'Resta'){
      setState(() {
        if (completedModulResta < modulesPerTheme) {
          completedModulResta++; // Incrementar módulos completados
          progress = completedModulResta / (totalThemes * modulesPerTheme); // Calcular progreso
        }
        // Aumentar el progreso por un 10% por cada evaluación completada
      });
    }
    if (widget.titulo == 'División'){
      setState(() {
        if (completedModulDivision < modulesPerTheme) {
          completedModulDivision++; // Incrementar módulos completados
          progress = completedModulDivision / (totalThemes * modulesPerTheme); // Calcular progreso
        }
        // Aumentar el progreso por un 10% por cada evaluación completada
      });
    }
    if (widget.titulo == 'Multiplicación'){
      setState(() {
        if (completedModulMulti < modulesPerTheme) {
          completedModulMulti++; // Incrementar módulos completados
          progress = completedModulMulti / (totalThemes * modulesPerTheme); // Calcular progreso
        }
        // Aumentar el progreso por un 10% por cada evaluación completada
      });
    }
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
            top: 80, // Ajusta la posición vertical según lo necesites
            left: 130, // Ajusta la posición horizontal para que no esté centrado
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
                        inputs('Suma', completedModulSuma),
                        const SizedBox(height: 15),
                        inputs('Resta', completedModulResta),
                        const SizedBox(height: 15),
                        inputs('Multiplicación', completedModulMulti),
                        const SizedBox(height: 15),
                        inputs('División', completedModulDivision),
                        
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

  Widget inputs(String operation, int valor) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Usamos MediaQuery para obtener el ancho de la pantalla
        double screenWidth = MediaQuery.of(context).size.width;
        
        // Ajusta el ancho del botón a un porcentaje del ancho de la pantalla
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
                  operation, // Nombre de la operación
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  '$valor/4',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}