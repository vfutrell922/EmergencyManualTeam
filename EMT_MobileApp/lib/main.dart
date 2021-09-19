// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'homepage.dart';
import 'httpservice.dart';
import 'model/protocol.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final HttpService httpService = HttpService();
  @override
  Widget build(BuildContext context) {
    collectHandbook();
    return MaterialApp(
      title: 'EMT Manual',
      home: HomePage(),
    );
  }

  bool collectHandbook() {
    debugPrint("Getting protocols");
    httpService.getProtocols().then((List<Protocol> protocols) {});

    return true;
  }
}
