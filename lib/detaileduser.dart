import 'dart:convert';

import 'package:login2/UI/Commenclass/Products.dart';

import 'userclass.dart';

class Detaileduser {
  String token;
  String role;
  Usr user;
  final List<product> myitem;

  Detaileduser({this.token, this.role, this.user, this.myitem});

  factory Detaileduser.fromjason(Map<String, dynamic> json) {
    return Detaileduser(
        token: json['token'],
        role: json['role'],
        user: Usr.fromJson(json['object']),
        //myitem: productlist(json['object'])
    );
  }

  static List<product> productlist(placesJson) {
    var list = placesJson['purchaseRequests'] as List;
    print(list);

    List<product> productlist = list.map((json)=>product.fromjson(json)).toList();

    return productlist;
  }
}
