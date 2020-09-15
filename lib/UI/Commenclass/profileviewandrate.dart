import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:login2/Method/buyermethod.dart';

import '../../userclass.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Profileviewandrate extends StatefulWidget {
  int id;
  int acc_id;
  String role;
  bool canrate;
  Profileviewandrate({this.id,this.acc_id,this.canrate,this.role});
  @override
  _ProfileviewandrateState createState() => _ProfileviewandrateState(rated: !canrate);
}

class _ProfileviewandrateState extends State<Profileviewandrate> {
  _ProfileviewandrateState({this.rated});
  bool approved = true;
  double rate;
  Usr userfarmer;
  bool isloading = true;
  bool rated = false;
  SharedPreferences spref;

  Future _profileinfo() async {
    String url = 'http://34.87.38.40/farmer/' + widget.id.toString();
    if(widget.role=='farmer'){
      url='http://34.87.38.40/farmer/' + widget.id.toString();
    }else if(widget.role=='buyer'){
      url='http://34.87.38.40/buyer/' + widget.id.toString();
    }
    else if(widget.role=='transporter'){
      url='http://34.87.38.40/transporter/' + widget.id.toString();
    }

    print(url);

    await http.get(url).then((response) {
      print(response.statusCode);
      print(response.body);
      var json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        String content = response.body;
        //List prdct = json.decode(content);
        if (content == '[]') {
          NoItempopup(this.context,'No Info About user');
        } else {
          setState(() {
            if(widget.role=='farmer'){
            approved = json['confirmed'];}
            //buyerlist = prdct.map((json) => Usr.fromJson(json)).toList();
            userfarmer = Usr.fromJsonfarmer(json);
            isloading = false;
          });
          print(userfarmer.fullname);
          print(approved);
        }
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        print('error');
      } else if (response.statusCode >= 500) {
        ServerErrorPopup(this.context);
      }
    });
  }

  ratefn() {
    Map arr = {
      "rater_id": spref.getInt('account_id'),
      "receiver_id": widget.acc_id,
      "rate": rate,
    };
    print(arr);

    http
        .post('http://34.87.38.40/rater_receiver',
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(arr))
        .then((response) {
      print(response.statusCode);

      if (response.statusCode == 500) {
        print(response.body);
        var content = jsonDecode(response.body);
        Errorshow(context, content['message']);
      } else if (response.statusCode == 200) {
        Popupmessage(context, 'You have Scusessully rate this user', 'Rated',false);
        setState(() {
          rated = true;
        });
      }
    });
  }

  Future inti() async {
    spref = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileinfo();
    inti();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
         ' profile',
          style: TextStyle(color: Colors.indigoAccent, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.indigoAccent),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: true,
      ),
      body: isloading
          ? Center(
              child: Stack(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      _profileinfo();
                    },
                  ),
                  Container(
                      height: 10, width: 100, child: LinearProgressIndicator())
                ],
              ),
            )
          : ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                  //color: Colors.amber,
                  alignment: Alignment.topLeft,
                  child: Container(
                      //color: Colors.black,
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Expanded(
                          //     child: Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Container(
                          //       decoration: BoxDecoration(
                          //         borderRadius:
                          //             BorderRadius.all(Radius.circular(15)),
                          //       ),
                          //       height: 200,
                          //       width: 150,
                          //       child: //Icon(Icons.person,size: 80,)
                          //       Image.asset(
                          //         'images/Farmer.jpg',
                          //         fit: BoxFit.cover,
                          //       )
                          //       ),
                          // )),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(right:8.0),
                                        child: Icon(Icons.person),
                                      ),
                                      Expanded(
                                          child: Text(
                                        userfarmer.fullname.toString(),
                                        style: TextStyle(fontSize: 20),
                                      )),
                                      Expanded(
                                          child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_on,
                                            size: 10,
                                          ),
                                          Text(
                                            userfarmer.district.toString(),
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ))
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4.0, left: 3),
                                    child: Text(
                                      widget.role,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.indigoAccent),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 5),
                                    child: Text(
                                      'Rankings',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                            userfarmer.starcount.toString().substring(0,3)),
                                      ),
                                      RatingBarIndicator(
                                        itemCount: 5,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.indigoAccent,
                                        ),
                                        itemSize: 20,
                                        itemPadding: EdgeInsets.all(0),
                                        rating: userfarmer.starcount,
                                      )
                                    ],
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(top: 80.0),
                                  //   child: Container(
                                  //     height: 1,
                                  //     color: Colors.black,
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 20,
                        child: Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  'Information',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400),
                                ),
                                // Container(
                                //   height: 1,
                                //   width: 100,
                                //   color: Colors.grey,
                                // )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Icon(
                                    Icons.call,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('phone:'),
                                ),
                                Expanded(
                                    child: Text(
                                        userfarmer.mobilenumber.toString()))
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Icon(
                                    Icons.location_on,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('address:'),
                                ),
                                Expanded(
                                    child: Text(userfarmer.address.toString() +
                                        ',' +
                                        userfarmer.district.toString()))
                              ],
                            ),
                            
                            approved
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        'Approved  ',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.indigoAccent,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Icon(
                                          Icons.done,
                                          color: Colors.white,
                                          size: 10,
                                        ),
                                      )
                                    ],
                                  )
                                : Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        'Pending  ',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Icon(
                                          Icons.priority_high,
                                          color: Colors.white,
                                          size: 10,
                                        ),
                                      )
                                    ],
                                  ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                widget.canrate?Text('Rate',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400)):SizedBox(),
                                // Container(
                                //   height: 1,
                                //   width: 100,
                                //   color: Colors.grey,
                                // )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                widget.canrate?Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: RatingBar(
                                    itemSize: 30,
                                    itemCount: 5,
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.grey,
                                    ),
                                    onRatingUpdate: (val) {
                                      setState(() {
                                        rate = val;
                                      });
                                    },
                                  ),
                                ):SizedBox()
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                widget.canrate ? RaisedButton(
                                  color: Colors.amber,
                                  child: Text('Rate'),
                                  onPressed: !rated
                                      ? () {
                                          print(rate);
                                          ratefn();
                                        }
                                      : null,
                                ):SizedBox()
                              ],
                            )
                          ],
                        ),
                      ),
                      // Expanded(
                      //   child: Text(''),
                      // )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
