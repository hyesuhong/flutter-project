import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_routes.dart';
import 'package:flutter_application_1/route_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  String getInitialPage() => AppRoutes.home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: getInitialPage(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
