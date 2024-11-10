import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences{
  MySharedPreferences();
  int _pages = 1;
  int? _pageNumber = 1;

  Future<void> startPage() async {
    await SharedPreferences.getInstance();
    print('INITsTATE APP$_pages');
  }
  Future<void> endPage() async {
    await SharedPreferences.getInstance();
    print('DISPOSE APP$_pageNumber');
  }
}