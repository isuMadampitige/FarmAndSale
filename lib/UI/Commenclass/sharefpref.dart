import 'package:shared_preferences/shared_preferences.dart';

Future Getinstance() async {
  SharedPreferences shref = await SharedPreferences.getInstance();
  shref.setString('key','34');
  return shref;
}

