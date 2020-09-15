import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:login2/Method/buyermethod.dart';
import 'package:login2/UI/Buyer/Sentrequest.dart';
import 'package:login2/UI/Commenclass/Products.dart';
import 'package:login2/UI/Farmer/myitemlist.dart';
import 'package:http/http.dart' as http;
import 'package:login2/userclass.dart';

class ViewConfirmedrequest extends StatefulWidget {
  product myitem;
  String purchase_id;
  String farmer_id;

  ViewConfirmedrequest({this.purchase_id, this.farmer_id, this.myitem});

  @override
  _ViewConfirmedrequestState createState() => _ViewConfirmedrequestState(
      purchase_id: purchase_id, farmer_id: farmer_id, myitem: myitem);
}

class _ViewConfirmedrequestState extends State<ViewConfirmedrequest> {
  String purchase_id;
  String farmer_id;
  product myitem;
  List<Usr> buyerlist;
  bool isloading = false;
  _ViewConfirmedrequestState({this.purchase_id, this.farmer_id, this.myitem});

  reqestedbuyer() async {
    String url = 'http://34.87.38.40/purchaseItem/' +
        purchase_id.toString() +
        '/requestedBuyers/' +
        farmer_id.toString();

    print(url);
    print(widget.purchase_id);

    await http.get(url).then((response) {
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        String content = response.body;
        List prdct = json.decode(content);
        if (content == '[]') {
          NoItempopup(this.context,'No Requested Buyers Yet');
        } else {
          setState(() {
            buyerlist = prdct.map((json) => Usr.fromJson(json)).toList();
            isloading = false;
          });
          print(buyerlist[0].fullname);
        }
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        print('error');
      } else if (response.statusCode >= 500) {
        ServerErrorPopup(this.context);
      }
    });
  }

  confirmbuyer(String buyrid) async {
    String url = 'http://34.87.38.40/purchaseItem/' +
        myitem.purchase_item_id.toString() +
        '/select_buyer/' +
        buyrid;

    await http.post(url, body: {"type": "type"}).then((response) {
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        SentRequestPopup(context);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //reqestedbuyer();
    print(widget.myitem.district.toString());
    print(myitem.district.toString());
    print(myitem.confirmedbuyer.starcount);
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[70],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green.withOpacity(1),
        title: Text(myitem.type.toString()),
        leading: Container(
          height: 20,
          width: 20,
          //color: Colors.amber,
          // decoration: BoxDecoration(
          //     shape: BoxShape.circle, color: Colors.grey.withOpacity(0.1)),
          child: IconButton(
            iconSize: 20,
            //padding: EdgeInsets.all(1),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
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
                              myitem.purchase_item_id.toString(),
                          child: Image.asset(
                            lst[varietypic(myitem.variety)],
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
                              myitem.type.toString() +
                                  '  (' +
                                  myitem.variety +
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
                                  color: Colors.green,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(
                                   myitem.district.toString() +
                                        ',' +
                                        myitem.city.toString(),
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
                                      myitem.harvest_date.toString(),
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
                                      myitem.exp_date.toString(),
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
                                             myitem.unit_price
                                                      .toString() +
                                                  ' Rs',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.green)),
                                          Text(
                                              ' per 1' +
                                                  myitem
                                                      .quantity_unit.toString(),
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
                                            myitem.quantity
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 13,
                                            )),
                                        Text(
                                            myitem.quantity_unit
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
              onTap: null,
            ),
          ),
          // Container(
          //   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          //   child: Column(
          //     children: <Widget>[
          //       Container(
          //         decoration: BoxDecoration(
          //             //color: Colors.white,
          //             borderRadius: BorderRadius.all(Radius.circular(10))),
          //         margin: EdgeInsets.only(bottom: 5),
          //         //color: Colors.grey,
          //         child: ListTile(
          //           //contentPadding: EdgeInsets.all(10.0),
          //           leading: Container(
          //             height: 100,
          //             width: 60,
          //             // decoration: BoxDecoration(
          //             //   shape: BoxShape.circle,
          //             //   color: Colors.grey[100],
          //             //   image: DecorationImage(
          //             //       image: ExactAssetImage('images/avacado.jpg'),
          //             //       fit: BoxFit.fill),
          //             // )
          //             child: Hero(
          //               tag: myitem.purchase_item_id,
          //               child: Image.asset(
          //                 lst[myitem.purchase_item_id%5],
          //                 fit: BoxFit.cover,
          //               ),
          //             ),
          //           ),
          //           title: Padding(
          //             padding: EdgeInsets.only(top: 0.0, bottom: 10),
          //             //color: Colors.black,
          //             // alignment: Alignment.topLeft,
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: <Widget>[
          //                 Text(
          //                   //Text(
          //                   myitem.type.toUpperCase() +
          //                       ' (' +
          //                       //+
          //                       myitem.variety.toString() +
          //                       ')'
          //                   // (')')
          //                   ,
          //                   style: TextStyle(
          //                       fontSize: 15, fontWeight: FontWeight.bold),
          //                 ),
          //                 Text(myitem.unit_price.toString() + ' Rs / kg',
          //                     style: TextStyle(
          //                         fontSize: 10, fontWeight: FontWeight.bold)),
          //                 Text(myitem.quantity.toString() + ' kg',
          //                     style: TextStyle(
          //                         fontSize: 10, fontWeight: FontWeight.bold))
          //               ],
          //             ),
          //           ),
          //           subtitle: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: <Widget>[
          //               Text(
          //                 'Kurunegala,narammala',
          //                 // myitem.district+','+myitem.city,
          //                 style: TextStyle(
          //                     fontWeight: FontWeight.w300, fontSize: 10),
          //               ),
          //             ],
          //           ),
          //           trailing: Column(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             crossAxisAlignment: CrossAxisAlignment.end,
          //             children: <Widget>[
          //               Text(myitem.harvest_date,
          //                   style: TextStyle(
          //                       fontSize: 12, fontWeight: FontWeight.bold)),
          //               // Text(
          //               //   '( 2 more Days to expire )',
          //               //   style: TextStyle(
          //               //       fontSize: 8,
          //               //       fontWeight: FontWeight.bold,
          //               //       color: Colors.red),
          //               // )
          //               //timediffrence('2019-08-25'
          //               //myitem.exp_date
          //               // )
          //             ],
          //           ),
          //           // onTap: () {
          //           //   Navigator.push(
          //           //       context,
          //           //       MaterialPageRoute(
          //           //           builder: (context) => Viewrequest()));
          //           // },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   color: Colors.grey,
          //   height: 1,
          //   width: MediaQuery.of(context).size.width,
          //   margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
          // ),
          Container(
            padding: EdgeInsets.only(left: 10),
            color: Colors.white,
            //height: 1,
            width: MediaQuery.of(context).size.width,
            //padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: Text(
              'Confirmed Buyer',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Container(
            color: Colors.grey,
            height: 1,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
          ),
          Expanded(
              flex: 1,
              child: RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 2));
                },
                color: Colors.blue,
                child: Container(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: isloading
                      ? ListView(
                          children: <Widget>[
                            Center(
                              child: CircularProgressIndicator(),
                            )
                          ],
                        )
                      : ListView(
                          children: <Widget>[
                            //itemCount: 1,//buyerlist.length,
                            // itemBuilder: (context, index) {
                            //return
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 5, 5, 5),
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.lightBlue,
                                            image: DecorationImage(
                                                image: ExactAssetImage(
                                                    'images/farmer.png'),
                                                fit: BoxFit.cover)),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                              margin: EdgeInsets.only(left: 20),
                                              child: Text(
                                                //'samarasekara',
                                                myitem.confirmedbuyer.fullname,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15),
                                              ))),
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  DateTime.now().toString())))
                                    ],
                                  ),
                                  Container(
                                    //margin: EdgeInsets.only(left: 10, right: 10),
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: RatingBarIndicator(
                                              itemSize: 15,
                                              itemCount: 5,
                                              rating: myitem
                                                  .confirmedbuyer.starcount,
                                              itemBuilder: (context, int) =>
                                                  Icon(
                                                Icons.star,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              '(180)',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                            //;
                            // },
                          ],
                        ),
                ),
              ))
        ],
      ),
    );
  }
}
