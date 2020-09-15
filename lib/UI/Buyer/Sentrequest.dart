import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:login2/Method/buyermethod.dart';
import 'package:login2/UI/Commenclass/listtile.dart';
import 'package:login2/UI/Commenclass/notificationstruct.dart';
import 'dart:convert';
import 'package:login2/UI/Farmer/Farmer.dart';
import 'package:login2/UI/Farmer/HorizentalList.dart';
import 'package:login2/userclass.dart';
import 'package:login2/UI/Commenclass/Products.dart';

import 'listtilesent.dart';

class Sentrequest extends StatefulWidget {
  Usr logeduser = new Usr();

  Sentrequest({this.logeduser});

  @override
  _SentrequestState createState() => _SentrequestState();
}

class _SentrequestState extends State<Sentrequest> {
  List<product> tmplist;
  bool isloading = true;

  Future loadsentorder() async {
    var url = 'http://34.87.38.40/buyer/' +
        widget.logeduser.id.toString() +
        '/requestedItems';

    var url2 = 'http://34.87.38.40/buyer/' +
        widget.logeduser.id.toString() +
        '/confirmed_items_by_owners';
    print(url2);

    //http.Response response =
    await http.get(url).then((response) {
      //print(response.body);
      String content = response.body;
      List prdct = json.decode(content);
      print(response.body);
      print(response.statusCode);
      print(content);
      if (response.statusCode == 200) {
        if (content == '[]') {
          _noitemalert(context);
        } else {
          setState(() {
            tmplist = prdct.map((json) => product.fromjson(json)).toList();
            isloading = false;
          });
        }
      } else if (response.statusCode == 500) {
        ServerErrorPopup(context);
      } else {
        NetworkErrorPopup(context);
      }
    });
  }

  Future<void> _noitemalert(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.fromLTRB(24, 12, 24, 5),
          contentPadding: EdgeInsets.fromLTRB(24, 5, 24, 12),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Container(
            child: Text(
              'No Item',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          content: Container(
            child: const Text(
              'You have not request any Item yet!',
              style: TextStyle(fontSize: 12.0),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    loadsentorder();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          //HorizontalList(),
          Expanded(
              child: RefreshIndicator(
            onRefresh: () async {
              loadsentorder();
              await Future.delayed(Duration(seconds: 2));
            },
            child: isloading
                ? Stack(children: [
                    Center(
                        child: Text(
                      'No Requested',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    )),
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  ])
                : ListView.builder(
                    addRepaintBoundaries: false,
                    itemCount: tmplist.length,
                    itemBuilder: (context, index) {
                      return Productlisttile(
                        tile: tmplist[index],
                        context: context,
                      );
                    },
                  ),
          )),
        ],
      ),
    );
  }
}
