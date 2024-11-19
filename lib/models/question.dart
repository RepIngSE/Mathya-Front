class Question {
  final String pregunta;
  List<String> opciones; 
  final String respuestaCorrecta;

  Question({
    required this.pregunta,
    required this.opciones,
    required this.respuestaCorrecta,
  });

  factory Question.fromJson(List<Map<String, dynamic>> jsonGroup) {
    String pregunta = jsonGroup.first['pregunta'];
    String respuestaCorrecta = jsonGroup.firstWhere((element) => element['correcto'] == 1)['respuesta'];

    List<String> opciones = jsonGroup.map((e) => e['respuesta'] as String).toList();
    
    return Question(
      pregunta: pregunta,
      opciones: opciones,
      respuestaCorrecta: respuestaCorrecta,
    );
  }
}
