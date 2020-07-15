

import 'package:shared_preferences/shared_preferences.dart';

void setString(String key,String value) async {

  SharedPreferences prefs=await SharedPreferences.getInstance();
  prefs.setString(key, value);

}
Future<String> getString(String key)async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  return prefs.get(key);
}