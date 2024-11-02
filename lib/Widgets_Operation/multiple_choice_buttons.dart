import 'package:flutter/material.dart';

class MultipleChoiceButtons extends StatefulWidget {
  final List<String> options; // Lista de opciones
  final ValueChanged<int> onOptionSelected; // Callback para cuando se selecciona una opción
  final int correctOptionIndex; // Índice de la opción correcta
  final int selectedOptionIndex; // Índice de la opción seleccionada

  const MultipleChoiceButtons({
    Key? key,
    required this.options,
    required this.onOptionSelected,
    required this.correctOptionIndex,
    required this.selectedOptionIndex,
  }) : super(key: key);

  @override
  _MultipleChoiceButtonsState createState() => _MultipleChoiceButtonsState();
}

class _MultipleChoiceButtonsState extends State<MultipleChoiceButtons> {
  bool isLocked = false; // Estado para bloquear la selección

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.options.length, (index) {
        bool isSelected = widget.selectedOptionIndex == index; // Verifica si es la opción seleccionada
        bool isCorrect = widget.correctOptionIndex == index; // Verifica si es la opción correcta

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            width: double.infinity,
            height: 50, // Ancho completo
            child: ElevatedButton(
              onPressed: isLocked
                  ? null // Bloquear el botón si ya se seleccionó
                  : () {
                      widget.onOptionSelected(index); // Llamar al callback con el índice seleccionado
                      setState(() {
                        isLocked = true; // Bloquear la selección después de hacer clic
                      });
                    },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Tamaño y grosor del texto
                backgroundColor: isSelected
                    ? (isCorrect ? Colors.green[700] : Colors.red[700]) // Colores más oscuros para el feedback
                    : const Color.fromARGB(255, 255, 255, 255), // Color por defecto
                foregroundColor: const Color.fromARGB(255, 0, 0, 0), // Cambia el color del texto aquí
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Menos redondeados
                  side: BorderSide(
                    color: isSelected ? (isCorrect ? Colors.green : Colors.red) : Colors.transparent, // Borde según selección
                    width: 2, // Grosor del borde
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Alinear el contenido
                children: [
                  Text('${index + 1}. ${widget.options[index]}'), // Número a la izquierda
                  if (isSelected)
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: isCorrect ? Colors.green : Colors.red, // Cuadro a la derecha
                        borderRadius: BorderRadius.circular(5), // Bordes redondeados
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}