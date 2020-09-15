import 'package:flutter/material.dart';


class additemdetails  {
  Icon ttt = Icon(Icons.add_a_photo);
  int purchase_item_id;
  double quantity;
  String type;
  String category;
  String variety;
  String district;
  String city;
  String harvest_date;
  String exp_date;
  double unit_price;
  String date;
  String confirmedbuyer;
  BuildContext route;
  String unit;
  String hday;
  String hyear;
  String hmonth;
  String eyear;
  String emonth;
  String eday;

  additemdetails({
    this.purchase_item_id,
    this.type,
    this.quantity,
    this.district,
    this.city,
    this.date,
    this.exp_date,
    this.variety,
    this.category,
    this.unit_price,
    this.harvest_date,
    this.unit
    
  });

  factory additemdetails.fromjson(Map<String, dynamic> json) {
    return additemdetails(
      purchase_item_id: json['purchase_item_id'],
      quantity: json['quantity'],
      unit: json['unit'],
      type: json['type'],
      category: json['category'],
      variety: json['variety'],
      district: json['district'],
      city: json['city'],
      harvest_date: json['harvest_date'],
      exp_date: json['exp_date'],
      unit_price: json['unit_price'],
      date: json['date'],

    );
  }
}