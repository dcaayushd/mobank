import 'package:flutter/material.dart';

enum LetterState {
  absent,
  present,
  correct;

  Color get color {
    switch (this) {
      case LetterState.absent:
        return Colors.grey.shade800;
      case LetterState.present:
        return Colors.amber.shade700;
      case LetterState.correct:
        return Colors.green.shade600;
    }
  }
}