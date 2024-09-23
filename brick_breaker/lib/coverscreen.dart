import 'package:flutter/material.dart';

class Coverscreen extends StatelessWidget {
  final bool hasGameStarted;
  final bool isGameOver;

  const Coverscreen({
    super.key,
    required this.hasGameStarted,
    required this.isGameOver,
  });

  @override
  Widget build(BuildContext context) {
    if (hasGameStarted || isGameOver) {
      return const SizedBox.shrink(); // Hide the cover screen if the game has started or is over
    }

    return Container(
      color: Colors.deepPurple[100],
      alignment: Alignment.center,
      child: const Text(
        'Tap to Start',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
