import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login2/userclass.dart';


class product  {
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
  Usr confirmedbuyer;
  Usr farmer;
  BuildContext route;
  String quantity_unit;
  String hday;
  String hyear;
  String hmonth;
  String eyear;
  String emonth;
  String eday;
  int paid;
  

  product({
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
    this.confirmedbuyer,
    this.farmer,
    this.quantity_unit,
    this.paid
  });

  factory product.fromjson(Map<String, dynamic> json) {
    return product(
      purchase_item_id: json['purchase_item_id'],
      quantity: json['quantity'],
      type: json['type'],
      category: json['category'],
      variety: json['variety'],
      district: json['district'],
      city: json['city'],
      harvest_date: json['harvest_date'],
      exp_date: json['exp_date'],
      unit_price: json['unit_price'],
      date: json['date'],
      quantity_unit:json['quantity_unit'],
      paid: json['paid'],
      farmer: Usr.fromJsonfarmer(json['farmer'])
      //confirmedbuyer: Usr.fromJson(json['confirmedBuyer'])
    );
  }

  factory product.fromjson2(Map<String, dynamic> json) {
    return product(
      purchase_item_id: json['purchase_item_id'],
      quantity: json['quantity'],
      type: json['type'],
      category: json['category'],
      variety: json['variety'],
      district: json['district'],
      city: json['city'],
      harvest_date: json['harvest_date'],
      exp_date: json['exp_date'],
      unit_price: json['unit_price'],
      date: json['date'],
      quantity_unit:json['quantity_unit'],
      confirmedbuyer: Usr.fromJson(json['confirmedBuyer']),
      farmer: Usr.fromJsonfarmer(json['farmer'])
    );
  }
  Usr parseuser(Map<String ,dynamic> json){

    return Usr.fromJson(json['confirmedBuyer']);
  }

}