import 'dart:convert';

import 'package:login2/Method/buyermethod.dart';
import 'package:login2/UI/Commenclass/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<List<Notifications>> getnotification(String role)async  {
 
  int acc_id = 24; //spref.getInt('account_id');
   int myacc_id = await get_account_id();
  print(acc_id);
  print(myacc_id);
  Map arr = {'role': role, 'acc_id': myacc_id};
  var url = 'http://34.87.38.40/notification';
  List<Notifications> data;
  await http
      .post(url,
          headers: {"Content-Type": "application/json"}, body: jsonEncode(arr))
      .then((response) {
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      if(response.body=='[]'){
        data= [];
      }else{
      List content = jsonDecode(response.body);
      data = content.map((json) => Notifications.fronjson(json)).toList();
      // print(data[0].notification_id);
      // print(data[0].purchaseItem.quantity_unit);
      // print(data[0].purchaseItem.farmer.fullname);
      // print(data[0].purchaseItem.confirmedbuyer.fullname);
      

      }
    }
    else{
      data=[];
    }
    
  });
  return data;
}

Future<int> get_account_id() async{
  SharedPreferences spref = await SharedPreferences.getInstance();
  int acc_id=spref.getInt('account_id');
  return acc_id;
}

Future<bool> set_notification_number(int notification_length) async{
  SharedPreferences spref = await SharedPreferences.getInstance();
  spref.setInt('notification_length',notification_length);
  return true;
}
