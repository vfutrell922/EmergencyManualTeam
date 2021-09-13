import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../db/logdb_handler.dart';
import '../model/log.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class LogPage extends StatefulWidget {
  @override
  _LogPageState createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(); // Create instance.

  Future readLog(int id) async {
    return await logDatabase.instance.readLog(id);
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
                    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                  },
                  child: new Text("Reset"),
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
                  onPressed: addLog,
                  child: new Text("Store"),
                )
              ],
            )
          ],
        )));
  }

  Future addLog() async {
    final log = Log(
      id: 2,
      logData: _stopWatchTimer.rawTime.value.toString(),
    );

    await logDatabase.instance.create(log);
  }
}
