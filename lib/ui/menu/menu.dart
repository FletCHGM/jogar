import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/model/audio_controll/audio.dart';
import '/ui/game/game.dart';
import '/ui/menu/rules.dart';
import '/model/colors/colors.dart';
import '/model/textstyle/textstyles.dart';
import '/ui/menu/settings.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  var audioPlayer = AudioPlayer();
  @override
  void initState() {
    playMainTheme();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background/png/back.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  'assets/images/background/png/glow.png',
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: const Alignment(0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 430 * 144,
                      height: MediaQuery.of(context).size.height / 932 * 160,
                      child: SvgPicture.asset(
                        'assets/images/icons/svg/prize_cup.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 430 * 311,
                      height: MediaQuery.of(context).size.height / 932 * 456,
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                            'assets/images/background/svg/menu_back.svg',
                            fit: BoxFit.contain,
                          ),
                          Align(
                            alignment: const Alignment(0, -0.75),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  430 *
                                  113.85,
                              height: MediaQuery.of(context).size.height /
                                  932 *
                                  34.51,
                              child: SvgPicture.asset(
                                'assets/images/icons/svg/menu_text.svg',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTapDown: (_) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Game(),
                                ),
                              );
                            },
                            child: Align(
                              alignment: const Alignment(0, -0.44),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width /
                                    430 *
                                    222,
                                height: MediaQuery.of(context).size.height /
                                    932 *
                                    79,
                                child: Stack(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/button/button.svg',
                                      fit: BoxFit.contain,
                                    ),
                                    Center(
                                      child: Text(
                                        'START',
                                        style: changa(43, FontWeight.w500,
                                            MainColors.mainBrown),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTapDown: (_) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Settings(),
                                ),
                              );
                            },
                            child: Align(
                              alignment: const Alignment(0, -0.05),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width /
                                    430 *
                                    222,
                                height: MediaQuery.of(context).size.height /
                                    932 *
                                    79,
                                child: Stack(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/button/button.svg',
                                      fit: BoxFit.contain,
                                    ),
                                    Center(
                                      child: Text(
                                        'OPTIONS',
                                        style: changa(43, FontWeight.w500,
                                            MainColors.mainBrown),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTapDown: (_) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Rules(),
                                ),
                              );
                            },
                            child: Align(
                              alignment: const Alignment(0, -0.05 + 0.39),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width /
                                    430 *
                                    222,
                                height: MediaQuery.of(context).size.height /
                                    932 *
                                    79,
                                child: Stack(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/button/button.svg',
                                      fit: BoxFit.contain,
                                    ),
                                    Center(
                                      child: Text(
                                        'RULES',
                                        style: changa(43, FontWeight.w500,
                                            MainColors.mainBrown),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTapDown: (_) {
                              exit(0);
                            },
                            child: Align(
                              alignment: const Alignment(0, -0.05 + 0.39 * 2),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width /
                                    430 *
                                    222,
                                height: MediaQuery.of(context).size.height /
                                    932 *
                                    79,
                                child: Stack(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/button/button.svg',
                                      fit: BoxFit.contain,
                                    ),
                                    Center(
                                      child: Text(
                                        'EXIT',
                                        style: changa(43, FontWeight.w500,
                                            MainColors.mainBrown),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
