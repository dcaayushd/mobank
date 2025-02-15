import 'package:flutter/material.dart';
import '../models/game_state.dart';

class Grid extends StatelessWidget {
  final GameState gameState;

  const Grid({super.key, required this.gameState});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemCount: 30,
      padding: const EdgeInsets.symmetric(horizontal: 36),
      itemBuilder: (context, index) {
        final row = index ~/ 5;
        final col = index % 5;
        
        String letter = '';
        Color backgroundColor = Colors.grey.shade900;
        Color borderColor = Colors.grey.shade700;
        
        if (row < gameState.guesses.length) {
          letter = gameState.guesses[row][col];
          final evaluation = gameState.evaluations[row][col];
          backgroundColor = evaluation.color;
          borderColor = evaluation.color;
        } else if (row == gameState.guesses.length && col < gameState.currentGuess.length) {
          letter = gameState.currentGuess[col];
        }

        return Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: borderColor,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              letter,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}