import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

String url;
//"http://10.203.158.66:3000";

saveIp(ip) async {
    SharedPreferences mem = await SharedPreferences.getInstance();
    mem.setString('ip', ip);
    url = "http://$ip:3000";
    return true;
  }

removeIp() async {
  SharedPreferences mem = await SharedPreferences.getInstance();
  mem.remove('ip');
  url = null;
}

updateIp() async {
  SharedPreferences mem = await SharedPreferences.getInstance();
  if (mem.containsKey('ip')) {
    url = "http://${mem.getString('ip')}:3000";
  } else {
    url = null;
  }
  return url;
}

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