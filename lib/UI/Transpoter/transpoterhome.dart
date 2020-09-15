import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login2/Method/getnotification.dart';
import 'package:login2/UI/Commenclass/notification.dart';
import 'package:login2/UI/Commenclass/transportreq.dart';
import 'package:login2/UI/Transpoter/confirmedtranceport.dart';
import 'package:login2/UI/Transpoter/transporternotifications.dart';
import 'package:login2/UI/Transpoter/transporterprofile.dart';
import 'package:login2/UI/Transpoter/transportervehicles.dart';
import 'package:login2/UI/Transpoter/transportreqtransporter.dart';
import 'package:login2/UI/stat/statics.dart';
import 'package:login2/main.dart';
import 'package:login2/userclass.dart';

class Transpoterhome extends StatefulWidget {
  Usr logeduser;

  Transpoterhome({this.logeduser});

  @override
  _TranspoterhomeState createState() => _TranspoterhomeState();
}

class _TranspoterhomeState extends State<Transpoterhome> {
  
  String point = 'Home';
  String header = 'Home';

  Widget nav() {
    if (point == 'AllItem') {
      //return Buyerdefaultpage(
       // logeduser: widget.logeduser,
     // );
    } else if (point == 'Sentreq') {
      // return Sentrequest(
      //   logeduser: widget.logeduser,
      // );
    } else if (point == 'Home') {
       return Transportreqtranporter(id: widget.logeduser.id.toString());
    }
    else if(point == 'confirmed'){
       return Confirmedtranceport(id: widget.logeduser.id.toString(),);
    }
    else if(point == 'notifications'){
       return NotificateTransporter();
    }
    else if(point == 'myvehicles'){
       return Myvehicles(id: widget.logeduser.id,);
    }
    else if(point == 'myprofile'){
       return TranseporterProfile();
    }
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(header),
        backgroundColor: Colors.orange,
        actions: <Widget>[IconButton(
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
                  point = 'Home';
                  header = 'Find a Hire';
                });
              },
            )],
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
              decoration: new BoxDecoration(color: Colors.orange),
            ),
            //body//
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TranseporterProfile(farmer_id: widget.logeduser.id.toString(),)));
                

              },
              child: ListTile(
                title: Text('My profile'),
                leading: Icon(Icons.person,color: Colors.orangeAccent),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                 point='notifications';
                 header = 'Notifications'; 
                });
                Navigator.pop(context);
              },
              child: ListTile(
                title: Text('Notifications'),
                leading: Icon(Icons.notifications,color: Colors.orangeAccent,),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                 point='Home';
                 header = 'Find a hire'; 
                });
                Navigator.pop(context);
              },
              child: ListTile(
                title: Text('Find a Hire'),
                leading: Icon(Icons.search,color: Colors.orangeAccent,),
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     // initState();
            //     // setState(() {
            //     //   isloading = false;
            //     // });
            //     //loadrequest();
            //      Navigator.pop(context);
            //     Navigator.push(context, MaterialPageRoute(builder: (context)=>Staticcharts()));
            //   },
            //   child: ListTile(
            //     title: Text('Statistics'),
            //     leading: Icon(Icons.table_chart,color: Colors.orangeAccent),
            //   ),
            // ),
            InkWell(
              onTap: () {
                setState(() {
                 point='confirmed'; 
                 header = 'Confirmed';
                });
                Navigator.pop(context);

              },
              child: ListTile(
                title: Text('Confirmed order'),
                leading: Icon(Icons.shopping_basket,color: Colors.orangeAccent),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                 point='myvehicles'; 
                 header = 'My Vehicles';
                });
                Navigator.pop(context);

              },
              child: ListTile(
                title: Text('My Vehicles'),
                leading: Icon(Icons.local_shipping,color: Colors.orangeAccent),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement((context),
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.lock_open,color: Colors.orangeAccent),
              ),
            ),
          ],
        ),
      ),
      body: nav()
    );
  }
}
