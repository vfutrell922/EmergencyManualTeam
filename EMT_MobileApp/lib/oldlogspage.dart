// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.
import 'package:flutter/material.dart';
import 'db/logdb_handler.dart';
import 'model/log.dart';

class OldLogsPage extends StatefulWidget {
  @override
  _OldLogsPageState createState() => _OldLogsPageState();
}

class _OldLogsPageState extends State<OldLogsPage> {
  List<Log> logs = [];

  @override
  void initState() {
    this._getLogs();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logs'),
        centerTitle: true,
        backgroundColor: Color(0xFFFFFF),
      ),
      body: Container(
        child: _buildLogsList(),
      ),
    );
  }

  void _getLogs() async {
    //TODO: Where we will actually fetch from the database
    //dummmy data right now
    //List tempList = ["Nov 10, 2020", "Nov 11, 2020", "Nov 12, 2020"];

    List<Log> dbList = await LogDatabase.instance.readAll();

    setState(() {
      logs = dbList;
    });
  }

  Widget _buildLogsList() {
    return ListView.builder(
      //itemCount: logs == null ? 0 : logs.length,
      itemCount: logs.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text('Run ID: ${logs[index].id}'),
          subtitle: Text('Run Time: ${logs[index].logData}'),
          //TODO Trailing icon here, check yaml file
          onTap: () => print(logs.length),
        );
      },
    );
  }
}
