import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// A simple model class
class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // Notifies listeners to rebuild the UI
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Provider Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('You have pushed the button this many times:'),
              Consumer<Counter>(
                builder: (context, counter, child) {
                  // Child parameter is used to optimize the performance
                  // by not rebuilding the child widget when the model changes
                  // because it is state-independent.
                  // In order to use it, you need to pass the child widget to the Consumer widget.
                  return Text(
                    '${counter.count}',
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<Counter>().increment();
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}