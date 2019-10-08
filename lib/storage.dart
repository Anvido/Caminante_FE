import 'package:shared_preferences/shared_preferences.dart';

getToken() async {
    SharedPreferences mem = await SharedPreferences.getInstance();
    var aux = mem.get('token');
    return aux;
  }

setToken(String token) async {
  SharedPreferences mem = await SharedPreferences.getInstance();
  mem.setString('token', token);
}

verifyToken() async {
  SharedPreferences mem = await SharedPreferences.getInstance();
  if (mem.containsKey('token')) {
    print('Si hay');
    return mem.get('token');
  } else {
    print('No hay');
    return null;
  }
}

removeToken() async {
  SharedPreferences mem = await SharedPreferences.getInstance();
  if (mem.containsKey('token')) {
    mem.remove('token');
  }
}