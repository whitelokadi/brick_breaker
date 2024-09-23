import 'package:flutter/material.dart';

class Gameoverscreen extends StatelessWidget {
  final bool isGameOver;
  final VoidCallback onReset;

  const Gameoverscreen({
    super.key,
    required this.isGameOver,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    if (!isGameOver) {
      return const SizedBox.shrink(); // Hide the game over screen if the game is not over
    }

    return Container(
      color: Colors.black.withOpacity(0.7),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Game Over',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onReset,
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }
}
