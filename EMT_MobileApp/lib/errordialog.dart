// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.
import 'package:flutter/material.dart';

class ErrorDialog extends StatefulWidget {
  final String msg;
  ErrorDialog({required this.msg});
  @override
  State<StatefulWidget> createState() => _ErrorDialogState(msg: msg);
}

class _ErrorDialogState extends State<ErrorDialog> {
  /// the message to display
  final String msg;

  _ErrorDialogState({required this.msg});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: Text(msg),
      actions: <Widget>[
        TextButton(
          child: Text('Ok'),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
      ],
    );
  }
}
