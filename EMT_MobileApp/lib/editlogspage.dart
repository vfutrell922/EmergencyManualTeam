// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.
import 'package:flutter/material.dart';
import 'db/logdb_handler.dart';
import 'model/log.dart';
import 'errordialog.dart';
import 'oldlogspage.dart';

class EditLogOverlay extends StatefulWidget {
  final Log curLog;

  EditLogOverlay({required this.curLog});
  @override
  State<StatefulWidget> createState() => _EditLogOverlayState(curLog: curLog);
}

class _EditLogOverlayState extends State<EditLogOverlay> {
  final Log curLog;

  _EditLogOverlayState({required this.curLog});

  late TextEditingController _RunNumController;
  @override
  void initState() {
    _RunNumController = TextEditingController.fromValue(
      TextEditingValue(
        text: '${curLog.runNum}',
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _RunNumController.dispose();
    super.dispose();
  }

  /// Save the editted run number if it is different and a number, and reload page.
  Future _save() async {
    try {
      int? newRunNum = int.parse(_RunNumController.text);
      //check if the new run number has changed
      if (newRunNum != '${curLog.runNum}') {
        Log newLog = Log(
            runNum: newRunNum,
            additionalData: curLog.additionalData,
            id: curLog.id,
            startTime: curLog.startTime,
            endTime: curLog.endTime);
        //replace the log with the new data
        await LogDatabase.instance.updateLog(newLog).then((id) {
          setState(() {
            Navigator.pop(context);
          });
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new OldLogsPage()),
          );
        });
      }
    } catch (FormatException) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            ErrorDialog(msg: "Please enter a number."),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit Log"),
      actions: <Widget>[
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "Run Number:",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20.0),
            ),
            new Container(
              width: 50.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                  controller: _RunNumController),
            ),
          ],
        ),
        new IconButton(
          icon: new Icon(Icons.save),
          onPressed: _save,
        ),
      ],
    );
  }
}
