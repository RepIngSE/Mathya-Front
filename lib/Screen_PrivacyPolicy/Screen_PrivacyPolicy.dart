import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDEEDC), 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85, 
            decoration: BoxDecoration(
              color: Colors.white, 
              borderRadius: BorderRadius.circular(20), 
              border: Border.all(color: Colors.black12), 
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Encabezado
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF7CDA54), 
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'políticas',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87, 
                    ),
                  ),
                ),
                // Contenido del texto
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    'Las políticas de uso de nuestra app educativa están diseñadas para fomentar un entorno seguro y productivo para todos los usuarios. Al utilizar la app, los estudiantes y docentes se comprometen a respetar los derechos de los demás, usar el contenido de manera ética y apropiada, y no compartir información confidencial sin autorización. Además, se prohíbe el uso indebido de la plataforma, incluyendo el plagio y cualquier comportamiento que interrumpa el aprendizaje. El objetivo es asegurar una experiencia educativa de calidad, promoviendo la colaboración y el respeto mutuo.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87, 
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
