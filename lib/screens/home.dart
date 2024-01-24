import 'dart:async';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int totalSeconds = 1500;
  late Timer timer;

  void onTick(Timer timer) {
    print(timer);
    setState(() {
      totalSeconds--;
    });
  }

  void onStartPressed() {
    timer = Timer.periodic(
      Duration(
        seconds: 1,
      ),
      onTick,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Flexible(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                totalSeconds.toString(),
                style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 88,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: IconButton(
                iconSize: 112,
                color: Theme.of(context).cardColor,
                icon: Icon(Icons.play_circle_outline),
                onPressed: () => onStartPressed(),
              ),
            ),
          ),
          Flexible(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                            fontSize: 20,
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
                          ),
                        ),
                        Text(
                          '0',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w500,
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
