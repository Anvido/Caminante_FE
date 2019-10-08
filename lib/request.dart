import 'dart:convert';

import 'package:dio/dio.dart';

String url = "http://192.168.0.7:3000";

getHttp(String path) async {
  Response response = await Dio().get("$url$path");
  return response.data;
}

postHttp(String path, Map<String, dynamic> data) async {
  String jsonData = jsonEncode(data);
  print(jsonData);
  Response response = await Dio().post("$url$path", data: jsonData);
  return response.data;
}