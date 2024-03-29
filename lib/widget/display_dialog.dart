import 'package:flutter/material.dart';

Future<void> showErrorDialog(
  context,
  String title,
  String msg,
) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  msg,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.0 ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("ok"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
}
