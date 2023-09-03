import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String errMessage;

  const ErrorDialog(this.errMessage, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: Text(errMessage),
      actions: [
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
