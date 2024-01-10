import 'package:flutter/material.dart';
import 'package:tictactoe/constants/colors.dart';

class ScorePanel extends StatelessWidget {
  const ScorePanel({
    super.key,
    required this.customFontWhite,
    required this.playerXScore,
    required this.playerOScore,
    required this.xPlayerTurn,
  });

  final TextStyle customFontWhite;
  final int playerXScore;
  final int playerOScore;
  final bool xPlayerTurn;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Player X:',
                    style: customFontWhite.copyWith(
                        fontSize: 18, color: MainColor.orangeColor),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    playerXScore.toString(),
                    style: customFontWhite.copyWith(fontSize: 18),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    'Player O:',
                    style: customFontWhite.copyWith(
                        fontSize: 18, color: MainColor.orangeColor),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    playerOScore.toString(),
                    style: customFontWhite.copyWith(fontSize: 18),
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Player Turn',
                      style: customFontWhite.copyWith(
                          fontSize: 22, color: MainColor.orangeColor),
                    ),
                    Text(
                      xPlayerTurn ? 'X' : 'O',
                      style: customFontWhite.copyWith(fontSize: 40),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
