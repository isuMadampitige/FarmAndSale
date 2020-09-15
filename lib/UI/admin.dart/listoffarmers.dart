import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login2/Method/buyermethod.dart';
import 'package:login2/userclass.dart';

GlobalKey<RefreshIndicatorState> refkey = GlobalKey();

class Listoffarmers extends StatefulWidget {
//  String id;
//  Transportreqtranporter({this.id});
  // @override
  _ListoffarmersState createState() => _ListoffarmersState();
}

class _ListoffarmersState extends State<Listoffarmers> {
  List<Usr> tmplist;
  bool isloading = true;

  Future loadrequest() async {
    var url = 'http://34.87.38.40/farmer/pending_farmers';
    print(url);

    //http.Response response =
    await http.get(url).then((response) {
      print(response.body);
      String content = response.body;
      List prdct = json.decode(content);

      //print(response.statusCode);
      //print(content);
      if (response.statusCode == 200) {
        if (content == '[]') {
          // _noitemalert(context);
        }
        setState(() {
          tmplist = prdct.map((json) => Usr.fromJsonfarmer(json)).toList();
          isloading = false;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadrequest();
  }

  List<String> lst = [
    'images/avacado.jpg',
    'images/banana.jpg',
    'images/fruit.jpg',
    'images/tomato.jpg',
    'images/carrot.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      //color: Colors.amber,
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                AppBar(
                  title: Text(
                    'Notices',
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.green.withOpacity(0),
                  elevation: 0.0,
                ),
                Expanded(
                  child: RefreshIndicator(
                    key: refkey,
                    onRefresh: () async {
                      loadrequest();
                      await Future.delayed(Duration(seconds: 2));
                    },
                    child: !isloading
                        ? ListView.builder(
                            itemCount: tmplist.length,
                            itemBuilder: (context, index) {
                              // return Productlisttile(
                              //   context: context,
                              //   tile: tmplist[index],id: widget.logeduser.id.toString(),
                              // );
                              return InkWell(
                                child: Card(
                                  child: Container(
                                    //height: 200,
                                    //color: Colors.yellow,
                                    width: double.maxFinite,
                                    //height: double.maxFinite,
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // Container(
                                        //   //Image Container
                                        //   width: 110,
                                        //   height: 110,
                                        //   child: Hero(
                                        //     //tag: 'img' + tile.purchase_item_id.toString(),
                                        //     child: Image.asset(
                                        //       //lst[tile.purchase_item_id%5],
                                        //       fit: BoxFit.fitHeight,
                                        //     ),
                                        //   ),
                                        //   color: Colors.green[300],
                                        // ), //Image Container
                                        Expanded(
                                            //width: double.maxFinite,
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              //Title Container
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 8, 10, 2),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text(
                                                          tmplist[index]
                                                              .fullname,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900),
                                                        ),
                                                        Text(' In ',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w200,
                                                            )),
                                                        Text(
                                                          tmplist[index]
                                                              .address,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text('In '),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              backgroundBlendMode:
                                                                  BlendMode
                                                                      .darken,
                                                              color:
                                                                  Colors.yellow,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10))),
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          child: Text(
                                                              tmplist[index]
                                                                  .district),
                                                          // color: Colors.yellow,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              //Title Container
                                              alignment: Alignment.topLeft,
                                            ),
                                            Container(
                                              //Devider line
                                              height: 2,
                                              //width: ,
                                              color: Colors.grey,
                                              margin: EdgeInsets.fromLTRB(
                                                  10, 2, 10, 5),
                                            ),
                                            Container(
                                              //Farmer,starcount container
                                              // width: 300,
                                              margin: EdgeInsets.only(right: 5),
                                              //color: Colors.amberAccent,
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 5, 10, 0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      // Expanded(
                                                      // Wrap(
                                                      // children: <Widget>[
                                                      Text(
                                                        'data',
                                                        //tmplist[index].confiremdBuyer.fullname,
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      // ],
                                                      // ),
                                                      Expanded(
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 0.0,
                                                                  bottom: 0.0),
                                                          alignment: Alignment
                                                              .topCenter,
                                                          child:
                                                              RatingBarIndicator(
                                                            rating: 2.4,
                                                            itemBuilder:
                                                                (context,
                                                                        index) =>
                                                                    Icon(
                                                              Icons.star,
                                                              color: Colors.red,
                                                            ),
                                                            itemCount: 5,
                                                            itemPadding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        0),
                                                            itemSize: 16.0,
                                                            direction:
                                                                Axis.horizontal,
                                                          ),
                                                        ),
                                                      ),
                                                      // Text(
                                                      //   'data3',
                                                      //   // tile.exp_date.toString(),
                                                      //   style: TextStyle(
                                                      //       fontSize: 12,
                                                      //       fontWeight:
                                                      //           FontWeight.w500),
                                                      // )
                                                    ],
                                                  ),
                                                  SizedBox(height: 8),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        //alignment: Alignment.centerLeft,
                                                        //color: Colors.black,
                                                        child: Row(
                                                          children: <Widget>[
                                                            Text('data',
                                                                // tmplist[index]
                                                                //     .nic,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Colors
                                                                        .green)),
                                                            Text('v',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11,
                                                                    color: Colors
                                                                        .grey)),
                                                          ],
                                                        ),
                                                      ),
                                                      // Text('data5',
                                                      //     //tile.quantity.toString(),
                                                      //     style: TextStyle(
                                                      //       fontSize: 13,
                                                      //     )),
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
                                onTap: () {
                                  var url = 'http://34.87.38.40/farmer/' +
                                      tmplist[index].id.toString() +
                                      '/approve';
                                      print(url);
                                      try{
                                  http.post(url).then((response) {
                                    if (response.statusCode == 200) {
                                      SentRequestPopup(context);
                                    } else {
                                      NetworkErrorPopup(context);
                                    }
                                  });
                                      }
                                      catch(e){
                                        print(e);
                                        NetworkErrorPopup(context);
                                      }
                                      
                                },
                              );
                            })
                        : Container(
                            child: Center(child: CircularProgressIndicator()),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
