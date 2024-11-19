import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/question.dart';
import '../services/question_service.dart';
import '../Widgets_Operation/multiple_choice_buttons.dart';

class OperationContent extends StatefulWidget {
  final String title;
  final String text;
  final List<String> images;

  const OperationContent({
    Key? key,
    required this.title,
    required this.text,
    required this.images,
  }) : super(key: key);

  @override
  _OperationContentState createState() => _OperationContentState();
}

class _OperationContentState extends State<OperationContent> {
  List<Question> questions = [];
  int currentIndex = 0;
  List<int?> selectedOptions = [];
  bool isSubmitted = false;
  int userId=0;

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
    _getUserId();
  }

  // Método para obtener el ID del usuario desde SharedPreferences
  Future<void> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('idUser') ?? 0;
    });
  }

  Future<void> _fetchQuestions() async {
    try {
      int moduleId = getModuleIdBasedOnTitle(widget.title);
      List<Question> fetchedQuestions =
          await QuestionService.fetchQuestions(moduleId);

      // Seleccionar 5 preguntas al azar
      questions = (fetchedQuestions.toList()..shuffle()).take(5).toList();

      // Reordenar las opciones de cada pregunta
      for (var question in questions) {
        question.opciones.shuffle(); // Barajar las opciones de cada pregunta
      }

      // Inicializar la lista de respuestas seleccionadas
      selectedOptions = List.filled(questions.length, null);

      setState(() {}); // Refrescar el estado después de obtener las preguntas
    } catch (e) {
      print("Error fetching questions: $e");
    }
  }

  int getModuleIdBasedOnTitle(String title) {
    switch (title) {
      case 'Suma':
        return 1;
      case 'Resta':
        return 2;
      case 'Multiplicación':
        return 3;
      case 'División':
        return 4;
      default:
        return 0;
    }
  }

  void _onOptionSelected(int index, int questionIndex) {
    if (!isSubmitted) {
      setState(() {
        selectedOptions[questionIndex] = index;
      });
    }
  }

  Future<void> _submitAnswers() async {
  setState(() {
    isSubmitted = true; // Marcar como enviado
  });

  // Calcular el número de respuestas correctas
  int correctAnswers = 0;
  for (int i = 0; i < questions.length; i++) {
    if (selectedOptions[i] != null &&
        questions[i].opciones[selectedOptions[i]!] ==
            questions[i].respuestaCorrecta) {
      correctAnswers++;
    }
  }

  // Calcular el puntaje
  double puntaje = (correctAnswers / questions.length) * 100;

  // Aquí puedes definir el ID del módulo
  int idModulo = getModuleIdBasedOnTitle(widget.title);

  // Guardar los resultados
  await registrarResultado(userId, idModulo, correctAnswers, puntaje);

  // Mostrar el diálogo de resultados
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Resultados del Test'),
        content: Text(
          'Respuestas correctas: $correctAnswers de ${questions.length} - Puntaje: ${puntaje.toStringAsFixed(2)}%',
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Aceptar'),
          ),
        ],
      );
    },
  );
}

Future<void> registrarResultado(int idUsuario, int idModulo, int respuestasCorrectas, double puntaje) async {
  final url = Uri.parse('https://mathya-back-2.onrender.com/resultados/');

  // Crea el cuerpo de la solicitud
  final body = json.encode({
    'id_usuario': idUsuario,
    'id_modulo': idModulo,
    'id_pregunta': 1,
    'puntaje': puntaje,
  });

  // Realiza la solicitud POST
  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 201) {
      print('Resultado guardado correctamente');
    } else {
      print('Error al guardar los resultados: ${response.statusCode}');
    }
  } catch (e) {
    print('Error de conexión: $e');
  }
}

@override
Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    if (questions.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Container(
        width: screenWidth,
        padding: const EdgeInsets.all(16.0),
        color: Color(0xFFFFF5DE), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: screenHeight * 0.04,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];
                return Card(
                  color: Color(0xFF7ED957),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question.pregunta,
                          style: TextStyle(
                            fontSize: screenHeight * 0.025,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        MultipleChoiceButtons(
                          options: question.opciones,
                          onOptionSelected: (selectedIndex) {
                            _onOptionSelected(selectedIndex, index);
                          },
                          selectedOptionIndex: selectedOptions[index] ?? -1,
                          correctOptionIndex: question.opciones
                              .indexOf(question.respuestaCorrecta),
                          isSubmitted: isSubmitted,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: isSubmitted ? null : _submitAnswers,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF7ED957),
                  foregroundColor: Color.fromARGB(255, 255, 255, 255),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text(
                  'Enviar Respuestas',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
