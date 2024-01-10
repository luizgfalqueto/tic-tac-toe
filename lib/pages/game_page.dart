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
            return true;
          }
          if (indexes[3] == stringIndex && indexes[6] == stringIndex) {
            _updateScore(indexes[0]);
            return true;
          }
          if (indexes[4] == stringIndex && indexes[8] == stringIndex) {
            _updateScore(indexes[0]);
            return true;
          }
          break;
        case 1:
          if (indexes[0] == stringIndex && indexes[2] == stringIndex) {
            _updateScore(indexes[1]);
            return true;
          }
          if (indexes[4] == stringIndex && indexes[7] == stringIndex) {
            _updateScore(indexes[1]);
            return true;
          }
          break;
        case 2:
          if (indexes[1] == stringIndex && indexes[0] == stringIndex) {
            _updateScore(indexes[2]);
            return true;
          }
          if (indexes[4] == stringIndex && indexes[6] == stringIndex) {
            _updateScore(indexes[2]);
            return true;
          }
          if (indexes[5] == stringIndex && indexes[8] == stringIndex) {
            _updateScore(indexes[2]);
            return true;
          }
          break;
        case 3:
          if (indexes[0] == stringIndex && indexes[6] == stringIndex) {
            _updateScore(indexes[3]);
            return true;
          }
          if (indexes[4] == stringIndex && indexes[5] == stringIndex) {
            _updateScore(indexes[3]);
            return true;
          }
          break;
        case 4:
          if (indexes[0] == stringIndex && indexes[8] == stringIndex) {
            _updateScore(indexes[4]);
            return true;
          }
          if (indexes[1] == stringIndex && indexes[7] == stringIndex) {
            _updateScore(indexes[4]);
            return true;
          }
          if (indexes[3] == stringIndex && indexes[6] == stringIndex) {
            _updateScore(indexes[4]);
            return true;
          }
          if (indexes[2] == stringIndex && indexes[5] == stringIndex) {
            _updateScore(indexes[4]);
            return true;
          }
          break;
        case 5:
          if (indexes[2] == stringIndex && indexes[8] == stringIndex) {
            _updateScore(indexes[5]);
            return true;
          }
          if (indexes[3] == stringIndex && indexes[4] == stringIndex) {
            _updateScore(indexes[5]);
            return true;
          }
          break;
        case 6:
          if (indexes[0] == stringIndex && indexes[3] == stringIndex) {
            _updateScore(indexes[6]);
            return true;
          }
          if (indexes[2] == stringIndex && indexes[4] == stringIndex) {
            _updateScore(indexes[6]);
            return true;
          }
          if (indexes[7] == stringIndex && indexes[8] == stringIndex) {
            _updateScore(indexes[6]);
            return true;
          }
          break;
        case 7:
          if (indexes[1] == stringIndex && indexes[4] == stringIndex) {
            _updateScore(indexes[7]);
            return true;
          }
          if (indexes[6] == stringIndex && indexes[8] == stringIndex) {
            _updateScore(indexes[7]);
            return true;
          }
          break;
        case 8:
          if (indexes[2] == stringIndex && indexes[5] == stringIndex) {
            _updateScore(indexes[8]);
            return true;
          }
          if (indexes[0] == stringIndex && indexes[4] == stringIndex) {
            _updateScore(indexes[8]);
            return true;
          }
          if (indexes[6] == stringIndex && indexes[7] == stringIndex) {
            _updateScore(indexes[8]);
            return true;
          }
          break;
        default:
      }
    }
    return false;
  }

  void _updateScore(String winner) {
    if (winner == 'X') {
      setState(() {
        playerXScore++;
        resultMessage = 'Player X Wins!';
      });
    } else if (winner == 'O') {
      setState(() {
        playerOScore++;
        resultMessage = 'Player O Wins!';
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
    });
  }

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
                flex: 2,
                child: GridView.builder(
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
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
                              color: MainColor.orangeColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                width: 5,
                                color: MainColor.orangeColor,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      resultMessage ?? 'Result',
                      style: customFontWhite,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    resultMessage != null
                        ? ElevatedButton(
                            onPressed: () {
                              _resetTable();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: MainColor.orangeColor),
                            child: Text(
                              'Again',
                              style: customFontWhite.copyWith(
                                  fontSize: 16, height: 1),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
