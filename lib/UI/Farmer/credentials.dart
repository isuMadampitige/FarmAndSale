import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:login2/Method/buyermethod.dart';
import 'package:login2/UI/Farmer/Farmer.dart';
import 'package:login2/UI/Transpoter/transpoterhome.dart';
import 'package:login2/detaileduser.dart';
import 'package:login2/userclass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:login2/main.dart';
import 'package:login2/UI/Buyer/byuerhome.dart';

class fcredential extends StatefulWidget {
  Usr user;
  Detaileduser detailusr;
  String role;

  fcredential({Key key, this.user, this.role}) : super(key: key);
  @override
  _fcredentialState createState() => _fcredentialState();
}

class _fcredentialState extends State<fcredential> {
  final _credentialform = GlobalKey<FormState>();

  var status = null;

  TextEditingController username = TextEditingController();
  TextEditingController pwd = TextEditingController();
  TextEditingController repwd = TextEditingController();

  //String baseurl = 'http://34.87.38.40/farmer/45/account';

  Future<int> _post() async {
    var url = 'http://34.87.38.40/' +
        widget.role.toString() +
        '/' +
        widget.user.id.toString() +
        '/account';
    Map arr = {
      "username": username.text,
      "password": pwd.text,
    };

    var js = jsonEncode(arr);

    print(url);
    try{
    http.Response response = await http.post(Uri.encodeFull(url),
        headers: {"Content-Type": "application/json"}, body: js);

    print(response.body);
    print(response.statusCode);

    return int.parse(response.statusCode.toString());
    }
    catch(e){
      return 404;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
        //color: Colors.amber,
        alignment: Alignment.topCenter,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //color: Colors.blue[50],
        child: ListView(
          children: [
            Container(
              //color: Colors.amber,
              height: 500,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      //height: 200,
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.green.withOpacity(0.75),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Hi ',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                widget.user.fullname + 
                               ',',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Text(' Enter Your Username And Password'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(25, 30, 35, 0),
                      //color: Colors.blueGrey.withOpacity(0.5),
                      // width: 300,
                      alignment: Alignment.topCenter,
                      child: Form(
                        key: _credentialform,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(bottom: 15.0),
                              child: TextFormField(
                                controller: username,
                                decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.person, color: Colors.grey),
                                  prefixStyle: TextStyle(),
                                  hintText: 'Username',
                                  filled: true,
                                  fillColor: Colors.brown[20],
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7.0)),
                                  ),
                                ),
                                style: TextStyle(height: 0.9, fontSize: 11.0),
                                validator: (value) {
                                  if (value.length == 0) {
                                    return 'This Can not be empty!';
                                  } else if (value.length > 20) {
                                    return 'Maximun 20 Characters';
                                  } else
                                    return status;
                                },
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.only(bottom: 15.0),
                              child: TextFormField(
                                controller: pwd,
                                decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.lock, color: Colors.grey),
                                  prefixStyle: TextStyle(),
                                  hintText: 'Password',
                                  filled: true,
                                  fillColor: Colors.brown[20],
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7.0)),
                                  ),
                                ),
                                style: TextStyle(height: 0.9, fontSize: 11.0),
                                validator: (value) {
                                  if (value.length == 0) {
                                    return 'This Can not be empty!';
                                  } else if (value.length > 20) {
                                    return 'Maximun 20 Characters';
                                  } else if (value.length < 8) {
                                    return 'Password Is too Short!';
                                  } else
                                    return status;
                                },
                                obscureText: true,
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.only(bottom: 15.0),
                              child: TextFormField(
                                controller: repwd,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock_outline,
                                      color: Colors.grey),
                                  prefixStyle: TextStyle(),
                                  hintText: 'Re-Enter Password',
                                  filled: true,
                                  fillColor: Colors.brown[20],
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7.0)),
                                  ),
                                ),
                                style: TextStyle(height: 0.9, fontSize: 11.0),
                                validator: (value) {
                                  if (value.length == 0) {
                                    return 'This Can not be empty!';
                                  } else if (value != pwd.text) {
                                    return 'Password Does not match';
                                  } else
                                    return null;
                                },
                                obscureText: true,
                              ),
                            ),

                            // Container(
                            //   alignment: Alignment.bottomRight,
                            //   width: double.infinity,
                            //   child: RaisedButton(
                            //     child: Text(
                            //       'Already Have a Account?',
                            //       style: TextStyle(fontSize: 11.0, color: Colors.blue),
                            //     ),
                            //     onPressed: () {
                            //       Navigator.pushReplacement(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (context) => HomeScreen()));
                            //     },
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Text('Next',style: TextStyle(color: Colors.white),),
              color: Colors.green.withOpacity(0.85),
              onPressed: () {
                
                if (_credentialform.currentState.validate()) {
                  _post().then((int value) {
                    
                    if (value == 200) {
                      if (widget.role == 'farmer') {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => FarmerInfo(
                                      logeduser: widget.user,
                                    )));
                      } else if (widget.role == 'buyer') {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Buyerhome(
                                      logeduser: widget.user,
                                    )));
                      } else if (widget.role == 'transporter') {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Transpoterhome(
                                      logeduser: widget.user,
                                    )));
                      }
                    } else if (value >= 400 && value <500) {
                      NetworkErrorPopup(context);
                    }
                  });
                 }   
              },
              
            ),
          ),
        ],
      ),
    );
  }
}
