import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:login2/Method/buyermethod.dart';
import 'package:login2/UI/Commenclass/vehicledetails.dart';
import 'package:login2/UI/admin.dart/viewvehicledetails.dart';

class Vehicles extends StatefulWidget {
  bool approved =false;
  Vehicles({this.approved});
  @override
  _VehiclesState createState() => _VehiclesState();
}

class _VehiclesState extends State<Vehicles> {
  List<dynamic> details;
  bool isloading = true;

  loadvehicle() {
    var url = !widget.approved?'http://34.87.38.40/vehicle/not approved':'';
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
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadvehicle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(onRefresh: () async{
          await loadvehicle();
          await Future.delayed(Duration(seconds: 2));
        },child: isloading
            ? Center(child: CircularProgressIndicator(),)
            : ListView.builder(
                itemCount: details.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Card(
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
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Icon(
                                          Icons.local_shipping,
                                          size: 12,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      Text(
                                        details[index].brand.toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900),
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
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Icon(
                                          Icons.directions_car,
                                          size: 12,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      Text(
                                        //'top2'+
                                        details[index].reg_number.toString(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        '   (' +
                                            details[index]
                                                .transporter
                                                .district
                                                .toString() +
                                            ')',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  //Devider line
                                  // height: 2,
                                  //width: 250,
                                  // color: Colors.grey,
                                  margin: EdgeInsets.fromLTRB(10, 5, 10, 2),
                                  child: Text(
                                    'Owner',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300),
                                  ),
                                ),
                                Container(
                                  //Farmer,starcount container
                                  // width: 300,
                                  margin: EdgeInsets.only(right: 5),
                                  //color: Colors.amberAccent,
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          // Expanded(
                                          // Wrap(
                                          // children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Icon(
                                              Icons.person,
                                              size: 12,
                                              color: Colors.orange,
                                            ),
                                          ),
                                          Text(
                                            details[index]
                                                .transporter
                                                .fullname
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                          ),
                                          // ],
                                          // ),
                                          // Expanded(
                                          //   child: Container(
                                          //     padding: EdgeInsets.only(
                                          //         top: 0.0, bottom: 0.0),
                                          //     alignment: Alignment.topCenter,
                                          //     child: RatingBarIndicator(
                                          //       rating: 4, //tile.farmer.starcount,
                                          //       itemBuilder: (context, index) => Icon(
                                          //         Icons.star,
                                          //         color: Colors.red,
                                          //       ),
                                          //       itemCount: 5,
                                          //       itemPadding: EdgeInsets.symmetric(
                                          //           horizontal: 0),
                                          //       itemSize: 16.0,
                                          //       direction: Axis.horizontal,
                                          //     ),
                                          //   ),
                                          // ),
                                          // Text(
                                          //   'top4',
                                          //   //tile.exp_date.toString(),
                                          //   style: TextStyle(
                                          //       fontSize: 12,
                                          //       fontWeight: FontWeight.w500),
                                          // )
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            //alignment: Alignment.centerLeft,
                                            //color: Colors.black,
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Icon(
                                                    Icons.location_on,
                                                    size: 12,
                                                    color: Colors.orange,
                                                  ),
                                                ),
                                                Text(
                                                    details[index]
                                                        .transporter
                                                        .address
                                                        .toString(), //tile.unit_price.toString() + ' Rs',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black)),
                                                // Row(children: <Widget>[Text('data'),])
                                              ],
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: details[index].isApproved
                                                  ? Row(
                                                      children: <Widget>[
                                                        Text(
                                                          'Approved',
                                                          style: TextStyle(
                                                              fontSize: 10),
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.green,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
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
                                                          style: TextStyle(
                                                              fontSize: 10),
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10))),
                                                          child: Icon(
                                                            Icons.priority_high,
                                                            color: Colors.white,
                                                            size: 10,
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                          // Expanded(child: Text('data'),)
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
                    ),
                    onTap: !widget.approved? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Viewvehicledetails(details: details[index],),
                          ));
                    }:null,
                  );
                },
              )));
  }
}
