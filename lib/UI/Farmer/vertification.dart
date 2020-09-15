import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login2/Method/buyermethod.dart';
import 'package:login2/UI/Farmer/credentials.dart';
import 'package:http/http.dart' as http;

import '../../userclass.dart';

Usr usertemp;

class Vertify extends StatefulWidget {
  Usr userf ;
  var url;
  String role;

  Vertify({this.userf, this.url, this.role});

  @override
  _VertifyState createState() => _VertifyState();
}

class _VertifyState extends State<Vertify> {
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  TextEditingController c3 = TextEditingController();
  TextEditingController c4 = TextEditingController();
  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();

  _nextfocus() {
    if (c1.text.length == 1) {
      FocusScope.of(context).requestFocus(f2);
      //print(c1.text);
    }
  }

  _nextfocus1() {
    if (c2.text.length == 1) {
      FocusScope.of(context).requestFocus(f3);
      //print(c2.text);
    }
  }

  _nextfocus2() {
    if (c3.text.length == 1) {
      FocusScope.of(context).requestFocus(f4);
      //print(c3.text);
    }
  }

  int id=4;

  Sendnumber() async {
    print(widget.userf.mobilenumber.toString());

    Map mnumber = {'mobile_number': '0718545744'//widget.userf.mobilenumber.toString()
    };

    var js = jsonEncode(mnumber);

    try {
      var response = await http.post('http://34.87.38.40/temporary user/mobile',
          headers: {"Content-Type": "application/json"}, body: js);

      print(response.body);

      if (response.statusCode == 200) {
        String content = response.body;
        var js = jsonDecode(content);
        int temp = js['user_id'];
        print(temp);
        setState(() {
          id = temp;
          
        });
        print(temp);
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        NetworkErrorPopup(context);
      } else if (response.statusCode >= 500) {
        ServerErrorPopup(context);
      }
    } catch (e) {
      print(e);
      NetworkErrorPopup(context);
    }
  }

  Sendcode() async {
    print(widget.userf.mobilenumber.toString());

    Map mnumber = {'mobile_number': widget.userf.mobilenumber.toString()};

    var js = jsonEncode(mnumber);

    String code = c1.text + c2.text + c3.text + c4.text;
    print(code);
    String url =
        'http://34.87.38.40/temporary user/' + id.toString() + '/codes/' + code;

    try {
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: js);

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        _signin().then((value) {
          if (value == 200) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => fcredential(
                          user: usertemp,
                          role: widget.role,
                        )));
          } else {
            NetworkErrorPopup(context);
          }
        });
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        NetworkErrorPopup(context);
      } else if (response.statusCode >= 500) {
        ServerErrorPopup(context);
      }
    } catch (e) {
      print(e);
      NetworkErrorPopup(context);
    }
  }

  Future<int> _signin() async {
    //var url = 'http://34.87.38.40/farmer';
    Map arr = {
      'full_name': widget.userf.fullname,
      'district': widget.userf.district,
      'address': widget.userf.address,
      'mobile_number': widget.userf.mobilenumber,
    };
    var js = jsonEncode(arr);
    //print(js);
    //print(arr);
    try {
      final response = await http.post(Uri.encodeFull(widget.url),
          headers: {"Content-Type": "application/json"}, body: js);

      print(response.statusCode);
      print(response.body);

      setState(() {
        usertemp = Usr.fromJson(json.decode(response.body));
      });

      print(usertemp.fullname);
      return int.parse(response.statusCode.toString());
      //return response;
    } catch (e) {
      return 404;
    }
  }

  @override
  void initState() {
    super.initState();
    c1.addListener(_nextfocus);
    c2.addListener(_nextfocus1);
    c3.addListener(_nextfocus2);

    Sendnumber();
  }

  @override
  void dispose() {
    c1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Align(
          alignment: Alignment(0.0, -1.0),
          child: Container(
            height: MediaQuery.of(context).size.height / 4,
            alignment: Alignment(0.05, 8.0),
            child: Container(
              width: 75,
              height: 75,
              alignment: Alignment(0.0, 0.0),
              child: Image.asset(
                'images/index.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Container(
          //color: Colors.amber,
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                    color: Colors.green.withOpacity(0.85),
                    alignment: Alignment.center,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Vertification Code',
                            style: TextStyle(fontSize: 25),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 15, bottom: 5),
                            width: 300,
                            alignment: Alignment.center,
                            child: Text(
                              'Please enter your vertification code sent',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Text(widget.userf.mobilenumber.toString()),
                        ])),
              ),
              Expanded(
                flex: 2,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          //color: Colors.amber,
                          margin: EdgeInsets.fromLTRB(0, 20, 10, 0),
                          width: 40,
                          height: 80,
                          child: TextField(
                            onChanged: (val) {},
                            controller: c1,
                            focusNode: f1,
                            keyboardType: TextInputType.phone,
                            maxLength: 1,
                            maxLengthEnforced: true,
                            cursorRadius: Radius.circular(10.0),
                            scrollPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            decoration: InputDecoration(
                                counter: Text(''),
                                hasFloatingPlaceholder: false,
                                contentPadding:
                                    EdgeInsets.fromLTRB(15, 10, 10, 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)))),
                          )),
                      Container(
                          //color: Colors.amber,
                          margin: EdgeInsets.fromLTRB(0, 20, 10, 0),
                          width: 40,
                          height: 80,
                          child: TextField(
                            controller: c2,
                            focusNode: f2,
                            keyboardType: TextInputType.phone,
                            maxLength: 1,
                            maxLengthEnforced: true,
                            cursorRadius: Radius.circular(10.0),
                            scrollPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            decoration: InputDecoration(
                                counter: Text(''),
                                hasFloatingPlaceholder: false,
                                contentPadding:
                                    EdgeInsets.fromLTRB(15, 10, 10, 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)))),
                          )),
                      Container(
                          //color: Colors.amber,
                          margin: EdgeInsets.fromLTRB(0, 20, 10, 0),
                          width: 40,
                          height: 80,
                          child: TextField(
                            controller: c3,
                            focusNode: f3,
                            keyboardType: TextInputType.phone,
                            maxLength: 1,
                            maxLengthEnforced: true,
                            cursorRadius: Radius.circular(10.0),
                            scrollPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            decoration: InputDecoration(
                                counter: Text(''),
                                hasFloatingPlaceholder: false,
                                contentPadding:
                                    EdgeInsets.fromLTRB(15, 10, 10, 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)))),
                          )),
                      Container(
                          //color: Colors.amber,
                          margin: EdgeInsets.fromLTRB(0, 20, 10, 0),
                          width: 40,
                          height: 80,
                          child: TextField(
                            controller: c4,
                            focusNode: f4,
                            keyboardType: TextInputType.phone,
                            maxLength: 1,
                            maxLengthEnforced: true,
                            cursorRadius: Radius.circular(10.0),
                            scrollPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            decoration: InputDecoration(
                                counter: Text(''),
                                hasFloatingPlaceholder: false,
                                contentPadding:
                                    EdgeInsets.fromLTRB(15, 10, 10, 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)))),
                          )),
                    ]),
              )
            ],
          ),
        ),
      ]),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10),
            child: RaisedButton(
              child: Text(
                'Vertify',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Sendcode();
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>fcredential(user: widget.userf,)));
              },
              color: Colors.green.withOpacity(0.90),
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

testsnack(BuildContext context) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text('data'),
  ));
}

Usr loged = Usr(
    id: 1,
    nic: '947836214v',
    fullname: 'dasanayaka',
    mobilenumber: '0778596412');
