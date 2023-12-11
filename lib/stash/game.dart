import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

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
  @override
  void initState() {
    elementsList = Matrix().firstCreate();
    super.initState();
  }

  double width(double coaf, BuildContext context) {
    var res = MediaQuery.of(context).size.width / 720 * coaf;
    return res;
  }

  double height(double coaf, BuildContext context) {
    var res = MediaQuery.of(context).size.height / 1280 * coaf;
    return res;
  }

  swapElements(a, b) {
    setState(() {
      elementsToChange = Matrix().swapElements(a, b, elementsList);
    });
    if (elementsToChange.isEmpty) {
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
        gradient: RadialGradient(radius: 1.1, colors: [
          Colors.white,
          Colors.red,
          Colors.black,
        ]),
      ),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    elementsToChange = elementsList;
                  });
                  Timer(const Duration(milliseconds: 200), () {
                    setState(() {
                      elementsList = Matrix().firstCreate();
                      elementsToChange.clear();
                      score -= 50;
                    });
                  });
                },
                icon: const Icon(Icons.refresh))
          ],
          backgroundColor: const Color.fromARGB(137, 85, 0, 0),
          title: Center(
              child: Text(
            'SCORE: $score',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
              fontSize: width(46, context),
            ),
          )),
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
                child: Container(
              height: 0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
              ),
            )),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(128, 255, 0, 0),
                      Colors.black54
                    ]),
                    border: Border.all(color: Colors.black, width: 4),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25),
                    )),
                height: width(644, context),
                width: width(644, context),
                child: Center(
                  child: SizedBox(
                    height: width(590, context),
                    width: width(622, context),
                    child: Stack(
                      children: [
                        for (GameElement i in elementsList)
                          AnimatedPositioned(
                              duration: const Duration(milliseconds: 150),
                              top: (i.pos.y == 0)
                                  ? 0
                                  : i.pos.y *
                                      (width(2.5, context) +
                                          width(116, context)),
                              left: (i.pos.x == 0)
                                  ? 0
                                  : i.pos.x *
                                      (width(10.5, context) +
                                          width(116, context)),
                              child: Stack(
                                children: [
                                  InkWell(
                                    hoverColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      if (first == null) {
                                        setState(() {
                                          first = i;
                                        });
                                      }
                                      if (i == first) {
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
                                          height: width(115, context),
                                          width: width(115, context),
                                          child: Center(
                                            child: AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 150),
                                              height:
                                                  (first == i || second == i)
                                                      ? width(90, context)
                                                      : (!elementsToChange
                                                              .contains(i))
                                                          ? width(115, context)
                                                          : 0,
                                              width: (first == i || second == i)
                                                  ? width(90, context)
                                                  : (!elementsToChange
                                                          .contains(i))
                                                      ? width(115, context)
                                                      : 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: SizedBox(
                                        height: width(115, context),
                                        width: width(115, context),
                                        child: Center(
                                          child: AnimatedContainer(
                                            duration: Duration(
                                                milliseconds: (!elementsToChange
                                                        .contains(i))
                                                    ? 100
                                                    : 200),
                                            height: (first == i || second == i)
                                                ? width(90, context)
                                                : (!elementsToChange
                                                        .contains(i))
                                                    ? width(115, context)
                                                    : 0,
                                            width: (first == i || second == i)
                                                ? width(90, context)
                                                : (!elementsToChange
                                                        .contains(i))
                                                    ? width(115, context)
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
                                        height: width(115, context),
                                        width: width(115, context),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
