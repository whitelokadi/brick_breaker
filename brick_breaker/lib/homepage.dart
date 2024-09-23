import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ball.dart'; // Assume you have a ball widget
import 'brick.dart'; // Assume you have a brick widget
import 'coverscreen.dart'; // Assume you have a cover screen widget
import 'gameoverscreen.dart'; // Assume you have a game over screen widget
import 'player.dart'; // Assume you have a player widget

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

enum Direction { up, down, left, right }

class _HomepageState extends State<Homepage> {
  // Ball variables
  double ballX = 0;
  double ballY = 0;
  double ballXincrements = 0.01;
  double ballYincrements = 0.01;
  Direction ballYDirection = Direction.down;
  Direction ballXDirection = Direction.left;

  // Player variables
  double playerX = -0.2;
  double playerWidth = 0.4;

  // Brick Variables
  static double wallGap = 0.5 * (2 - 3 * 0.4 - 2 * 0.02);
  List<List<dynamic>> myBricks = [
    [-1 + wallGap, -0.9, false],
    [-0.5 + wallGap, -0.9, false],
    [0 + wallGap, -0.9, false],
  ];

  // Game settings
  bool hasGameStarted = false;
  bool isGameOver = false;

  void startGame() {
    hasGameStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      updateDirection();
      moveBall();
      if (isPlayerDead()) {
        timer.cancel();
        isGameOver = true;
      }
      checkForBrokenBricks();
    });
  }

  void checkForBrokenBricks() {
    for (int i = 0; i < myBricks.length; i++) {
      if (ballX >= myBricks[i][0] &&
          ballX <= myBricks[i][0] + 0.4 &&
          ballY <= myBricks[i][1] + 0.05 &&
          !myBricks[i][2]) {
        setState(() {
          myBricks[i][2] = true;
          double leftSideDist = (myBricks[i][0] - ballX).abs();
          double rightSideDist = (myBricks[i][0] + 0.4 - ballX).abs();
          double topSideDist = (myBricks[i][1] - ballY).abs();
          double bottomSideDist = (myBricks[i][1] + 0.05 - ballY).abs();
          String min =
              findMin(leftSideDist, rightSideDist, topSideDist, bottomSideDist);
          switch (min) {
            case 'left':
              ballXDirection = Direction.left;
              break;
            case 'right':
              ballXDirection = Direction.right;
              break;
            case 'up':
              ballYDirection = Direction.up;
              break;
            case 'down':
              ballYDirection = Direction.down;
              break;
          }
        });
      }
    }
  }

  String findMin(double a, double b, double c, double d) {
    List<double> myList = [a, b, c, d];
    double currentMin = a;
    for (double value in myList) {
      if (value < currentMin) {
        currentMin = value;
      }
    }
    if ((currentMin - a).abs() < 0.01) {
      return 'left';
    } else if ((currentMin - b).abs() < 0.01)
      return 'right';
    else if ((currentMin - c).abs() < 0.01)
      return 'up';
    else if ((currentMin - d).abs() < 0.01) return 'down';
    return '';
  }

  bool isPlayerDead() {
    return ballY >= 1;
  }

  void moveBall() {
    setState(() {
      if (ballYDirection == Direction.down) {
        ballY += ballYincrements;
      } else {
        ballY -= ballYincrements;
      }
      if (ballXDirection == Direction.left) {
        ballX -= ballXincrements;
      } else {
        ballX += ballXincrements;
      }
    });
  }

  void updateDirection() {
    setState(() {
      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballYDirection = Direction.up;
      } else if (ballY <= -1) {
        ballYDirection = Direction.down;
      }
      if (ballX >= 1) {
        ballXDirection = Direction.left;
      } else if (ballX <= -1) {
        ballXDirection = Direction.right;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (playerX > -1) playerX -= 0.2;
    });
  }

  void moveRight() {
    setState(() {
      if (playerX + playerWidth < 1) playerX += 0.2;
    });
  }

  void resetGame() {
    setState(() {
      playerX = -0.2;
      ballX = 0;
      ballY = 0;
      isGameOver = false;
      hasGameStarted = false;
      myBricks = [
        [-1 + wallGap, -0.9, false],
        [-0.5 + wallGap, -0.9, false],
        [0 + wallGap, -0.9, false],
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: Center(
            child: Stack(
              children: [
                Coverscreen(
                    hasGameStarted: hasGameStarted, isGameOver: isGameOver),
                Gameoverscreen(isGameOver: isGameOver, onReset: resetGame),
                MyBall(
                    ballX: ballX,
                    ballY: ballY,
                    hasGameStarted: hasGameStarted,
                    isGameOver: isGameOver),
                MyPlayer(playerX: playerX, playerWidth: playerWidth),
                MyBrick(
                    brickX: myBricks[0][0],
                    brickY: myBricks[0][1],
                    brickBroken: myBricks[0][2],
                    brickHeight: 0.05,
                    brickWidth: 0.4),
                MyBrick(
                    brickX: myBricks[1][0],
                    brickY: myBricks[1][1],
                    brickBroken: myBricks[1][2],
                    brickHeight: 0.05,
                    brickWidth: 0.4),
                MyBrick(
                    brickX: myBricks[2][0],
                    brickY: myBricks[2][1],
                    brickBroken: myBricks[2][2],
                    brickHeight: 0.05,
                    brickWidth: 0.4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
