import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:login2/Method/getnotification.dart';
import 'package:login2/UI/Commenclass/filter.dart';
import 'package:login2/UI/Commenclass/listtile.dart';
import 'package:login2/UI/Commenclass/notification.dart';
import 'package:login2/UI/Farmer/FarmerProfile.dart';
import 'package:login2/UI/Farmer/additem/selectType.dart';
import 'package:login2/UI/Farmer/additem/selectcategory.dart';
import 'package:login2/UI/Farmer/confirmedorderfarmer.dart';
import 'package:login2/UI/Farmer/farmernotification.dart';
import 'package:login2/UI/Farmer/myitemlist.dart';
//import 'package:login2/UI/Farmer/notification.dart';
import 'package:login2/UI/stat/statics.dart';
//import 'package:login2/UI/statics/mainchart.dart';
import 'package:login2/detaileduser.dart';
import 'package:login2/main.dart';
import 'package:http/http.dart' as http;
import 'package:login2/userclass.dart' as user;
import 'HorizentalList.dart';
import 'package:login2/userclass.dart';
import 'package:login2/UI/Commenclass/notificationstruct.dart';
import 'package:login2/UI/Commenclass/Products.dart';
import 'package:login2/Method/buyermethod.dart';
import 'package:login2/UI/Farmer/AddedItemList.dart';
import 'package:login2/UI/Commenclass/AboutAs.dart';

class FarmerInfo extends StatefulWidget {
  user.Usr logeduser;
  Detaileduser userdetails;
  String url = 'http://34.87.38.40/purchaseItem/viewAll';

  FarmerInfo({this.logeduser, this.url, this.userdetails});

  @override
  createState() {
    return FarmerInfostate();
  }
}

class FarmerInfostate extends State<FarmerInfo> {

  int notificationnumber =0;
 
  @override
  void initState()  {
    assignnotification();
    super.initState();
    
    // print(widget.userdetails.user.farmer_id.toString());
  }
  List<Notifications> notifications;
  assignnotification()async{
    notifications=  await getnotification('farmer');
    setState(() {
      
      notificationnumber = notifications.length;
    });
    
    
  }

  var page = 'myitemlist';
  var title='My Added List';

  Widget _Drawernavigaor() {
    if (page == 'myitemlist') {
      //return ViewallItem();
      return Myitem(
        id: widget.logeduser.id,
      );
    } else if (page == 'viewall') {
      return ViewallItem();
    } else if (page == 'myconfirmitem')
      return Myconfirmitem(
        id: widget.logeduser.id,
      );
    else if(page == 'notifications')
      return Notificate();
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   _context = context;
    // });

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      appBar: new AppBar(
        backgroundColor: Colors.green.withOpacity(0.95),
        title: Text(title),
        actions: <Widget>[
          new IconButton(
            icon: Stack(
              children: <Widget>[
                Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                Container(child: Text(notificationnumber.toString()),color: Colors.red,),
              ],
            ),
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => Notificate()));
              //getnotification('farmer');
              //assignnotification();
              setState(() {
                  page = 'notifications';
                  title='Notifications';
                });
            },
          ),
          new IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              assignnotification();
              setState(() {
                 page = 'myitemlist';
                  title='My Added List';
              });
            },
          ),
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            //header//
            new UserAccountsDrawerHeader(
              accountName: Text(widget.logeduser.fullname),
              accountEmail: Text(widget.logeduser.mobilenumber),
              currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Image.asset(
                    'images/farmer.png',
                    fit: BoxFit.fitHeight,
                    height: 60,
                  ) //Icon(
                  //   Icons.person,
                  //   color: Colors.white,
                  // ),
                  ),
              decoration: new BoxDecoration(color: Colors.green.withOpacity(0.95)),
            ),
            //body//
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FarmerProfile(
                              farmer_id: widget.logeduser.id.toString(),
                            )));
              },
              child: ListTile(
                title: Text('My profile'),
                leading: Icon(
                  Icons.person,
                  color: Colors.lightGreen,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  page = 'notifications';
                  title='Notifications';
                });
              },
              child: ListTile(
                title: Text('Notifications'),
                leading: Icon(
                  Icons.notifications,
                  color: Colors.lightGreen,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  page = 'myitemlist';
                  title='My Added List';
                });
              },
              child: ListTile(
                title: Text('My Added List'),
                leading: Icon(
                  Icons.playlist_add_check,
                  color: Colors.lightGreen,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  page = 'viewall';
                  title='Explore';
                });
              },
              child: ListTile(
                title: Text('Explore'),
                leading: Icon(
                  Icons.search,
                  color: Colors.lightGreen,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                //initState();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Staticcharts()));
              },
              child: ListTile(
                title: Text('Statistics'),
                leading: Icon(
                  Icons.insert_chart,
                  color: Colors.lightGreen,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  page = 'myconfirmitem';
                  title='Confirmed Order';
                });
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>Myconfirmitem()));
              },
              child: ListTile(
                title: Text('Confirmed order'),
                leading: Icon(
                  Icons.shopping_basket,
                  color: Colors.lightGreen,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Aboutas()));
              },
              child: ListTile(
                title: Text('About Us'),
                leading: Icon(
                  Icons.help,
                  color: Colors.lightGreen,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement((context),
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: ListTile(
                title: Text('Logout'),
                leading: Icon(
                  Icons.lock_open,
                  color: Colors.lightGreen,
                ),
              ),
            ),
          ],
        ),
      ),
      body: _Drawernavigaor(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green.withOpacity(0.75),
        onPressed: widget.logeduser.confirmed? () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SelectCategory(id: widget.logeduser.id)));
        }:null,
      ),
    );
  }
}
 
