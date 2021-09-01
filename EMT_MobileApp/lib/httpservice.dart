import 'dart:convert';
import 'package:http/http.dart';

class HttpService {
  final String postsURL =
      "http://ec2-3-144-121-87.us-east-2.compute.amazonaws.com/api/protocolsget";

  Future<String> getPosts() async {
    Response res = await get(postsURL);

    if (res.statusCode == 200) {
      String body = res.body;

      return body;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
