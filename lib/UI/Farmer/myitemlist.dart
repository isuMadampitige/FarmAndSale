import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login2/Method/buyermethod.dart';
import 'package:login2/UI/Commenclass/Products.dart';
import 'package:login2/UI/Farmer/Viewfarmerrequest.dart';
import 'package:login2/detaileduser.dart';
import 'package:http/http.dart' as http;

class Myitem extends StatefulWidget {
  List<product> myitems;
  int id;

  Myitem({this.myitems, this.id});

  @override
  _MyitemState createState() => _MyitemState();
}

class _MyitemState extends State<Myitem> {
  //_MyitemState();

  bool boolcheck = false;
  List<product> myitems;

  void reqmyitems() async {
    String url =
        'http://34.87.38.40/purchaseItem/' + widget.id.toString() + '/requests';
    print(url);
    try {
      await http.get(url).then((response) {
        print(response.body);
        print(response.statusCode);

        if (response.statusCode == 200) {
          String content = response.body;
          List prdct = json.decode(content);
          if (content == '[]') {
            NoItempopup(this.context,'No request Yet');
            setState(() {
              boolcheck = false;
            });
          } else {
            setState(() {
              myitems = prdct.map((json) => product.fromjson(json)).toList();
              boolcheck = true;
              widget.myitems = myitems.toList();
            });
            print(myitems[0].district);
          }
        } else if (response.statusCode >= 400 && response.statusCode < 500) {
          print('error');
        } else if (response.statusCode >= 500) {
          ServerErrorPopup(this.context);
        }
      });
    } catch (e) {
      print(e);
      NetworkErrorPopup(context);
    }
  }

