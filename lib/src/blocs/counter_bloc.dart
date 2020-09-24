import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../resources/grpc/math_grpc_provider.dart';


class CounterProvider extends InheritedWidget {
  final CounterBloc bloc;

  CounterProvider({Key key, Widget child})
      : bloc = CounterBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  static CounterBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<CounterProvider>()).bloc;
  }
}

class CounterBloc {
  final _repo = MathGrpcProvider();
  final _counter = PublishSubject<int>();

  Stream<int> get counter => _counter.stream;

  int defaultValue = 1;

  addNumber(int i) async {
    final res = await _repo.add(i);

    print('hasil grpc: ${res.result}');

    return _counter.sink.add(res.result.toInt());
  }

  dispose() {
    _counter.close();
  }
}
