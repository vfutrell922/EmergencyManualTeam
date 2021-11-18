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

  Future _save() async {
    try {
      int? newRunNum = int.parse(_RunNumController.text);

      if (newRunNum != '${curLog.runNum}') {
        Log newLog = Log(
            runNum: newRunNum,
            additionalData: curLog.additionalData,
            id: curLog.id,
            startTime: curLog.startTime,
            endTime: curLog.endTime);
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
            ErrorDialog(msg: "Please enter a number for Run Number."),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit Log"),
      content: Container(
        child: new Column(
          children: <Widget>[
            new Container(
                child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "Run Number:",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20.0),
                ),
                new Container(
                  width: 35.0,
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
            )),
          ],
        ),
      ),
      actions: <Widget>[
        new IconButton(
          icon: new Icon(Icons.save),
          onPressed: _save,
        ),
      ],
    );
  }
}

// Widget _editDialog(BuildContext context) {
//   return new AlertDialog(
//     title: Text('Delete Log?'),
//     actions: <Widget>[
//       new Text(
//           "Are you sure you want to delete log for Run ${curLog.runNum}  ?"),
//       TextButton(
//         child: Text('CANCEL'),
//         onPressed: () {
//           setState(() {
//             Navigator.pop(context);
//           });
//         },
//       ),
//       TextButton(
//         child: Text('Delete Log',
//             style: TextStyle(
//               color: Colors.red,
//             )),
//         onPressed: () async {
//           Navigator.pop(context);
//           //Navigator.pop(context, true);
//           await LogDatabase.instance.deleteLog(curLog.id!).then((value) {
//             Navigator.pop(context, true);
//           });
//         },
//       ),
//     ],
//   );
// }
