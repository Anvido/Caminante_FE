import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart';

setToken(String tokenP) async {
  SharedPreferences mem = await SharedPreferences.getInstance();
  mem.setString('token', tokenP);
  token = tokenP;
  return true;
}

updateToken() async {
  SharedPreferences mem = await SharedPreferences.getInstance();
  if (mem.containsKey('token')) {
    token = mem.get('token');
    return token;
  } else {
    token = null;
  }
  print("updateToken: $token");
  return token;
}

removeToken() async {
  SharedPreferences mem = await SharedPreferences.getInstance();
  if (mem.containsKey('token')) {
    token = null;
    mem.remove('token');
  }
}

setIp(String ip) async {
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
  print("updateIp: $url");
  return url;
}