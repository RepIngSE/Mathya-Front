import 'package:flutter/material.dart';
import 'package:mathya/Widgets_Operation/operation_content.dart';
import 'package:mathya/Screen_Operation/OperationView.dart';
import 'dart:math';

// Constantes
class GameConstants {
  static const List<String> operations = ['+', '-', '×', '÷'];
  static const int maxQuestionsPerOperation = 5;
  static const int maxRandomNumber = 10;
  static const int optionsCount = 4;
  static const int scoreIncrement = 10;
  static const int scoreDecrement = 5;
}

// Modelo para el estado del juego
class GameState {
  int score;
  int questionCount;
  String currentOperation = '+';
  int currentOperationCount;
  int number1;
  int number2;
  int correctAnswer;
  List<int> options;

  GameState({
    this.score = 0,
    this.questionCount = 0,
    this.currentOperation = '+',
    this.currentOperationCount = 0,
    this.number1 = 0,
    this.number2 = 0,
    this.correctAnswer = 0,
    this.options = const [],
  });
}

class MathGameScreen extends StatefulWidget {
  final String activity;
  final String currentOperation;

  const MathGameScreen(
      {super.key, this.activity = '', this.currentOperation = ''});

  @override
  State<MathGameScreen> createState() => _MathGameScreenState();
}

class _MathGameScreenState extends State<MathGameScreen> {
  final Random _random = Random();
  late GameState _gameState;

  @override
  void initState() {
    super.initState();
    _gameState = GameState();
    _generateNewProblem();
  }

  // Métodos de generación de problemas
  void _generateNewProblem() {
    if (_gameState.currentOperationCount >=
        GameConstants.maxQuestionsPerOperation) {
      _showOperationLimitDialog();
      return;
    }

    setState(() {
      _gameState.number1 = _random.nextInt(GameConstants.maxRandomNumber) + 1;
      _gameState.number2 = _random.nextInt(GameConstants.maxRandomNumber) + 1;
      _gameState.correctAnswer = _calculateAnswer(
        _gameState.number1,
        _gameState.number2,
        _gameState.currentOperation,
      );
      _gameState.options = _generateOptions(_gameState.correctAnswer);
      _gameState.questionCount++;
      _gameState.currentOperationCount++;
    });
  }

  int _calculateAnswer(int num1, int num2, String operation) {
    switch (operation) {
      case '+':
        return num1 + num2;
      case '-':
        return num1 - num2;
      case '×':
        return num1 * num2;
      case '÷':
        return num2 != 0 ? num1 ~/ num2 : num1;
      default:
        return 0;
    }
  }

  List<int> _generateOptions(int answer) {
    Set<int> options = {answer};
    while (options.length < GameConstants.optionsCount) {
      options.add(answer + _random.nextInt(11) - 5);
    }
    return options.toList()..shuffle();
  }

  // Métodos de manejo de respuestas
  void _checkAnswer(int selectedAnswer) {
    bool isCorrect = selectedAnswer == _gameState.correctAnswer;
    setState(() {
      _gameState.score += isCorrect
          ? GameConstants.scoreIncrement
          : -GameConstants.scoreDecrement;
      _gameState.score = max(0, _gameState.score);
    });
    _showFeedbackDialog(isCorrect);
  }

  // Métodos de diálogo
  Future<void> _showFeedbackDialog(bool isCorrect) async {
    await _showDialog(
      title: isCorrect ? '¡Correcto! 🎉' : '¡Incorrecto! 😊',
      content: isCorrect
          ? 'Ganaste ${GameConstants.scoreIncrement} puntos\nPuntaje total: ${_gameState.score}'
          : 'La respuesta correcta era: ${_gameState.correctAnswer}\nPuntaje total: ${_gameState.score}',
      actions: [
        TextButton(
          child: const Text('Siguiente'),
          onPressed: () {
            Navigator.of(context).pop();
            _generateNewProblem();
          },
        ),
      ],
    );
  }

  Future<void> _showOperationLimitDialog() async {
    await _showDialog(
      title: '¡Límite Alcanzado! 🎉',
      content:
          'Has alcanzado el límite de ${GameConstants.maxQuestionsPerOperation} '
          'preguntas para la operación ${_gameState.currentOperation}.',
      actions: [
        TextButton(
          child: const Text('Continuar con otra operación'),
          onPressed: () {
            Navigator.of(context).pop();
            _selectNewOperation();
          },
        ),
      ],
    );
  }

  Future<void> _showDialog({
    required String title,
    required String content,
    required List<Widget> actions,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: actions,
        );
      },
    );
  }

  // Métodos de control del juego
  void _selectNewOperation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleccionar Operación'),
          content: SingleChildScrollView(
            child: Column(
              children: GameConstants.operations.map((operation) {
                return ListTile(
                  title: Text(operation),
                  onTap: () => _handleOperationSelection(operation),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void _handleOperationSelection(String operation) {
    setState(() {
      _gameState = GameState(currentOperation: operation);
      Navigator.of(context).pop();
      _generateNewProblem();
    });
  }

  // Widgets de UI
  Widget _buildOption(int number, double size) {
    return Draggable<int>(
      data: number,
      feedback: _buildOptionContainer(number, size, Color(0xFF7ED957)),
      childWhenDragging:
          _buildOptionContainer(number, size, Colors.grey.shade300),
      child: _buildOptionContainer(number, size, Color(0xFF7ED957)),
    );
  }

  Widget _buildOptionContainer(int number, double size, Color color) {
    return Container(
      alignment: Alignment.center,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        number.toString(),
        style: TextStyle(
          fontSize: size * 0.3,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDragTarget(double size) {
    return DragTarget<int>(
      onAccept: _checkAnswer,
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: size * 1.5,
          height: size * 1.5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black26),
          ),
          child: const Text('Suelta aquí',
              style: TextStyle(color: Color.fromARGB(248, 0, 0, 0))),
        );
      },
    );
  }

  Widget _buildTestButton() {
    return ElevatedButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OperationContent(
              title: widget.activity, text: widget.activity, images: const []),
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF7ED957),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        textStyle: const TextStyle(fontSize: 20),
      ),
      child: const Text('Test'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.shortestSide * 0.2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF7ED957),
        centerTitle: true,
        title: const Text('Actividad de Matematicas',
            style: TextStyle(fontSize: 24)),
      ),
      backgroundColor: Color(0xFFFFF5DE),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _selectNewOperation,
              child: const Text('Seleccionar Operación', style: TextStyle(color:Color.fromRGBO(0, 0, 0, 1))),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              )
            ),
            const SizedBox(height: 40),
            Text(
              '${_gameState.number1} ${_gameState.currentOperation} ${_gameState.number2} = ?',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            _buildDragTarget(size),
            const SizedBox(height: 40),
            Wrap(
              spacing: 15,
              children: _gameState.options
                  .map((option) => _buildOption(option, size))
                  .toList(),
            ),
            const SizedBox(height: 30),
            Text(
              'Puntaje: ${_gameState.score}',
              style: const TextStyle(fontSize: 24, color: Color.fromARGB(255, 43, 1, 90)),
            ),
          ],
        ),
      ),
    );
  }
}
