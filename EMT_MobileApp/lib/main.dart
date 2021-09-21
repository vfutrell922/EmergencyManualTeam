// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'homepage.dart';
import 'httpservice.dart';
import 'model/protocol.dart';
import 'db/db_handler.dart';
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

  Future<bool> collectHandbook() async {
    debugPrint("Getting protocols");
    EMTAppDatabase.instance.deleteDB();
    httpService.getProtocols().then((List<Protocol> protocols) async {
      for (var i = 0; i < protocols.length; i++) {
        debugPrint("Protocol Entry >>> " + protocols[i].toJson().toString());
        await EMTAppDatabase.instance.addProtocol(protocols[i]);
      }
    });

    return true;
  }
}
