import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/flutter_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '$_counter',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton(
                onPressed: _decrementCounter,
                child: const Icon(Icons.remove),
              ),
              ElevatedButton(
                onPressed: _incrementCounter,
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () =>
              flutterDialog(context, 'Hello dialog', 'Hello world', 'Hello'),
          child: const Text('Say Hello'),
        ),
      ],
    )));
  }
}
