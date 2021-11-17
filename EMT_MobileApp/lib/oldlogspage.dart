// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.
import 'package:emergencymanual/logdetailspage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'db/logdb_handler.dart';
import 'model/log.dart';
import 'phonepage.dart';

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
      floatingActionButton: PhoneButton(context),
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
    List<Log> dbList = await LogDatabase.instance.readAll();

    //dbList.forEach((Log curlog) { curlog.runNum == null ? curlog.runNum = -1});

    setState(() {
      logs = new List.from(dbList.reversed);
    });
  }

  Widget _buildLogsList() {
    return ListView.builder(
      itemCount: logs.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
            child: new GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(
                  new MaterialPageRoute(
                      builder: (context) =>
                          new LogDetailsPage(curLog: logs[index])),
                )
                .then((val) => {_getLogs()});
          },
          child: Container(
              child: new Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Container(
                      child: Text(
                        'Run ID: ${logs[index].runNum}',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 25.0),
                      ),
                    ),
                    new Container(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new GestureDetector(
                            onTap: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    _deleteLogDialog(context, logs[index]),
                              );
                            },
                            child: new Container(
                                margin: const EdgeInsets.all(0.0),
                                child: new Icon(
                                  Icons.delete,
                                  size: 30.0,
                                )),
                          ),
                          new GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            new LogDetailsPage(
                                                curLog: logs[index])),
                                  )
                                  .then((val) => {_getLogs()});
                            },
                            child: new Container(
                                margin: const EdgeInsets.all(0.0),
                                child: new Icon(
                                  Icons.create_outlined,
                                  size: 30.0,
                                )),
                          ),
                          new GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            new LogDetailsPage(
                                                curLog: logs[index])),
                                  )
                                  .then((val) => {_getLogs()});
                            },
                            child: new Container(
                                margin: const EdgeInsets.all(0.0),
                                child: new Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 30.0,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Run Time: ${logs[index].startTime}',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ]),
              ),
              Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 0.0),
                child: Container(
                  height: 5.0,
                ),
              ),
            ],
          )),
        ));
      },
    );
  }

  Widget _deleteLogDialog(BuildContext context, Log curLog) {
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
            });
          },
        ),
      ],
    );
  }
}
