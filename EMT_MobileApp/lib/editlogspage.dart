import 'package:flutter/material.dart';
import 'db/logdb_handler.dart';
import 'model/log.dart';

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
    // widget.taskOpj.note = _noteController.text;
    // await Tasks.updateTask(widget.taskOpj);
    // widget.notifyParent();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit Log"),
      content: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(172, 206, 242, 1),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: new Column(
          children: <Widget>[
            TextField(
                decoration: InputDecoration(border: InputBorder.none),
                autofocus: true,
                keyboardType: TextInputType.text,
                maxLines: null,
                controller: _RunNumController),
            Text("EDIT"),
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
