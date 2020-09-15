import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login2/UI/Commenclass/Products.dart';
import 'package:flutter/material.dart';
import 'package:login2/userclass.dart';
import 'package:login2/UI/Commenclass/notificationstruct.dart';
import 'package:login2/UI/Farmer/Farmer.dart';
import 'package:login2/Method/buyermethod.dart';

class AddedItem extends StatefulWidget {
  int userid;

  AddedItem(this.userid);

  @override
  _AddedItemState createState() => _AddedItemState();
}

class _AddedItemState extends State<AddedItem> {
  BuildContext _context;
  List<product> gridview;
  bool isloading = true;

  Future loadproduct() async {
    var url = 'http://34.87.38.40/purchaseItem/' +
        widget.userid.toString() +
        '/requests';

    await http.get(url).then((response) {
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        if(response.body=='[]'){
            NoItempopup(context,'You Have not added item yet');
            setState(() {
             
            });
        }else{
        String content = response.body;
        List prdct = json.decode(content);
        setState(() {
          gridview = prdct.map((json) => product.fromjson(json)).toList();
          isloading = false;
        });
        print(gridview);
        }
      }
      else if(response.statusCode>=400&&response.statusCode<500){
        print('error');
      }
      else if(response.statusCode>=500){
        ServerErrorPopup(context);
      }
    });
  }

  List<String> lst = [
    'images/avacado.jpg',
    'images/banana.jpg',
    'images/fruit.jpg',
    'images/tomato.jpg',
    'images/carrot.jpg',
  ];

  @override
  void initState() {
    loadproduct();
    //isloading=false;
  }

  @override
  Widget build(BuildContext context) {
    //loadproduct();
    return Scaffold(
      appBar: AppBar(
        title: Text('My Added Items'),
        backgroundColor: Colors.lightGreen,
      ),

      //body:Center(child: Text('Buyer'),),
      body: Container(
        child: isloading
            ? Center(
                child: CircularProgressIndicator(
                strokeWidth: 3.0,
              ))
            : ListView.builder(
                itemCount: gridview.length,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        //Image Container
                        width: 110,
                        height: 110,
                        child: Hero(
                          tag: 'img' +
                              gridview[index].purchase_item_id.toString(),
                          child: Image.asset(
                            lst[gridview[index].purchase_item_id % 5],
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
                              gridview[index].type.toString() +
                                  '  (' +
                                  gridview[index].variety +
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
                                    gridview[index].district.toString() +
                                        ',' +
                                        gridview[index].city.toString(),
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
                                      gridview[index].harvest_date,
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
                                      gridview[index].exp_date,
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
                                              gridview[index].unit_price
                                                      .toString() +
                                                  ' Rs',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.green)),
                                          Text(
                                              ' per 1' +
                                                  gridview[index]
                                                      .quantity_unit,
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.grey)),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text('Total:-',
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.black)),
                                        Text(
                                            gridview[index].quantity
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 13,
                                            )),
                                        Text(
                                            gridview[index].quantity_unit
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
          );
                  //ListTile(
                  //   leading: Icon(Icons.add_a_photo),
                  //   title: Text(gridview[index].type),
                  //   subtitle: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: <Widget>[
                  //       Text(
                  //         gridview[index].quantity.toString() + "Kg",
                  //         style: TextStyle(fontWeight: FontWeight.bold),
                  //       ),
                  //       Text(gridview[index].district)
                  //     ],
                  //   ),
                  //   trailing: Text(gridview[index].date),
                  //   onTap: () {
                  //     // Navigator.push(
                  //     //     context,
                  //     //     MaterialPageRoute(
                  //     //         builder: (context) => viewitem(
                  //     //               cproduct: gridview[index],
                  //     //             )));
                  //   },
                  //   isThreeLine: true,
                  // );
                },
              ),
      ),
    );
  }
}

// class product  {
//   int purchase_item_id;
//   String type;
//   String quantity;
//   String location;
//   String exp_date;
//   String date;
//   BuildContext route;

//   product({
//     this.purchase_item_id,
//     this.type,
//     this.quantity,
//     this.location,
//     this.date,
//     this.exp_date,
//   });

//   factory product.fromjson(Map<String, dynamic> json) {
//     return product(
//       type: json['type'],
//       quantity: json['quantity'],
//       date: json['date'],
//       location: json['location'],
//       exp_date: json['exp_date'],
//     );
//   }
// }
