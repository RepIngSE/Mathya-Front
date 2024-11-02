import 'package:flutter/material.dart';

class OperationButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const OperationButton({Key? key, required this.label, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Color de fondo
        foregroundColor: const Color.fromARGB(255, 0, 0, 0), // Color del texto
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        minimumSize: Size(double.infinity, 60), // Botón largo
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}