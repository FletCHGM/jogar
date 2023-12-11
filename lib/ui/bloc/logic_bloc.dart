import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'logic_event.dart';
part 'logic_state.dart';

class LogicBloc extends Bloc<Load, LogicState> {
  LogicBloc() : super(LogicInitial()) {
    on<Load>((event, emit) {});
  }
}
