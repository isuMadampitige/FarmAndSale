import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login2/Method/buyermethod.dart';
import 'package:login2/UI/Commenclass/Products.dart';
import 'package:login2/UI/Farmer/location.dart';
//import 'package:login2/UI/Commenclass/Products.dart' as prefix0;
//import 'package:google_maps_flutter/google_maps_flutter.dart';


class ItemDiscrip extends StatefulWidget{

  int fid;
  product prd ;
  

  ItemDiscrip({this.fid,this.prd});

   @override
  AddItemstate createState() {
    return AddItemstate(prd: prd);
  }
}

class AddItemstate extends State<ItemDiscrip>{

  AddItemstate({this.prd});

  product prd;
  //product prodct = new prefix0.product();
  bool isloading = false;
  final _formadditem = GlobalKey<FormState>();
  String Hdate;
  String Edate;
  RegExp cityvalidate = new RegExp(r"([a-zA-Z])");
  RegExp unitprice = new RegExp(r"([0-9])");
  var districts = [
    'kurunegala',
    'Kandy',
    'gampaha',
    'Anuradhapuraya',
    'polonnruwa'
  ];
   Future _purItem1() async {
    Map arr = {
      'category': prd.category,
      'type': prd.type,
      'quantity_unit':prd.quantity_unit,
      'quantity': prd.quantity,
      'harvest_date':Hdate,
      'exp_date': Edate,
      'unit_price': prd.unit_price,
      'variety': prd.variety,
      'district':prd.district,
      'city':prd.city,
      'item_id':prd.purchase_item_id
    };
    var js = jsonEncode(arr);
    print(js);
    var url = 'http://34.87.38.40/purchaseItem/farmer/' + widget.fid.toString();
    print(url);
     await http
        .post(Uri.encodeFull(url),
            headers: {"Content-Type": "application/json"}, body: js)
        .then((response) {
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var content = jsonDecode(response.body);
        print(content['purchase_item_id']);
         
         Navigator.push(
                        context,
                          MaterialPageRoute(
                            builder: (context) => Location(itm_id: content['purchase_item_id'],)
                          ));
       // _formadditem.currentState.reset();
      } else if (response.statusCode >= 500) {
        ServerErrorPopup(context);
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        NetworkErrorPopup(context);
      } 
    });
  }

  TextEditingController variety1 = TextEditingController(text:'null');
  TextEditingController units = TextEditingController(text:'null');
  TextEditingController hYear = TextEditingController(text:'null');
  TextEditingController hMonth = TextEditingController(text:'null');
  TextEditingController hDay = TextEditingController(text:'null');
  TextEditingController eYear = TextEditingController(text:'null');
  TextEditingController eMonth = TextEditingController(text:'null');
  TextEditingController eDay = TextEditingController(text:'null');
  TextEditingController district = TextEditingController(text:'null');

  Map arr = Map();
  var variety = ['Raja', 'Lyra', 'Graenola', 'Sante','Desiree','Hillstar','Kondor','Isna'];
  var unit = ['Kg', 'Number of Items', 'bunches'];
  var hyear = ['2019', '2020', '2021','2022'];
  var hmonth = ['01', '02', '03','04', '05','06','07','08','09','10','11','12'];
  //var hmont = ['January', 'Febraury', 'March','April', 'May','June',"July",'Augest','September','Octomber','November','December'];
  var hday = ['01', '02', '03','04', '05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31'];

  var eyear = ['2019', '2020', '2021','2022'];
  var emonth = ['01', '02', '03','04', '05','06','07','08','09','10','11','12'];
  //var emont = ['January', 'Febraury', 'March','April', 'May','June',"July",'Augest','September','Octomber','November','December'];
  var eday = ['01', '02', '03','04', '05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31'];

  @override
  void initState(){
    super.initState();

    print(widget.fid);
    print(widget.prd.type);
  }

       
    


  

  @override
  Widget build(BuildContext context) {
    var text;
    return Scaffold(
      backgroundColor: Colors.green[30],
      
      body: ListView(
        children: <Widget>[
          Center(
            child: Container(
               width: 320,
              //height: 680,
              child: Form(
                key: _formadditem,
                child: Column(
                  children: <Widget>[
                    //row1//
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text('Item Discription',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                      //row2//
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text('Varity',
                                style: TextStyle(
                                  fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              child: DropdownButton<String>(
                                items: variety.map((String dis) {
                                  return DropdownMenuItem<String>(
                                    value: dis,
                                    child: Text(
                                     dis,
                                     style: TextStyle(fontSize: 12),
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                              setState(() {
                                prd.variety=val;
                                print(prd.variety);
                                variety1.text=val;
                              });
                              
                              },
                              hint: Row(
                                children: <Widget>[
                                  Text(variety1.text),
                                ],
                              ),
                            )
                            ),
                          ),

                        ],
                      ),
                      //row3//
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text('Quantity',
                                style: TextStyle(
                                  fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                           Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text('Unit',
                                style: TextStyle(
                                  fontSize: 17,
                                  ),
                                ),
                              ),
                        ],
                      ),
                      //row4//
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                         Column(
                           children: <Widget>[
                             Padding(
                               padding: const EdgeInsets.only(top:10.0),
                               child: Container(
                                 width: 80,
                                 height: 45,
                                 child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                      borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                      ),
                                    hintText: 'quantity',
                                    fillColor: Colors.grey[100],
                                    filled: true,
                                    
                                   ),
                                  style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                  
                                
                                ),
                                onSaved: (val){
                                    prd.quantity=double.parse(val) ;

                                },
                              ),
                               ),
                             ),
                           ],
                         ),
                         Container(
                           child: DropdownButton<String>(
                              items: unit.map((String dis) {
                                return DropdownMenuItem<String>(
                                  value: dis,
                                  child: Text(
                                   dis,
                                   style: TextStyle(fontSize: 15),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                            setState(() {
                              prd.quantity_unit=val;
                              units.text=val;
                            });
                            
                            },
                            hint: Row(
                              children: <Widget>[
                                Text(units.text),
                              ],
                            ),
                          )
                         ),
                       ],
                     ),
                     //row5//
                     Row(
                       children: <Widget>[
                         Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text('Harvest Date',
                                    style: TextStyle(
                                      fontSize: 17,
                                      ),
                                    ),
                                  ),
                       ],
                     ),
                     //row6////
                     Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text('Year',
                                style: TextStyle(
                                  fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                           Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text('Month',
                                style: TextStyle(
                                  fontSize: 17,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text('Day',
                                style: TextStyle(
                                  fontSize: 17,
                                  ),
                                ),
                              ),
                        ],
                      ),
                      //row7////
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                child: DropdownButton<String>(
                                  items: hyear.map((String dis) {
                                    return DropdownMenuItem<String>(
                                      value: dis,
                                      child: Text(
                                        dis,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      prd.hyear=val;
                                      hYear.text=val;
                                      print(prd.hyear);

                                  });
                            
                                  },
                                  hint: Row(
                                    children: <Widget>[
                                      Text(hYear.text),
                                  ],
                                ),
                                )
                              ),
                            ],
                          ),
                           Container(
                                child: DropdownButton<String>(
                                  items: hmonth.map((String dis) {
                                    return DropdownMenuItem<String>(
                                      value: dis,
                                      child: Text(
                                        dis,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      prd.hmonth=val;
                                      hMonth.text=val;
                                      print(prd.hmonth);

                                  });
                            
                                  },
                                  hint: Row(
                                    children: <Widget>[
                                      Text(hMonth.text),
                                  ],
                                ),
                                )
                              ),
                           Container(
                                child: DropdownButton<String>(
                                  items: hday.map((String dis) {
                                    return DropdownMenuItem<String>(
                                      value: dis,
                                      child: Text(
                                        dis,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      prd.hday=val;
                                      hDay.text=val;
                                      print(prd.hday);
                                  });
                            
                                  },
                                  hint: Row(
                                    children: <Widget>[
                                      Text(hDay.text),
                                  ],
                                ),
                                )
                              ),
                        ],
                      ),
                      //row8/////
                      Row(
                       children: <Widget>[
                         Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text('Expire Date',
                                    style: TextStyle(
                                      fontSize: 17,
                                      ),
                                    ),
                                  ),
                       ],
                     ),
                     //row9//
                     Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text('Year',
                                style: TextStyle(
                                  fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                           Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text('Month',
                                style: TextStyle(
                                  fontSize: 17,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text('Month',
                                style: TextStyle(
                                  fontSize: 17,
                                  ),
                                ),
                              ),
                        ],
                      ),
                      //row10////
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                child: DropdownButton<String>(
                                  items: eyear.map((String dis) {
                                    return DropdownMenuItem<String>(
                                      value: dis,
                                      child: Text(
                                        dis,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      prd.eyear=val;
                                      eYear.text=val;
                                      print(prd.eyear);
                                  });
                            
                                  },
                                  hint: Row(
                                    children: <Widget>[
                                      Text(eYear.text),
                                  ],
                                ),
                                )
                              ),
                            ],
                          ),
                           Container(
                                child: DropdownButton<String>(
                                  items: emonth.map((String dis) {
                                    return DropdownMenuItem<String>(
                                      value: dis,
                                      child: Text(
                                        dis,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      prd.emonth=val;
                                      eMonth.text=val;
                                      print(prd.emonth);
                                  });
                            
                                  },
                                  hint: Row(
                                    children: <Widget>[
                                      Text(eMonth.text),
                                  ],
                                ),
                                )
                              ),
                            Container(
                                child: DropdownButton<String>(
                                  items: eday.map((String dis) {
                                    return DropdownMenuItem<String>(
                                      value: dis,
                                      child: Text(
                                        dis,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      prd.eday=val;
                                      eDay.text=val;
                                      print(prd.eday);
                                  });
                            
                                  },
                                  hint: Row(
                                    children: <Widget>[
                                      Text(eDay.text),
                                  ],
                                ),
                                )
                              ),
                        ],
                      ),
                      //row11///
                      Row(
                       children: <Widget>[
                         Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text('Unit Price',
                                    style: TextStyle(
                                      fontSize: 17,
                                      ),
                                    ),
                                  ),
                       ],
                     ),
                     //row12//
                     Row(
                       children: <Widget>[
                         Padding(
                           padding: const EdgeInsets.only(top:10.0),
                           child: Container(
                             height: 45,
                             width: 320,
                             child: TextFormField(
                                validator: (value) {
                            if (value.isEmpty)
                              return 'This can not be empty';
                             else if (!unitprice.hasMatch(value))
                              return "cannot Enter Characters";
                            else
                              return null;
                          },
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                              borderRadius:
                                                BorderRadius.all(Radius.circular(4)),
                                              ),
                                            hintText: 'Unit Price',
                                            fillColor: Colors.grey[100],
                                            filled: true,
                                            
                                           ),
                                          style: TextStyle(
                                          fontSize: 17.0,
                                          color: Colors.black,
                                        ),
                                        onSaved: (val){
                                          var value = double.parse(val);
                                          prd.unit_price=value;

                                        },
                                      ),
                           ),
                         ),
                       ],
                     ),
                      //row13///
                      Row(
                       children: <Widget>[
                         Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text('District',
                                    style: TextStyle(
                                      fontSize: 17,
                                      ),
                                    ),
                                  ),
                       ],
                     ),
                     //row14//
                     Row(
                       children: <Widget>[
                         Padding(
                           padding: const EdgeInsets.only(top:10.0),
                           child: Container(
                             height: 45,
                             width: 320,
                             child: DropdownButton<String>(
                                  items: districts.map((String dis) {
                                    return DropdownMenuItem<String>(
                                      value: dis,
                                      child: Text(
                                        dis,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      prd.district=val;
                                      district.text=val;
                                  });
                            
                                  },
                                  hint: Row(
                                    children: <Widget>[
                                      Text(district.text),
                                  ],
                                ),
                                )
                            //  TextFormField(
                            //                 decoration: InputDecoration(
                            //                   border: OutlineInputBorder(
                            //                   borderRadius:
                            //                     BorderRadius.all(Radius.circular(4)),
                            //                   ),
                            //                 hintText: 'District',
                            //                 fillColor: Colors.grey[100],
                            //                 filled: true,
                                            
                            //                ),
                            //               style: TextStyle(
                            //               fontSize: 17.0,
                            //               color: Colors.black,
                            //             ),
                            //             onSaved: (val){
                            //               prd.district=val;

                            //             },
                            //           ),
                           ),
                         ),
                       ],
                     ),
                      //row15///
                      Row(
                       children: <Widget>[
                         Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text('City',
                                    style: TextStyle(
                                      fontSize: 17,
                                      ),
                                    ),
                                  ),
                       ],
                     ),
                     //row16//
                     Row(
                       children: <Widget>[
                         Padding(
                           padding: const EdgeInsets.only(top:10.0),
                           child: Container(
                             height: 45,
                             width: 320,
                             child: TextFormField(
                               validator: (value) {
                            if (value.isEmpty)
                              return 'This can not be empty';
                             else if (!cityvalidate.hasMatch(value))
                              return "cannot Enter numbers";
                            else
                              return null;
                          },
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                              borderRadius:
                                                BorderRadius.all(Radius.circular(4)),
                                              ),
                                            hintText: 'city',
                                            fillColor: Colors.grey[100],
                                            filled: true,
                                            
                                           ),
                                          style: TextStyle(
                                          fontSize: 17.0,
                                          color: Colors.black,
                                        ),
                                        onSaved: (val){
                                          prd.city=val;

                                        },
                                      ),
                           ),
                         ),
                       ],
                     ),
                     //row17//
                    //  Row(
                    //    mainAxisAlignment: MainAxisAlignment.center,
                    //    children: <Widget>[
                    //      Padding(
                    //        padding: const EdgeInsets.only(top:20.0),
                    //        child: Container(
                    //           width: 150,
                    //           height: 45,
                    //           child: RaisedButton(
                    //             onPressed: () {
                    //               Navigator.push(
                    //                 context,
                    //                  MaterialPageRoute(
                    //                     builder: (context) => Location(),
                    //                   )
                    //               );
                    //             },
                    //             color: Colors.blue,
                    //             textColor: Colors.white,
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius:
                    //                     BorderRadius.all(Radius.circular(30.0))),
                    //             child: Text(
                    //               'Lovation',
                    //               style: TextStyle(fontSize: 20.0),
                    //             ),
                    //           ),
                    //         ),
                    //      ),
                    //    ],
                    //  ),
                     //row18//
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Padding(
                           padding: const EdgeInsets.only(top:20.0),
                           child: Container(
                              width: 150,
                              height: 45,
                              child: RaisedButton(
                                onPressed: () {
                                  //_purItem();
                                  

                                  if (_formadditem.currentState.validate()) {
                                    _formadditem.currentState.save();
                                    setState(() {
                                      Hdate=prd.hyear.toString() +'-'+ prd.hmonth.toString() +'-'+ prd.hday.toString();
                                      print(Hdate);
                                      Edate=prd.eyear.toString()+'-'+ prd.emonth.toString() +'-'+ prd.eday.toString();
                                    });
                                    
                                    _purItem1();
                                  }
                                },
                                color: Colors.deepOrange,
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0))),
                                child: Text(
                                  'Submit',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ),
                         ),
                       ],
                     ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
// class PurchaseItem {
//   int quantity;
//   String category;
//   String type;
//   String variety;
//   String unit;
//   String harvest_date;
//   String exp_date;
//   int unit_price;

//   PurchaseItem({
//     this.category,
//     this.quantity,
//     this.exp_date,
//     this.harvest_date,
//     this.type,
//     this.unit_price,
//     this.variety
//   });

   get Product => null;
// }

