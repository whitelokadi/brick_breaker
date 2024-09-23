import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  final double brickX;
  final double brickY;
  final double brickHeight;
  final double brickWidth;
  final bool brickBroken;

  const MyBrick(
      {super.key, required this.brickHeight,
      required this.brickWidth,
      required this.brickX,
      required this.brickY,
      required this.brickBroken});

  @override
  Widget build(BuildContext context) {
    return brickBroken
        ? Container()
        : Container(
            alignment: Alignment((2*brickX+brickWidth)/(2-brickWidth ), brickY),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: MediaQuery.of(context).size.height * brickHeight / 2,
                width: MediaQuery.of(context).size.width * brickWidth / 2,
                color: Colors.deepPurple,
              ),
            ),
          );
  }
}

// import 'package:flutter/material.dart';

// class MyBrick extends StatelessWidget {
//   final double brickX;
//   final double brickY;
//   final double brickHeight;
//   final double brickWidth;
//   final bool brickBroken; // Add a parameter to track if the brick is broken

//   const MyBrick({
//     super.key,
//     required this.brickX,
//     required this.brickY,
//     required this.brickHeight,
//     required this.brickWidth,
//     required this.brickBroken,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       left: (MediaQuery.of(context).size.width / 2) + (brickX * MediaQuery.of(context).size.width / 2),
//       top: (MediaQuery.of(context).size.height / 2) + (brickY * MediaQuery.of(context).size.height / 2),
//       child: Container(
//         width: brickWidth * MediaQuery.of(context).size.width,
//         height: brickHeight * MediaQuery.of(context).size.height,
//         color: brickBroken ? Colors.transparent : Colors.red, // Change color if broken
//       ),
//     );
//   }
// }
