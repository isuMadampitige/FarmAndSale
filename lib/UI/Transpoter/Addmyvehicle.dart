import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login2/Method/buyermethod.dart';

class AddMyVehicle extends StatefulWidget {
  int id;
  AddMyVehicle({this.id});
  @override
  _AddMyVehicleState createState() => _AddMyVehicleState();
}

class _AddMyVehicleState extends State<AddMyVehicle> {
  TextEditingController brand = TextEditingController();
  TextEditingController regnum = TextEditingController();
  TextEditingController vehinum = TextEditingController();
  TextEditingController insunum = TextEditingController();
  final _formaddvehicle = GlobalKey<FormState>();

  sendvehicledetails() {
    Map arr = {
      'brand': brand.text,
      'reg_number': regnum.text,
      'vehicle_number': vehinum.text,
      'insurance_no': insunum.text
    };
    print(arr);

    var url = 'http://34.87.38.40/vehicle/transporter/' + widget.id.toString();
    print(url);
    try {
      http
          .post(url,
              headers: {"Content-Type": "application/json"},
              body: jsonEncode(arr))
          .then((response) async {
        print(response.statusCode);
        //print(response.body)
        if (response.statusCode == 200) {
          await ItemAddedpopup(context);
          Navigator.pop(context);
        } else if (response.statusCode == 500) {
          var content = jsonDecode(response.body);
          Popupmessage(
              context,
              'Check You have Enter your Driving Licence details To your Profile, ' +
                  content['message'].toString(),
              'Error',
              true);
        }
      });
    } catch (e) {
      Popupmessage(context, e.toString(), 'Error', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Add Your Vehicles',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        //color: Colors.amber,
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formaddvehicle,
          child: ListView(
            children: <Widget>[
              Wrap(children: <Widget>[Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('For better User Experience Please be Kind to enter Correct Value only,Your Licence and Vehicle not be undeer any legal barrier.If you are under any legal Barrier Please let us know!'),
              )],),
              //Expanded(child: Text('data'),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Brand'),
                  Container(
                    width: 200,
                    height: 50,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        hintText: 'Vehicle Brand',
                        fillColor: Colors.grey[100],
                        filled: true,
                        //prefixIcon: Icon(Icons.branding_watermark),
                      ),
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value.isEmpty)
                          return "This can not be empty";
                        //else if (!regmobile.hasMatch(value))
                        //return "Enter valid Mobile number";
                        else
                          return null;
                      },
                      onSaved: (value) {
                        brand.text = value;
                      },
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Register number'),
                  Container(
                    width: 200,
                    height: 50,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        hintText: 'Register number',
                        fillColor: Colors.grey[100],
                        filled: true,
                        //prefixIcon: Icon(Icons.pate),
                      ),
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value.isEmpty)
                          return "This can not be empty";
                        //else if (!regmobile.hasMatch(value))
                        //return "Enter valid Mobile number";
                        else
                          return null;
                      },
                      onSaved: (value) {
                        brand.text = value;
                      },
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Vehicle Number'),
                  Container(
                    width: 200,
                    height: 50,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        hintText: 'Vehicle Number',
                        fillColor: Colors.grey[100],
                        filled: true,
                        //prefixIcon: Icon(Icons.branding_watermark),
                      ),
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value.isEmpty)
                          return "This can not be empty";
                        //else if (!regmobile.hasMatch(value))
                        //return "Enter valid Mobile number";
                        else
                          return null;
                      },
                      onSaved: (value) {
                        brand.text = value;
                      },
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Insuarance Number'),
                  Container(
                    width: 200,
                    height: 50,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        hintText: 'Insuarance number',
                        fillColor: Colors.grey[100],
                        filled: true,
                        //prefixIcon: Icon(Icons.branding_watermark),
                      ),
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value.isEmpty)
                          return "This can not be empty";
                        //else if (!regmobile.hasMatch(value))
                        //return "Enter valid Mobile number";
                        else
                          return null;
                      },
                      onSaved: (value) {
                        brand.text = value;
                      },
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      print(widget.id);
                      if (_formaddvehicle.currentState.validate()) {
                        _formaddvehicle.currentState.save();
                        sendvehicledetails();
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
