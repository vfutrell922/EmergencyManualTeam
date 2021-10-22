import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'db/logdb_handler.dart';
import 'model/log.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class LogPage extends StatefulWidget {
  @override
  _LogPageState createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(); // Create instance.

  Future readLog(int id) async {
    return await LogDatabase.instance.read(id);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose(); // Need to call dispose function.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Logging'),
          centerTitle: true,
          backgroundColor: Color(0xFFFFFF),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<int>(
              stream: _stopWatchTimer.rawTime,
              initialData: _stopWatchTimer.rawTime.value,
              builder: (context, snapshot) {
                final value = snapshot.data;
                final displayTime =
                    StopWatchTimer.getDisplayTime(value!, hours: true);
                return Text(
                  displayTime,
                  style: const TextStyle(
                      fontSize: 40.0, fontWeight: FontWeight.bold),
                );
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                    createLog();
                  },
                  child: new Text("Start"),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                  },
                  child: new Text("Stop"),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    //TODO delete current log or are we removing the reset entirely?
                    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                  },
                  child: new Text("Reset"),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ElevatedButton(
            //       onPressed:
            //           addLog, //TODO sierra want to promt user for run number here
            //       child: new Text("Store"),
            //     )
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context),
                      );
                    },
                    child: Text("testing popup")),
              ],
            ),
          ],
        )));
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Popup example'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text("TODO ",
              style: TextStyle(
                color: Colors.red,
              )),
          new TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Run Number'),
            onChanged: (text) {
              updateLog(text);
            },
          )
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            // TODO here?
            // updateLog();
            Navigator.of(context).pop();
          },
          child: const Text('Save Log'),
        ),
      ],
    );
  }

  // TODO activated when "start" is pressed
  Future createLog() async {
    final log = Log(
      // the start time?? TODO
      // datetime.now
      runTime: _stopWatchTimer.rawTime.value.toString(),
    );
    await LogDatabase.instance.add(log);
  }

  //TODO not using this anymore, should instead use "createLog" on "start" press
  // and "updateLog" when changes are made
  // Future addLog() async {
  //   final log = Log(
  //     runTime: _stopWatchTimer.rawTime.value.toString(),
  //     //TODO create json string here
  //   );
  //
  //  await LogDatabase.instance.add(log);
  //}

  // called anytime the log is running and they add more info
  // or if they go back and update info
  // TODO this will have a lot of backend work (or will need more specific functions) to differentiate what they're updating
  Future<void> updateLog(String data) async {
    //TODO this stuff will eventually be global instead
    int hardId = 1;
    Future<Log> curLog = LogDatabase.instance.read(hardId);

    final log = Log(
        //TODO

        );

    await LogDatabase.instance.updateLog(log);
  }
}
