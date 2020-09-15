import 'package:flutter/material.dart';
import 'package:login2/UI/Buyer/Sentrequest.dart';
import 'package:login2/UI/Buyer/confimredorderbuyer.dart';
import 'package:login2/UI/Buyer/explore.dart';
import 'package:login2/UI/Transpoter/transpoterhome.dart';
import 'package:login2/UI/admin.dart/Confirmedfarmers.dart';
import 'package:login2/UI/admin.dart/listoffarmers.dart';
import 'package:login2/UI/admin.dart/vehicles.dart';
import 'package:login2/main.dart';
import 'package:login2/userclass.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:login2/UI/Farmer/Farmer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login2/UI/Commenclass/Products.dart';
//import 'package:login2/UI/Buyer/Category.dart';
import 'package:login2/UI/Commenclass/AboutAs.dart';

class AdminHome extends StatefulWidget {
  //Usr logeduser ;
  //new Usr();

  // Usr logeduser =new Usr();

  // AdminHome({this.logeduser});

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  Future<ListTile> llist;
  BuildContext _context;
  SharedPreferences spref;

  getshare() async {
    spref = await SharedPreferences.getInstance();
  }

  List<product> tmplist;
  bool isloading = true; //set this to false to load list

  Future loadproduct() async {
    //http.Response response =
    await http
        .get(
      'http://34.87.38.40/purchaseItem/viewAll',
    )
        .then((response) {
      //print(response.body);
      String content = response.body;
      List prdct = json.decode(content);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          tmplist = prdct.map((json) => product.fromjson(json)).toList();
          isloading = false;
        });
        print(tmplist);
      }
    });
  }

  @override
  void initState() {
    loadproduct();
    getshare();
    //print(spref.getInt('buyer_id')?? '1');
  }

  String point = 'Farmers';
  String header = 'Farmers(Not Confimed)';

  Widget navi() {
    if (point == 'Farmer') {
      return Listoffarmers();
      //   logeduser: widget.logeduser,
      //);
    } else if (point == 'Confirmed') {
      return Confirmedfarmers();
      // logeduser: widget.logeduser,
      // );
    } else if (point == 'approve vehicle') {
      return Vehicles(approved: false,);
    }
     else if (point == 'approved vehicle') {
      return Vehicles(approved: true,);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    //initState();
    return Scaffold(
        appBar: AppBar(
          title: Text(header),
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    point = 'Confirmed';
                    header = 'Confirmed Farmers';
                  });
                  //int id = spref.getInt('buyer_id');
                  //print(id);
                },
                child: ListTile(
                  title: Row(
                    children: <Widget>[
                      Text('Confirmed Farmers'),
                      Text(' (Approved)',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.green,
                              fontSize: 10))
                    ],
                  ),
                  leading: Icon(Icons.person_pin, color: Colors.blue),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    point = 'Farmer';
                    header = 'Farmer(Not Confirmed)';
                  });
                },
                child: ListTile(
                  title: Row(
                    children: <Widget>[
                      Text('Confirm Farmers'),
                      Text(' (Not approved)',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.red,
                              fontSize: 10))
                    ],
                  ),
                  leading: Icon(Icons.person_add, color: Colors.blue),
                ),
              ),
              // InkWell(
              //   onTap: () {
              //     //Navigator.push(context, MaterialPageRoute(builder: (context)=>Vehicles()));
              //     Navigator.pop(context);
              //     setState(() {
              //       point = 'approved vehicle';
              //       header = 'vehicle(Approved)';
              //     });
              //   },
              //   child: ListTile(
              //     title: Row(
              //       children: <Widget>[
              //         Text('Transporter vehicles'),
              //         Text(' (Approved)',
              //             style: TextStyle(
              //                 fontWeight: FontWeight.w300,
              //                 color: Colors.green,
              //                 fontSize: 10))
              //       ],
              //     ),
              //     leading: Icon(Icons.local_parking, color: Colors.blue),
              //   ),
              // ),
              InkWell(
                onTap: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>Vehicles()));
                  Navigator.pop(context);
                  setState(() {
                    point = 'approve vehicle';
                    header = 'vehicle(Not approved)';
                  });
                },
                child: ListTile(
                  title: Row(
                    children: <Widget>[
                      Text('Transporter vehicles'),
                      Text(' (Not approved)',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.red,
                              fontSize: 10))
                    ],
                  ),
                  leading: Icon(Icons.directions_car, color: Colors.blue),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push((context),
                      MaterialPageRoute(builder: (context) => Aboutas()));
                },
                child: ListTile(
                  title: Text('About '),
                  leading: Icon(Icons.help, color: Colors.blue),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement((context),
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: ListTile(
                  title: Text('Login Out'),
                  leading: Icon(Icons.lock_open, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        body: navi());
  }
}
