import 'dart:async';

import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  static const timerSeconds = 10;

  int totalSeconds = timerSeconds;
  bool isRunning = false;
  int totalPomodoros = 0;

  bool resettable = false;

  late Timer timer;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      timer.cancel();
      setState(() {
        totalPomodoros++;
        isRunning = false;
        totalSeconds = timerSeconds;
      });
    } else {
      setState(() {
        totalSeconds--;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      Duration(
        seconds: 1,
      ),
      onTick,
    );

    setState(() {
      isRunning = true;
      resettable = true;
    });
  }

  void onPausePressed() {
    timer.cancel();

    setState(() {
      isRunning = false;
    });
  }

  void onRefreshPressed() {
    timer.cancel();
    setState(() {
      totalPomodoros = 0;
      isRunning = false;
      totalSeconds = timerSeconds;
      resettable = false;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        children: [
          Flexible(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 112,
                    color: Theme.of(context).cardColor,
                    icon: isRunning
                        ? Icon(Icons.pause_circle_outline)
                        : Icon(Icons.play_circle_outline),
                    onPressed: () =>
                        isRunning ? onPausePressed() : onStartPressed(),
                  ),
                  AnimatedPadding(
                    padding: resettable
                        ? EdgeInsets.only(
                            bottom: 32,
                          )
                        : EdgeInsets.zero,
                    duration: Duration(
                      milliseconds: 300,
                    ),
                    curve: Curves.linear,
                  ),
                  AnimatedSwitcher(
                    duration: Duration(
                      milliseconds: 300,
                    ),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    switchInCurve: Curves.linear,
                    switchOutCurve: Curves.linear,
                    child: resettable
                        ? IconButton(
                            icon: Icon(Icons.refresh),
                            iconSize: 32,
                            color: Theme.of(context).cardColor,
                            onPressed: () => onRefreshPressed(),
                          )
                        : SizedBox.shrink(),
                  )
                ],
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
                          '$totalPomodoros',
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
