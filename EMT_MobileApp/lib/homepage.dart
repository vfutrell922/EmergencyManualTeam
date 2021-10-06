// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.

import 'package:flutter/material.dart';
import 'quicklinkspage.dart';
import 'oldlogspage.dart';
import 'searchprotocolspage.dart';
import 'newlog.dart';

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
        body: HomePagePanel());
  }
}

class HomePagePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = (screenWidth - (screenWidth * .1)) / 2;
    double buttonHeight = buttonWidth * 0.5;
    return new Center(
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
          Image.asset('assets/images/logo.png', height: 300, width: 300),
          new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new SizedBox(
                  width: buttonWidth,
                  height: buttonHeight,
                  child: new ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            //TODO sierra example
                            builder: (context) => new LogPage()),
                      );
                    },
                    child: new Text("Start New Log"),
                  ),
                ),
                new SizedBox(
                  width: buttonWidth,
                  height: buttonHeight,
                  child: new ElevatedButton(
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
                ),
              ]),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: new ElevatedButton(
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
              ),
              new SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: new ElevatedButton(
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
                ),
              )
            ],
          ),
        ]));
  }
}
