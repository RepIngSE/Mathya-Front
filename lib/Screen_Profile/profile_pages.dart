import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mathya/Screen_Grades/Grades_pages.dart';
import 'package:mathya/Screen_Home/home.dart';
import 'package:mathya/Screen_Login/Login.dart';
import 'package:mathya/Screen_Operation/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PageProfile extends StatefulWidget {
  @override
  _PageProfileState createState() => _PageProfileState();
}

class _PageProfileState extends State<PageProfile> {
  int userId = 0;
  String userName = ''; 
  String userLastName = '';  // Variable para el apellido
  int userAge = 0;       // Variable para la edad
  String userEmail = ''; // Variable para el correo electrónico
  final TextEditingController _userNameController = TextEditingController();     
  final TextEditingController _userLastNameController = TextEditingController();     
  final TextEditingController _userEmailController = TextEditingController();     
  final TextEditingController _userAgeController = TextEditingController();     

  bool _isEmailEdited = false;  // Flag para verificar si el correo ha cambiado

  @override
  void initState() {
    super.initState();
    _loadUserData();  // Llama a la función para cargar el nombre del usuario al iniciar el widget
  }
  // Función para cargar los datos del usuario desde la API
  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() { 
      userId = prefs.getInt('idUser') ?? 0;  // Recupera el ID del usuario de SharedPreferences
    });
    // Realiza la solicitud HTTP para obtener los datos del usuario
    final response = await http.get(Uri.parse('https://mathya-back-2.onrender.com/getUser/$userId'));
    if (response.statusCode == 200) {
      // Si la respuesta es exitosa (status 200), parseamos el JSON
      var data = json.decode(response.body);
      var dataInfo = data[0];
      String name = dataInfo['nombre'];
      String lastName = dataInfo['apellido'];
      String eMail = dataInfo['correo'];
      int age = dataInfo['edad'];
      setState(() {
        userName = name;
        _userNameController.text = userName;
        userLastName = lastName;
        _userLastNameController.text = userLastName; 
        userEmail = eMail;
        _userEmailController.text = userEmail; 
        userAge = age;
        _userAgeController.text = userAge.toString(); 
        }
      );
    
    } else {
      // Si no es exitoso, maneja el error
      print('Error al obtener los datos del usuario: ${response.statusCode}');
    }
  }

  // Función para verificar si el correo ha cambiado
  void _onEmailChanged(String newEmail) {
    setState(() {
      _isEmailEdited = newEmail != userEmail;
    });
  }

  // Función para actualizar el correo en la base de datos
  Future<void> _updateEmail() async {
    String email = _userEmailController.text; 
    final response = await http.put(Uri.parse('https://mathya-back-2.onrender.com/getUser/$userId/$email'));
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('¡Actualización exitosa!')),
        );
      setState(() {
        userEmail = _userEmailController.text;
        _isEmailEdited = false;  // Resetear el flag de edición
      });
    
    } else {
      // Si no es exitoso, maneja el error
      print('Error al actualizar los datos del usuario: ${response.statusCode}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Color(0xFFFFF5DE),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF7CDA54),
              ),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 10.0,
                          offset: const Offset(4.0, 4.0),
                        ),
                        const Shadow(
                          color: Colors.grey,
                          blurRadius: 3.0,
                          offset: Offset(-2.0, -2.0),
                        ),
                      ],
                    ),
                    children: [
                      const TextSpan(
                        text: 'Hola  ',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: userName, // Muestra el nombre de usuario
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                buildTextField(_userEmailController,"Correo", readOnly: false, icon: Icons.edit, onChanged: _onEmailChanged),
                const SizedBox(height: 5),
                buildTextField(_userNameController,"Nombre", readOnly: true, icon: null),
                const SizedBox(height: 5),
                buildTextField(_userLastNameController,"Apellido", readOnly: true, icon: null),
                const SizedBox(height: 5),
                buildTextField(_userAgeController,"Age", readOnly: true, icon: null),

                // Botón de actualización solo si el correo ha cambiado
                if (_isEmailEdited)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: _updateEmail,
                      child: Text("Actualizar Correo"),
                      style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7ED957),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            
                      )
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

 Widget buildTextField(TextEditingController controller, String label, {bool readOnly = false, IconData? icon, ValueChanged<String>? onChanged}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        readOnly: readOnly, 
        controller: controller,// Solo lectura o editable
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(20.0),
          suffixIcon: icon != null
              ? Icon(
                  icon,
                  color: Colors.grey[600],
                )
              : null, // Si hay ícono, se muestra, si no, se muestra null
        ),
        onChanged: onChanged,  // Solo se activa si hay un onChanged
      ),
    );
  }
}
