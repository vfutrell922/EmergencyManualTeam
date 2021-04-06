import 'package:flutter/material.dart';
import 'quicklinks.dart';
import 'oldlogs.dart';
import 'searchprotocols.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Manual'),
        centerTitle: true,
        backgroundColor: Color(0xFFFFFF),
      ),
      body: new Center(
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
            Image.asset('assets/images/logo.png', height: 300, width: 300),
            new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new SearchProtocolsPage()),
                      );
                    },
                    child: new Text(
                      "Start New Log",
                    ),
                  ),
                  new ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new OldLogsPage()),
                      );
                    },
                    child: new Text(
                      "View Old Logs",
                    ),
                  ),
                ]),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new SearchProtocolsPage()),
                    );
                  },
                  child: new Text(
                    "Protocols",
                  ),
                ),
                new ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new QuickLinksPage()),
                    );
                  },
                  child: new Text(
                    "Quick Links",
                  ),
                )
              ],
            ),
          ])),
    );
  }
}
