import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  ErrorMessage({Key? key, String error=""}) : super(key: key){
    this.error = error;
  }
  String error = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error occurred'),
      content: Text('$error'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
