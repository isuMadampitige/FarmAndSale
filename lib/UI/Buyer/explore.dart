import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login2/Method/buyermethod.dart';
import 'package:login2/UI/Commenclass/Products.dart';
//import 'package:login2/UI/Commenclass/listtile.dart';
import 'package:login2/userclass.dart' as user;
import 'package:http/http.dart' as http;
import 'package:login2/UI/Buyer/listtileb.dart';
import '../../detaileduser.dart';

class Explore extends StatefulWidget {
  user.Usr logeduser;
  //Detaileduser userdetails;
  String url = 'http://34.87.38.40/purchaseItem/viewAll';

  // ViewallItem ref1 = ViewallItem();

  //  ViewallItem(){

  // }
  Explore({this.logeduser});

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  Future<ListTile> llist;
  BuildContext _context;

  List<dynamic> tmplist;
  bool isloading = true; //set this to false to load list

  Future loadproduct() async {
    //http.Response response =

    try {
      await http
          .get(
        'http://34.87.38.40/purchaseItem/viewAll',
      )
          .then((response) {
        //print(response.body);

        print(response.statusCode);
        print(response.body);
        if (response.statusCode == 200) {
          String content = response.body;
          var prdct = json.decode(content);
          if (content == '[]') {
            NoItempopup(this.context,'No Any Item');
          } else {
            setState(() {
              tmplist = prdct.map((json) => product.fromjson(json)).toList();
              isloading = false;
            });
            print(tmplist[0].type);
          }
        } else if (response.statusCode >= 400 && response.statusCode < 500) {
          print('error');
        } else if (response.statusCode >= 500) {
          ServerErrorPopup(this.context);
          setState(() {
            // isloading=false;
          });
        }
      });
    } catch (e) {
      print(e);
      NetworkErrorPopup(context);
    }
  }

