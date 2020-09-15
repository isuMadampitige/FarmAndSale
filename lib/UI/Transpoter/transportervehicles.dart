import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login2/Method/buyermethod.dart';
import 'package:login2/UI/Commenclass/vehicledetails.dart';
import 'package:login2/UI/Transpoter/Addmyvehicle.dart';
import 'package:http/http.dart' as http;
import 'package:login2/UI/admin.dart/viewvehicledetails.dart';

class Myvehicles extends StatefulWidget {
  int id;
  Myvehicles({this.id});
  @override
  _MyvehiclesState createState() => _MyvehiclesState();
}

class _MyvehiclesState extends State<Myvehicles> {

    List<dynamic> details;
    List<dynamic> details1;
  bool isloading = true;
  bool isloading1 = true;
  bool approved =false;

  loadMyvehicle() {
    var url = !approved?'http://34.87.38.40/vehicle/'+widget.id.toString()+'/all':'';
    try{
    http.get(url).then((response) {
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var content = jsonDecode(response.body);
        print(content);
        setState(() {
          details = content.map((json) => Vehicle.fromjson(json)).toList();
        });
        isloading = false;
        print(details[0].vehicle_id);
        print(details[0].transporter.fullname);
      } else if (response.statusCode == 500) {
        ServerErrorPopup(context);
      } else {
        NetworkErrorPopup(context);
      }
    });}
    catch(e){
      Popupmessage(context, e.toString(), 'Error', true);
    }
  }

  loadMyapprovevehicle() {
    var url = 'http://34.87.38.40/vehicle/'+widget.id.toString()+'/approved';
    try{
    http.get(url).then((response) {
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var content = jsonDecode(response.body);
        print(content);
        setState(() {
          details1 = content.map((json) => Vehicle.fromjson(json)).toList();
        });
        isloading1 = false;
        print(details1[0].vehicle_id);
        print(details1[0].transporter.fullname);
      } else if (response.statusCode == 500) {
        ServerErrorPopup(context);
      } else {
        NetworkErrorPopup(context);
      }
    });}
    catch(e){
      Popupmessage(context, e.toString(), 'Error', true);
    }
  }

  @override
  void initState() {
    loadMyvehicle();
    loadMyapprovevehicle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
          child: Scaffold(
        appBar: AppBar(
          title: Text('Vehicles',style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
         bottom: TabBar(
           indicatorColor: Colors.black,tabs: <Widget>[
           
           Tab(child: Text('All vehicles',style: TextStyle(color: Colors.black),),),
           Tab(child: Text('Approved Vehicles',style: TextStyle(color: Colors.black)))
         ],), 
        ),
        body: TabBarView(children: <Widget>[
          RefreshIndicator(
            onRefresh: ()async{
               loadMyvehicle();
              await Future.delayed(Duration(seconds: 2));
            },
                      child: isloading
              ? Center(child: CircularProgressIndicator(),)
              :  ListView.builder(
                  itemCount: details.length,
                  itemBuilder: (context, index) {
                     return Card(
              child: Container(
                //height: 200,
                //color: Colors.yellow,
                width: double.maxFinite,
                //height: double.maxFinite,
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      //Image Container
                      width: 110,
                      height: 110,
                      child: Icon(
                        Icons.local_shipping,
                        color: Colors.grey,
                      ),

                      color: Colors.amberAccent,
                    ), //Image Container
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          //Title Container
                          padding: EdgeInsets.fromLTRB(10, 8, 10, 2),
                          child:
                              // Row(children:<Widget>[
                              Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.local_shipping,
                                  size: 12,
                                  color: Colors.orange,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    'Brand:',
                                    style: TextStyle(fontSize: 12),
                                  )),
                              Text(
                                details[index].brand.toString(),
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                          //])

                          //Title Container
                          alignment: Alignment.topLeft,
                        ),
                        Container(
                          //Adddress Conatiner
                          padding: EdgeInsets.fromLTRB(10, 2, 5, 5),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.directions_car,
                                  size: 12,
                                  color: Colors.orange,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    'Reg_number :',
                                    style: TextStyle(fontSize: 12),
                                  )),
                              Text(
                                //'top2'+
                                details[index].reg_number.toString(),
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '   (' +
                                    details[index].transporter.district.toString() +
                                    ')',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      Icons.looks_one,
                                      size: 12,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        'Vehicle_number :',
                                        style: TextStyle(fontSize: 12),
                                      )),
                                  Text(
                                    details[index].vehicle_number.toString(),
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      Icons.import_contacts,
                                      size: 12,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        'Insuarance Number :',
                                        style: TextStyle(fontSize: 12),
                                      )),
                                  Text(
                                      details[index].insurance_number
                                          .toString()
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Icon(
                                            Icons.import_contacts,
                                            size: 12,
                                            color: Colors.orange,
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8.0),
                                            child: Text(
                                              'Vehicle Id :',
                                              style: TextStyle(fontSize: 12),
                                            )),
                                        Text(
                                            details[index].vehicle_id
                                                .toString()
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: details[index].isApproved
                                          ? Row(
                                              children: <Widget>[
                                                Text(
                                                  'Approved',
                                                  style: TextStyle(fontSize: 10),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: Icon(
                                                    Icons.done,
                                                    color: Colors.white,
                                                    size: 10,
                                                  ),
                                                )
                                              ],
                                            )
                                          : Row(
                                              children: <Widget>[
                                                Text(
                                                  'Pending',
                                                  style: TextStyle(fontSize: 10),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: Icon(
                                                    Icons.priority_high,
                                                    color: Colors.white,
                                                    size: 10,
                                                  ),
                                                )
                                              ],
                                            )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            );}),
          ),
          RefreshIndicator(
            onRefresh: ()async{ loadMyvehicle();
            await Duration(seconds: 2);},
                      child: isloading1
              ? Center(child: CircularProgressIndicator(),)
              : ListView.builder(
                  itemCount: details1.length,
                  itemBuilder: (context, index) {
                     return Card(
              child: Container(
                //height: 200,
                //color: Colors.yellow,
                width: double.maxFinite,
                //height: double.maxFinite,
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      //Image Container
                      width: 110,
                      height: 110,
                      child: Icon(
                        Icons.local_shipping,
                        color: Colors.grey,
                      ),

                      color: Colors.amberAccent,
                    ), //Image Container
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          //Title Container
                          padding: EdgeInsets.fromLTRB(10, 8, 10, 2),
                          child:
                              // Row(children:<Widget>[
                              Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.local_shipping,
                                  size: 12,
                                  color: Colors.orange,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    'Brand:',
                                    style: TextStyle(fontSize: 12),
                                  )),
                              Text(
                                details1[index].brand.toString(),
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                          //])

                          //Title Container
                          alignment: Alignment.topLeft,
                        ),
                        Container(
                          //Adddress Conatiner
                          padding: EdgeInsets.fromLTRB(10, 2, 5, 5),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.directions_car,
                                  size: 12,
                                  color: Colors.orange,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    'Reg_number :',
                                    style: TextStyle(fontSize: 12),
                                  )),
                              Text(
                                //'top2'+
                                details1[index].reg_number.toString(),
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '   (' +
                                    details1[index].transporter.district.toString() +
                                    ')',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      Icons.looks_one,
                                      size: 12,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        'Vehicle_number :',
                                        style: TextStyle(fontSize: 12),
                                      )),
                                  Text(
                                    details1[index].vehicle_number.toString(),
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      Icons.import_contacts,
                                      size: 12,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        'Insuarance Number :',
                                        style: TextStyle(fontSize: 12),
                                      )),
                                  Text(
                                      details1[index].insurance_number
                                          .toString()
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Icon(
                                            Icons.import_contacts,
                                            size: 12,
                                            color: Colors.orange,
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8.0),
                                            child: Text(
                                              'Vehicle Id :',
                                              style: TextStyle(fontSize: 12),
                                            )),
                                        Text(
                                            details1[index].vehicle_id
                                                .toString()
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: details1[index].isApproved
                                          ? Row(
                                              children: <Widget>[
                                                Text(
                                                  'Approved',
                                                  style: TextStyle(fontSize: 10),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: Icon(
                                                    Icons.done,
                                                    color: Colors.white,
                                                    size: 10,
                                                  ),
                                                )
                                              ],
                                            )
                                          : Row(
                                              children: <Widget>[
                                                Text(
                                                  'Pending',
                                                  style: TextStyle(fontSize: 10),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: Icon(
                                                    Icons.priority_high,
                                                    color: Colors.white,
                                                    size: 10,
                                                  ),
                                                )
                                              ],
                                            )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            );}),
          ),
          //Text('data')
        ],),
        floatingActionButton: FloatingActionButton(child: Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            Icon(Icons.local_shipping),
            
          ],
        ),onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddMyVehicle(id: widget.id,)));
        },),
      ),
    );
  }
}