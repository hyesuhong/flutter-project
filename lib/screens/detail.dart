import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/header_bar.dart';
import 'package:flutter_application_1/widgets/thumbnail.dart';

class DetailScreen extends StatelessWidget {
  final String id, title, thumb;
  const DetailScreen({
    super.key,
    required this.id,
    required this.title,
    required this.thumb,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(
        title: title,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Thumbnail(
                thumbUrl: thumb,
              ),
            ],
          )
        ],
      ),
    );
  }
}
