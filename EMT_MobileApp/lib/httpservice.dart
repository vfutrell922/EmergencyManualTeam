import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart';
import 'model/protocol.dart';
import 'model/chart.dart';

import 'package:flutter/foundation.dart';

final String siteName = "https://mwaprotocol.com";
//"http://ec2-52-15-53-224.us-east-2.compute.amazonaws.com";

class HttpService {
  final String protocolsURL = siteName + "/api/protocolsget";
  final String chartsURL = siteName + "/api/chartsget";

  String? findMedications(String medicationInfo) {
    if (medicationInfo.split(',').length > 2) {
      return medicationInfo;
    }
    return null;
  }

  List<Protocol> readProtocols(String body) {
    int i = 0;
    List<String> medicationData = <String>[];
    for (i; i <= body.length; i++) {
      if (body[i] == "]") {
        Iterable l = json.decode(body.substring(0, i + 1));
        medicationData = List<String>.from(l.map((model) => model.toString()));
        body = body.substring(i + 1, body.length);
        break;
      }
    }
    //Iterable l = json.decode(body);
    List l = json.decode(body).toList();

    debugPrint("Iterable: " + l.toString());
    List<Protocol> protocols = List<Protocol>.from(l.map((model) =>
        Protocol.fromWebJson(
            model, findMedications(medicationData[l.indexOf(model)]))));
    return protocols;
  }

  Future<List<Protocol>> getProtocols() async {
    Response res = await get(protocolsURL);

    if (res.statusCode == 200) {
      debugPrint("Got protocol response");
      return readProtocols(res.body);
    } else {
      debugPrint(res.statusCode.toString());
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
