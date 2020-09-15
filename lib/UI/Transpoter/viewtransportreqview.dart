import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login2/Method/buyermethod.dart';
import 'package:login2/UI/Commenclass/Products.dart';
import 'package:login2/UI/Commenclass/transportreq.dart';
import 'package:login2/UI/Transpoter/senndrequest.dart';

class Viewtransportreq extends StatefulWidget {
  String id;
  Transportdetails tmplist;
  product tile;
  Viewtransportreq({this.tmplist, this.id, this.tile});
  @override
  _ViewtransportreqState createState() =>
      _ViewtransportreqState(tmplist: tmplist, tile: tile);
}

class _ViewtransportreqState extends State<Viewtransportreq> {
  _ViewtransportreqState({this.tmplist, this.tile});
  Transportdetails tmplist;
  bool isloading = true;
  product tile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.id);
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
  valprint() {
    print(tmplist.confiremdBuyer.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            //color: Colors.amber,
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: InkWell(
                          onTap: () {
                            valprint();
                          },
                          child: Card(
                            child: Container(
                              //height: 200,
                              //color: Colors.yellow,
                              width: double.maxFinite,
                              //height: double.maxFinite,
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 8, 10, 2),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    tmplist.start,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                  Text(' to ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w200,
                                                      )),
                                                  Text(
                                                    tmplist.end,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Text('On '),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        backgroundBlendMode:
                                                            BlendMode.darken,
                                                        color: Colors.yellow,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    padding: EdgeInsets.all(5),
                                                    child: Text(tmplist.date),
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
                                        margin:
                                            EdgeInsets.fromLTRB(10, 2, 10, 5),
                                      ),
                                      Container(
                                        //Farmer,starcount container
                                        // width: 300,
                                        margin: EdgeInsets.only(right: 5),
                                        //color: Colors.amberAccent,
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                                Text(
                                                  tmplist.confiremdBuyer.fullname.toString(),
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                // ],
                                                // ),
                                                Expanded(
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 0.0, bottom: 0.0),
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: RatingBarIndicator(
                                                      rating: 2.4,
                                                      itemBuilder:
                                                          (context, index) =>
                                                              Icon(
                                                        Icons.star,
                                                        color: Colors.red,
                                                      ),
                                                      itemCount: 5,
                                                      itemPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 0),
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
                                                      .end,
                                              children: <Widget>[
                                                Container(
                                                  //alignment: Alignment.centerLeft,
                                                  //color: Colors.black,
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text('Quantity:'),
                                                      Text(
                                                          tmplist.purchaseItem
                                                              .quantity
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Colors
                                                                  .green)),
                                                      Text(tmplist.purchaseItem.quantity_unit.toString(),
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              color:
                                                                  Colors.grey)),
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
                        ),
                      ),
                    ],
                  ),
                ),
                // Expanded(
                //   flex: 1,
                //   child: Text('product'),
                // ),
                Expanded(
                  flex: 2,
                  child: AnimatedOpacity(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                //Image Container
                                width: 110,
                                height: 110,
                                child: Hero(
                                  tag:
                                      'img1' + tile.purchase_item_id.toString(),
                                  child: Image.asset(
                                    lst[tile.purchase_item_id % 5],
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                color: Colors.green[300],
                              ), //Image Container
                              Expanded(
                                  //width: double.maxFinite,
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    //Title Container
                                    padding: EdgeInsets.fromLTRB(10, 8, 10, 2),
                                    child: Text(
                                      tile.type.toString() +
                                          '  (' +
                                          tile.variety +
                                          ')',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    //Title Container
                                    alignment: Alignment.topLeft,
                                  ),
                                  Container(
                                    //Adddress Conatiner
                                    padding: EdgeInsets.fromLTRB(10, 2, 5, 5),
                                    child: Text(
                                      tile.district.toString() +
                                          ',' +
                                          tile.city.toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                  Container(
                                    //Devider line
                                    height: 2,
                                    width: 250,
                                    color: Colors.grey,
                                    margin: EdgeInsets.fromLTRB(10, 2, 10, 5),
                                  ),
                                  Container(
                                    //Farmer,starcount container
                                    // width: 300,
                                    margin: EdgeInsets.only(right: 5),
                                    //color: Colors.amberAccent,
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            // Expanded(
                                            // Wrap(
                                            // children: <Widget>[
                                            Text(
                                              tmplist.farmer.fullname.toString(),
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            // ],
                                            // ),
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    top: 0.0, bottom: 0.0),
                                                alignment: Alignment.topCenter,
                                                child: RatingBarIndicator(
                                                  rating: 2.4,
                                                  itemBuilder:
                                                      (context, index) => Icon(
                                                    Icons.star,
                                                    color: Colors.red,
                                                  ),
                                                  itemCount: 5,
                                                  itemPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 0),
                                                  itemSize: 16.0,
                                                  direction: Axis.horizontal,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              tile.exp_date.toString(),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              //alignment: Alignment.centerLeft,
                                              //color: Colors.black,
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                      tile.unit_price
                                                              .toString() +
                                                          ' Rs',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.green)),
                                                  Text(' Per 1',
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.grey)),
                                                          Text(tile.quantity_unit.toString())
                                                ],
                                              ),
                                            ),
                                            Text('Quantity:'+tile.quantity.toString(),
                                                style: TextStyle(
                                                  fontSize: 13,
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
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => Viewlisttilefarmer(
                        //         tile: tile,
                        //       ),
                        //     ));
                      },
                    ),
                  ),
                ),
                // Expanded(
                //   flex: 1,
                //   child: Text('Buyer'),
                // ),
                Expanded(
                    flex: 2,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Buyer"),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              CircleAvatar(child: Text(tmplist.confiremdBuyer.fullname[0].toUpperCase()),),
                              // Container(
                              //   margin: EdgeInsets.fromLTRB(10, 5, 5, 5),
                              //   height: 50,
                              //   width: 50,
                              //   decoration: BoxDecoration(
                              //       shape: BoxShape.circle,
                              //       color: Colors.lightBlue,
                              //       image: DecorationImage(
                              //           image: ExactAssetImage(
                              //               'images/farmer.png'),
                              //           fit: BoxFit.cover)),
                              // ),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                      margin: EdgeInsets.only(left: 20),
                                      child: Text(
                                        tmplist.confiremdBuyer.fullname
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15),
                                      ))),
                                      Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 10,right: 10),
                                    child: RatingBarIndicator(
                                      itemSize: 15,
                                      itemCount: 5,
                                      rating: tmplist.confiremdBuyer.starcount,
                                      itemBuilder: (context, int) => Icon(
                                        Icons.star,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10,right: 20),
                                    child: Text(
                                      tmplist.confiremdBuyer.starcount.toString(),
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                              // Expanded(
                              //     flex: 1,
                              //     child: Container(
                              //         padding: EdgeInsets.only(right: 20),
                              //         alignment: Alignment.centerRight,
                              //         child: Text(DateTime.now().toString())))
                            ],
                          ),
                          // Container(
                          //   //margin: EdgeInsets.only(left: 10, right: 10),
                          //   height: 1,
                          //   color: Colors.grey,
                          // ),
                          
                        ],
                      ),
                    )),
                // Expanded(
                //   flex: 1,
                //   child: Text('farmer'),
                // ),
                // Expanded(
                //   child: Padding(
                //     padding: const EdgeInsets.only(right: 12.0, bottom: 12),
                //     child: Container(
                //         alignment: Alignment.bottomRight,
                //         //height: 100,
                //         child: RaisedButton(
                //           child: Text('Request'),
                //           color: Colors.redAccent,
                //           onPressed: () {
                //             Filterdialog(context, widget.id,
                //                 tmplist.transport_request_id.toString());
                //           },
                //         )),
                //   ),
                // )
                Expanded(
                    flex: 2,
                    child: SizedBox(),
                    // child: Card(
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.zero),
                    //   color: Colors.white,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: <Widget>[
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Text('Farmer'),
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: <Widget>[
                    //           CircleAvatar(child: Text(tmplist.farmer.fullname[0].toUpperCase()),backgroundColor: Colors.green,),
                    //           // Container(
                    //           //   margin: EdgeInsets.fromLTRB(10, 5, 5, 5),
                    //           //   height: 50,
                    //           //   width: 50,
                    //           //   decoration: BoxDecoration(
                    //           //       shape: BoxShape.circle,
                    //           //       color: Colors.lightBlue,
                    //           //       image: DecorationImage(
                    //           //           image: ExactAssetImage(
                    //           //               'images/farmer.png'),
                    //           //           fit: BoxFit.cover)),
                    //           // ),
                    //           Expanded(
                    //               flex: 2,
                    //               child: Container(
                    //                   margin: EdgeInsets.only(left: 20),
                    //                   child: Text(
                    //                     tmplist.farmer.fullname
                    //                         .toString(),
                    //                     style: TextStyle(
                    //                         fontWeight: FontWeight.w400,
                    //                         fontSize: 15),
                    //                   ))),
                    //                   Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: <Widget>[
                    //           Row(
                    //             children: <Widget>[
                    //               Container(
                    //                 margin: EdgeInsets.only(left: 10,right: 10),
                    //                 child: RatingBarIndicator(
                    //                   itemSize: 15,
                    //                   itemCount: 5,
                    //                   rating: tmplist.farmer.starcount,
                    //                   itemBuilder: (context, int) => Icon(
                    //                     Icons.star,
                    //                     color: Colors.red,
                    //                   ),
                    //                 ),
                    //               ),
                    //               Container(
                    //                 margin: EdgeInsets.only(left: 10,right: 20),
                    //                 child: Text(
                    //                   tmplist.farmer.starcount.toString(),
                    //                   style: TextStyle(fontSize: 10),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       )
                    //           // Expanded(
                    //           //     flex: 1,
                    //           //     child: Container(
                    //           //         padding: EdgeInsets.only(right: 20),
                    //           //         alignment: Alignment.centerRight,
                    //           //         child: Text(DateTime.now().toString())))
                    //         ],
                    //       ),
                    //       // Container(
                    //       //   //margin: EdgeInsets.only(left: 10, right: 10),
                    //       //   height: 1,
                    //       //   color: Colors.grey,
                    //       // ),
                          
                    //     ],
                    //   ),
                   // )
                    ),
                Expanded(flex: 3,child: SizedBox(),)
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Sendreqesttransporter(
                        id: widget.id,tid: widget.tmplist.transport_request_id.toString(),
                      )));
        },
        backgroundColor: Colors.orange,
      ),
    );
  }
}
