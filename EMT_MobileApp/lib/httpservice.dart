import 'dart:convert';
import 'package:http/http.dart';
import 'model/protocol.dart';
import 'model/chart.dart';

import 'package:flutter/foundation.dart';

class HttpService {
  final String protocolsURL =
      "http://ec2-3-141-14-235.us-east-2.compute.amazonaws.com/api/protocolsget";
  final String chartsURL =
      "http://ec2-3-141-14-235.us-east-2.compute.amazonaws.com/api/chartsget";

  Future<List<Protocol>> getProtocols() async {
    Response res = await get(protocolsURL);

    if (res.statusCode == 200) {
      Iterable l = json.decode(res.body);

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
      Iterable l = json.decode(res.body);

      List<Chart> charts =
          List<Chart>.from(l.map((model) => Chart.fromWebJson(model)));
      return charts;
    } else {
      throw "Unable to retrieve charts.";
    }
  }
}
