import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:login2/Method/buyermethod.dart';
import 'package:login2/UI/Buyer/transportnotices.buyer.dart';
import 'package:login2/UI/Commenclass/Products.dart';
import 'package:login2/UI/Commenclass/transportreq.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'addtranspoterpopup.dart';

class Viewsentlisttilebuyer extends StatefulWidget {
  product tile;

  Viewsentlisttilebuyer({this.tile});

  @override
  _ViewsentlisttilebuyerState createState() => _ViewsentlisttilebuyerState();
}

class _ViewsentlisttilebuyerState extends State<Viewsentlisttilebuyer> {
  List<Transportdetails> tmplist;
  Transportdetails tmplist1;
  bool noticed = false;
  SharedPreferences spref;
  String buyer_id;
  int paid;

  List<String> lst = [
    'images/isna.jpg',
    'images/kondor.jpg',
    'images/lyra.jpg',
    'images/sante.jpg',
    'images/raja.jpg',
    'images/Desiree.jpg',
    'images/granola.jpg',
  ];

  PageController pgctrl;

  @override
  void initState() {
    paid = widget.tile.paid;
    pgctrl =
        PageController(initialPage: 0, keepPage: false, viewportFraction: 0.5);
    super.initState();
    getpref();
  }

  @override
  void dispose() {
    pgctrl.dispose();
    super.dispose();
  }

  getpref() async {
    spref = await SharedPreferences.getInstance();
    setState(() {
      buyer_id = spref.getInt('buyer_id').toString();
    });
    getsentreq();
  }

  getsentreq() async {
    var url =
        'http://34.87.38.40/transportRequest/added_by/' + buyer_id.toString();
    var url1 = 'http://34.87.38.40/transportRequest/1' +
        //widget.purchase_item_id +
        '/requestedTransporters/' +
        buyer_id.toString();

    var url2 = 'http://34.87.38.40/transportRequest/item/' +
        widget.tile.purchase_item_id.toString() +
        '/requestedTransporters/' +
        buyer_id.toString();
    var url3 = 'http://34.87.38.40/transportRequest/purchase_item/' +
        widget.tile.purchase_item_id.toString();

    print(url);
    print(buyer_id);

    try {
      await http
          .get(
        Uri.encodeFull(url3),
      )
          .then((response) {
        //print(response.body);

        print(response.statusCode);
        print(response.body);
        if (response.statusCode == 200) {
          String content = response.body;
          var prdct = json.decode(content);
          if (content == '[]') {
            NoItempopup(this.context,'No Item To Show');
          } else {
            setState(() {
              //tmplist =prdct.map((json) => Transportdetails.fromjson(json)).toList();
              tmplist1 = Transportdetails.fromjson(prdct);
              noticed = true;
              paid = prdct['purchaseItem']['paid'];
              print(paid);
            });
            print(tmplist1.transport_request_id);
          }
        } else if (response.statusCode >= 400 && response.statusCode < 500) {
          print('error');
        } else if (response.statusCode >= 500) {
          ServerErrorPopup(this.context);
        }
      });
    } catch (e) {
      print(e);
      Popupmessage(
          context,
          'You Havent paid yet paid For the item and add Transport notice',
          'Havent paid',
          true);
    }
  }

