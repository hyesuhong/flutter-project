import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/toon_model.dart';
import 'package:flutter_application_1/screens/detail.dart';
import 'package:flutter_application_1/styles/font.dart';

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
            ),
          ),
        );
        print(toon.title);
      },
      child: Column(
        children: [
          Container(
            width: 250,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  offset: Offset(0, 8),
                  color: Colors.black.withOpacity(0.3),
                )
              ],
            ),
            child: Image.network(
              toon.thumb,
              headers: const {
                "User-Agent":
                    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
              },
            ),
          ),
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
