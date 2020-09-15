import 'package:shared_preferences/shared_preferences.dart';

 Future<int> getaccount_id()async{
  SharedPreferences spref = await SharedPreferences.getInstance();
  int acc_id = spref.getInt('account_id');
  return acc_id;
}