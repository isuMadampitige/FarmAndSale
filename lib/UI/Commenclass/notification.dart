
import 'package:login2/UI/Commenclass/Products.dart';

class Notifications{
  int notification_id;
  int farmer_acc_id;
  int buyer_acc_id;
  int transporter_acc_id;
  product purchaseItem;

  Notifications({this.notification_id,this.farmer_acc_id,this.buyer_acc_id,this.transporter_acc_id,this.purchaseItem});

  factory Notifications.fronjson(Map<String, dynamic> json){
    return Notifications(notification_id: json['notification_id'],
    farmer_acc_id: json['farmer_acc_id'],
    buyer_acc_id: json['buyer_acc_id'],
    transporter_acc_id: json['transporter_acc_id'],
    purchaseItem: product.fromjson2(json['purchaseItem'])
    
    );
  }
}