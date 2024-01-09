import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class GamePage extends StatefulWidget {
  const GamePage({
    super.key,
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static var customFontWhite = GoogleFonts.coiny(
    textStyle: TextStyle(
      color: MainColor.whiteColor,
      fontSize: 28,
      letterSpacing: 3,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Expanded(
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
                              '0',
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
                              '0',
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
                                'Turn',
                                style: customFontWhite.copyWith(
                                    fontSize: 22, color: MainColor.orangeColor),
                              ),
                              Text(
                                'X',
                                style: customFontWhite.copyWith(fontSize: 32),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    'Tabuleiro',
                    style: customFontWhite,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Result',
                    style: customFontWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
