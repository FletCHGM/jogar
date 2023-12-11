import 'package:flutter/material.dart';
import '/ui/core/core.dart';
import '/model/audio_controll/audio.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding.instance.addObserver(Handler());
  runApp(const Core());
}
