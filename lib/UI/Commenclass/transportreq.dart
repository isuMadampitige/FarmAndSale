import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login2/UI/Commenclass/Products.dart';
import 'package:login2/userclass.dart';


class Transportdetails  {
  Icon ttt = Icon(Icons.add_a_photo);
  int transport_request_id;
  String start;
  String end;
  String date;
  String notify_date;
  double price_per_1km;
  product purchaseItem;
  Usr confiremdBuyer;
  Usr transporter;
  Usr farmer;
  
  
 // Usr confirmedbuyer;
  BuildContext route;

  Transportdetails({
    this.transport_request_id,
    this.start,
    this.end,
    this.date,
    this.notify_date,
    this.price_per_1km,
    this.purchaseItem,
    this.confiremdBuyer,
    this.transporter,
    this.farmer,
    
  });

  factory Transportdetails.fromjson(Map<String,dynamic> json) {
    return Transportdetails(
      transport_request_id: json['transport_request_id'],
      start: json['start'],
      end: json['end'],
      date: json['date'],
      notify_date: json['notify_date'],
      price_per_1km: json['price_per_1km'],
      purchaseItem: product.fromjson(json['purchaseItem']),
      //transporter: Usr.fromJson(json['transporter']),
      //confiremdBuyer: json['harvest_date'],
      confiremdBuyer: Usr.fromJson(json['purchaseItem']['confirmedBuyer']),
      farmer: Usr.fromJsonfarmer(json['purchaseItem']['farmer']),

    );
  }

  factory Transportdetails.fromjson2(Map<String, dynamic> json) {
    return Transportdetails(
       transport_request_id: json['transportRequest']['transport_request_id'],
      // start: json['transportRequest']['start'],
      // end: json['transportRequest']['end'],
      // date: json['transportRequest']['date'],
      // notify_date: json['transportRequest']['notify_date'],
       price_per_1km: json['price_per_1km'],
       purchaseItem: product.fromjson(json['transportRequest']['purchaseItem']),
      transporter: Usr.fromJsontransporter(json['transporter']),
      //confiremdBuyer: json['harvest_date'],
      //confiremdBuyer: Usr.fromJson(json['purchaseItem']['confirmedBuyer']),
      //farmer: Usr.fromJsonfarmer(json['purchaseItem']['farmer']),
    );
  }
  Usr parsebuyer(Map<String ,dynamic> json){

    return Usr.fromJson(json['confirmedBuyer']);
  }

  Usr parsetransporter(Map<String ,dynamic> json){

    return Usr.fromJson(json['transporter']);
  }

}