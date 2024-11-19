import 'package:flutter/material.dart';

class MultipleChoiceButtons extends StatelessWidget {
  final List<String> options;
  final Function(int) onOptionSelected;
  final int selectedOptionIndex;
  final int correctOptionIndex;
  final bool isSubmitted;

  const MultipleChoiceButtons({
    Key? key,
    required this.options,
    required this.onOptionSelected,
    required this.selectedOptionIndex,
    required this.correctOptionIndex,
    required this.isSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(options.length, (index) {
        // Verifica si la opción fue seleccionada
        bool isSelected = selectedOptionIndex == index;

        return GestureDetector(
          onTap: () {
            if (!isSubmitted) {
              onOptionSelected(index); // Llamamos al callback cuando se selecciona una opción
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color.fromARGB(255, 248, 162, 50) // Color para los seleccionados
                  : const Color.fromARGB(255, 255, 255, 255), // Fondo blanco para las demás opciones
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected
                    ? const Color.fromARGB(255, 4, 58, 5) // Borde azul solo para la opción seleccionada
                    : Colors.grey, // Borde gris para las no seleccionadas
                width: 2,
              ),
            ),
            child: Text(
              options[index],
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? const Color.fromARGB(255, 0, 0, 0) : Colors.black, // Texto blanco si seleccionada
              ),
            ),
          ),
        );
      }),
    );
  }
}
