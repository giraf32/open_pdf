import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences{
  MySharedPreferences();

  Future<void> setFirstPage(String key,String value) async {
    await SharedPreferences.getInstance()
    ..setString(key,value);

   // print('INITsTATE APP$_pages');
  }
  Future<String?> getFirstPage(String key) async {
  SharedPreferences preferences =  await SharedPreferences.getInstance();
  String? value = await preferences.getString(key);
  return value;

   // print('DISPOSE APP$_pageNumber');
  }
}