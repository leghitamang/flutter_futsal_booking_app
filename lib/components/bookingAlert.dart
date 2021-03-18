import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  final String title;
  final String message;
  Alert(this.title, this.message);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('OK'),
        )
      ],
    );
  }
}