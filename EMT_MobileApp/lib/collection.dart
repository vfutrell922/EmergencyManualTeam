import 'httpservice.dart';
import 'model/protocol.dart';
import 'model/chart.dart';
import 'model/medication.dart';
import 'model/phonenumber.dart';
import 'db/handbookdb_handler.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

final HttpService httpService = HttpService();

Future<bool> checkInternetAndUpdateHandbookdb() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      debugPrint('connected');
      return await collectHandbook().then((result) async {
        return result;
      });
    }
  } on SocketException catch (_) {
    debugPrint('not connected, will not update database');
  }
  return false;
}

Future<bool> collectHandbook() async {
  HandbookDatabase.instance.clearDB();
  // debugPrint("Getting protocols");
  httpService.getProtocols().then((List<Protocol> protocols) async {
    for (var i = 0; i < protocols.length; i++) {
      // debugPrint("Protocol Entry >>> " + protocols[i].toJson().toString());
      await HandbookDatabase.instance.addProtocol(protocols[i]);
    }
  });

  // debugPrint("Getting charts");
  httpService.getCharts().then((List<Chart> charts) async {
    for (var i = 0; i < charts.length; i++) {
      debugPrint("Chart Entry >>> " + charts[i].Protocol.toString());
      await HandbookDatabase.instance.addChart(charts[i]);
    }
  });

  // debugPrint("Getting medication");
  httpService.getMedications().then((List<Medication> medications) async {
    for (var i = 0; i < medications.length; i++) {
      debugPrint("Medication Entry >>> " + medications[i].toJson().toString());
      await HandbookDatabase.instance.addMedication(medications[i]);
    }
  });

  // debugPrint("Getting phone numbers");
  httpService.getPhoneNumbers().then((List<PhoneNumber> phonenums) async {
    for (var i = 0; i < phonenums.length; i++) {
      // debugPrint("PhoneNum Entry >>> " + phonenums[i].toJson().toString());
      await HandbookDatabase.instance.addPhoneNumber(phonenums[i]);
    }
  });

  return true;
}
