import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:login2/Method/getnotification.dart';
import 'package:login2/UI/Buyer/Sentrequest.dart';
import 'package:login2/UI/Buyer/buyernotifications.dart';
import 'package:login2/UI/Buyer/confimredorderbuyer.dart';
import 'package:login2/UI/Buyer/explore.dart';
import 'package:login2/UI/Commenclass/notification.dart';
import 'package:login2/UI/Transpoter/transpoterhome.dart';
import 'package:login2/UI/stat/statics.dart';
import 'package:login2/main.dart';
import 'package:login2/userclass.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:login2/UI/Farmer/Farmer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Buyerdefaultpage.dart';
import 'package:login2/UI/Commenclass/Products.dart';
//import 'package:login2/UI/Buyer/Category.dart';
import 'package:login2/UI/Commenclass/AboutAs.dart';

import 'buyerprofile.dart';

class Buyerhome extends StatefulWidget {
  //Usr logeduser ; 
  //new Usr();

  Usr logeduser =new Usr();

  Buyerhome({this.logeduser});

  @override
  _BuyerhomeState createState() => _BuyerhomeState();
}

class _BuyerhomeState extends State<Buyerhome> {
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

  int notificationnumber =0;
List<Notifications> notifications;
  assignnotification()async{
    notifications=  await getnotification('farmer');
    setState(() {
      
      notificationnumber = notifications.length;
    });
    
    
  }

  @override
  void initState() {
    loadproduct();
    getshare();
    //print(spref.getInt('buyer_id')?? '1');
  }

  String point = 'explore';
  String header = 'Explore';

  Widget nav() {
    if (point == 'AllItem') {
      return Buyerdefaultpage(
        logeduser: widget.logeduser,
      );
    } else if (point == 'Sentreq') {
      return Sentrequest(
        logeduser: widget.logeduser,
      );
    } else if (point == 'explore') {
      return Explore(
        logeduser: widget.logeduser,
      );
    } else if (point == 'confirmed') {
      return Confirmorder(
        logeduser: widget.logeduser,
      );
    }
    else if (point == 'notifications') {
      return NotificateBuyer();
    }
  }

  @override
  Widget build(BuildContext context) {
    //initState();
    return Scaffold(
        appBar: AppBar(
          title: Text(header),
          actions: <Widget>[
            IconButton(
              icon: Stack(
                children: <Widget>[
                  Container(child: Text(notificationnumber.toString()),color: Colors.red,),
                  Icon(Icons.notifications),
                ],
              ),
              onPressed: () {
                 setState(() {
                    point = 'notifications';
                    header = 'Notifications';
                  });
              },
            ),
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                assignnotification();
                setState(() {
                  point = 'explore';
                  header = 'Explore';
                });
              },
            )
          ],
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              //header//
              new UserAccountsDrawerHeader(
                accountName: Text(widget.logeduser.fullname),
                accountEmail: Text(widget.logeduser.mobilenumber),
                currentAccountPicture: GestureDetector(
                  child: new CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
                decoration: new BoxDecoration(color: Colors.blue),
              ),
              //body//
              InkWell(
                onTap: () {
                  prefix0.Navigator.pop(context);
                   Navigator.push(context,
                       MaterialPageRoute(builder: (context) => BuyerProfile(farmer_id: widget.logeduser.id.toString(),)));
                },
                child: ListTile(
                  title: Text('My profile'),
                  leading: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    point = 'notifications';
                    header = 'Notifications';
                  });
                },
                child: ListTile(
                  title: Text('Notifications'),
                  leading: Icon(Icons.notifications, color: Colors.blue),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    point = 'explore';
                    header = 'Explore';
                  });
                },
                child: ListTile(
                  title: Text('Explore'),
                  leading: Icon(Icons.explore, color: Colors.blue),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    point = 'Sentreq';
                    header = 'Sent request';
                  });
                  int id = spref.getInt('buyer_id');
                  print(id);
                },
                child: ListTile(
                  title: Text('Sent Reqest'),
                  leading: Icon(Icons.add_shopping_cart, color: Colors.blue),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    point = 'confirmed';
                    header = 'Confirmed Order';
                  });
                },
                child: ListTile(
                  title: Text('Confirmed Order'),
                  leading: Icon(Icons.shopping_cart, color: Colors.blue),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  // setState(() {
                  //   point = 'AllItem';
                  //   header = 'All Items';
                  // });
                  Navigator.push(
                      (context),
                      MaterialPageRoute(
                          builder: (context) => Staticcharts()));
                },
                child: ListTile(
                  title: Text('Statistics'),
                  leading: Icon(Icons.table_chart, color: Colors.blue),
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
                  title: Text('Logout'),
                  leading: Icon(Icons.lock_open, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        body: nav()
        // Center(child:  Container(
        //    // height: 470,
        //     child: isloading
        //         ? Center(
        //             child: CircularProgressIndicator(
        //             strokeWidth: 3.0,
        //           ))
        //         : ListView.builder(
        //             itemCount: tmplist.length,
        //             itemBuilder: (context, index) {
        //               return ListTile(
        //                 //contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        //                 leading: Icon(Icons.add_a_photo),
        //                 title: Text(tmplist[index].type),
        //                 subtitle: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: <Widget>[
        //                     Text(
        //                       tmplist[index].quantity + "Kg",
        //                       style: TextStyle(fontWeight: FontWeight.bold),
        //                     ),
        //                     Text(tmplist[index].location)
        //                   ],
        //                 ),
        //                 trailing: Text(tmplist[index].date),
        //                 onTap: () {
        //                   Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                           builder: (context) => viewitem(
        //                                 cproduct: tmplist[index],user_id: widget.logeduser.id,
        //                               )));
        //                 },
        //                 isThreeLine: true,
        //               );
        //             },
        //           ),
        //   ),),
        );
  }
}

// class product extends ListTile {
//   Icon ttt = Icon(Icons.add_a_photo);
//   int purchase_item_id;
//   String type;
//   String quantity;
//   String location;
//   String exp_date;
//   String date;
//   BuildContext route;

//   product({
//     this.purchase_item_id,
//     this.type,
//     this.quantity,
//     this.location,
//     this.date,
//     this.exp_date,
//   });

//   factory product.fromjson(Map<String, dynamic> json) {
//     return product(
//       type: json['type'],
//       quantity: json['quantity'],
//       date: json['date'],
//       location: json['location'],
//       exp_date: json['exp_date'],
//     );
//   }
// }
