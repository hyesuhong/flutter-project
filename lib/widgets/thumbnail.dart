import 'package:flutter/material.dart';

class Thumbnail extends StatelessWidget {
  final String id, thumbUrl;
  const Thumbnail({
    super.key,
    required this.id,
    required this.thumbUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: id,
      child: Container(
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
          thumbUrl,
          headers: const {
            "User-Agent":
                "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
          },
        ),
      ),
    );
  }
}
