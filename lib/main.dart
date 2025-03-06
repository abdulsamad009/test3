import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(HangmanApp());
}

class HangmanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HangmanGame(),
    );
  }
}

class HangmanGame extends StatefulWidget {
  @override
  _HangmanGameState createState() => _HangmanGameState();
}

class _HangmanGameState extends State<HangmanGame> {
  final List<String> words = ["FLUTTER", "DART", "MOBILE", "HANGMAN", "DEVELOPER"];
  String word = "";
  List<String> guessedLetters = [];
  int wrongGuesses = 0;
  final int maxWrong = 6;

  @override
  void initState() {
    super.initState();
    newGame();
  }

  void newGame() {
    setState(() {
      word = (words..shuffle()).first;
      guessedLetters.clear();
      wrongGuesses = 0;
    });
  }

  void checkGuess(String letter) {
    setState(() {
      if (!guessedLetters.contains(letter)) {
        guessedLetters.add(letter);
        if (!word.contains(letter)) {
          wrongGuesses++;
        }
      }
    });
  }

  bool isGameOver() {
    return wrongGuesses >= maxWrong || word.split('').every((l) => guessedLetters.contains(l));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hangman Game")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            word.split('').map((l) => guessedLetters.contains(l) ? l : "_").join(" "),
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text("Wrong Guesses: $wrongGuesses / $maxWrong", style: TextStyle(fontSize: 20)),
          SizedBox(height: 20),
          Wrap(
            spacing: 8,
            children: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                .split("")
                .map((letter) => ElevatedButton(
                      onPressed: isGameOver() ? null : () => checkGuess(letter),
                      child: Text(letter),
                    ))
                .toList(),
          ),
          SizedBox(height: 20),
          if (isGameOver())
            Column(
              children: [
                Text(
                  wrongGuesses >= maxWrong ? "You Lost! Word was: $word" : "You Won!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: newGame,
                  child: Text("Play Again"),
                )
              ],
            )
        ],
      ),
    );
  }
}