Future stop() async {
  await Future.delayed(Duration(seconds: 2));
}

class ViewallItem extends StatefulWidget {
  user.Usr logeduser;
  Detaileduser userdetails;
  String url = 'http://34.87.38.40/purchaseItem/viewAll';

  // ViewallItem ref1 = ViewallItem();

  //  ViewallItem(){

  // }

  @override
  _ViewallItemState createState() => _ViewallItemState();
}

class _ViewallItemState extends State<ViewallItem> {
  Future<ListTile> llist;
  BuildContext _context;

  List<product> tmplist;
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
          List prdct = json.decode(content);
          if (content == '[]') {
            NoItempopup(this.context,'No Product Items');
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

    try {
      await http
          .post('http://34.87.38.40/purchaseItem/filter',
              headers: {"Content-Type": "application/json"}, body: filterarr)
          .then((response) {
        //print(response.body);

        print(response.statusCode);
        print(response.body);
        if (response.statusCode == 200) {
          String content = response.body;
          List prdct = json.decode(content);
          if (content == '[]') {
            NoItempopup(this.context,'No Filter items');
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
    } catch (e) {
      print(e);
      NetworkErrorPopup(context);
    }
  }

  TextEditingController district = TextEditingController(text: 'all');
  TextEditingController city = TextEditingController(text: 'all');
  TextEditingController type = TextEditingController(text: 'all');
  TextEditingController variety = TextEditingController(text: 'all');

  @override
  void initState() {
    loadproduct();
    // filterproduct();
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
      body: Column(children: <Widget>[
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
                                      style: TextStyle(fontSize: 10,color: Colors.black),
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
                            child:DropdownButton<String>(
                              style: TextStyle(fontSize: 10),
                                items: types.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(fontSize: 10,color: Colors.black),
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
                            child:DropdownButton<String>(
                              style: TextStyle(fontSize: 10),
                                items: varieties.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(fontSize: 10,color: Colors.black),
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
                            district.text = 'all';
                            city.text = 'all';
                            type.text = 'all';
                            variety.text = 'all';
                          });

                          //   });
                          //   print(arr);
                          //await Filterdialog(context, arr);
                          // print(arr);
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>Drawer(child: Text('data'),)));
                        },
                        color: Colors.blue.withOpacity(0.75),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                      )
                    ],
                  )),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          )),
        Expanded(
          child: isloading
              ? Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                  ),
                )
              : RefreshIndicator(
                  key: refreshkey,
                  child: ListView.builder(
                      itemCount: tmplist.length,
                      itemBuilder: (context, index) {
                        return Productlisttile(
                          context: context,
                          tile: tmplist[index],
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
    );
  }
}
