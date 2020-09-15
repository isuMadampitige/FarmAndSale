import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
//import 'package:login2/UI/Farmer/Farmer.dart' as prd;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:login2/UI/Commenclass/Products.dart' as prd;

class viewitem extends StatefulWidget {
  bool canrequest=false;
  prd.product cproduct;
  int user_id = null;
  viewitem({this.cproduct, this.user_id,this.canrequest});
  @override
  _viewitemState createState() => _viewitemState();
}

class _viewitemState extends State<viewitem> {
  var url = 'http://34.87.38.40/purchaseItem/7/requests/13';

  Future request() async {
    //http.Response response =
    await http
        .post(url,
            headers: {"Accept": "application/json"},
            body: jsonEncode({"test": "test"}))
        .then((response) {
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        _ackAlert(context);
        setState(() {
         isrequested=true; 
        });
      }
    });
  }

  Future<void> _ackAlert(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Request sent'),
        content: const Text('Your request has been successfully send to the Farmer,You Will receive Confirmation from Farmer'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

  String bunstat = 'request';
  bool isrequested = false;
  bool canrequest=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 120,
          ),
          CircleAvatar(
            radius: 30,
            child: Icon(Icons.add_a_photo),
          ),
          SizedBox(
            height: 120,
          ),
          Container(
            //color: Colors.blue,
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Item Description',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Type:' + widget.cproduct.type,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Added Date:' + widget.cproduct.date,
                    style: TextStyle(
                      fontSize: 15,
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Size:' + widget.cproduct.quantity.toString() + "Kg",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Purchase_item_id:' +
                      widget.cproduct.purchase_item_id.toString(),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Exp_date:' + widget.cproduct.exp_date.toString(),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 80,
          ),
          widget.canrequest ?
          !isrequested
              ? RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                color: Colors.blue,
                  child: Text('Request',style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    print(widget.user_id);
                    print(widget.cproduct.purchase_item_id);
                    setState(() {
                      url = 'http://34.87.38.40/purchaseItem/' +
                          widget.cproduct.purchase_item_id.toString() +
                          '/requests/' +
                          widget.user_id.toString();
                          
                    });
                    print(url);
                    request();
                  },
                )
              : RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Text('Requested',style: TextStyle(color: Colors.white),),
                  onPressed: null,
                )
        :Text(''),
        ],
      )),
    );
  }
}
