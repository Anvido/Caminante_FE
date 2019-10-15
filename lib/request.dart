import 'dart:convert';
import 'package:dio/dio.dart';
import 'globals.dart';

getHttp(String path) async {
  Response response = await Dio().get("$url$path");
  return response.data;
}

postHttp(String path, Map<String, dynamic> data) async {
  String jsonData = jsonEncode(data);
  Response response = await Dio().post("$url$path", data: jsonData);
  return response.data;
}

postAuth(Map<String, dynamic> data) async {
  String jsonData = jsonEncode(data);
  Response response = await Dio().post("$url/", data: jsonData, options: Options(
    headers: {
    'Authorization': 'bearer $token' 
    }
  ));
  return response.data;
}