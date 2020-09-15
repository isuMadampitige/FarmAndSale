import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:login2/Method/buyermethod.dart';
import 'package:login2/Method/getaccountid.dart';
import 'package:login2/UI/Commenclass/notification.dart';
import 'package:login2/UI/Commenclass/profileviewandrate.dart';
import 'package:http/http.dart' as http;

class Notificationcardview extends StatelessWidget {
  Notifications data;
  String role;
  Notificationcardview({this.data, this.role});
  static const primcolor = Colors.green;
  static const secndcolor = Colors.blue;
  int rate;
  List<String> lst = [
    'images/isna.jpg',
    'images/kondor.jpg',
    'images/lyra.jpg',
    'images/sante.jpg',
    'images/raja.jpg',
    'images/Desiree.jpg',
    'images/granola.jpg',
  ];

  ratefn(int rateraccid, int receiverid, int rate, BuildContext context) {
    Map arr = {
      "rater_id": rateraccid,
      "receiver_id": receiverid,
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
        Popupmessage(
            context, 'You have Successfully rate this user', 'Rated', false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          data.purchaseItem.date.toString(),
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: primcolor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
            child: Text(
              'Item Details',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          AnimatedOpacity(
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
                          tag: 'img' +
                              data.purchaseItem.purchase_item_id.toString(),
                          child: Image.asset(
                            lst[varietypic(data.purchaseItem.variety)],
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        color: Colors.white,
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
                              data.purchaseItem.type.toString() +
                                  '  (' +
                                  data.purchaseItem.variety +
                                  ')',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w900),
                            ),
                            //Title Container
                            alignment: Alignment.topLeft,
                          ),
                          Container(
                            //Adddress Conatiner
                            padding: EdgeInsets.fromLTRB(10, 2, 5, 5),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  size: 12,
                                  color: primcolor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    data.purchaseItem.district.toString() +
                                        ',' +
                                        data.purchaseItem.city.toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300),
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
                            margin: EdgeInsets.fromLTRB(10, 2, 10, 5),
                          ),
                          Container(
                            //Farmer,starcount container
                            // width: 300,
                            margin: EdgeInsets.only(right: 5),
                            //color: Colors.amberAccent,
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Expanded(
                                    // Wrap(
                                    // children: <Widget>[
                                    Text('Harvet date :',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500)),
                                    Text(
                                      data.purchaseItem.harvest_date,
                                      //'Samarasekara',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Expanded(
                                    // Wrap(
                                    // children: <Widget>[
                                    Text('EXP date :',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500)),
                                    Text(
                                      data.purchaseItem.exp_date,
                                      //'Samarasekara',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      //alignment: Alignment.centerLeft,
                                      //color: Colors.black,
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                              data.purchaseItem.unit_price
                                                      .toString() +
                                                  ' Rs',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.green)),
                                          Text(
                                              ' per 1' +
                                                  data.purchaseItem
                                                      .quantity_unit,
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.grey)),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text('Quantity',
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.black)),
                                        Text(
                                            data.purchaseItem.quantity
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 13,
                                            )),
                                        Text(
                                            data.purchaseItem.quantity_unit
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
          role != 'farmer'
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 0, 8),
                  child: Text(
                    'Farmer Details',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                )
              : SizedBox(),
          role != 'farmer'
              ? InkWell(
                  onTap: () async {
                    int acc_id = await getaccount_id();
                    if (acc_id == data.farmer_acc_id) {
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Profileviewandrate(
                                    role: 'farmer',
                                    id: data.purchaseItem.farmer.id,
                                    acc_id: data.farmer_acc_id,
                                    canrate: true,
                                  )));
                    }
                  },
                  child: Card(
                    child: Container(
                      //height: 200,
                      //color: Colors.yellow,
                      width: double.maxFinite,
                      //height: double.maxFinite,
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                width: 110,
                                child: CircleAvatar(
                                  backgroundColor: primcolor,
                                  radius: 30,
                                  child: Center(
                                    child: Text(
                                      data.purchaseItem.farmer.fullname[0]
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: RatingBarIndicator(
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.red,
                                  ),
                                  itemPadding: EdgeInsets.all(0.0),
                                  itemSize: 15,
                                  rating: data.purchaseItem.farmer.starcount,
                                ),
                              ),
                              Text(data.purchaseItem.farmer.starcount
                                  .toString()
                                  .substring(0, 3))
                            ],
                          ), //Image Container
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                //Title Container
                                padding: EdgeInsets.fromLTRB(10, 8, 10, 2),
                                child:
                                    // Row(children:<Widget>[
                                    Row(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        Icons.person,
                                        size: 12,
                                        color: primcolor,
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          'Full Name:',
                                          style: TextStyle(fontSize: 12),
                                        )),
                                    Text(
                                      data.purchaseItem.farmer.fullname
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                                //])

                                //Title Container
                                alignment: Alignment.topLeft,
                              ),
                              Container(
                                //Adddress Conatiner
                                padding: EdgeInsets.fromLTRB(10, 2, 5, 5),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(Icons.location_on,
                                          size: 12, color: primcolor),
                                    ),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          'Address :',
                                          style: TextStyle(fontSize: 12),
                                        )),
                                    Expanded(
                                      child: Text(
                                        //'top2'+
                                        data.purchaseItem.farmer.address
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                //Adddress Conatiner
                                padding: EdgeInsets.fromLTRB(10, 2, 5, 5),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        Icons.location_city,
                                        size: 12,
                                        color: primcolor,
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          'District :',
                                          style: TextStyle(fontSize: 12),
                                        )),
                                    Expanded(
                                      child: Text(
                                        data.purchaseItem.farmer.district
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Icon(
                                            Icons.call,
                                            size: 12,
                                            color: primcolor,
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Text(
                                              'Mobile number :',
                                              style: TextStyle(fontSize: 12),
                                            )),
                                        Text(
                                          data.purchaseItem.farmer.mobilenumber
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    // Row(
                                    //   children: <Widget>[
                                    //     Padding(
                                    //       padding:
                                    //           const EdgeInsets.only(right: 8.0),
                                    //       child: Icon(
                                    //         Icons.email,
                                    //         size: 12,
                                    //         color: primcolor,
                                    //       ),
                                    //     ),
                                    //     Padding(
                                    //         padding: const EdgeInsets.only(
                                    //             right: 8.0),
                                    //         child: Text(
                                    //           'Email :',
                                    //           style: TextStyle(fontSize: 12),
                                    //         )),
                                    //     Text(
                                    //         data.purchaseItem.farmer.email
                                    //             .toString(),
                                    //         style: TextStyle(
                                    //             fontSize: 10,
                                    //             fontWeight: FontWeight.w500,
                                    //             color: Colors.black)),
                                    //   ],
                                    // ),
                                    
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Icon(
                                            Icons.stars,
                                            size: 12,
                                            color: primcolor,
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Text(
                                              'Rating :',
                                              style: TextStyle(fontSize: 12),
                                            )),
                                        Text(
                                            data.purchaseItem.farmer.starcount
                                                .toString()
                                                .substring(0, 3),
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox(),
          role != 'buyer'
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 0, 8),
                  child: Text(
                    'Rate Buyer',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                )
              : SizedBox(),
          role != 'buyer'
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: RatingBar(
                        itemSize: 30,
                        itemCount: 5,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.blue,
                        ),
                        onRatingUpdate: (val) {
                          // setState(() {
                          rate = val.toInt();
                          // });
                        },
                      ),
                    )
                  ],
                )
              : SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text("rate"),
                onPressed: () {
                  if(role=='farmer'){
                  ratefn(data.farmer_acc_id, data.buyer_acc_id, rate, context);}
                  else if(role=='transporter'){ratefn(data.transporter_acc_id, data.buyer_acc_id, rate, context);}
                },
              )
            ],
          ),
          // InkWell(
          //     onTap: () async {
          //       int acc_id = await getaccount_id();
          //       if (acc_id == data.buyer_acc_id) {
          //       } else {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => Profileviewandrate(
          //                       role: 'buyer',
          //                       id: data.purchaseItem.confirmedbuyer.id,
          //                       acc_id: data.buyer_acc_id,
          //                       canrate: true,
          //                     )));
          //       }
          //     },
          //     child: Card(
          //       child: Container(
          //         //height: 200,
          //         //color: Colors.yellow,
          //         width: double.maxFinite,
          //         //height: double.maxFinite,
          //         padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          //         child: Row(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           children: <Widget>[
          //             Column(
          //               children: <Widget>[
          //                 Container(
          //                   width: 110,
          //                   child: CircleAvatar(
          //                     backgroundColor: secndcolor,
          //                     radius: 30,
          //                     child: Center(
          //                       child: Text(
          //                         data.purchaseItem.confirmedbuyer
          //                             .fullname[0]
          //                             .toString(),
          //                         style: TextStyle(
          //                             fontSize: 25, color: Colors.white),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 Padding(
          //                   padding: const EdgeInsets.only(top: 8.0),
          //                   child: RatingBarIndicator(
          //                     itemBuilder: (context, _) => Icon(
          //                       Icons.star,
          //                       color: Colors.red,
          //                     ),
          //                     itemPadding: EdgeInsets.all(0.0),
          //                     itemSize: 15,
          //                     rating: data.purchaseItem.farmer.starcount,
          //                   ),
          //                 ),
          //                 Text(data.purchaseItem.confirmedbuyer.starcount
          //                     .toString()
          //                     .substring(0, 3))
          //               ],
          //             ), //Image Container
          //             Expanded(
          //                 child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: <Widget>[
          //                 Container(
          //                   //Title Container
          //                   padding: EdgeInsets.fromLTRB(10, 8, 10, 2),
          //                   child:
          //                       // Row(children:<Widget>[
          //                       Row(
          //                     children: <Widget>[
          //                       Padding(
          //                         padding:
          //                             const EdgeInsets.only(right: 8.0),
          //                         child: Icon(
          //                           Icons.person,
          //                           size: 12,
          //                           color: secndcolor,
          //                         ),
          //                       ),
          //                       Padding(
          //                           padding:
          //                               const EdgeInsets.only(right: 8.0),
          //                           child: Text(
          //                             'Full Name:',
          //                             style: TextStyle(fontSize: 12),
          //                           )),
          //                       Text(
          //                         data.purchaseItem.confirmedbuyer.fullname
          //                             .toString(),
          //                         style: TextStyle(
          //                             fontSize: 14,
          //                             fontWeight: FontWeight.w900),
          //                       ),
          //                     ],
          //                   ),
          //                   //])

          //                   //Title Container
          //                   alignment: Alignment.topLeft,
          //                 ),
          //                 Container(
          //                   //Adddress Conatiner
          //                   padding: EdgeInsets.fromLTRB(10, 2, 5, 5),
          //                   child: Row(
          //                     children: <Widget>[
          //                       Padding(
          //                         padding:
          //                             const EdgeInsets.only(right: 8.0),
          //                         child: Icon(Icons.location_on,
          //                             size: 12, color: secndcolor),
          //                       ),
          //                       Padding(
          //                           padding:
          //                               const EdgeInsets.only(right: 8.0),
          //                           child: Text(
          //                             'Address :',
          //                             style: TextStyle(fontSize: 12),
          //                           )),
          //                       Expanded(
          //                         child: Text(
          //                           //'top2'+
          //                           data.purchaseItem.confirmedbuyer.address
          //                               .toString(),
          //                           style: TextStyle(
          //                               fontSize: 12,
          //                               fontWeight: FontWeight.w500),
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //                 Container(
          //                   //Adddress Conatiner
          //                   padding: EdgeInsets.fromLTRB(10, 2, 5, 5),
          //                   child: Row(
          //                     children: <Widget>[
          //                       Padding(
          //                         padding:
          //                             const EdgeInsets.only(right: 8.0),
          //                         child: Icon(
          //                           Icons.location_city,
          //                           size: 12,
          //                           color: secndcolor,
          //                         ),
          //                       ),
          //                       Padding(
          //                           padding:
          //                               const EdgeInsets.only(right: 8.0),
          //                           child: Text(
          //                             'District :',
          //                             style: TextStyle(fontSize: 12),
          //                           )),
          //                       Expanded(
          //                         child: Text(
          //                           data.purchaseItem.confirmedbuyer
          //                               .district
          //                               .toString(),
          //                           style: TextStyle(
          //                               fontSize: 12,
          //                               fontWeight: FontWeight.w500),
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //                 Container(
          //                   margin: EdgeInsets.only(right: 5),
          //                   padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
          //                   child: Column(
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     mainAxisAlignment:
          //                         MainAxisAlignment.spaceBetween,
          //                     children: <Widget>[
          //                       Row(
          //                         mainAxisAlignment:
          //                             MainAxisAlignment.start,
          //                         crossAxisAlignment:
          //                             CrossAxisAlignment.end,
          //                         children: <Widget>[
          //                           Padding(
          //                             padding:
          //                                 const EdgeInsets.only(right: 8.0),
          //                             child: Icon(
          //                               Icons.call,
          //                               size: 12,
          //                               color: secndcolor,
          //                             ),
          //                           ),
          //                           Padding(
          //                               padding: const EdgeInsets.only(
          //                                   right: 8.0),
          //                               child: Text(
          //                                 'Mobile number :',
          //                                 style: TextStyle(fontSize: 12),
          //                               )),
          //                           Text(
          //                             data.purchaseItem.confirmedbuyer
          //                                 .mobilenumber
          //                                 .toString(),
          //                             style: TextStyle(
          //                                 fontSize: 10,
          //                                 fontWeight: FontWeight.w500,
          //                                 color: Colors.black),
          //                           ),
          //                         ],
          //                       ),
          //                       SizedBox(height: 8),

          //                       //SizedBox(height: 8.0),
          //                       Row(
          //                         children: <Widget>[
          //                           Padding(
          //                             padding:
          //                                 const EdgeInsets.only(right: 8.0),
          //                             child: Icon(
          //                               Icons.stars,
          //                               size: 12,
          //                               color: secndcolor,
          //                             ),
          //                           ),
          //                           Padding(
          //                               padding: const EdgeInsets.only(
          //                                   right: 8.0),
          //                               child: Text(
          //                                 'Rating :',
          //                                 style: TextStyle(fontSize: 12),
          //                               )),
          //                           Text(
          //                               data.purchaseItem.confirmedbuyer
          //                                   .starcount
          //                                   .toString()
          //                                   .substring(0, 3),
          //                               style: TextStyle(
          //                                   fontSize: 10,
          //                                   fontWeight: FontWeight.w500,
          //                                   color: Colors.black))
          //                         ],
          //                       )
          //                     ],
          //                   ),
          //                 ),
          //               ],
          //             )),
          //           ],
          //         ),
          //       ),
          //     ),
          //   )
          // ,
          role != 'transporter'
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 0, 8),
                  child: Text(
                    'Rate Transporter',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                )
              : SizedBox(),
          role != 'transporter'
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: RatingBar(
                        itemSize: 30,
                        itemCount: 5,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        onRatingUpdate: (val) {
                          // setState(() {
                          rate = val.toInt();
                          // });
                        },
                      ),
                    )
                  ],
                )
              : SizedBox(),
          role != 'transporter'
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      child: Text('Rate'),
                      onPressed: () {
                        if(role=='farmer'){
                        ratefn(data.farmer_acc_id, data.transporter_acc_id,
                            rate, context);}
                            else if(role=='buyer'){ratefn(data.buyer_acc_id, data.transporter_acc_id,
                            rate, context);}
                      },
                    )
                  ],
                )
              : SizedBox()
        ],
      ),
    );
  }
}
