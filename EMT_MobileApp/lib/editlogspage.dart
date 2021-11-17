import 'package:flutter/material.dart';
import 'db/logdb_handler.dart';
import 'model/log.dart';

class EditLogOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EditLogOverlayState();
}

class EditLogOverlayState extends State<EditLogOverlay>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
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
              Text("EDIT"),
            ],
          ),
        ));
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
