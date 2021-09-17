import 'package:flutter/material.dart';

class OldLogsPage extends StatefulWidget {
  @override
  _OldLogsPageState createState() => _OldLogsPageState();
}

class _OldLogsPageState extends State<OldLogsPage> {
  List logs = [];

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
    List tempList = ["Nov 10, 2020", "Nov 11, 2020", "Nov 12, 2020"];

    setState(() {
      logs = tempList;
    });
  }

  Widget _buildLogsList() {
    return ListView.builder(
      itemCount: logs == null ? 0 : logs.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(logs[index]),
          onTap: () => print(logs[index]),
        );
      },
    );
  }
}
