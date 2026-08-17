import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'true_idle_game.dart';
import 'ui.dart';

void main() {
  final game = TrueIdleGame();

  runApp(GameWidget(game: game));
}
