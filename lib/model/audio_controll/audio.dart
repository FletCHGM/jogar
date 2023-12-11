import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '/model/settings/setting.dart';
import '/ui/game/game_repos.dart';

var _themePlayer = AudioPlayer();
playMainTheme() {
  _themePlayer.play(
      AssetSource(
        themePath[Random().nextInt(4)],
      ),
      volume: themeVolume * 0.6);

  _themePlayer.onPlayerStateChanged.listen((event) {
    if (event == PlayerState.completed) {
      _themePlayer.play(
        AssetSource(
          themePath[Random().nextInt(4)],
        ),
      );
    }
  });
}

playSwap() {
  var audioPlayer = AudioPlayer();
  audioPlayer.play(
    AssetSource('sound/effects/swap.mp3'),
    volume: soundVolume,
  );
}

playMatch() {
  var audioPlayer = AudioPlayer();
  audioPlayer.play(
    AssetSource('sound/effects/match.mp3'),
    volume: soundVolume,
  );
}

setThemeVolume(double coaf) {
  themeVolume = coaf * 0.6;
  _themePlayer.setVolume(themeVolume);
}

setSoundVolume(double coaf) {
  soundVolume = coaf;
}

class Handler extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _themePlayer.pause();
    }
    if (state == AppLifecycleState.hidden) {
      _themePlayer.pause();
    }
    if (state == AppLifecycleState.inactive) {
      _themePlayer.pause();
    }
    if (state == AppLifecycleState.resumed) {
      _themePlayer.resume();
    }
    super.didChangeAppLifecycleState(state);
  }
}
