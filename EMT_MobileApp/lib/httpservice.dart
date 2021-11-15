import 'dart:convert';
import 'dart:ffi';
import 'package:emergencymanual/model/phonenumber.dart';
import 'package:http/http.dart';
import 'model/protocol.dart';
import 'model/chart.dart';
import 'model/medication.dart';
import 'globals.dart' as globals;

import 'package:flutter/foundation.dart';

final String siteName = "https://mwaprotocol.com";

class HttpService {
  final String protocolsURL = siteName + "/api/protocolsget";
  final String chartsURL = siteName + "/api/chartsget";
  final String medicationsURL = siteName + "/api/medicationsget";
  final String phonenumsURL = siteName + "/api/phonenumbersget";

  Future<List<Protocol>> getProtocols() async {
    Response res = await get(protocolsURL);

    if (res.statusCode == 200) {
      return readProtocols(res.body);
    } else {
      throw "Unable to retrieve protocols.";
    }
  }

  Future<List<Medication>> getMedications() async {
    Response res = await get(medicationsURL);

    if (res.statusCode == 200) {
      Iterable l = json.decode(res.body);

      List<Medication> medications = List<Medication>.from(
          l.map((model) => Medication.fromWebJson(model)));
      return medications;
    } else {
      throw "Unable to retrieve medications.";
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

  Future<List<PhoneNumber>> getPhoneNumbers() async {
    Response res = await get(phonenumsURL);

    if (res.statusCode == 200) {
      Iterable l = json.decode(res.body);
      List<PhoneNumber> phonenums = List<PhoneNumber>.from(
          l.map((model) => PhoneNumber.fromWebJson(model)));
      return phonenums;
    } else {
      throw "Unable to retrieve phone numbers.";
    }
  }

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
    List k = json.decode(body).toList();

    List<Protocol> protocols = List<Protocol>.from(k.map((model) =>
        Protocol.fromWebJson(
            model, findMedications(medicationData[k.indexOf(model)]))));
    return protocols;
  }
}
