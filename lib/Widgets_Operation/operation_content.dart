import 'package:flutter/material.dart';
import '../widgets_operation/multiple_choice_buttons.dart';
import '../Screen_Grades/Grades_pages.dart';

class OperationContent extends StatefulWidget {
  final String title; // Título de la operación
  final List<String> images; // Lista de imágenes
  final String text; // Texto que se mostrará
  final String questionTitle; // Título de la pregunta (espacio reservado)

  const OperationContent({
    Key? key,
    required this.title,
    required this.images,
    required this.text,
    required this.questionTitle, // Agregar la propiedad para el título de la pregunta
  }) : super(key: key);

  @override
  _OperationContentState createState() => _OperationContentState();
}

class _OperationContentState extends State<OperationContent> {
  bool isFlipped = false; // Estado para saber si está volteado
  int? selectedOption; // Almacena la opción seleccionada

  void _toggleContent() {
    setState(() {
      isFlipped = !isFlipped; // Cambiar el estado al hacer clic
    });
  }

  void _onOptionSelected(int index) {
    setState(() {
      selectedOption = index; // Guardar la opción seleccionada
    });
    print('Opción seleccionada: ${options[index]}'); // Imprime la opción seleccionada
  }

  // Lista de opciones para los botones
  List<String> options = ['Opción 1', 'Opción 2', 'Opción 3', 'Opción 4'];

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      // Añadido para permitir desplazamiento
      child: Container(
        // Contenedor para limitar el ancho
        width: screenWidth, // Ancho completo
        padding: EdgeInsets.all(16.0), // Espaciado
        color: Color(0xFFFFF5DE), // Cambia el color de fondo aquí
        child: Stack(
          // Usamos un Stack para superponer el botón de cerrar
          children: [
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Alinear al centro
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: screenHeight * 0.04,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 216, 106, 106),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _toggleContent,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 470),
                      child: isFlipped
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  widget.text,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                    height:
                                        16), // Espacio entre el texto y la imagen
                              ],
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Image.network(
                                widget.images[0],
                                height: screenHeight * 0.30,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                ),
                // Título y subtítulo fijos
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  child: Column(
                    children: [
                      Text(
                        'Actividad',
                        style: TextStyle(
                          fontSize: screenHeight * 0.035,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 35, 150),
                        ),
                      ),
                      Text(
                        '(3 Ejercicios para responder)',
                        style: TextStyle(
                          fontSize: screenHeight * 0.025,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                // Título de la pregunta (espacio reservado) alineado a la izquierda
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  child: Align(
                    // Alineado a la izquierda
                    alignment:
                        Alignment.centerLeft, // Alineación a la izquierda
                    child: Text(
                      widget
                          .questionTitle, // Aquí se muestra el título de la pregunta
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                // Aquí se agregan los botones de opción múltiple
                MultipleChoiceButtons(
                  options: options,
                  onOptionSelected: _onOptionSelected,
                  correctOptionIndex:
                      1, // Cambia este valor al índice de la opción correcta
                  selectedOptionIndex: selectedOption ??
                      -1, // Si no hay selección, -1 (sin selección)
                ),
                SizedBox(height: screenHeight * 0.02), // Espacio inferior
                Text(
                  'Test',
                  style: TextStyle(
                    fontSize: screenHeight * 0.035,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 35, 150),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 80.0,
                        left: 16.0,
                        right: 16.0,
                        bottom: 16.0), // Espacio superior
                    width: screenWidth * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Centrar verticalmente
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Text(
                            """Ejercicio 1\n"""
                            '''Juanito tiene 3 manzanas y su amigo Pedro le da 2 manzanas más. ¿Cuántas manzanas tiene Juanito ahora?''',
                            style: TextStyle(
                              fontSize: 18, // Tamaño del texto
                              fontWeight: FontWeight.bold, // Estilo del texto
                              color: Colors.black, // Color del texto
                            ),
                            textAlign: TextAlign.start, // Alineación del texto
                          ),
                        ),
                        const SizedBox(
                            height:
                                30), // Espaciado entre el texto y los botones
                        MultipleChoiceButtons(
                          options: options,
                          onOptionSelected: _onOptionSelected,
                          correctOptionIndex: 1, // Índice de la opción correcta
                          selectedOptionIndex: selectedOption ??
                              -1, // Opción seleccionada o -1 si no hay
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Text(
                            """Ejercicio 2\n"""
                            '''María tiene 1 perro y su hermana le regala 3 perros más. ¿Cuántos perros tiene María en total?''',
                            style: TextStyle(
                              fontSize: 18, // Tamaño del texto
                              fontWeight: FontWeight.bold, // Estilo del texto
                              color: Colors.black, // Color del texto
                            ),
                            textAlign: TextAlign.start, // Alineación del texto
                          ),
                        ),
                        const SizedBox(
                            height:
                                30), // Espaciado entre el texto y los botones
                        MultipleChoiceButtons(
                          options: options,
                          onOptionSelected: _onOptionSelected,
                          correctOptionIndex: 1, // Índice de la opción correcta
                          selectedOptionIndex: selectedOption ??
                              -1, // Opción seleccionada o -1 si no hay
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                              top:
                                  20.0), // Cambia 16.0 por el valor que necesites
                          child: Text(
                            """Ejercicio 3\n"""
                            '''En un parque, hay 7 patos en un estanque. Luego, llegan 2 patos más. ¿Cuántos patos hay en total en el estanque?''',
                            style: TextStyle(
                              fontSize: 18, // Tamaño del texto
                              fontWeight: FontWeight.bold, // Estilo del texto
                              color: Colors.black, // Color del texto
                            ),
                            textAlign: TextAlign.start, // Alineación del texto
                          ),
                        ),
                        const SizedBox(
                            height:
                                30), // Espaciado entre el texto y los botones
                        MultipleChoiceButtons(
                          options: options,
                          onOptionSelected: _onOptionSelected,
                          correctOptionIndex: 1, // Índice de la opción correcta
                          selectedOptionIndex: selectedOption ??
                              -1, // Opción seleccionada o -1 si no hay
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 30.0,
                  ), //Espaciado
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageGrades(titulo: widget.title),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Color de fondo
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // Bordes redondeados
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20), // Espaciado
                      textStyle:
                          const TextStyle(fontSize: 20), // Tamaño del texto
                    ),
                    child: const Text('Enviar'),
                  ),
                ),
              ],
            ),
            // Botón de cerrar (X) fijado en la parte superior derecha
            Positioned(
              top: 10, // Ajusta según sea necesario
              left: 10, // Ajusta según sea necesario
              child: IconButton(
                icon: const Icon(Icons.close,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    size: 23), // Icono de cerrar
                onPressed: () {
                  Navigator.of(context).pop(); // Cerrar la ventana
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
