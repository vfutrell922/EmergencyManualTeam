import 'dart:convert';
import 'package:http/http.dart';
import 'model/protocol.dart';
import 'model/chart.dart';

import 'package:flutter/foundation.dart';

final String siteName = "https://mwaprotocol.com";

class HttpService {
  final String protocolsURL = siteName + "/api/protocolsget";
  final String chartsURL = siteName + "/api/chartsget";
  Future<List<Protocol>> getProtocols() async {
    Response res = await get(protocolsURL);

    if (res.statusCode == 200) {
      debugPrint("Got protocol response");
      Iterable l = json.decode(res.body);
      debugPrint("Iterable: " + l.toString());
      List<Protocol> protocols =
          List<Protocol>.from(l.map((model) => Protocol.fromWebJson(model)));
      return protocols;
    } else {
      throw "Unable to retrieve protocols.";
    }
  }

  Future<List<Chart>> getCharts() async {
    Response res = await get(chartsURL);

    if (res.statusCode == 200) {
      debugPrint("Got chart response");
      Iterable l = json.decode(res.body);

      List<Chart> charts =
          List<Chart>.from(l.map((model) => Chart.fromWebJson(model)));
      return charts;
    } else {
      throw "Unable to retrieve charts.";
    }
  }
}
