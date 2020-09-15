import 'package:flutter/material.dart';
import 'package:login2/Method/buyermethod.dart';
import 'package:login2/UI/Buyer/viewsentreqtilebuyer.dart';
import 'package:login2/UI/Commenclass/Products.dart';
import 'package:login2/UI/Farmer/Farmer.dart';
import 'package:login2/UI/Farmer/FarmerProfile.dart';
//import 'package:login2/UI/Farmer/notification.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class Productlisttilesent extends StatelessWidget {
  BuildContext context;
  product tile;

  Productlisttilesent({this.context, this.tile});

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
                    tag: 'img' + tile.purchase_item_id.toString(),
                    child: Image.asset(
                      lst[varietypic(tile.variety)],
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
                        tile.type.toString() + '  (' + tile.variety + ')',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w900),
                      ),
                      //Title Container
                      alignment: Alignment.topLeft,
                    ),
                    Container(
                      //Adddress Conatiner
                      padding: EdgeInsets.fromLTRB(10, 2, 5, 5),
                      child: Text(
                        tile.district.toString() + ',' + tile.city.toString(),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w300),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Expanded(
                              // Wrap(
                              // children: <Widget>[
                              Text(
                                tile.farmer.fullname.toString(),
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w500),
                              ),
                              // ],
                              // ),
                              Expanded(
                                child: Container(
                                  padding:
                                      EdgeInsets.only(top: 0.0, bottom: 0.0),
                                  alignment: Alignment.topCenter,
                                  child: RatingBarIndicator(
                                    rating: 2.4,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.red,
                                    ),
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    itemSize: 16.0,
                                    direction: Axis.horizontal,
                                  ),
                                ),
                              ),
                              Text(
                                tile.exp_date.toString(),
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                //alignment: Alignment.centerLeft,
                                //color: Colors.black,
                                child: Row(
                                  children: <Widget>[
                                    Text(tile.unit_price.toString() + ' Rs',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.green)),
                                    Text('/kg',
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.grey)),
                                  ],
                                ),
                              ),
                              
                              Text('Total:-'+tile.quantity.toString()+tile.quantity_unit,
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
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Viewsentlisttilebuyer(
                  tile: tile,
                ),
              ));
        },
      ),
    );
  }
}

class starcount {
  String name;
  double val;
  starcount(this.name, this.val);
}
