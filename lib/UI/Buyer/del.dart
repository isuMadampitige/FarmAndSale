import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login2/UI/Commenclass/Products.dart';
import 'dart:convert';
import 'package:login2/productclass.dart';
import 'package:login2/Method/buyermethod.dart';
import 'package:login2/UI/Commenclass/notificationstruct.dart';

class ItemDisplay extends StatefulWidget {
  int userid;
  String url;
  ItemDisplay(this.url, this.userid);
  @override
  _ItemDisplayState createState() => _ItemDisplayState();
}

class _ItemDisplayState extends State<ItemDisplay> {
  bool isloading = true;
  List<product> tmplist;

  Future loadproduct() async {
    //http.Response response =
    await http
        .get(
      widget.url,
    )
        .then((response) {
      //print(response.body);

      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        if (response.body == '[]') {
          NoItempopup(context,'Noting');
        } else {
          String content = response.body;
          List prdct = json.decode(content);
          setState(() {
            tmplist = prdct.map((json) => product.fromjson(json)).toList();
            isloading = false;
          });
          print(tmplist);
        }
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        print('error');
      } else if (response.statusCode == 500) {
        ServerErrorPopup(context);
      }
    });
  }

  @override
  void initState() {
    loadproduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blueGrey),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: isloading
            ? Center(
                child: CircularProgressIndicator(
                strokeWidth: 3.0,
              ))
            : ListView.builder(
                itemCount: tmplist.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 150,
                      color: Colors.grey[200],
                      //padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      alignment: Alignment.center,
                      child: ListTile(
                        contentPadding: EdgeInsets.fromLTRB(5, 20, 5, 5),
                        dense: true,
                        leading: Container(child: Icon(Icons.add_a_photo),color: Colors.amber,height: 300,),
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
                                        user_id: widget.userid,
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
