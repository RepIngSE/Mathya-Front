import 'package:flutter/material.dart';
import '../widgets_operation/operation_content.dart';

class OperationView extends StatelessWidget {
  final String operation;

  const OperationView({Key? key, required this.operation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text;
    List<String> images;
    String questionTitle; // Variable para el título de la pregunta

    switch (operation) {
      case 'Suma':
        text = 'Aquí va el contenido de la suma.';
        images = [
          'assets/images/Suma.jpg',
        ];
        questionTitle = 'Pregunta sobre Suma'; // Título de la pregunta para suma
        break;
      case 'Resta':
        text = 'Aquí va el contenido de la resta.';
        images = [
          'assets/images/Resta.jpg',
        ];
        questionTitle = 'Pregunta sobre Resta'; // Título de la pregunta para resta
        break;
      case 'Multiplicación':
        text = 'Aquí va el contenido de la multiplicación.';
        images = [
          'assets/images/Multiplicacion.jpg',
        ];
        questionTitle = 'Pregunta sobre Multiplicación'; // Título de la pregunta para multiplicación
        break;
      case 'División':
        text = 'Aquí va el contenido de la división.';
        images = [
          'assets/images/Division.jpg',
        ];
        questionTitle = 'Pregunta sobre División'; // Título de la pregunta para división
        break;
      default:
        text = 'Operación no definida.';
        images = [];
        questionTitle = ''; // Título vacío si la operación no está definida
    }

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: OperationContent(
              title: operation,
              text: text,
              images: images,
              questionTitle: questionTitle, // Pasar el título de la pregunta
            ),
          ),
          // Botón "X" para cerrar la vista
        
        ],
      ),
    );
  }
}