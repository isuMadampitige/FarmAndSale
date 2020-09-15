import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login2/Method/buyermethod.dart';
import 'package:login2/UI/Farmer/Farmer.dart';
import 'package:login2/UI/Farmer/SignUp.dart';
import 'package:http/http.dart' as http;
import 'package:login2/UI/admin.dart/adminhome.dart';
import 'package:login2/userclass.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'detaileduser.dart';
import 'UI/Buyer/byuerhome.dart';
import 'package:login2/UI/Transpoter/transpoterhome.dart';

void main() {
//   final ThemeData kIOSTheme = new ThemeData(
//   primarySwatch: Colors.orange,
//   primaryColor: Colors.grey[100],
//   primaryColorBrightness: Brightness.light,
// );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SLOP',
    home: HomeScreen(),
    //theme: kIOSTheme,
  ));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenstate createState() => _HomeScreenstate();
}

class _HomeScreenstate extends State<HomeScreen> {
  // Usertemp _log1 = Usertemp();

  SharedPreferences spref;
  String username;
  String pwd;
  Detaileduser user;
  TextEditingController uname = TextEditingController();
  TextEditingController pwdc = TextEditingController();
  var error = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inti();
  }

  Future inti() async {
    spref = await SharedPreferences.getInstance();
  }

  void navigateuser(String role) {
    if (role == 'Farmer') {
      spref.setInt('farmer_id', user.user.id);
      //print(spref.getInt('account_id'));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => FarmerInfo(
                    logeduser: user.user,
                    userdetails: user,
                  )));
    } else if (role == 'Buyer') {
      spref.setInt('buyer_id', user.user.id);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Buyerhome(
                    logeduser: user.user,
                  )));
    } else if (role == 'Transporter') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Transpoterhome(
                    logeduser: user.user,
                  )));
    }
  }
  
  Future<void> _servererror(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //titlePadding: EdgeInsets.fromLTRB(80, 5, 80, 2),
          //contentPadding: EdgeInsets.fromLTRB(40, 2, 40, 5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Container(
            child: Text(
              'Internal Server Error',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          content: Container(
            child: const Text(
              'Unfortunately Server Is not responding!.please Try again.',
              style: TextStyle(fontSize: 12.0),
            ),
          ),
        );
      },
    );
  }

  _login() async {
    Map arr = {
      "username": username,
      "password": pwd,
    };
    var js = jsonEncode(arr);
    if (username == 'adminone' && pwd == 'adminone') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AdminHome()));
    } else {
      try {
        http.Response response = await http
            .post(Uri.encodeFull('http://34.87.38.40/login'),
                headers: {"Content-Type": "application/json"}, body: js)
            .then((http.Response response) {
          //print(_log1.username);
          print(response.body);
          print(response.statusCode);
          var content = jsonDecode(response.body);
          if (response.statusCode == 200) {
            spref.setInt('account_id', content['account_id'] );
            user = Detaileduser.fromjason(json.decode(response.body));
            print(user.user.fullname);
            // print(user.myitem.type);
            navigateuser(user.role);
          } else if (response.statusCode >= 400 && response.statusCode < 500) {
            setState(() {
              error = "InCorrect username or password";
              _formkey.currentState.validate();
            });
          } else if (response.statusCode == 500) {
            _servererror(context);
          }
        });
      } catch (e) {
        print(e);
        NetworkErrorPopup(context);
      }
    }
  }

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //initState();
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.transparent,
        child: Stack(
          children: <Widget>[
            // ClipRRect(
            //   borderRadius:
            //       BorderRadius.only(bottomRight: Radius.circular(200.0)),
            //   child: Container(
            //     color: Colors.yellow[700],
            //     height: 80.0,
            //     width: 130.0,
            //   ),
            // ),
            // Positioned(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       ClipRRect(
            //         borderRadius:
            //             BorderRadius.only(bottomRight: Radius.circular(200.0)),
            //         child: Container(
            //           color: Colors.green,
            //           height: 130.0,
            //           width: 60.0,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                width: 380,
                height: 500,
                //color: Colors.amber,
                child: Form(
                  key: _formkey,
                  autovalidate: false,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Material(
                        //     elevation: 10.0,
                        //     borderRadius:
                        //         BorderRadius.all(Radius.circular(50.0)),
                        //     child: Image.asset(
                        //       'images/logo4.png',
                        //       width: 80,
                        //       height: 80,
                        //     )),
                        Image.asset(
                              'images/logo4.png',
                              width: 150,
                              height: 150,
                            ),
                            //Text('The Biggest E Market For Farmers'),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            hintText: 'User Name',
                            fillColor: Colors.grey[100],
                            filled: true,
                            prefixIcon: Icon(Icons.person),
                          ),
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                          controller: uname,
                          validator: (value) {
                            if (value.isEmpty)
                              return "This can not be empty";
                            else
                              return error;
                          },
                          onSaved: (text) {
                            setState(() {
                              username = text;
                            });
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              //border: InputBorder.none,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(fontSize: 12.0),
                              fillColor: Colors.grey[100],
                              filled: true,
                              prefixIcon: Icon(Icons.lock)),
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                          controller: pwdc,
                          validator: (value) {
                            if (value.isEmpty)
                              return 'This can not be empty';
                            // else if (value.length < 8)
                            //  return "Enter more than 8 character";
                            else
                              return null;
                          },
                          onSaved: (text) {
                            setState(() {
                              pwd = text;
                            });
                          },
                          obscureText: true,
                        ),
                        Container(
                          width: 380,
                          height: 45,
                          child: RaisedButton(
                            onPressed: () {
                              setState(() {
                                error = null;
                              });

                              if (_formkey.currentState.validate()) {
                                _formkey.currentState.save();
                                _login();
                              }
                              //check();

                              print(username);
                              // print(_log1.username);
                              //print(_log1.pwd);
                            },
                            color: Colors.green,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ),
                        Container(
                          width: 380,
                          height: 45,
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            color: Colors.deepOrange,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//   class Usertemp {
//     String username;
//     String pwd;

//     Usertemp({this.username,this.pwd});

// }
