import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question.dart';

class QuestionService {
  static Future<List<Question>> fetchQuestions(int moduleId) async {
    final response = await http.get(
      Uri.parse('https://mathya-back-2.onrender.com/api/modulos/$moduleId/preguntas'),
    );

    if (response.statusCode == 200) {
      try {
        List<dynamic> jsonResponse = json.decode(response.body);

        // Agrupar por `id_pregunta` para obtener un conjunto de respuestas para cada pregunta
        Map<int, List<Map<String, dynamic>>> groupedQuestions = {};
        for (var question in jsonResponse) {
          int questionId = question['id_pregunta'];
          if (groupedQuestions.containsKey(questionId)) {
            groupedQuestions[questionId]?.add(question);
          } else {
            groupedQuestions[questionId] = [question];
          }
        }

        // Convertir los grupos en una lista de `Question`
        List<Question> questions = groupedQuestions.entries.map((entry) {
          return Question.fromJson(entry.value);
        }).toList();

        return questions;
      } catch (e) {
        print('Error al procesar los datos de la API: $e');
        throw Exception('Error al procesar los datos de la API');
      }
    } else {
      throw Exception('Failed to load questions');
    }
  }
}
