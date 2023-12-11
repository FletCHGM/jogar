import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/model/bloc/logic_bloc.dart';

class Core extends StatefulWidget {
  const Core({super.key});

  @override
  State<Core> createState() => _CoreState();
}

class _CoreState extends State<Core> {
  final _coreBloc = LogicBloc();

  @override
  initState() {
    _coreBloc.add(AppInit());
    super.initState();
  }

  coreSwitch() {
    var state = _coreBloc.state;
    return switch (state) {
      LogicInitial() => state.widget,
      Loaded() => state.widget,
      NotLoaded() => state.widget,
      Loading() => state.widget,
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<LogicBloc, LogicState>(
          bloc: _coreBloc,
          builder: (context, state) {
            var returned = coreSwitch();
            return returned;
          }),
    );
  }
}
