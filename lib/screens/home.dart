import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/home_body_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return HomeBody();
          } else {
            return Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 600,
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      spreadRadius: 10,
                      offset: Offset.zero,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ],
                ),
                child: HomeBody(),
              ),
            );
          }
        },
      ),
    );
  }
}
