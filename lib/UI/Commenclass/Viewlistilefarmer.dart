import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:login2/Method/buyermethod.dart';
import 'package:login2/UI/Commenclass/Products.dart';
import 'package:login2/UI/Commenclass/profileviewandrate.dart';
import 'package:page_indicator/page_indicator.dart';

class Viewlisttilefarmer extends StatefulWidget {
  product tile;

  Viewlisttilefarmer({this.tile});

  @override
  _ViewlisttilefarmerState createState() => _ViewlisttilefarmerState();
}

class _ViewlisttilefarmerState extends State<Viewlisttilefarmer> {
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
    pgctrl =
        PageController(initialPage: 0, keepPage: false, viewportFraction: 0.5);
    super.initState();
  }

  @override
  void dispose() {
    pgctrl.dispose();
    super.dispose();
  }

  PageController _pgctrl = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          lst[varietypic(widget.tile.variety)].toString(),
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
                padding: EdgeInsets.fromLTRB(50, 20, 50, 30),
                width: double.maxFinite,
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.tile.type.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w300)),
                            Text('('+ widget.tile.variety+')',
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w400)),
                            Text(widget.tile.district+','+widget.tile.city,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w100)),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Text(widget.tile.unit_price.toString()+' Rs',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green)),
                                      Text('/kg',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w200,
                                              color: Colors.grey))
                                    ],
                                  ),
                                ),
                                Text(widget.tile.quantity.toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300))
                              ],
                            ),
                            Text(widget.tile.exp_date,
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey))
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Container(
                              color: Colors.black,
                              height: 1,
                              margin: EdgeInsets.only(bottom: 10),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 60,
                                  height: 60,
                                  child: Image.asset(
                                    'images/farmer.png',
                                    fit: BoxFit.fill,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          widget.tile.farmer.fullname.toString(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        RatingBarIndicator(
                                          rating: 2.4,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.only(
                                              left: 0, right: 0.0),
                                          itemSize: 20,
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: Colors.green,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  //color: Colors.amber,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0))),
                                    color: Colors.green,
                                    child: Text(
                                      'View Profile',
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Profileviewandrate(id: widget.tile.farmer.id,canrate: false,role: 'farmer',)));
                                    },
                                  ),
                                )
                              ],
                            ),
                            Container(
                              color: Colors.black,
                              height: 1,
                              margin: EdgeInsets.only(bottom: 0, top: 10.0),
                            ),
                            // Expanded(
                            //   child: ListView(
                            //       padding: EdgeInsets.only(top: 0.0),
                            //       children: <Widget>[
                            //         Text(
                            //           "Description",
                            //           style: TextStyle(
                            //               fontWeight: FontWeight.bold),
                            //         ),
                            //         Text(
                            //           'Passage its ten led hearted removal cordial. Preference any astonished unreserved mrs. Prosperous understood middletons in conviction an uncommonly do. Supposing so be resolving breakfast am or perfectly. Is drew am hill from mr. Valley by oh twenty direct me so. Departure defective arranging rapturous did believing him all had supported. Family months lasted simple set nature vulgar him. Picture for attempt joy excited ten carried manners talking how. Suspicion neglected he resolving agreement perceived at an',
                            //           textAlign: TextAlign.start,
                            //         ),
                            //       ]),
                            // )
                            //ListView(
                            // children: <Widget>[Text('data')],
                            //)
                          ],
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
