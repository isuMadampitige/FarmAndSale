import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:login2/Method/buyermethod.dart';
import 'package:login2/UI/Commenclass/listtile.dart';
import 'package:login2/UI/Commenclass/notificationstruct.dart';
import 'dart:convert';
import 'package:login2/UI/Farmer/Farmer.dart';
import 'package:login2/userclass.dart';
import 'package:login2/UI/Commenclass/Products.dart';

import 'listtilesent.dart';

class Confirmorder extends StatefulWidget {
  Usr logeduser = new Usr();

  Confirmorder({this.logeduser});

  @override
  _ConfirmorderState createState() => _ConfirmorderState();
}

class _ConfirmorderState extends State<Confirmorder> {
  List<product> tmplist;
  bool isloading = true;

  Future loadrequest() async {
    var url = 'http://34.87.38.40/buyer/' +
        widget.logeduser.id.toString() +
        '/requestedItems';

        var url2 = 'http://34.87.38.40/buyer/' +
        widget.logeduser.id.toString() +
        '/confirmed_items_by_owners';
        print(url2);

    //http.Response response =
    try{
    await http.get(url2).then((response) {
      //print(response.body);
      String content = response.body;
      List prdct = json.decode(content);
      print(response.body);
      print(response.statusCode);
      print(content);
      if (response.statusCode == 200) {
        if (content == '[]') {
          _noitemalert(context);
        }
        else{
          //print(tmplist[0].type);
        
        setState(() {
          tmplist = prdct.map((json) => product.fromjson(json)).toList();
          isloading = false;
        });
        }
        
      }
      else if(response.statusCode==500){
        ServerErrorPopup(context);

      }
      else{
        NetworkErrorPopup(context);
      }
    });
  }
  catch(e){
   NetworkErrorPopup(context);
  }
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
    loadrequest();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RefreshIndicator(
          onRefresh: () async{
            loadrequest();
            await Future.delayed(Duration(seconds: 2));
          },
                  child: isloading
              ? CircularProgressIndicator()
              : ListView.builder(
                  addRepaintBoundaries: false,
                  itemCount: tmplist.length,
                  itemBuilder: (context, index) {
                    return Productlisttilesent(
                      tile: tmplist[index],
                      context: context,
                    );
                  },
                ),
        ));
  }
}
