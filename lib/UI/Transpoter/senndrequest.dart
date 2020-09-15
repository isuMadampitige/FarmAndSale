import 'dart:convert';

import 'package:login2/Method/buyermethod.dart';
import 'package:login2/UI/Commenclass/vehicledetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Sendreqesttransporter extends StatefulWidget {
  String id;
  String tid;
  Sendreqesttransporter({this.id,this.tid});
  @override
  _SendreqesttransporterState createState() => _SendreqesttransporterState();
}

class _SendreqesttransporterState extends State<Sendreqesttransporter> {
  TextEditingController priceper1km = TextEditingController();
  var details1;
  bool isloading = true;
  String vehicle_id;
  loadMyapprovevehicle() {
    var url =
        'http://34.87.38.40/vehicle/' + widget.id.toString() + '/approved';
    try {
      http.get(url).then((response) {
        print(response.statusCode);
        print(response.body);
        if (response.statusCode == 200) {
          List content = jsonDecode(response.body);
          print(content);
          setState(() {
            details1 = content.map((json) => Vehicle.fromjson(json)).toList();
            _dropdownmenuitems = _adddropdownmenuitems(details1);
            //selectedvehicle = details1[0];
            isloading = false;
          });

          // isloading1 = false;
          print(details1[0].vehicle_id);
          print(details1[0].transporter.fullname);
        } else if (response.statusCode == 500) {
          ServerErrorPopup(context);
        } else {
          NetworkErrorPopup(context);
        }
      });
    } catch (e) {
      Popupmessage(context, e.toString(), 'Error', true);
    }
  }
  
  sendreq()  {
    String url2='http://34.87.38.40/Ttr';
    Map arr = {
      'transporter_id':widget.id,
      'transport_request_id':widget.tid,
      'price_per_1km': priceper1km.text,
      'vehicle_id': vehicle_id
      
    };
    print(arr);
    var content = jsonEncode(arr);
    print(content);
    try {
      http
          .post(Uri.encodeFull(url2),
              headers: {"Content-Type": "application/json"}, body: content)
          .then((response) async {
        print(response.body);
        print(response.statusCode);
        if (response.statusCode == 200) {
          Navigator.pop(context);
          await Popupmessage(context, 'Your Requset has been sent', 'Success', false);
          await SentRequestPopup(context);
         // Navigator.push(context, MaterialPageRoute(builder: (content)=>Buyerhome()));
          Navigator.pop(context);
          //refkey.currentState.reassemble();
          //Transportreqtranporter().createState();
          
        } else if (response.statusCode >= 400 && response.statusCode < 500) {
         // Navigator.pop(context);
          NetworkErrorPopup(context);
        } else if (response.statusCode >= 500) {
         // Navigator.pop(context);
          ServerErrorPopup(context);
        }
      });
    } catch (e) {
      print(e);
      //Navigator.pop(context);
      NetworkErrorPopup(context);
    }
  }

  List<Vehicle> test = [
    Vehicle(brand: 'toyots', reg_number: 'dbfdjfj'),
  ];
  List<DropdownMenuItem<Vehicle>> _dropdownmenuitems;
  Vehicle selectedvehicle;

  List<DropdownMenuItem<Vehicle>> _adddropdownmenuitems(
      List<Vehicle> _vehicles) {
    List<DropdownMenuItem<Vehicle>> items = List();
    for (Vehicle x in _vehicles) {
      items.add(DropdownMenuItem(
        value: x,
        child: Card(
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                child: Icon(Icons.local_shipping),
                color: Colors.amber,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    x.brand,
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(x.reg_number, style: TextStyle(fontSize: 12))
                ],
              )
            ],
          ),
        ),
      ));
    }
    return items;
  }

  @override
  void initState() {
    loadMyapprovevehicle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        //elevation: 0.0,
        title: Text('Add Your Details to send Request'),
      ),
      body: ListView(
        //mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 8.0),
            child: Text('Add Your Price'),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Container(
                color: Colors.amber,
                height: 50,
                width: 250,
                child: ListView(
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: 150,
                            height: 50,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: priceper1km,
                              decoration: InputDecoration(
                                
                                  hintText: 'Type Price per',
                                  hintStyle: TextStyle(fontSize: 12)),
                            ),
                          ),
                          Text('/1 Km:'),
                        ]),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Choose your vehicle'),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
                //color: Colors.amber,
                child: !isloading
                    ? DropdownButton(
                      hint: Text('Vehicle'),
                        value: selectedvehicle,
                        items: _dropdownmenuitems,
                        onChanged: (Vehicle x) {
                          print(x.brand);
                          setState(() {
                            vehicle_id = x.vehicle_id.toString();
                            selectedvehicle = x;
                            print(vehicle_id);
                          });
                        },
                      )
                    : Row(
                        children: <Widget>[
                          Container(
                              width: 50, child: LinearProgressIndicator()),
                          IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: () {
                              loadMyapprovevehicle();
                            },
                          )
                        ],
                      )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: <Widget>[
                Text('Add your price and select your Vehicle to send request to  buyers ,and they will respond eventually.'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  if(vehicle_id!=null&&priceper1km!=null){
                      sendreq();
                  }
                  
                },
              )
            ],
          )

          // Expanded(
          //   child: ListView.builder(
          //     itemCount: 2,
          //     itemBuilder: (context, index) {
          //       return Text('data');
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
