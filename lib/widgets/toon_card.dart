import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/toon_model.dart';
import 'package:flutter_application_1/screens/detail.dart';
import 'package:flutter_application_1/styles/font.dart';
import 'package:flutter_application_1/widgets/thumbnail.dart';

class ToonCard extends StatelessWidget {
  final ToonModel toon;
  const ToonCard({
    super.key,
    required this.toon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              id: toon.id,
              title: toon.title,
              thumb: toon.thumb,
            ),
          ),
        );
        print(toon.title);
      },
      child: Column(
        children: [
          Thumbnail(thumbUrl: toon.thumb),
          SizedBox(
            height: 16,
          ),
          Text(
            toon.title,
            style: TextStyle(
              fontSize: 16,
              fontVariations: [NotoSansKRWeight.w400],
            ),
          )
        ],
      ),
    );
  }
}
