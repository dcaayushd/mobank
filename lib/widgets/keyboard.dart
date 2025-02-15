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

              double width = 30;
              if (key == 'ENTER' || key == '⌫') width = 56;

              return Padding(
                padding: const EdgeInsets.all(3),
                child: SizedBox(
                  height: 58,
                  width: width,
                  child: Material(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(4),
                    child: InkWell(
                      onTap: () => onKeyTap(key),
                      child: Center(
                        child: Text(
                          key,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
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