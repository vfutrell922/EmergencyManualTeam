// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EMT Manual',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int dummy = 0;
  void newLogPressed() {
    setState(() {
      dummy = dummy + 1;
    });
  }

  void oldLogPressed() {
    setState(() {
      dummy = dummy + 1;
    });
  }

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
                    onPressed: newLogPressed,
                    child: new Text(
                      "Start New Log",
                    ),
                  ),
                  new ElevatedButton(
                    onPressed: oldLogPressed,
                    child: new Text(
                      "View Old Logs",
                    ),
                  ),
                ]),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new ElevatedButton(
                  onPressed: newLogPressed,
                  child: new Text(
                    "Protocols",
                  ),
                ),
                new ElevatedButton(
                  onPressed: newLogPressed,
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
