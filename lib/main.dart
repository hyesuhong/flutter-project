import 'package:flutter/material.dart';

import 'screens/home.dart';
import 'screens/users.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      // home: const UsersPage(title: 'Home'),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/users': (context) => const UsersPage(),
      },
    );
  }
}