  void delete(int purchaseItemId) async {
    String url =
        'http://34.87.38.40/purchaseItem/'+purchaseItemId.toString()+'/' + widget.id.toString();
    print(url);
    try {
      await http.delete(url).then((response) {
        print(response.body);
        print(response.statusCode);

        if (response.statusCode == 200) {
          //String content = response.body;
          //List prdct = json.decode(content);
         // if (content == '[]') {
            //NoItempopup(this.context);
            //setState(() {
             // boolcheck = false;
           // });
          //} else {
            
          //}
          Popupmessage(context, 'Sccuessfully Deleted', 'Deleted', false);
        } else if (response.statusCode >= 400 && response.statusCode < 500) {
          print('error');
        } else if (response.statusCode >= 500) {
          ServerErrorPopup(this.context);
        }
      });
    } catch (e) {
      print(e);
      NetworkErrorPopup(context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.id.toString());
    reqmyitems();
  }

  List<String> lst = [
    'images/isna.jpg',
    'images/kondor.jpg',
    'images/lyra.jpg',
    'images/sante.jpg',
    'images/raja.jpg',
    'images/Desiree.jpg',
    'images/granola.jpg',
  ];

  @override
  void dispose() {
    boolcheck = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'My Items',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.green.withOpacity(0),
          bottomOpacity: 0.0,
          elevation: 0.0,
          toolbarOpacity: 0.0,
        ),
        body: Stack(
          children: <Widget>[
            RefreshIndicator(
                onRefresh: () async {
                  reqmyitems();
                  await Future.delayed(Duration(seconds: 2));
                  //timediffrence('2019-08-29');
                },
                child: boolcheck
                    ? ListView.builder(
                        itemCount: myitems.length,
                        itemBuilder: (context, index) {
                          return AnimatedOpacity(
                            curve: Curves.linear,
                            duration: Duration(seconds: 5),
                            //reverseDuration: Duration(seconds: 5),
                            opacity: 1.0,
                            child: InkWell(
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
                                      Container(
                                        //Image Container
                                        width: 110,
                                        height: 110,
                                        child: Hero(
                                          tag: 'img' +
                                              myitems[index]
                                                  .purchase_item_id
                                                  .toString(),
                                          child: Image.asset(
                                            lst[varietypic(myitems[index].variety)],
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                        color: Colors.white,
                                      ), //Image Container
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
                                                10, 0, 10, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  myitems[index]
                                                          .type
                                                          .toString() +
                                                      '  (' +
                                                      myitems[index].variety +
                                                      ')',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.delete,
                                                    size: 15,
                                                  ),
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title:
                                                                Text('Delete'),
                                                            content: const Text(
                                                                'Are You sure you want to delete The Item'),
                                                            actions: <Widget>[
                                                              FlatButton(
                                                                child:
                                                                    Text('Ok'),
                                                                onPressed: () {
                                                                  //http.delete('url');
                                                                  delete(myitems[index].purchase_item_id);
                                                                  print(
                                                                      'object');
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  return true;
                                                                },
                                                              ),
                                                              FlatButton(
                                                                child: Text(
                                                                    'Cancel'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  return false;
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        });
                                                  },
                                                  padding: EdgeInsets.all(0.0),
                                                )
                                              ],
                                            ),
                                            //Title Container
                                            alignment: Alignment.topLeft,
                                          ),
                                          Container(
                                            //Adddress Conatiner
                                            padding: EdgeInsets.fromLTRB(
                                                10, 2, 5, 5),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.location_on,
                                                  size: 12,
                                                  color: Colors.green,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0),
                                                  child: Text(
                                                    myitems[index]
                                                            .district
                                                            .toString() +
                                                        ',' +
                                                        myitems[index]
                                                            .city
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            //Devider line
                                            height: 2,
                                            width: 250,
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
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    // Expanded(
                                                    // Wrap(
                                                    // children: <Widget>[
                                                    Text('Harvet date :',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                    Text(
                                                      myitems[index]
                                                          .harvest_date
                                                          .toString(),
                                                      //'Samarasekara',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    // Expanded(
                                                    // Wrap(
                                                    // children: <Widget>[
                                                    Text('EXP date :',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                    Text(
                                                      myitems[index]
                                                          .exp_date
                                                          .toString(),
                                                      //'Samarasekara',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
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
                                                          Text(
                                                              myitems[index]
                                                                      .unit_price
                                                                      .toString() +
                                                                  ' Rs',
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .green)),
                                                          Text(
                                                              ' per 1' +
                                                                  myitems[index]
                                                                      .quantity_unit
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .grey)),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Text('Quantity:',
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                color: Colors
                                                                    .black)),
                                                        Text(
                                                            myitems[index]
                                                                .quantity
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                            )),
                                                        Text(
                                                            myitems[index]
                                                                .quantity_unit
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                            )),
                                                      ],
                                                    ),
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Viewrequest(
                                              purchase_id: myitems[index]
                                                  .purchase_item_id
                                                  .toString(),
                                              farmer_id: widget.id.toString(),
                                              myitem: myitems[index],
                                            )));
                              },
                            ),
                          );
                        })
                    //Stack(
                    //                     children: <Widget>[
                    //                       Container(
                    //                         decoration: BoxDecoration(
                    //                             color: Colors.white,
                    //                             borderRadius:
                    //                                 BorderRadius.all(Radius.circular(10))),
                    //                         margin: EdgeInsets.only(bottom: 5),
                    //                         //color: Colors.white,
                    //                         child: ListTile(
                    //                           //contentPadding: EdgeInsets.all(10.0),
                    //                           leading: Container(
                    //                               height: 50,
                    //                               width: 50,
                    //                               decoration: BoxDecoration(
                    //                                 shape: BoxShape.circle,
                    //                                 color: Colors.grey[100],
                    //                                 image: DecorationImage(
                    //                                     image: ExactAssetImage(
                    //                                         'images/avacado.jpg'),
                    //                                     fit: BoxFit.fill),
                    //                               )),
                    //                           title: Padding(
                    //                             padding:
                    //                                 EdgeInsets.only(top: 0.0, bottom: 10),
                    //                             //color: Colors.black,
                    //                             // alignment: Alignment.topLeft,
                    //                             child: Column(
                    //                               mainAxisAlignment:
                    //                                   MainAxisAlignment.spaceEvenly,
                    //                               crossAxisAlignment:
                    //                                   CrossAxisAlignment.start,
                    //                               children: <Widget>[
                    //                                 Text(
                    //                                   myitems[index].type.toUpperCase() +
                    //                                       '(' +
                    //                                       myitems[index]
                    //                                           .variety
                    //                                           .toString() +
                    //                                       ')',
                    //                                   style: TextStyle(
                    //                                       fontSize: 15,
                    //                                       fontWeight: FontWeight.bold),
                    //                                 ),
                    //                                 Text(
                    //                                     myitems[index]
                    //                                             .unit_price
                    //                                             .toString() +
                    //                                         ' / kg',
                    //                                     style: TextStyle(
                    //                                         fontSize: 10,
                    //                                         fontWeight: FontWeight.bold)),
                    //                                 Text(
                    //                                     myitems[index].quantity.toString() +
                    //                                         ' kg',
                    //                                     style: TextStyle(
                    //                                         fontSize: 10,
                    //                                         fontWeight: FontWeight.bold))
                    //                               ],
                    //                             ),
                    //                           ),
                    //                           subtitle: Column(
                    //                             crossAxisAlignment:
                    //                                 CrossAxisAlignment.start,
                    //                             children: <Widget>[
                    //                               Text(
                    //                                 myitems[index].district.toUpperCase() +
                    //                                     (',') +
                    //                                     myitems[index].city.toString(),
                    //                                 style: TextStyle(
                    //                                     fontWeight: FontWeight.w300,
                    //                                     fontSize: 10),
                    //                               ),
                    //                             ],
                    //                           ),
                    //                           trailing: Column(
                    //                             mainAxisAlignment:
                    //                                 MainAxisAlignment.spaceBetween,
                    //                             crossAxisAlignment: CrossAxisAlignment.end,
                    //                             children: <Widget>[
                    //                               Text(myitems[index].exp_date.toString(),
                    //                                   style: TextStyle(
                    //                                       fontSize: 12,
                    //                                       fontWeight: FontWeight.bold)),
                    //                               // Text(
                    //                               //   '( 2 more Days to expire )',
                    //                               //   style: TextStyle(
                    //                               //       fontSize: 8,
                    //                               //       fontWeight: FontWeight.bold,
                    //                               //       color: Colors.red),
                    //                               // )
                    //                               timediffrence(
                    //                                   myitems[index].exp_date.toString())
                    //                             ],
                    //                           ),
                    //                           onTap: () {
                    //                             Navigator.push(
                    //                                 context,
                    //                                 MaterialPageRoute(
                    //                                     builder: (context) => Viewrequest(
                    //                                           purchase_id: myitems[index]
                    //                                               .purchase_item_id
                    //                                               .toString(),
                    //                                           farmer_id:
                    //                                               widget.id.toString(),myitem: myitems[index],
                    //                                         )));
                    //                           },
                    //                         ),
                    //                       ),
                    //                       boolcheck
                    //                           ? Positioned(
                    //                               //left: 1.0,
                    //                               top: -1.5,
                    //                               right: 1.0,
                    //                               child: Container(
                    //                                 //alignment: Alignment.topRight,
                    //                                 margin: EdgeInsets.only(
                    //                                     right: 10, top: 2.0),
                    //                                 width: 4,
                    //                                 height: 4,
                    //                                 //decoration: BoxDecoration(
                    //                                 // shape: BoxShape.circle, color: Colors.redAccent),
                    //                                 child: Icon(
                    //                                   Icons.chat_bubble,
                    //                                   size: 14,
                    //                                   color: Colors.red,
                    //                                 ),
                    //                               ),
                    //                             )
                    //                           : Container()
                    //                     ],
                    //                   );
                    //                 },
                    //               )
                    : Stack(
                        children: <Widget>[
                          Center(
                            child: Text(
                              'You Have not added any item yet',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w300),
                            ),
                          ),
                          Container(
                            height: 500,
                            child: ListView(),
                          )
                        ],
                      )),
            // Container(
            //   color: Colors.transparent,
            //     height: 20,
            //     child: AppBar(
            //       elevation: 0.0,
            //       title: Text('data',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            //       toolbarOpacity: 1,
            //       backgroundColor: Colors.grey.withOpacity(0.5),
            //     ))
          ],
        ));
  }
}

Text timediffrence(String date) {
  String time = '23:59:59';
  var dt = DateTime.parse(date + ' ' + time);
  //print(dt);
  var today = DateTime.now();
  //print(today);
  var diff = dt.difference(today);
  int num = diff.inDays.toInt();
  //print(num);
  if (num <= 2) {
    //print(num.toString() + ' more days to Expire');
    return Text(
      '(' + num.toString() + ' more days to expire)',
      style: TextStyle(fontSize: 9, color: Colors.red),
    );
  } else if (num > 2 && num < 5) {
    return Text(
      '(' + num.toString() + ' more days to expire)',
      style: TextStyle(fontSize: 9, color: Colors.yellow),
    );
  } else {
    return Text('');
  }
}
