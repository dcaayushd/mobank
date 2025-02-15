import 'package:flutter/material.dart';
import '../models/letter_state.dart';

class Keyboard extends StatelessWidget {
  final Function(String) onKeyTap;
  final Map<String, LetterState> letterStates;

  const Keyboard({
    super.key,
    required this.onKeyTap,
    required this.letterStates,
  });

  @override
  Widget build(BuildContext context) {
    const rows = [
      ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
      ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
      ['ENTER', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', '⌫'],
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final keyWidth = (screenWidth - 70) / 10; 
    final keyHeight = keyWidth * 1.5; 

    return Column(
      children: rows.map((row) {
        return Padding(
          padding: const EdgeInsets.all(3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.map((key) {
              final letterState = letterStates[key];
              Color backgroundColor = Colors.grey.shade800;
              if (letterState != null) {
                backgroundColor = letterState.color;
              }

              // Calculate dynamic width for special keys
              double width = keyWidth;
              if (key == 'ENTER') width = keyWidth * 1.5;
              if (key == '⌫') width = keyWidth * 1.5;

              return Padding(
                padding: const EdgeInsets.all(3),
                child: SizedBox(
                  height: keyHeight,
                  width: width,
                  child: Material(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(4),
                    child: InkWell(
                      onTap: () => onKeyTap(key),
                      child: Center(
                        child: Text(
                          key,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: keyWidth * 0.4, 
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}