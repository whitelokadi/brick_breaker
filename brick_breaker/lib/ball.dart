import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
  final double ballX;
  final double ballY;
  final bool hasGameStarted;
  final bool isGameOver;

  const MyBall({
    super.key,
    required this.ballX,
    required this.ballY,
    required this.hasGameStarted,
    required this.isGameOver,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width / 2 + (ballX * MediaQuery.of(context).size.width / 2) - 10,
      top: MediaQuery.of(context).size.height / 2 + (ballY * MediaQuery.of(context).size.height / 2) - 10,
      child: Container(
        width: 20, // Diameter of the ball
        height: 20, // Diameter of the ball
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
      ),
    );
  }
}
