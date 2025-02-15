// import 'package:flutter/material.dart';
import 'letter_state.dart';
import '../utils/words.dart';

class GameState {
  final String targetWord;
  final List<String> guesses;
  final List<List<LetterState>> evaluations;
  String currentGuess;
  bool gameOver;
  final Map<String, LetterState> letterStates;

  GameState()
      : targetWord = WordList.getRandomWord().toUpperCase(),
        guesses = [],
        evaluations = [],
        currentGuess = '',
        gameOver = false,
        letterStates = {};

  void submitGuess() {
    if (currentGuess.length != 5) return;

    final evaluation = List<LetterState>.filled(5, LetterState.absent);
    final targetLetterCount = <String, int>{};

    // Count target letters
    for (var i = 0; i < targetWord.length; i++) {
      targetLetterCount[targetWord[i]] = 
          (targetLetterCount[targetWord[i]] ?? 0) + 1;
    }

    // First pass: mark correct letters
    for (var i = 0; i < currentGuess.length; i++) {
      if (currentGuess[i] == targetWord[i]) {
        evaluation[i] = LetterState.correct;
        targetLetterCount[currentGuess[i]] = 
            targetLetterCount[currentGuess[i]]! - 1;
      }
    }

    // Second pass: mark present letters
    for (var i = 0; i < currentGuess.length; i++) {
      if (evaluation[i] != LetterState.correct) {
       if ((targetLetterCount[currentGuess[i]] ?? 0) > 0) {
  evaluation[i] = LetterState.present;
  targetLetterCount[currentGuess[i]] = 
      (targetLetterCount[currentGuess[i]] ?? 0) - 1;
}

      }
    }

    // Update letter states
    for (var i = 0; i < currentGuess.length; i++) {
      final letter = currentGuess[i];
      final currentState = letterStates[letter];
      final newState = evaluation[i];
      
      if (currentState == null || newState.index > currentState.index) {
        letterStates[letter] = newState;
      }
    }

    guesses.add(currentGuess);
    evaluations.add(evaluation);
    currentGuess = '';

    if (currentGuess == targetWord || guesses.length >= 6) {
      gameOver = true;
    }
  }
}