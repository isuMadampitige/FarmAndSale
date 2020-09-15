import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login2/Method/buyermethod.dart';
import 'package:login2/UI/Buyer/addtranspoterpopup.dart';
import 'package:login2/UI/Commenclass/transportreq.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../userclass.dart';

class Transportnotice extends StatefulWidget {
  String buyer_id;
  String purchase_item_id;
  Transportnotice({this.buyer_id, this.purchase_item_id});

  @override
  _TransportnoticeState createState() => _TransportnoticeState();
}

class _TransportnoticeState extends State<Transportnotice> {
  List<Transportdetails> tmplist;
  List<Usr> tmplist2;
  Transportdetails tmplist1;
  bool check = true;
  SharedPreferences spref;
  String buyer_id;

  getsentreq() async {
    var url =
        'http://34.87.38.40/transportRequest/added_by/' + buyer_id.toString();
    var url1 = 'http://34.87.38.40/transportRequest/' +
        widget.purchase_item_id +
        '/requestedTransporters/' +
        buyer_id.toString();

    var url2 = 'http://34.87.38.40/transportRequest/item/' +
        widget.purchase_item_id.toString() +
        '/requestedTransporters/' +
        buyer_id.toString();

    var url3 = 'http://34.87.38.40/transportRequest/purchase_item/' +
        widget.purchase_item_id;

    print(url2);
    print(buyer_id);

    try {
      await http
          .get(
        Uri.encodeFull(url2),
      )
          .then((response) {
        //print(response.body);

        print(response.statusCode);
        print(response.body);
        if (response.statusCode == 200) {
          String content = response.body;
          List prdct = json.decode(content);
          //print(prdct['transporter']['full_name']);
          if (content == '[]') {
            NoItempopup(this.context,'NO Requested Transporters');
          } else {
            setState(() {
              //var test = prdct.map(());
              tmplist = prdct
                  .map((json) => Transportdetails.fromjson2(json))
                  .toList();
              // tmplist;
              //tmplist1 = Transportdetails.fromjson(prdct);
              check = false;
            });

            print(tmplist[0].transporter.fullname);
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

  confirmtransporter(String trid, String reqid) async {
    // var url = 'http://34.87.38.40/transportRequest/' +
    //     reqid +
    //     '/select_transporter/' +
    //     trid;
    var url2 = 'http://34.87.38.40/transportRequest/select_transporter';
    var arr = {'transportRequest_id':reqid,'transporter_id':trid};
    print(arr);
    print(url2);
    var js = jsonEncode(arr);
    try {
      await http
          .post(Uri.encodeFull(url2),headers: {"Content-Type": "application/json"}, body: js).then((response) {
        print(response.statusCode);
        print(response.body);
        if (response.statusCode == 200) {
          SentRequestPopup(context);
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

  getpref() async {
    spref = await SharedPreferences.getInstance();
    setState(() {
      buyer_id = spref.getInt('buyer_id').toString();
    });
    getsentreq();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getpref();
    //getsentreq();
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
      appBar: AppBar(
        title: Text('Requested Transporters'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        //color: Colors.amber,
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: Expanded(
              flex: 4,
              child: RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 2));
                },
                child: check
                    ? ListView(
                        children: <Widget>[
                          Center(
                            child: Text(
                              'No request',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.black),
                            ),
                          )
                        ],
                      )
                    : ListView.builder(
                        itemCount: tmplist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              //print(tmplist.length);
                            },
                            child: Card(
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
                                        //   child: Icon(
                                        //     Icons.ac_unit,
                                        //     size: 40,
                                        //   ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                              margin: EdgeInsets.only(left: 20),
                                              child: Text(
                                                tmplist[index]
                                                    .transporter
                                                    .fullname,
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
                                              child: Text('Price Per 1Km: ' +
                                                  tmplist[index]
                                                      .price_per_1km
                                                      .toString())))
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
                                              rating:
                                                  2, //buyerlist[index].starcount,
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
                                      Container(
                                          child: FlatButton(
                                        child: Text('Confirm'),
                                        onPressed: () {
                                          // confirmbuyer(buyerlist[index].id.toString());
                                          print(tmplist[index].transporter.id);
                                          print(tmplist[index]
                                              .purchaseItem
                                              .purchase_item_id);
                                          confirmtransporter(
                                              tmplist[index]
                                                  .transporter
                                                  .id
                                                  .toString(),
                                              tmplist[index]
                                                  .transport_request_id.toString());
                                        },
                                      ))
                                    ],
                                  )
                                  //Text('data'),
                                  //Text('data'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
