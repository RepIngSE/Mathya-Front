import 'package:flutter/material.dart';
import '../widgets_operation/operation_content.dart';
import '../widgets_operation/ActividadContent.dart';

class OperationView extends StatelessWidget {
  final String operation;

  const OperationView({Key? key, required this.operation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = '';
    String description = ''; // Descripción adicional
    List<String> images = [];
    String currentOperation = '';

    // Asignar valores según la operación
    switch (operation) {
      case 'Suma':
        text = 'Diviertete Aprendiendo';
        description =
            'Imagina que tienes 3 manzanas y luego te dan 2 manzanas más. Si juntas todas, ahora tienes 5 manzanas. Entonces, sumar es contar todo lo que tienes cuando unes dos grupos de cosas.';
        images = ['assets/images/Suma.jpg'];
        currentOperation = '+';
        break;
      case 'Resta':
        text = 'Diviertete Aprendiendo';
        description =
            'La resta es quitar o sacar algo para ver cuántas cosas quedan. Imagina que tienes 5 caramelos, pero te comes 2. Si cuentas los caramelos que quedan, verás que ahora tienes 3. Eso es restar: empezar con un número, quitar una parte y ver cuánto queda.';
        images = ['assets/images/Resta.jpg'];
        currentOperation = '-';
        break;
      case 'Multiplicación':
        text = 'Diviertete Aprendiendo';
        description =
            'La multiplicación es sumar el mismo número varias veces. Imagina que tienes 3 bolsas, y en cada bolsa hay 2 dulces. Si cuentas todos los dulces de las 3 bolsas, tendrás 6 en total. Así, multiplicar es como decir: "3 veces 2 es 6.';
        images = ['assets/images/Multiplicacion.jpg'];
        currentOperation = 'x';
        break;
      case 'División':
        text = 'Diviertete Aprendiendo';
        description =
            'La división es repartir cosas en partes iguales. Imagina que tienes 8 galletas y 4 amigos. Si quieres darles la misma cantidad a cada uno, les das 2 galletas a cada amigo. Eso es dividir: ver cuánto le toca a cada uno cuando repartes algo en partes iguales.';
        images = ['assets/images/Division.jpg'];
        currentOperation = '÷';
        break;
      default:
        text = 'Operación no definida.';
        description = 'Descripción no disponible.';
        images = [];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(operation),
        backgroundColor: Color(0xFF7ED957), // Color para la AppBar
      ),
      backgroundColor: Color(0xFFFFF5DE),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título
                Text(
                  "Operación matemática seleccionada.",
                  style: TextStyle(
                    fontSize: 16,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(height: 16),

                // Carta con imagen degradada
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage(images.isNotEmpty ? images[0] : ''),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0), BlendMode.darken),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Descripción debajo de la imagen
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 25),

                // Carta de actividad
                Card(
                  color: Color.fromARGB(255, 255, 255, 255),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Imagen a la izquierda
                        Image.asset(
                          'assets/images/Suma.jpg',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 16),
                        // Texto a la derecha
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                text,
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(height: 10),
                              // Botón debajo del texto
                              SizedBox(
                                width: 200, 
                                height: 35,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF7ED957),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MathGameScreen(
                                          currentOperation: currentOperation,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text('Ir a Actividad'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Carta de test
                Card(
                  color: Color.fromARGB(255, 255, 255, 255),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Imagen a la izquierda
                        Image.asset(
                          'assets/images/Multiplicacion.jpg',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 16),
                        // Texto a la derecha
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                text,
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(height: 10),
                              // Botón debajo del texto
                              SizedBox(
                                width: 200, 
                                height: 35, 
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF7ED957),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OperationContent(
                                          title: operation,
                                          text: text,
                                          images: images,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text('Ir al Test'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