  PageController _pgctrl = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        //color: Colors.blue,
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 3,
                child: Stack(children: <Widget>[
                  Container(
                    //color: Colors.blue,
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    child: PageView.builder(
                      controller: _pgctrl,
                      itemCount: lst.length,
                      itemBuilder: (context, index) => Hero(
                        tag: 'img' + widget.tile.purchase_item_id.toString(),
                        child: Image.asset(
                          lst[widget.tile.purchase_item_id % 5].toString(),
                          fit: BoxFit.fill,
                        ),
                      ),
                      physics: ClampingScrollPhysics(),
                    ),
                  ),
                ])),
            Expanded(
              flex: 5,
              child: Container(
                //color: Colors.cyanAccent,
                padding: EdgeInsets.fromLTRB(20, 1, 0, 30),
                width: double.maxFinite,
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(widget.tile.type.toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w300)),
                                      Text(' (' + widget.tile.variety + ')',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.green,
                                      size: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                          widget.tile.district +
                                              ',' +
                                              widget.tile.city,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w100)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.credit_card,
                                            color: Colors.green,
                                            size: 15,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                                widget.tile.unit_price
                                                        .toString() +
                                                    ' Rs',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey)),
                                          ),
                                          Text('/kg',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.shopping_basket,
                                      color: Colors.green,
                                      size: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                          widget.tile.quantity.toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.calendar_today,
                                      color: Colors.green,
                                      size: 15,
                                    ),
                                    //Text(' EXP Date:'),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(widget.tile.date,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Row(
                                  children: <Widget>[
                                    //Icon(Icons.calendar_today,color: Colors.green,size: 15,),
                                    Text(' EXP Date:'),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(widget.tile.exp_date,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Row(
                                  children: <Widget>[
                                    //Icon(Icons.calendar_today,color: Colors.green,size: 15,),
                                    Text(' Harvest Date:'),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(widget.tile.harvest_date,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          //color: Colors.grey.withOpacity(0.5),
                          child: Column(
                            children: <Widget>[
                              // Container(
                              //   color: Colors.black,
                              //   height: 1,
                              //   margin: EdgeInsets.only(bottom: 10),
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  child: Icon(Icons.person),
                                  backgroundColor: Colors.green,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  // Container(
                                  //   width: 60,
                                  //   height: 60,
                                  //   child: Image.asset(
                                  //     'images/farmer.png',
                                  //     fit: BoxFit.fill,
                                  //   ),
                                  //   decoration: BoxDecoration(
                                  //       color: Colors.blueAccent,
                                  //       borderRadius: BorderRadius.all(
                                  //           Radius.circular(10.0))),
                                  // ),
                                  Expanded(
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            widget.tile.farmer.fullname
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          RatingBarIndicator(
                                            rating:
                                                widget.tile.farmer.starcount,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.only(
                                                left: 0, right: 0.0),
                                            itemSize: 20,
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              Icons.star,
                                              color: Colors.green,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Container(
                                  //   //color: Colors.amber,
                                  //   child: RaisedButton(
                                  //     shape: RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius.all(
                                  //             Radius.circular(12.0))),
                                  //     color: Colors.green,
                                  //     child: Text(
                                  //       'View Profile',
                                  //       style: TextStyle(
                                  //           fontSize: 10, color: Colors.white),
                                  //     ),
                                  //     onPressed: () {},
                                  //   ),
                                  // )
                                ],
                              ),
                              // Container(
                              //   color: Colors.black,
                              //   height: 1,
                              //   margin: EdgeInsets.only(bottom: 0, top: 10.0),
                              // ),
                              // Container(
                              //   child: Text('Tranceport Notice'),
                              // ),

                              Expanded(
                                child: noticed
                                    ? Stack(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.3),
                                             borderRadius: BorderRadius.all(
                                             Radius.circular(20))),
                                            margin: EdgeInsets.only(
                                                bottom: 5, right: 20),
                                            //color: Colors.white,
                                            child: ListTile(
                                              contentPadding:
                                                  EdgeInsets.all(10.0),
                                              // leading: Hero(
                                              //   tag:
                                              //       12, //myitems[index].purchase_item_id,
                                              //   child: Container(
                                              //       height: 50,
                                              //       width: 50,
                                              //       decoration: BoxDecoration(
                                              //         shape: BoxShape.circle,
                                              //         color: Colors.grey[100],
                                              //         image: DecorationImage(
                                              //             image: ExactAssetImage(
                                              //                 lst[0]),
                                              //             // lst[myitems[index].purchase_item_id%5]),
                                              //             fit: BoxFit.fill),
                                              //       )),
                                              // ),
                                              title: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 0.0, bottom: 10),
                                                //color: Colors.black,
                                                // alignment: Alignment.topLeft,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Text(
                                                          tmplist1.start,
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          ' to ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w200),
                                                        ),
                                                        Text(
                                                          tmplist1.end,
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    // Row(
                                                    //   mainAxisAlignment: MainAxisAlignment.end,
                                                    //   crossAxisAlignment: CrossAxisAlignment.start,
                                                    //   children: <Widget>[
                                                    //     Text('Request'

                                                    //             ,
                                                    //         style: TextStyle(
                                                    //           color: Colors.blue,
                                                    //             fontSize: 10,
                                                    //             fontWeight:
                                                    //                 FontWeight
                                                    //                     .bold)),
                                                    //     // Text(
                                                    //     //     ' (' +
                                                    //     //         // tmplist[0]
                                                    //     //         //     .purchaseItem
                                                    //     //         //     .variety +
                                                    //     //         ')',
                                                    //     //     style: TextStyle(
                                                    //     //         fontSize: 10,
                                                    //     //         fontWeight:
                                                    //     //             FontWeight
                                                    //     //                 .bold)),
                                                    //   ],
                                                    // ),
                                                    // Text('data2',
                                                    //     //'800 kg',
                                                    //     style: TextStyle(
                                                    //         fontSize: 10,
                                                    //         fontWeight:
                                                    //             FontWeight.bold))
                                                  ],
                                                ),
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  // Text(
                                                  //   'More',
                                                  //   style: TextStyle(
                                                  //       fontWeight:
                                                  //           FontWeight.w300,
                                                  //       fontSize: 10),
                                                  // ),
                                                ],
                                              ),
                                              trailing: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Text('on ' + tmplist1.date,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Transportnotice(
                                                              buyer_id:
                                                                  buyer_id,
                                                              purchase_item_id: widget
                                                                  .tile
                                                                  .purchase_item_id
                                                                  .toString(),
                                                            )));
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(
                                        // height: 100,
                                        width: 200,
                                        //color: Colors.amber,
                                        child: Container(
                                          color: Colors.amber,
                                          //margin: EdgeInsets.all(30),
                                          //height: 50,
                                          //width: 10,
                                          child: FlatButton(
                                            color:
                                                Colors.amber.withOpacity(0.75),
                                            //shape: RoundedRectangleBorder(
                                            //borderRadius: BorderRadius.all(
                                            //Radius.circular(10.0))),
                                            child: Text(
                                              'Add Transport notice +',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            onPressed: paid == 1
                                                ? () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Addtransportpopup(
                                                                  purchaseid: widget
                                                                      .tile
                                                                      .purchase_item_id
                                                                      .toString(),
                                                                )));
                                                  }
                                                : null,
                                          ),
                                        ),
                                      ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  paid == 1
                                      ? Padding(
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                                  color: Colors.amber,
                                              child: Row(
                                                children: <Widget>[
                                                  Text("Paid"),
                                                  Icon(Icons.done)
                                                ],
                                              )),
                                          padding: EdgeInsets.all(0.8),
                                        )
                                      : FlatButton(
                                          child: Text('Pay here'),
                                          onPressed: paid == 0 ? () {} : null,
                                        )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
