import 'package:flutter/material.dart';

void main() {
  runApp(const QuizzApp());
}

class QuizzApp extends StatelessWidget {
  const QuizzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Quiz App',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizScreen()),
                );
              },
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _totalScore = 0;

  static final List<Map<String, dynamic>> questions = [
    {
      'questionText': 'What is the capital of France?',
      'answers': [
        {'text': 'Madrid', 'score': 0},
        {'text': 'Berlin', 'score': 0},
        {'text': 'Paris', 'score': 100},
        {'text': 'Rome', 'score': 0},
      ],
    },
    {
      'questionText': 'Who wrote "Romeo and Juliet"?',
      'answers': [
        {'text': 'Dickens', 'score': 0},
        {'text': 'Shakespeare', 'score': 100},
        {'text': 'Twain', 'score': 0},
        {'text': 'Austen', 'score': 0},
      ],
    },
    {
      'questionText': 'What is the chemical symbol for water?',
      'answers': [
        {'text': 'H2O', 'score': 100},
        {'text': 'CO2', 'score': 0},
        {'text': 'NaCl', 'score': 0},
        {'text': 'O2', 'score': 0},
      ],
    },
    {
      'questionText': 'Which planet is known as the Red Planet?',
      'answers': [
        {'text': 'Jupiter', 'score': 0},
        {'text': 'Mars', 'score': 100},
        {'text': 'Venus', 'score': 0},
        {'text': 'Saturn', 'score': 0},
      ],
    },
    {
      'questionText': 'What is the tallest mammal on Earth?',
      'answers': [
        {'text': 'Elephant', 'score': 0},
        {'text': 'Giraffe', 'score': 100},
        {'text': 'Horse', 'score': 0},
        {'text': 'Rhino', 'score': 0},
      ],
    },
    {
      'questionText': 'Which country is home to the kangaroo?',
      'answers': [
        {'text': 'Australia', 'score': 100},
        {'text': 'Brazil', 'score': 0},
        {'text': 'Canada', 'score': 0},
        {'text': 'India', 'score': 0},
      ],
    },
    {
      'questionText': 'What is the largest ocean on Earth?',
      'answers': [
        {'text': 'Atlantic', 'score': 0},
        {'text': 'Indian', 'score': 0},
        {'text': 'Pacific', 'score': 100},
        {'text': 'Arctic', 'score': 0},
      ],
    },
    {
      'questionText': 'Which planet is known as the "Morning Star"?',
      'answers': [
        {'text': 'Mars', 'score': 0},
        {'text': 'Mercury', 'score': 100},
        {'text': 'Venus', 'score': 0},
        {'text': 'Jupiter', 'score': 0},
      ],
    },
  ];

  void _answerQuestion(int score) {
    setState(() {
      _totalScore += score;
      _currentQuestionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(226, 233, 226, 255),
      body: _currentQuestionIndex < questions.length
          ? QuizQuestion(
              question: questions[_currentQuestionIndex],
              answerQuestion: _answerQuestion,
            )
          : QuizResult(
              totalScore: _totalScore,
              resetQuiz: _resetQuiz,
            ),
    );
  }
}

class QuizQuestion extends StatefulWidget {
  final Map<String, dynamic> question;
  final Function(int) answerQuestion;

  const QuizQuestion({
    super.key,
    required this.question,
    required this.answerQuestion,
  });

  @override
  QuizQuestionState createState() => QuizQuestionState();
}

class QuizQuestionState extends State<QuizQuestion> {
  int? selectedAnswerIndex;
  bool answerSelected = false;

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.4;
    double buttonHeight = MediaQuery.of(context).size.height * 0.08;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 200),
          margin: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              widget.question['questionText'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            childAspectRatio: (buttonWidth / buttonHeight),
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 50),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            children: List.generate(widget.question['answers'].length, (index) {
              Map<String, dynamic> answer = widget.question['answers'][index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ElevatedButton(
                  onPressed: () {
                    Future.delayed(const Duration(milliseconds: 500), () {
                      setState(() {
                        answerSelected = true;
                        selectedAnswerIndex = index;
                      });
                    });
                    widget.answerQuestion(answer['score']);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 244, 239, 239),
                    fixedSize: Size(buttonWidth, buttonHeight),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        answer['text'],
                        style:
                            const TextStyle(fontSize: 17, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class QuizResult extends StatelessWidget {
  final int totalScore;
  final Function resetQuiz;

  const QuizResult(
      {super.key, required this.totalScore, required this.resetQuiz});

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.9;
    double buttonHeight = MediaQuery.of(context).size.height * 0.1;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Your score: $totalScore',
            style: const TextStyle(fontSize: 34, color: Colors.white),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => resetQuiz(),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.transparent,
              side: const BorderSide(color: Colors.white),
              fixedSize: Size(buttonWidth, buttonHeight),
            ),
            child: const Text(
              'Restart Quiz',
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
