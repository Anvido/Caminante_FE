import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart';

getToken() async {
    SharedPreferences mem = await SharedPreferences.getInstance();
    var aux = mem.get('token');
    return aux;
  }

setToken(String token) async {
  SharedPreferences mem = await SharedPreferences.getInstance();
  mem.setString('token', token);
  return true;
}

verifyToken() async {
  SharedPreferences mem = await SharedPreferences.getInstance();
  if (mem.containsKey('token')) {
    return mem.get('token');
  } else {
    return null;
  }
}

removeToken() async {
  SharedPreferences mem = await SharedPreferences.getInstance();
  if (mem.containsKey('token')) {
    mem.remove('token');
  }
}

getIp() async {
  SharedPreferences mem = await SharedPreferences.getInstance();
  if (mem.containsKey('ip')) {
    return mem.getString('ip');
  }
  return null;
}

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