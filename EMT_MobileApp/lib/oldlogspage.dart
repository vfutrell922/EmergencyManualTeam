// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.
import 'package:emergencymanual/logdetailspage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'db/logdb_handler.dart';
import 'model/log.dart';
import 'homepage.dart';

class OldLogsPage extends StatefulWidget {
  @override
  _OldLogsPageState createState() => _OldLogsPageState();
}

int _selectedIndex = 0;

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
      itemCount: logs.length,
      itemBuilder: (BuildContext context, int index) {
        return new Card(
          child: ListTile(
              title: Text('Run ID: ${logs[index].runNum}'),
              subtitle: Text('Run Time: ${logs[index].startTime}'),
              selectedTileColor: Colors.grey[300],
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {
                Navigator.of(context)
                    .push(
                  new MaterialPageRoute(
                      builder: (context) =>
                          new LogDetailsPage(curLog: logs[index])),
                )
                    .then(
                  (_) {
                    setState(() {});
                  },
                );
              }),
        );
      },
    );
  }
}
