import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:login2/Method/buyermethod.dart';
import 'package:login2/UI/Farmer/Farmer.dart';
import 'package:http/http.dart' as http;
import 'package:login2/main.dart';
import 'package:login2/userclass.dart';
import 'package:login2/UI/Farmer/vertification.dart';
import 'credentials.dart';

// void main() {
//   runApp(MaterialApp(
//       debugShowCheckedModeBanner: false, title: 'Login App', home: SignUp()));
// }

class SignUp extends StatefulWidget {
  @override
  Signupstate createState() {
    return Signupstate();
  }
}

class Signupstate extends State<SignUp> {
  Usr user2 = new Usr();
  final _formsign = GlobalKey<FormState>();
  RegExp idreg = new RegExp(r"([0-9]){9}?((v|V){1})");
  RegExp regmail = new RegExp(r"(@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$)");
  RegExp mobilenum = new RegExp(r"([0-9]){10}");
  RegExp regmobile = new RegExp(r"(07)[0125678]{1}[0-9]{7}");
  bool isloading = false;
  String networkstate = '';
  var url = 'http://34.87.38.40/farmer';
  int _loginas = -1;
  String position = 'farmer';

  Future<int> _signin() async {
    setState(() {
      isloading = true;
    });

    Map arr = {
      'full_name': user2.fullname,
      'district': user2.district,
      'address': user2.address,
      'mobile_number': user2.mobilenumber,
    };
    var js = jsonEncode(arr);
    //print(js);
    //print(arr);
    try {
      final response = await http.post(Uri.encodeFull(url),
          headers: {"Content-Type": "application/json"}, body: js); 

      print(response.statusCode);
      print(response.body);

      setState(() {
        user2 = Usr.fromJson(json.decode(response.body));
      });

      print(user2.fullname);
      return int.parse(response.statusCode.toString());
      //return response;
    } catch (e) {
      return 404;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //color: Colors.brown,
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(200.0)),
              child: Container(
                color: Colors.yellow[700],
                height: 80.0,
                width: 130.0,
              ),
            ),
            Positioned(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(200.0)),
                    child: Container(
                      color: Colors.green,
                      height: 130.0,
                      width: 60.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                // height: MediaQuery.of(context).size.height,
                //alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                //color: Colors.blueGrey,
                child: ListView(
                  //addRepaintBoundaries: false,
                  children: <Widget>[
                    Container(
                      //color: Colors.amber,
                      //width: 380,
                      height: 500,
                      child: Form(
                        key: _formsign,
                        child: Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        'Sign Up',
                                        style: TextStyle(fontSize: 25),
                                      ),
                                      Image.asset(
                                        'images/logo.png',
                                        height: 95,
                                        width: 150,
                                        fit: BoxFit.fill,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        hintText: 'Full Name',
                                        fillColor: Colors.grey[100],
                                        filled: true,
                                        prefixIcon: Icon(Icons.person),
                                      ),
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.black,
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty)
                                          return "This can not be empty";
                                        else if (value.length > 30)
                                          return "Name can not contain more than 30 characters";
                                        else
                                          return null;
                                      },
                                      onSaved: (value) {
                                        user2.fullname = value;
                                        print("Full_Name:" + user2.fullname);
                                      },
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        hintText: 'District',
                                        fillColor: Colors.grey[100],
                                        filled: true,
                                        prefixIcon: Icon(Icons.pin_drop),
                                      ),
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.black,
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty)
                                          return "This can not be empty";
                                        else
                                          return null;
                                      },
                                      onSaved: (value) {
                                        user2.district = value;
                                      },
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        hintText: 'Address',
                                        fillColor: Colors.grey[100],
                                        filled: true,
                                        prefixIcon: Icon(Icons.home),
                                      ),
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.black,
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty)
                                          return "This can not be empty";
                                        else if (value.length < 8 &&
                                            value.length < 200)
                                          return "Enter valid address";
                                        else
                                          return null;
                                      },
                                      onSaved: (value) {
                                        user2.address = value;
                                        print("Address:" + user2.address);
                                      },
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        hintText: 'Mobile Number',
                                        fillColor: Colors.grey[100],
                                        filled: true,
                                        prefixIcon: Icon(Icons.phone),
                                      ),
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.black,
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty)
                                          return "This can not be empty";
                                        else if (!regmobile.hasMatch(value))
                                          return "Enter valid Mobile number";
                                        else
                                          return null;
                                      },
                                      onSaved: (value) {
                                        user2.mobilenumber = value;
                                        print("mobile_number:" +
                                            user2.mobilenumber);
                                      },
                                    ),

                                    // TextFormField(
                                    //   decoration: InputDecoration(
                                    //     border: OutlineInputBorder(
                                    //       borderRadius:
                                    //           BorderRadius.all(Radius.circular(10.0)),
                                    //     ),
                                    //     hintText: 'Email',
                                    //     fillColor: Colors.grey[100],
                                    //     filled: true,
                                    //     prefixIcon: Icon(Icons.email),
                                    //   ),
                                    //   style: TextStyle(
                                    //     fontSize: 12.0,
                                    //     color: Colors.black,
                                    //   ),
                                    //   validator: (value) {
                                    //     if (value.length != 0) {
                                    //       if (!regmail.hasMatch(value))
                                    //         return "Enter valid Email address";
                                    //       else
                                    //         return null;
                                    //     } else
                                    //       return null;
                                    //   },
                                    //   onSaved: (value) {
                                    //     usr.email = value;
                                    //     print("Email" + usr.email);
                                    //   },
                                    // ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Login as:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13.0)),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Radio(
                                              value: 0,
                                              groupValue: _loginas,
                                              activeColor: Colors.green,
                                              onChanged: (Object value) {
                                                setState(() {
                                                  url =
                                                      'http://34.87.38.40/farmer';
                                                  _loginas = value;
                                                  position = 'farmer';
                                                });
                                                print(url);
                                              },
                                            ),
                                            Text(
                                              'Farmer',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Radio(
                                              value: 1,
                                              groupValue: _loginas,
                                              activeColor: Colors.blue,
                                              onChanged: (Object value) {
                                                setState(() {
                                                  url =
                                                      'http://34.87.38.40/buyer';
                                                  _loginas = value;
                                                  position = 'buyer';
                                                });
                                                print(url);
                                                print(position);
                                              },
                                            ),
                                            Text(
                                              'Buyer',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Radio(
                                              value: 2,
                                              groupValue: _loginas,
                                              activeColor:
                                                  Colors.deepOrangeAccent,
                                              onChanged: (Object value) {
                                                setState(() {
                                                  url =
                                                      'http://34.87.38.40/transporter';
                                                  _loginas = value;
                                                  position = 'transporter';
                                                });
                                                print(url);
                                                print(position);
                                              },
                                            ),
                                            Text(
                                              'Transpoter',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              // Container(
                              //   alignment: Alignment.centerRight,
                              //   //width: 150,
                              //   height: 45,
                              //   child: RaisedButton(
                              //     onPressed: () {
                              //       if (_formsign.currentState.validate()) {
                              //         _formsign.currentState.save();
                              //         _signin().then((int value) {
                              //           if (value == 200) {
                              //             setState(() {
                              //               isloading = false;
                              //             });
                              //             // Navigator.pushReplacement(
                              //             //     context,
                              //             //     MaterialPageRoute(
                              //             //         builder: (context) => fcredential(
                              //             //               user: user2,
                              //             //               role: position,
                              //             //             )));
                              //           } else if (value == 502) {
                              //             setState(() {
                              //               isloading = false;
                              //               networkstate = 'Internal server error';
                              //             });
                              //             print("error");
                              //           } else if (value == null) {
                              //             setState(() {
                              //               isloading = false;
                              //               networkstate = 'Network TimeOut';
                              //             });
                              //           }
                              //         });
                              //       }
                              //     },
                              //     color: Colors.blue,
                              //     textColor: Colors.white,
                              //     shape: RoundedRectangleBorder(
                              //         borderRadius:
                              //             BorderRadius.all(Radius.circular(30.0))),
                              //     child: Text(
                              //       'Sign Up',
                              //       style: TextStyle(fontSize: 15.0),
                              //     ),
                              //   ),
                              // ),
                              // Container(
                              //     width: double.infinity,
                              //     alignment: Alignment.topLeft,
                              //     child: Row(
                              //         children: <Widget>[
                              //           Container(
                              //             width: 60,
                              //             height: 30,
                              //             child: RaisedButton(
                              //               onPressed: () {
                              //                 Navigator.pushReplacement(
                              //                     context,
                              //                     MaterialPageRoute(
                              //                         builder: (context) =>
                              //                             FarmerInfo(
                              //                               logeduser: loged,
                              //                             )));
                              //               },
                              //               color: Colors.green,
                              //               elevation: 0.5,
                              //               textColor: Colors.white,
                              //               shape: RoundedRectangleBorder(
                              //                   borderRadius: BorderRadius.all(
                              //                       Radius.circular(30.0))),
                              //               child: Text(
                              //                 'Log In',
                              //                 style: TextStyle(
                              //                     fontSize: 10.0,
                              //                     color: Colors.black),
                              //               ),
                              //             ),
                              //           ),
                              //           Container(
                              //             //width: double.infinity,
                              //             padding: EdgeInsets.only(left: 220),
                              //             alignment: Alignment.bottomRight,
                              //             child: isloading
                              //                 ? CircularProgressIndicator(
                              //                     strokeWidth: 5.0,
                              //                     semanticsValue: 'test',
                              //                   )
                              //                 : Text(
                              //                     networkstate,
                              //                     style: TextStyle(
                              //                         color: Colors.red,
                              //                         fontSize: 8.0,
                              //                         fontWeight: FontWeight.bold),
                              //                   ),
                              //           )
                              //         ],
                              //         crossAxisAlignment: CrossAxisAlignment.center,
                              //         mainAxisAlignment: MainAxisAlignment.start)),
                            ]),
                      ),
                    ),
                  ],
                  padding: EdgeInsets.fromLTRB(25, 80, 25, 0),
                )),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10),
            child: RaisedButton(
              child: Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
               onPressed: (){
                if (_formsign.currentState.validate()) {
                  _formsign.currentState.save();
                  // _signin().then((int value) {
                  //   if (value == 200) {
                  //     setState(() {
                  //       isloading = false;
                  //     });
                  //     Navigator.pushReplacement(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => fcredential(
                  //                   user: user2,
                  //                   role: position,
                  //                 )));
                  //   } else if (value>=400 && value<500) {
                  //     setState(() {
                  //       isloading = false;
                  //       NetworkErrorPopup(context);
                  //     });
                  //     print("error");
                  //   } else if (value == null) {
                  //     setState(() {
                  //       isloading = false;
                  //       networkstate = 'Network TimeOut';
                  //       ServerErrorPopup(context);
                  //     });
                  //   }
                  // });
                  //print(user2.fullname); 
                  if(_loginas!=-1){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Vertify(userf: user2,url: url,role: position,)));
                 //_signin();
                  }
                  else{
                    NoItempopup(context,'NO');
                  }
                }
               },
              
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              elevation: 0.0,
            ),
          )
        ],
      ),
    );
  }
}

//test data
Usr loged = Usr(
    id: 1,
    nic: '947836214v',
    fullname: 'dasanayaka',
    mobilenumber: '0778596412');
//test data
