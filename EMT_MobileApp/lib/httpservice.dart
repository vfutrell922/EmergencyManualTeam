import 'dart:convert';
import 'package:http/http.dart';
import 'model/protocol.dart';

import 'package:flutter/foundation.dart';

class HttpService {
  final String protocolsURL = "https://mwaprotocol.com/api/protocolsget";

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
}
