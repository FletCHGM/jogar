import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/model/audio_controll/audio.dart';
import '/model/hive/best_score.dart';
import '/model/colors/colors.dart';
import '/model/textstyle/textstyles.dart';
import '/model/timer/timer.dart';
import '/ui/menu/rules.dart';
import '/ui/menu/settings.dart';

import 'game_repos.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  int score = 0;
  GameElement? first;
  GameElement? second;
  List<GameElement> elementsToChange = [];
  List<GameElement> elementsList = [];
  late bool _isStarted;
  late bool _isOver;
  int bestScore = box.get(0);
  @override
  void initState() {
    elementsList = Matrix().firstCreate();
    _isStarted = false;
    _isOver = false;
    super.initState();
  }

  swapElements(a, b) {
    setState(() {
      elementsToChange = Matrix().swapElements(a, b, elementsList);
    });
    if (elementsToChange.isEmpty) {
      playSwap();
      Timer(const Duration(milliseconds: 200), () {
        setState(() {
          elementsToChange = Matrix().swapElements(a, b, elementsList);
          first = null;
          second = null;
        });
      });
    } else {
      setState(() {
        scoreImprove();
        first = null;
        second = null;
      });
    }
    setState(() {});
  }

  scoreImprove() {
    playMatch();
    setState(() {
      if (elementsToChange.length >= 3) {
        score += (elementsToChange.length - 2) * 100;
      }
    });

    var temp = [];
    var i = elementsToChange.length - 1;
    while (i > -1) {
      setState(() {
        elementsList[elementsList.indexOf(elementsToChange[i])].icon =
            icons[Random().nextInt(5)];
        var element = elementsList[elementsList.indexOf(elementsToChange[i])];
        temp.add(element);
      });
      i--;
    }
    Timer(const Duration(milliseconds: 150), () {
      setState(() {
        elementsToChange.clear();
      });
    });

    Timer(const Duration(milliseconds: 300), () {
      for (var i in temp) {
        if (Matrix().match(i, elementsList).length >= 3) {
          setState(() {
            elementsToChange = Matrix().match(i, elementsList);
            scoreImprove();
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background/png/back.png'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: (!_isStarted)
            ? Center(
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/background/png/glow.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 932 * 70,
                        child: Stack(
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                'assets/images/background/svg/score_back.svg',
                                fit: BoxFit.contain,
                              ),
                            ),
                            Center(
                              child: timer(3, 43, () {
                                setState(() {
                                  score = 0;
                                  _isStarted = true;
                                });
                              }),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Stack(
                children: [
                  (_isOver)
                      ? const SizedBox()
                      : Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            height:
                                MediaQuery.of(context).size.height / 932 * 331,
                            child: Image.asset(
                              'assets/images/background/png/icon_glow.png',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                  (_isOver)
                      ? const SizedBox()
                      : Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            height:
                                MediaQuery.of(context).size.height / 932 * 331,
                            child: Center(
                              child: Image.asset(
                                'assets/images/icons/png/game_cat_icon.png',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                  (_isOver)
                      ? const SizedBox()
                      : Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 430 * 26,
                            top: MediaQuery.of(context).size.height / 932 * 65,
                          ),
                          child: GestureDetector(
                            onTapDown: (_) {
                              Navigator.pop(context);
                            },
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width /
                                      430 *
                                      38,
                                  height: MediaQuery.of(context).size.height /
                                      932 *
                                      38,
                                  child: SvgPicture.asset(
                                      'assets/images/button/home.svg')),
                            ),
                          ),
                        ),
                  (_isOver)
                      ? const SizedBox()
                      : Padding(
                          padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width / 430 * 26,
                            top: MediaQuery.of(context).size.height / 932 * 65,
                          ),
                          child: GestureDetector(
                            onTapDown: (_) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Settings()));
                            },
                            child: Align(
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width /
                                      430 *
                                      38,
                                  height: MediaQuery.of(context).size.height /
                                      932 *
                                      38,
                                  child: SvgPicture.asset(
                                      'assets/images/button/settings.svg')),
                            ),
                          ),
                        ),
                  (_isOver)
                      ? const SizedBox()
                      : Padding(
                          padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width / 430 * 24,
                            bottom:
                                MediaQuery.of(context).size.height / 932 * 24.4,
                          ),
                          child: GestureDetector(
                            onTapDown: (_) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Rules()));
                            },
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width /
                                      430 *
                                      38,
                                  height: MediaQuery.of(context).size.height /
                                      932 *
                                      38,
                                  child: SvgPicture.asset(
                                      'assets/images/button/info.svg')),
                            ),
                          ),
                        ),
                  (_isOver)
                      ? const SizedBox()
                      : Align(
                          alignment: const Alignment(-0.55, 0.9),
                          child: GestureDetector(
                            onTapDown: (_) {
                              setState(() {
                                elementsToChange = elementsList;
                              });
                              Timer(const Duration(milliseconds: 200), () {
                                setState(() {
                                  elementsList = Matrix().firstCreate();
                                  elementsToChange.clear();
                                });
                              });
                            },
                            child: Container(
                                color: Colors.transparent,
                                width: MediaQuery.of(context).size.width /
                                    430 *
                                    38,
                                height: MediaQuery.of(context).size.height /
                                    932 *
                                    38,
                                child: SvgPicture.asset(
                                    'assets/images/button/retry.svg')),
                          ),
                        ),
                  (_isOver)
                      ? const SizedBox()
                      : Align(
                          alignment: const Alignment(0, 0.9),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Center(
                                child: OutlinedText(
                                    text: 'TIME',
                                    fontSize: 18,
                                    outlineSize: 1,
                                    textColor: MainColors.mainCream,
                                    outlineColor: MainColors.mainLightOrange,
                                    shadowColor: Colors.transparent,
                                    textFamily: 'Changa'),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    932 *
                                    47,
                                width: MediaQuery.of(context).size.height /
                                    430 *
                                    153,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: SvgPicture.asset(
                                        'assets/images/background/svg/score_back.svg',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Center(
                                      child: timer(240, 29, () {
                                        setState(() {
                                          if (bestScore < score) {
                                            box.put(0, score);
                                            bestScore = score;
                                          }
                                          _isOver = true;
                                        });
                                      }),
                                    )
                                  ],
                                ),
                              ),
                              const Center(
                                child: OutlinedText(
                                    text: 'SCORE',
                                    fontSize: 18,
                                    outlineSize: 1,
                                    textColor: MainColors.mainCream,
                                    outlineColor: MainColors.mainLightOrange,
                                    shadowColor: Colors.transparent,
                                    textFamily: 'Changa'),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    932 *
                                    47,
                                width: MediaQuery.of(context).size.height /
                                    430 *
                                    153,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: SvgPicture.asset(
                                        'assets/images/background/svg/score_back.svg',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        '$score',
                                        style: changa(29, FontWeight.w800,
                                            MainColors.mainDarkBrown),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                  Align(
                    alignment: const Alignment(0, 0.2),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 430 * 358,
                      height: MediaQuery.of(context).size.height / 932 * 445,
                      child: Stack(
                        children: [
                          for (GameElement i in elementsList)
                            AnimatedPositioned(
                                duration: const Duration(milliseconds: 150),
                                top: (i.pos.y == 0)
                                    ? 0
                                    : i.pos.y *
                                        (MediaQuery.of(context).size.height /
                                                932 *
                                                2 +
                                            MediaQuery.of(context).size.height /
                                                932 *
                                                85),
                                left: (i.pos.x == 0)
                                    ? 0
                                    : i.pos.x *
                                        (MediaQuery.of(context).size.width /
                                                430 *
                                                6 +
                                            MediaQuery.of(context).size.width /
                                                430 *
                                                85),
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTapDown: (_) {
                                        if (first == null) {
                                          setState(() {
                                            first = i;
                                          });
                                        } else if (first == i) {
                                          setState(() {
                                            first == null;
                                          });
                                        } else {
                                          setState(() {
                                            second = i;
                                          });
                                          if ((first!.pos.x ==
                                                      second!.pos.x - 1 &&
                                                  first!.pos.y ==
                                                      second!.pos.y) ||
                                              (first!.pos.x ==
                                                      second!.pos.x + 1 &&
                                                  first!.pos.y ==
                                                      second!.pos.y) ||
                                              (first!.pos.y ==
                                                      second!.pos.y - 1 &&
                                                  first!.pos.x ==
                                                      second!.pos.x) ||
                                              (first!.pos.y ==
                                                      second!.pos.y + 1 &&
                                                  first!.pos.x ==
                                                      second!.pos.x)) {
                                            swapElements(first, second);
                                          } else {
                                            setState(() {
                                              first = null;
                                              second = null;
                                            });
                                          }
                                        }
                                      },
                                      child: Draggable<GameElement>(
                                        data: i,
                                        feedback: SizedBox(
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                932 *
                                                85,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                430 *
                                                85,
                                            child: Center(
                                              child: AnimatedContainer(
                                                duration: const Duration(
                                                    milliseconds: 150),
                                                height: (first == i ||
                                                        second == i)
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        430 *
                                                        65
                                                    : (!elementsToChange
                                                            .contains(i))
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            430 *
                                                            85
                                                        : 0,
                                                width: (first == i ||
                                                        second == i)
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        430 *
                                                        65
                                                    : (!elementsToChange
                                                            .contains(i))
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            430 *
                                                            85
                                                        : 0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              932 *
                                              85,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              430 *
                                              85,
                                          child: Center(
                                            child: AnimatedContainer(
                                              duration: Duration(
                                                  milliseconds:
                                                      (!elementsToChange
                                                              .contains(i))
                                                          ? 100
                                                          : 200),
                                              height: (first == i ||
                                                      second == i)
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      430 *
                                                      65
                                                  : (!elementsToChange
                                                          .contains(i))
                                                      ? MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          430 *
                                                          85
                                                      : 0,
                                              width: (first == i || second == i)
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      430 *
                                                      65
                                                  : (!elementsToChange
                                                          .contains(i))
                                                      ? MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          430 *
                                                          85
                                                      : 0,
                                              child: Image.asset(
                                                i.icon,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    DragTarget<GameElement>(
                                      builder: (BuildContext context,
                                          List incoming, List rejected) {
                                        return SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              932 *
                                              85,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              430 *
                                              85,
                                        );
                                      },
                                      onWillAccept: (data) {
                                        if ((i.pos.x == data!.pos.x - 1 &&
                                                i.pos.y == data.pos.y) ||
                                            (i.pos.x == data.pos.x + 1 &&
                                                i.pos.y == data.pos.y) ||
                                            (i.pos.y == data.pos.y - 1 &&
                                                i.pos.x == data.pos.x) ||
                                            (i.pos.y == data.pos.y + 1 &&
                                                i.pos.x == data.pos.x)) {
                                          return true;
                                        } else {
                                          return false;
                                        }
                                      },
                                      onAccept: (data) {
                                        swapElements(i, data);
                                      },
                                    ),
                                  ],
                                ))
                        ],
                      ),
                    ),
                  ),
                  (_isOver)
                      ? GestureDetector(
                          onTapDown: (_) {},
                          child: Container(
                            color: Colors.transparent,
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/images/background/png/glow.png',
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width /
                                        430 *
                                        26,
                                    top: MediaQuery.of(context).size.height /
                                        932 *
                                        65,
                                  ),
                                  child: GestureDetector(
                                    onTapDown: (_) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Settings()));
                                    },
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              430 *
                                              38,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              932 *
                                              38,
                                          child: SvgPicture.asset(
                                              'assets/images/button/settings.svg')),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width /
                                        430 *
                                        26,
                                    top: MediaQuery.of(context).size.height /
                                        932 *
                                        65,
                                  ),
                                  child: GestureDetector(
                                    onTapDown: (_) {
                                      Navigator.pop(context);
                                    },
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              430 *
                                              38,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              932 *
                                              38,
                                          child: SvgPicture.asset(
                                              'assets/images/button/home.svg')),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: const Alignment(0, -0.68),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        932 *
                                        157,
                                    width: MediaQuery.of(context).size.width /
                                        430 *
                                        150,
                                    child: Image.asset(
                                      'assets/images/icons/png/game_cat_icon.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: const Alignment(0, -0.2),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        932 *
                                        150,
                                    width: MediaQuery.of(context).size.width /
                                        430 *
                                        422,
                                    child: Image.asset(
                                      'assets/images/icons/png/won.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: const Alignment(0, 0.25),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Center(
                                        child: OutlinedText(
                                            text: 'SCORE',
                                            fontSize: 26,
                                            outlineSize: 1,
                                            textColor: MainColors.mainYellow,
                                            outlineColor:
                                                MainColors.mainLightOrange,
                                            shadowColor: Colors.transparent,
                                            textFamily: 'Changa'),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                932 *
                                                70,
                                        width:
                                            MediaQuery.of(context).size.height /
                                                430 *
                                                230,
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: SvgPicture.asset(
                                                'assets/images/background/svg/score_back.svg',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Center(
                                              child: Text(
                                                '$score',
                                                style: changa(
                                                    43,
                                                    FontWeight.w800,
                                                    MainColors.mainDarkBrown),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Center(
                                        child: OutlinedText(
                                            text: 'YOUR BEST SCORE',
                                            fontSize: 26,
                                            outlineSize: 1,
                                            textColor: MainColors.mainYellow,
                                            outlineColor:
                                                MainColors.mainLightOrange,
                                            shadowColor: Colors.transparent,
                                            textFamily: 'Changa'),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                932 *
                                                70,
                                        width:
                                            MediaQuery.of(context).size.height /
                                                430 *
                                                230,
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: SvgPicture.asset(
                                                'assets/images/background/svg/score_back.svg',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Center(
                                              child: Text(
                                                '$bestScore',
                                                style: changa(
                                                    43,
                                                    FontWeight.w800,
                                                    MainColors.mainDarkBrown),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTapDown: (_) {
                                    setState(() {
                                      elementsToChange = elementsList;
                                      _isStarted = false;
                                      _isOver = false;
                                    });
                                    Timer(const Duration(milliseconds: 200),
                                        () {
                                      setState(() {
                                        elementsList = Matrix().firstCreate();
                                        elementsToChange.clear();
                                      });
                                    });
                                  },
                                  child: Align(
                                    alignment: const Alignment(0.0, 0.735),
                                    child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                430 *
                                                71,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                932 *
                                                70,
                                        child: SvgPicture.asset(
                                            'assets/images/button/retry.svg')),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
      ),
    );
  }
}