  Future filterproduct() async {
    Map arr = {
      "district": district.text,
      "city": city.text,
      "type": type.text,
      "variety": variety.text
    };
    print(arr);

    var filterarr = jsonEncode(arr);

    //try {
    await http
        .post('http://34.87.38.40/purchaseItem/filter',
            headers: {"Content-Type": "application/json"}, body: filterarr)
        .then((response) {
      //print(response.body);

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var content = response.body;
        var prdct = json.decode(content);
        if (content == '[]') {
          NoItempopup(this.context,'No Item Under This Category');
        } else {
          setState(() {
            tmplist = prdct.map((json) => product.fromjson(json)).toList();
            isloading = false;
          });
          print(tmplist[0].type);
        }
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        print('error');
      } else if (response.statusCode >= 500) {
        ServerErrorPopup(this.context);
      }
    });
    // } catch (e) {
    //   print(e);
    //   NetworkErrorPopup(context);
    // }
  }

  TextEditingController district = TextEditingController(text: 'all');
  TextEditingController city = TextEditingController(text: 'all');
  TextEditingController type = TextEditingController(text: 'all');
  TextEditingController variety = TextEditingController(text: 'all');

  @override
  void initState() {
    loadproduct();
    //filterproduct();
    print(widget.logeduser.id.toString());
    //isloading=false;
  }

  Map arr = Map();
  var districts = [
    'all',
    'Jaffna',
    'Kilinochchi',
    'Mannar',
    'Mullaitivu',
    'Vavuniya',
    'Puttalam',
    'Kurunegala',
    'Gampaha',
    'Colombo',
    'Kalutara',
    'Anuradhapura',
    'Polonnaruwa',
    'Matale',
    'Kandy',
    'Nuwara Eliya',
    'Kegalle',
    'Ratnapura'  ,  
    'Trincomalee',
    'Batticaloa',
    'Ampara',
    'Badulla',
    'Monaragala',
    'Hambantota',
    'Matara',
    'Galle',
  ];

  var varieties = [
    'all',
    'Raja',
    'Lyra',
    'Graenola',
    'knapsack',
    'Sante',
    'Kondor',
    'Desiree',
    'Hillstar'
  ];

  var types = [
    'all',
    'potatoes',
  ];

  var refreshkey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: <Widget>[
          Container(
              child: Column(
            children: <Widget>[
              new Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0),
                  child: new Text(
                    'Filter',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              // HorizontalList(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      // flex: 2,
                      child: Column(
                        children: <Widget>[
                          Text('District'),
                          Padding(
                              padding: const EdgeInsets.only(right: 0.0),
                              child: DropdownButton<String>(
                                style: TextStyle(fontSize: 10),
                                //icon: Icon(Icons.arrow_drop_down),
                                //iconSize: 10,
                                items: districts.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    district.text = val;
                                  });
                                },
                                hint: Row(
                                  children: <Widget>[
                                    Text(district.text),
                                  ],
                                ),
                              )
                              // TextFormField(
                              //   decoration: InputDecoration(
                              //       hintText: 'District',
                              //       hintStyle: TextStyle(fontSize: 12)),
                              // ),
                              ),
                        ],
                      ),
                    ),
                    // Expanded(
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(right: 8.0),
                    //     child: TextFormField(
                    //       controller: city,
                    //       //style: TextStyle(fontSize: 8),
                    //       decoration: InputDecoration(
                    //           labelText: 'City',
                    //           hintStyle: TextStyle(fontSize: 12)),
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text('Type'),
                          Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: DropdownButton<String>(
                                style: TextStyle(fontSize: 10),
                                items: types.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    type.text = val;
                                  });
                                },
                                hint: Row(
                                  children: <Widget>[
                                    Text(type.text),
                                  ],
                                ),
                              )
                              //  TextFormField(
                              //   controller: variety,
                              //   decoration: InputDecoration(
                              //       labelText: 'variety',
                              //       //hintText: 'Variety',
                              //       hintStyle: TextStyle(fontSize: 12)),
                              // ),
                              ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text('Variety'),
                          Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: DropdownButton<String>(
                                style: TextStyle(fontSize: 10),
                                items: varieties.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    variety.text = val;
                                  });
                                },
                                hint: Row(
                                  children: <Widget>[
                                    Text(variety.text),
                                  ],
                                ),
                              )
                              //  TextFormField(
                              //   controller: variety,
                              //   decoration: InputDecoration(
                              //       labelText: 'variety',
                              //       //hintText: 'Variety',
                              //       hintStyle: TextStyle(fontSize: 12)),
                              // ),
                              ),
                        ],
                      ),
                    ),
                    // // Expanded(child: FlatButton(child: Text('Filter'),onPressed: (){},),)
                  ],
                ),
              ),
              new Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 25.0, 0, 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text('Recent List',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      FlatButton(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.filter_list,
                              color: Colors.white,
                            ),
                            Text(
                              'Filter',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () async {
                          // await  Filterdialog(context,arr).then((onValue){
                          //   print(onValue);
                          //   setState(() {
                          //     arr = onValue;
                          //   });
                          filterproduct();
                          setState(() {
                            district.text = null;
                            city.text = null;
                            type.text = null;
                            variety.text = null;
                          });

                          //   });
                          //   print(arr);
                          //await Filterdialog(context, arr);
                          // print(arr);
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>Drawer(child: Text('data'),)));
                        },
                        color: Colors.blue.withOpacity(0.75),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      )
                    ],
                  )),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          )),
          Expanded(
            child: RefreshIndicator(
              key: refreshkey,
              child: isloading
                  ? Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3.0,
                      ),
                    )
                  : ListView.builder(
                      //reverse: true,
                      itemCount: tmplist.length,
                      itemBuilder: (context, index) {
                        return Productlisttile(
                          context: context,
                          tile: tmplist[index],
                          id: widget.logeduser.id.toString(),
                        );
                      }),
              onRefresh: () async {
                loadproduct();
                await Future.delayed(Duration(seconds: 2));
              },
            ),
            // isloading
            //     ? Center(
            //         child: CircularProgressIndicator(
            //         strokeWidth: 3.0,
            //       ))
            //     : ListView.builder(
            //         itemCount: tmplist.length,
            //         itemBuilder: (context, index) {
            //           return ListTile(
            //             leading: Container(child:  Text('data'),height: 100,width: 200,color: Colors.amber,),
            //             title: Text(tmplist[index].type),
            //             subtitle: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: <Widget>[
            //                 Text(
            //                   tmplist[index].quantity + "Kg",
            //                   style: TextStyle(fontWeight: FontWeight.bold),
            //                 ),
            //                 Text(tmplist[index].location)
            //               ],
            //             ),
            //             trailing: Text(tmplist[index].date),
            //             onTap: () {
            //               Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                       builder: (context) => viewitem(
            //                             cproduct: tmplist[index],canrequest: false,
            //                           )));
            //             },
            //             isThreeLine: true,
            //           );
            //         },
            //       ),
          ),
        ]),
      ),
    );
  }
}
