import 'package:flutter/material.dart';

class MyPlayer extends StatelessWidget {
  final double playerX;
  final double playerWidth;

  const MyPlayer({
    Key? key,
    required this.playerX,
    required this.playerWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width / 2 + (playerX * MediaQuery.of(context).size.width / 2),
      bottom: 30, // Positioning the player 30 pixels from the bottom
      child: Container(
        width: MediaQuery.of(context).size.width * playerWidth,
        height: 10, // Height of the paddle
        color: Colors.blue, // Paddle color
      ),
    );
  }
}
