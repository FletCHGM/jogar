part of 'logic_bloc.dart';

sealed class LogicState {
  Widget widget = const SizedBox();
}

class LogicInitial implements LogicState {
  @override
  Widget widget = const SizedBox();
}

class Loading implements LogicState {
  @override
  late Widget widget = const Splash();
}

class Loaded implements LogicState {
  final String parsedValue;
  @override
  late Widget widget = InGameWidget(parsedValue: parsedValue);

  Loaded({required this.parsedValue});
}

class NotLoaded implements LogicState {
  @override
  late Widget widget = const Menu();
}
