import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/ui/menu/menu.dart';
import '/ui/splash/splash.dart';
import '/ui/online_game/widgets/online_game.dart';
import '/model/hive/best_score.dart';
import '/model/parser/parser.dart';

part 'logic_event.dart';
part 'logic_state.dart';

class LogicBloc extends Bloc<Load, LogicState> {
  LogicBloc() : super(LogicInitial()) {
    on<AppInit>((event, emit) async {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      emit(Loading());
      await Hive.initFlutter();
      Hive.registerAdapter(BestScoreAdapter());
      box = await Hive.openBox<int>('BestScore');
      if (box.isEmpty) {
        box.put(0, 0);
      }
      try {
        await Parser().initParser();
        String? parsedValue = await Parser().parseObject();
        if (parsedValue != null && parsedValue != 'Jogo333') {
          if (parsedValue.isNotEmpty &&
              await Parser().checkExistance(parsedValue) != 404) {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ]);
            emit(Loaded(parsedValue: parsedValue));
          } else {
            emit(NotLoaded());
          }
        } else {
          emit(NotLoaded());
        }
      } on Exception catch (_) {
        emit(NotLoaded());
      }
    });
  }
}
