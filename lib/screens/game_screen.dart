import 'package:flutter/material.dart';
import '../widgets/grid.dart';
import '../widgets/keyboard.dart';
import '../models/game_state.dart';
import '../utils/words.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameState gameState;

  @override
  void initState() {
    super.initState();
    gameState = GameState();
  }

  void _onKeyTap(String letter) {
    if (gameState.gameOver) return;

    setState(() {
      if (letter == '⌫') {
        if (gameState.currentGuess.isNotEmpty) {
          gameState.currentGuess = gameState.currentGuess.substring(
            0,
            gameState.currentGuess.length - 1,
          );
        }
      } else if (letter == 'ENTER') {
        if (gameState.currentGuess.length == 5) {
          if (WordList.validWords.contains(gameState.currentGuess.toLowerCase())) {
            gameState.submitGuess();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Not in word list'),
                duration: Duration(seconds: 1),
              ),
            );
          }
        }
      } else if (gameState.currentGuess.length < 5) {
        gameState.currentGuess += letter;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'WORDLE',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 28,
          ),
        ),
        backgroundColor: Colors.black87,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Expanded(
            child: Grid(gameState: gameState),
          ),
          Keyboard(
            onKeyTap: _onKeyTap,
            letterStates: gameState.letterStates,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}