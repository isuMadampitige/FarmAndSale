import 'package:flutter/material.dart';
import 'package:login2/UI/Commenclass/vehicledetails.dart';
import 'package:http/http.dart' as http;

class Viewvehicledetails extends StatefulWidget {
  Vehicle details;
  Viewvehicledetails({this.details});
  @override
  _ViewvehicledetailsState createState() => _ViewvehicledetailsState(details);
}

class _ViewvehicledetailsState extends State<Viewvehicledetails> {
  _ViewvehicledetailsState(this.details);

  approvevehicle(){
    var url = 'http://34.87.38.40/vehicle/'+details.vehicle_id.toString()+'/approve';
    print(url);
    http.post(url).then((response){
      print(response.statusCode);
    });
  }

  Vehicle details;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          details.transporter.fullname.toString(),
          style: TextStyle(color: Colors.orange),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.orange,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
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
                              details.brand.toString(),
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
                              details.reg_number.toString(),
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '   (' +
                                  details.transporter.district.toString() +
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
                                  details.vehicle_number.toString(),
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
                                    details.insurance_number
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
                                          details.vehicle_id
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
                                    child: details.isApproved
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
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 0, 8),
            child: Text('Owner'),
          ),
          Card(
            child: Container(
              //height: 200,
              //color: Colors.yellow,
              width: double.maxFinite,
              //height: double.maxFinite,
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.orange,
                    radius: 55,
                    child: Center(
                      child: Text(
                        details.transporter.fullname[0].toUpperCase(),
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
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
                                Icons.person,
                                size: 12,
                                color: Colors.orange,
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  'Full Name:',
                                  style: TextStyle(fontSize: 12),
                                )),
                            Text(
                              details.transporter.fullname.toString(),
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
                                Icons.location_on,
                                size: 12,
                                color: Colors.orange,
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  'Address :',
                                  style: TextStyle(fontSize: 12),
                                )),
                            Expanded(
                              child: Text(
                                //'top2'+
                                details.transporter.address.toString(),
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        //Adddress Conatiner
                        padding: EdgeInsets.fromLTRB(10, 2, 5, 5),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.location_city,
                                size: 12,
                                color: Colors.orange,
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  'District :',
                                  style: TextStyle(fontSize: 12),
                                )),
                            Expanded(
                              child: Text(
                                details.transporter.district.toString(),
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
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
                                    Icons.call,
                                    size: 12,
                                    color: Colors.orange,
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      'Mobile number :',
                                      style: TextStyle(fontSize: 12),
                                    )),
                                Text(
                                  details.transporter.mobilenumber.toString(),
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
                                    Icons.email,
                                    size: 12,
                                    color: Colors.orange,
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      'Email :',
                                      style: TextStyle(fontSize: 12),
                                    )),
                                Text(details.transporter.email.toString(),
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
                                          Icons.library_books,
                                          size: 12,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            'License :',
                                            style: TextStyle(fontSize: 12),
                                          )),
                                      Text(
                                          details.transporter.license
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.stars,
                                    size: 12,
                                    color: Colors.orange,
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      'Rating :',
                                      style: TextStyle(fontSize: 12),
                                    )),
                                Text(details.transporter.starcount.toString(),
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black))
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          )
        ],
      ),
      persistentFooterButtons: <Widget>[
        RaisedButton(
          onPressed: () {
            approvevehicle();
          },
          child: Text(
            'Confirm this Vehicle +',
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
