import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void flutterDialog(
    BuildContext context, String title, String content, String buttonText) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.transparent,
    builder: (BuildContext context) {
      return Platform.isAndroid
          ? AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(buttonText),
                )
              ],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            )
          : CupertinoAlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                  CupertinoDialogAction(
                    child: Text(buttonText),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ]);
    },
  );
}
