import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  final Map<String, dynamic> quiz;

  const QuizScreen({super.key, required this.quiz});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  late final List<Map<String, Object>> _questions;

  @override
  void initState() {
    super.initState();
    if (widget.quiz['questions'] != null &&
        widget.quiz['questions'] is List<Map<String, Object>>) {
      _questions = List<Map<String, Object>>.from(widget.quiz['questions']);
    } else {
      _questions = [];
    }
  }

  void _answerQuestion(String answer) {
    if (answer == _questions[_currentQuestionIndex]['correctAnswer']) {
      setState(() {
        _score++;
      });
    }
    setState(() {
      _currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz['title']),
      ),
      body: _currentQuestionIndex < _questions.length
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _questions[_currentQuestionIndex]['question'] as String,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                ...(_questions[_currentQuestionIndex]['answers']
                        as List<String>)
                    .map((answer) => ElevatedButton(
                          onPressed: () => _answerQuestion(answer),
                          child: Text(answer),
                        )),
              ],
            )
          : Center(
              child: Text(
                'Quiz Completed!\nYour score: $_score',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24),
              ),
            ),
    );
  }
}
