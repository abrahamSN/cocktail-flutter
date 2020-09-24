import 'package:flutter/material.dart';

import '../../blocs/counter_bloc.dart';

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = CounterProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Counter GRPC'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Call the server and increment the number by 3:'),
            StreamBuilder(
              stream: bloc.counter,
              initialData: bloc.defaultValue,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Text(
                  '${snapshot.data}',
                  style: TextStyle(fontSize: 20),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: StreamBuilder(
        stream: bloc.counter,
        initialData: bloc.defaultValue,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return FloatingActionButton(
            onPressed: () => bloc.addNumber(snapshot.data),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          );
        },
      ),
    );
  }
}
