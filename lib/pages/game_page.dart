import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/pages/score_panel.dart';

import '../constants/colors.dart';

class GamePage extends StatefulWidget {
  const GamePage({
    super.key,
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int playerOScore = 0;
  int playerXScore = 0;
  bool xPlayerTurn = true;
  int filledBoxes = 0;
  bool hasWinner = false;

  Timer? timer;
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  bool isRunning = false;

  String? resultMessage;

  static var customFontWhite = GoogleFonts.coiny(
    textStyle: TextStyle(
      color: MainColor.whiteColor,
      fontSize: 28,
      letterSpacing: 3,
    ),
  );

  List<String> indexes = [];
  List<int> indexesMatches = [];

  @override
  void initState() {
    super.initState();
    playerOScore = 0;
    playerXScore = 0;
    xPlayerTurn = true;
    filledBoxes = 0;
    resultMessage = null;
    indexes = [
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
    ];
  }

  bool _checkIndexMatch(int index) {
    if (index >= 0 && index <= 8) {
      String stringIndex = xPlayerTurn ? 'X' : 'O';
      switch (index) {
        case 0:
          if (indexes[1] == stringIndex && indexes[2] == stringIndex) {
            _updateScore(indexes[0]);
            indexesMatches.addAll([0, 1, 2]);
            return true;
          }
          if (indexes[3] == stringIndex && indexes[6] == stringIndex) {
            _updateScore(indexes[0]);
            indexesMatches.addAll([0, 3, 6]);
            return true;
          }
          if (indexes[4] == stringIndex && indexes[8] == stringIndex) {
            _updateScore(indexes[0]);
            indexesMatches.addAll([0, 4, 8]);
            return true;
          }
          break;
        case 1:
          if (indexes[0] == stringIndex && indexes[2] == stringIndex) {
            _updateScore(indexes[1]);
            indexesMatches.addAll([1, 0, 2]);
            return true;
          }
          if (indexes[4] == stringIndex && indexes[7] == stringIndex) {
            _updateScore(indexes[1]);
            indexesMatches.addAll([1, 4, 7]);
            return true;
          }
          break;
        case 2:
          if (indexes[1] == stringIndex && indexes[0] == stringIndex) {
            _updateScore(indexes[2]);
            indexesMatches.addAll([2, 1, 0]);
            return true;
          }
          if (indexes[4] == stringIndex && indexes[6] == stringIndex) {
            _updateScore(indexes[2]);
            indexesMatches.addAll([2, 4, 6]);
            return true;
          }
          if (indexes[5] == stringIndex && indexes[8] == stringIndex) {
            _updateScore(indexes[2]);
            indexesMatches.addAll([2, 5, 8]);
            return true;
          }
          break;
        case 3:
          if (indexes[0] == stringIndex && indexes[6] == stringIndex) {
            _updateScore(indexes[3]);
            indexesMatches.addAll([3, 0, 6]);
            return true;
          }
          if (indexes[4] == stringIndex && indexes[5] == stringIndex) {
            _updateScore(indexes[3]);
            indexesMatches.addAll([3, 4, 5]);
            return true;
          }
          break;
        case 4:
          if (indexes[0] == stringIndex && indexes[8] == stringIndex) {
            _updateScore(indexes[4]);
            indexesMatches.addAll([4, 0, 8]);
            return true;
          }
          if (indexes[1] == stringIndex && indexes[7] == stringIndex) {
            _updateScore(indexes[4]);
            indexesMatches.addAll([4, 1, 7]);
            return true;
          }
          if (indexes[3] == stringIndex && indexes[5] == stringIndex) {
            _updateScore(indexes[4]);
            indexesMatches.addAll([4, 3, 6]);
            return true;
          }
          if (indexes[2] == stringIndex && indexes[6] == stringIndex) {
            _updateScore(indexes[4]);
            indexesMatches.addAll([4, 2, 5]);
            return true;
          }
          break;
        case 5:
          if (indexes[2] == stringIndex && indexes[8] == stringIndex) {
            _updateScore(indexes[5]);
            indexesMatches.addAll([5, 2, 8]);
            return true;
          }
          if (indexes[3] == stringIndex && indexes[4] == stringIndex) {
            _updateScore(indexes[5]);
            indexesMatches.addAll([5, 3, 4]);
            return true;
          }
          break;
        case 6:
          if (indexes[0] == stringIndex && indexes[3] == stringIndex) {
            _updateScore(indexes[6]);
            indexesMatches.addAll([6, 0, 3]);
            return true;
          }
          if (indexes[2] == stringIndex && indexes[4] == stringIndex) {
            _updateScore(indexes[6]);
            indexesMatches.addAll([6, 2, 4]);
            return true;
          }
          if (indexes[7] == stringIndex && indexes[8] == stringIndex) {
            _updateScore(indexes[6]);
            indexesMatches.addAll([6, 7, 8]);
            return true;
          }
          break;
        case 7:
          if (indexes[1] == stringIndex && indexes[4] == stringIndex) {
            _updateScore(indexes[7]);
            indexesMatches.addAll([7, 1, 4]);
            return true;
          }
          if (indexes[6] == stringIndex && indexes[8] == stringIndex) {
            _updateScore(indexes[7]);
            indexesMatches.addAll([7, 6, 8]);
            return true;
          }
          break;
        case 8:
          if (indexes[2] == stringIndex && indexes[5] == stringIndex) {
            _updateScore(indexes[8]);
            indexesMatches.addAll([8, 2, 5]);
            return true;
          }
          if (indexes[0] == stringIndex && indexes[4] == stringIndex) {
            _updateScore(indexes[8]);
            indexesMatches.addAll([8, 0, 4]);
            return true;
          }
          if (indexes[6] == stringIndex && indexes[7] == stringIndex) {
            _updateScore(indexes[8]);
            indexesMatches.addAll([8, 6, 7]);
            return true;
          }
          break;
        default:
      }
    }

    if (filledBoxes == 9) {
      _updateScore('Draft');
    }
    return false;
  }

  void _updateScore(String winner) {
    if (winner == 'X') {
      setState(() {
        playerXScore++;
        resultMessage = 'Player X Won!';
        hasWinner = true;
        stopTimer();
      });
    } else if (winner == 'O') {
      setState(() {
        playerOScore++;
        resultMessage = 'Player O Won!';
        hasWinner = true;
        stopTimer();
      });
    } else {
      setState(() {
        resultMessage = 'Nobody Won!';
        hasWinner = true;
        stopTimer();
      });
    }
  }

  void _resetTable() {
    setState(() {
      xPlayerTurn = true;
      filledBoxes = 0;
      resultMessage = null;
      indexes = [
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
      ];
      indexesMatches.clear();
      hasWinner = false;
    });
  }

  void _resetGame() {
    _resetTable();
    setState(() {
      playerOScore = playerXScore = 0;
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
          setState(() {
            resultMessage = 'Nobody Won!';
            hasWinner = true;
            stopTimer();
          });
        }
      });
    });
  }

  void stopTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() => seconds = maxSeconds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              ScorePanel(
                customFontWhite: customFontWhite,
                playerOScore: playerOScore,
                playerXScore: playerXScore,
                xPlayerTurn: xPlayerTurn,
              ),
              Expanded(
                flex: 3,
                child: GridView.builder(
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (!isRunning) {
                            startTimer();
                            setState(() {
                              isRunning = true;
                            });
                          }

                          if (indexes[index] == '' && filledBoxes < 10) {
                            setState(() {
                              indexes[index] = xPlayerTurn ? 'X' : 'O';
                              filledBoxes++;
                            });

                            bool matchFinished = _checkIndexMatch(index);

                            if (!matchFinished) {
                              setState(() {
                                xPlayerTurn = xPlayerTurn ? false : true;
                              });
                            } else {
                              filledBoxes = 10;
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: indexesMatches.contains(index)
                                  ? MainColor.secondaryColor
                                  : MainColor.orangeColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                width: 5,
                                color: indexesMatches.contains(index)
                                    ? MainColor.secondaryColor
                                    : MainColor.orangeColor,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                indexes[index],
                                style: customFontWhite.copyWith(
                                  fontSize: 70,
                                  letterSpacing: 0,
                                  height: .8,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    resultMessage != null
                        ? Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  resultMessage!,
                                  style: customFontWhite.copyWith(fontSize: 26),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _resetTable();
                                    setState(() {
                                      resultMessage = null;
                                      isRunning = false;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: MainColor.orangeColor),
                                  child: Text(
                                    'Play Again!',
                                    style: customFontWhite.copyWith(
                                        fontSize: 16, height: 1),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : isRunning
                            ? SizedBox(
                                width: 80,
                                height: 80,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    CircularProgressIndicator(
                                      value: 1 - seconds / maxSeconds,
                                      valueColor: AlwaysStoppedAnimation(
                                          MainColor.whiteColor),
                                      strokeWidth: 6,
                                      backgroundColor: MainColor.orangeColor,
                                    ),
                                    Center(
                                      child: Text(
                                        seconds.toString(),
                                        style: customFontWhite.copyWith(
                                          fontSize: 30,
                                          height: .8,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Click on a square \n to get started!',
                                      textAlign: TextAlign.center,
                                      style: customFontWhite.copyWith(
                                          fontSize: 22,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                  ],
                ),
              ),
              TextButton(
                  onPressed: () {
                    _resetGame();
                  },
                  child: Text(
                    'Reset Game',
                    style: customFontWhite.copyWith(
                      color: MainColor.orangeColor,
                      fontSize: 16,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
