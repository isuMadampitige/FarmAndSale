import 'package:flutter/material.dart';
import 'package:login2/UI/Buyer/byuerhome.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import "package:login2/UI/Farmer/Farmer.dart";
import 'package:login2/UI/Commenclass/notificationstruct.dart';
import 'package:login2/userclass.dart';
import 'package:login2/UI/Commenclass/Products.dart';

class Buyerdefaultpage extends StatefulWidget {
  Usr logeduser = new Usr();

  Buyerdefaultpage({this.logeduser});

  @override
  _BuyerdefaultpageState createState() => _BuyerdefaultpageState();
}

class _BuyerdefaultpageState extends State<Buyerdefaultpage> {
  Future<ListTile> llist;
  BuildContext _context;

  List<product> tmplist;
  bool isloading = true; //set this to false to load list

   Future<void> _servererror(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //titlePadding: EdgeInsets.fromLTRB(80, 5, 80, 2),
          //contentPadding: EdgeInsets.fromLTRB(40, 2, 40, 5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Container(
            
            child: Text(
              'Internal Server Error',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          content: Container(
            
            child: const Text(
              'Unfortunately Server Is not responding!.please Try again.',
              style: TextStyle(fontSize: 12.0),
            ),
          ),
        );
      },
    );
  }

  Future loadproduct() async {
    //http.Response response =
    await http
        .get(
      'http://34.87.38.40/purchaseItem/viewAll',
    )
        .then((response) {
      //print(response.body);
      
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        String content = response.body;
      List prdct = json.decode(content);
        setState(() {
          tmplist = prdct.map((json) => product.fromjson(json)).toList();
          isloading = false;
        });
        print(tmplist);
      }
      else if(response.statusCode>=400&&response.statusCode<500){
          print('error');
      }
      else if(response.statusCode==500){
        _servererror(context);
      }

    });
  }

  @override
  void initState() {
    loadproduct();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // height: 470,
        child: isloading
            ? Center(
                child: CircularProgressIndicator(
                strokeWidth: 3.0,
              ))
            : ListView.builder(
                itemCount: tmplist.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.grey[200],
                    //padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    alignment: Alignment.center,
                      child: ListTile(
                    //contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    leading: Icon(Icons.add_a_photo),
                    title: Text(tmplist[index].type),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          tmplist[index].quantity.toString() + "Kg",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(tmplist[index].district)
                      ],
                    ),
                    trailing: Text(tmplist[index].date),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => viewitem(
                                    cproduct: tmplist[index],
                                    user_id: widget.logeduser.id,
                                    canrequest: true,
                                  )));
                    },
                    isThreeLine: true,
                  ));
                },
              ),
      ),
    );
  }
}
