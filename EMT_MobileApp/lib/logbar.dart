import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'globals.dart' as globals;
import 'model/log.dart';
import 'db/logdb_handler.dart';
import 'oldlogspage.dart';

class LogBar extends StatefulWidget {
  @override
  _LogState createState() => _LogState();
}

int _selectedIndex = 0;

class _LogState extends State<LogBar> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _textFieldController = TextEditingController();
    BottomNavigationBarItem leftSideItem =
        new BottomNavigationBarItem(icon: Icon(Icons.add_photo_alternate));
    if (globals.currentLogID == -1) {
      leftSideItem = BottomNavigationBarItem(
        icon: Icon(Icons.add_circle_outline),
        label: 'Start New Log',
        backgroundColor: Colors.lightGreen,
      );
    } else {
      leftSideItem = BottomNavigationBarItem(
        icon: Icon(Icons.download_done_outlined),
        label: 'Stop Current Log',
        backgroundColor: Colors.red[400],
      );
    }
    return new BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.shifting,
        items: <BottomNavigationBarItem>[
          leftSideItem,
          BottomNavigationBarItem(
            icon: Icon(Icons.preview_outlined),
            label: 'Review Logs',
            backgroundColor: Colors.blue[400],
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueGrey[800],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 0) {
            if (globals.currentLogID == -1) {
              globals.currentLogID = globals.nextLogID;
              globals.nextLogID++;
              addLog();
            } else {
              String valueText = "0";
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Save Log'),
                      content: TextField(
                        onChanged: (value) {
                          setState(() {
                            valueText = value;
                          });
                        },
                        controller: _textFieldController,
                        decoration: InputDecoration(hintText: "Run Number"),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('CANCEL'),
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                        ),
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                              addRunNum(int.parse(valueText));
                              globals.currentLogID = -1;
                            });
                          },
                        ),
                      ],
                    );
                  });
            }
            ;
          } else if (index == 1) {
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new OldLogsPage()),
            );
          }
        });
  }

  Future addLog() async {
    DateTime startTime = DateTime.now();
    String formattedTime = DateFormat('yyyy-MM-dd – kk:mm').format(startTime);

    final log = Log(startTime: formattedTime);
    await LogDatabase.instance.add(log);
  }

  Future addRunNum(int runNumber) async {
    Log currentLog = await LogDatabase.instance.read(globals.currentLogID);
    Log newLog = currentLog.copy(runNum: runNumber);
    await LogDatabase.instance.updateLog(newLog);
  }
}
