import 'package:flutter/material.dart';

class ErrorDialog extends StatefulWidget {
  final String msg;
  ErrorDialog({required this.msg});
  @override
  State<StatefulWidget> createState() => _ErrorDialogState(msg: msg);
}

class _ErrorDialogState extends State<ErrorDialog> {
  final String msg;
  _ErrorDialogState({required this.msg});
  late TextEditingController _RunNumController;
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
