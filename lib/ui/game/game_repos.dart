import 'dart:math';
import 'package:flutter/material.dart';

final icons = [
  'assets/images/icons/png/icon_10.png',
  'assets/images/icons/png/icon_A.png',
  'assets/images/icons/png/icon_catgirl.png',
  'assets/images/icons/png/icon_cleo.png',
  'assets/images/icons/png/icon_gward.png',
  'assets/images/icons/png/icon_J.png',
  'assets/images/icons/png/icon_K.png',
  'assets/images/icons/png/icon_Q.png',
];

final List<String> themePath = [
  'sound/theme/20311.mp3',
  'sound/theme/20312.mp3',
  'sound/theme/20313.mp3',
  'sound/theme/20314.mp3',
];

class ElementPosition {
  int x;
  int y;
  ElementPosition({
    required this.x,
    required this.y,
  });
}

class GameElement {
  ElementPosition pos;
  String icon;
  GameElement({
    required this.icon,
    required this.pos,
  });
}

class Matrix {
  List<GameElement> firstCreate() {
    List<GameElement> elementsList = [];
    var rand = Random();

    for (var y = 0; y < 5; y++) {
      for (var x = 0; x < 4; x++) {
        var element = GameElement(
            pos: ElementPosition(x: x, y: y), icon: icons[rand.nextInt(8)]);
        elementsList.add(element);
        try {
          while (element.icon ==
                  elementsList[elementsList.indexOf(element) - 1].icon &&
              element.icon ==
                  elementsList[elementsList.indexOf(element) - 2].icon) {
            elementsList[elementsList.indexOf(element)].icon =
                icons[rand.nextInt(8)];
          }
        } catch (_) {}
        try {
          while (element.icon ==
                  elementsList[elementsList.indexOf(element) + 1].icon &&
              element.icon ==
                  elementsList[elementsList.indexOf(element) + 2].icon) {
            elementsList[elementsList.indexOf(element)].icon =
                icons[rand.nextInt(8)];
          }
        } catch (_) {}
        try {
          while (element.icon ==
                  elementsList[elementsList.indexOf(element) - 4].icon &&
              element.icon ==
                  elementsList[elementsList.indexOf(element) - 8].icon) {
            elementsList[elementsList.indexOf(element)].icon =
                icons[rand.nextInt(8)];
          }
        } catch (_) {}
        try {
          while (element.icon ==
                  elementsList[elementsList.indexOf(element) + 4].icon &&
              element.icon ==
                  elementsList[elementsList.indexOf(element) + 8].icon) {
            elementsList[elementsList.indexOf(element)].icon =
                icons[rand.nextInt(8)];
          }
        } catch (_) {}
      }
    }
    return elementsList;
  }

  GameElement pickElement(
      List<List<GameElement>> elements, ElementPosition pos) {
    var row = elements[pos.y];
    GameElement res = row[pos.x];
    return res;
  }

  matchHorizontal(GameElement element, List<GameElement> elementsList) {
    List<GameElement> row = [];
    Map<int, GameElement> matches = {};
    List<GameElement> res = [element];
    for (GameElement i in elementsList) {
      if (i.pos.y == element.pos.y) {
        row.add(i);
      }
    }

    for (var i in row) {
      if (element.icon == i.icon) {
        matches.addAll({i.pos.x: i});
      }
    }
    var keys = matches.keys.toList();
    keys.sort();
    row.clear();
    for (var i in keys) {
      GameElement a = matches[i]!;
      row.add(a);
    }
    var x = element.pos.x;
    for (var i = row.indexOf(element); i > 0; i--) {
      if (row[i - 1].pos.x == x - 1) {
        x = row[i - 1].pos.x;
        res.add(row[i - 1]);
      }
    }
    x = element.pos.x;
    for (var i = row.indexOf(element); i < row.length - 1; i++) {
      if (row[i + 1].pos.x == x + 1) {
        x = row[i + 1].pos.x;
        res.add(row[i + 1]);
      }
    }

    return res;
  }

  matchVertical(GameElement element, List<GameElement> elementsList) {
    List<GameElement> row = [];
    Map<int, GameElement> matches = {};
    List<GameElement> res = [element];
    for (GameElement i in elementsList) {
      if (i.pos.x == element.pos.x) {
        row.add(i);
      }
    }

    for (var i in row) {
      if (element.icon == i.icon) {
        matches.addAll({i.pos.y: i});
      }
    }
    var keys = matches.keys.toList();
    keys.sort();
    row.clear();
    for (var i in keys) {
      GameElement a = matches[i]!;
      row.add(a);
    }
    var y = element.pos.y;
    for (var i = row.indexOf(element); i > 0; i--) {
      if (row[i - 1].pos.y == y - 1) {
        y = row[i - 1].pos.y;
        res.add(row[i - 1]);
      }
    }
    y = element.pos.y;
    for (var i = row.indexOf(element); i < row.length - 1; i++) {
      if (row[i + 1].pos.y == y + 1) {
        y = row[i + 1].pos.y;
        res.add(row[i + 1]);
      }
    }
    return res;
  }

  List<GameElement> match(GameElement element, List<GameElement> elementsList) {
    List<GameElement> x = matchHorizontal(element, elementsList);
    List<GameElement> y = matchVertical(element, elementsList);
    if (x.length < 3) {
      x = [];
    }
    if (y.length < 3) {
      y = [];
    }
    for (var i in y) {
      x.add(i);
    }
    return x;
  }

  swapElements(GameElement a, GameElement b, List<GameElement> elementsList) {
    var posA = a.pos;
    var posB = b.pos;

    a.pos = posB;
    b.pos = posA;
    var matchA = match(a, elementsList);
    var matchB = match(b, elementsList);
    for (var i in matchB) {
      matchA.add(i);
    }
    for (var i in matchA) {
      debugPrint('x${i.pos.x} y${i.pos.y} ${i.icon}');
    }
    return matchA;
  }
}
