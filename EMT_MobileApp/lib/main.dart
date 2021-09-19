// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
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
