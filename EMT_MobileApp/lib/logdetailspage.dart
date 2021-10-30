// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.

import 'package:flutter/material.dart';
import 'package:emergencymanual/icons.dart';
import 'model/log.dart';
import 'db/logdb_handler.dart';

class LogDetailsPage extends StatefulWidget {
  final Log curLog;
  LogDetailsPage({required this.curLog});

  @override
  _LogDetailsState createState() => _LogDetailsState(curLog: curLog);
}

// class EditDetailsPage extends StatefulWidget {
//   bool editLog = false;
//   EditDetailsPage({required editingLog});
//   @override
//   _EditDetailsState createState() => _EditDetailsState(editingLog: editLog);
// }

class LogBar extends StatefulWidget {
  @override
  _LogState createState() => _LogState();
}

int _selectedIndex = 0;
bool editingLog = false; //TODO does this get reset each time?

class _LogDetailsState extends State<LogDetailsPage> {
  final Log curLog;
  _LogDetailsState({required this.curLog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Run Number: ${curLog.runNum}'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'Edit Log',
              onPressed: () {
                // showDialog(
                //   context: context,
                //   builder: (BuildContext context) =>
                //       _EditDetailsState(context, true),
                // );
              }
              // TODO handle the press (create edit pop-up)
              ),
          IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Delete Log',
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => _deleteDialog(context),
                );
              })
        ],
        backgroundColor: Color(0xFFFFFF),
      ),
      body: //EditDetailsPage(editingLog: false),
          new Center(
        child: _buildEditLog(),

        // child: new Column(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: <Widget>[
        //       new Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           new Text("Date Performed: March 10, 2021"),
        //         ],
        //       )
        //     ]),
      ),
      bottomNavigationBar: LogBar(),
    );
  }

  Widget _buildEditLog() {
    List additionalDataList =
        LogDatabase.instance.additionalDataRetrieve(curLog.id!);
    return ListView.builder(
      itemCount: additionalDataList == null ? 0 : additionalDataList.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text('we made it boys'), //additionalDataList[index]),
        );
      },
    );
  }

  Widget _deleteDialog(BuildContext context) {
    return new AlertDialog(
      title: Text('Delete Log?'),
      actions: <Widget>[
        new Text(
            "Are you sure you want to delete log for Run ${curLog.runNum}  ?"),
        TextButton(
          child: Text('CANCEL'),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
        TextButton(
          child: Text('Delete Log',
              style: TextStyle(
                color: Colors.red,
              )),
          onPressed: () async {
            await LogDatabase.instance.deleteLog(curLog.id!).then((value) {
              setState(() {
                Navigator.pop(context);
              });
              Navigator.pop(context, true); //send back to oldLogsPage
            });
            //Future.delayed(Duration.zero, () {
          },
        ),
      ],
    );
  }
}

//TODO sierra this is for edit widget if trying to make that work
// class _EditDetailsState extends State<EditDetailsPage> {
//   _EditDetailsState(BuildContext context, {required bool editingLog});
//   @override
//   Widget build(BuildContext context) {
//     return new Center(
//       child: new Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             new Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 new Text("Date Performed: March 10, 2021"),
//               ],
//             )
//           ]),
//     );
//   }
// }

class _LogState extends State<LogBar> {
  @override
  Widget build(BuildContext context) {
    return new BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        });
  }
}
