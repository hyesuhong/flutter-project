import 'package:flutter/material.dart';
import 'package:flutter_application_1/styles/font.dart';

class HeaderBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double headerHeight = 56;

  const HeaderBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black12,
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey[600],
        elevation: 5,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontVariations: [NotoSansKRWeight.w500],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(headerHeight);
}
