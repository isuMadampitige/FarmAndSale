import 'package:flutter/material.dart';
import 'package:login2/UI/Commenclass/notification.dart';
import 'package:login2/UI/Commenclass/viewnotification.dart';

class Notificationcard extends StatelessWidget {
  Notifications data;
  String role;
  Notificationcard({this.data,this.role});

  static const primcolor = Colors.green;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        print('object');
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Notificationcardview(data: data,role: role,)));
      // return Notificationcardview(data: data,);
      },
          child: Card(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //Text('Shipping Items',style: TextStyle(fontWeight: FontWeight.bold),),
                  Icon(Icons.notifications),
                  Container(
                    child: Text('Delivery on : '+data.purchaseItem.date),
                    color: Colors.transparent,
                  )
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left:8.0,right: 8.0),
            //   child: Wrap(children: <Widget>[Text('Rate Your Customres According to their Service and ')],),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  // CircleAvatar(
                  //   child: Text(data.purchaseItem.type[0]),
                  // ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text(data.purchaseItem.type),
                        Text('(' + data.purchaseItem.variety + ')'),
                      ],
                    ),
                  )),
                  Text('More Details'),
                  Text('>>',style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top:5.0,bottom: 8.0,left: 4.0),
            //   child: Wrap(
            //     alignment: WrapAlignment.start,
            //     direction: Axis.horizontal,
            //     runAlignment: WrapAlignment.start,
            //     children: <Widget>[
                  
            //       // Icon(
            //       //   Icons.note_add,
            //       //   size: 15,
            //       //   color: Colors.green,
            //       // ),
            //       // Text('Farmer:'),
            //       // Text(data.purchaseItem.farmer.fullname),
            //       Text(data.purchaseItem.quantity.toString(),style: TextStyle(fontWeight: FontWeight.w700),),
            //       Text(data.purchaseItem.quantity_unit.toString(),style: TextStyle(fontWeight: FontWeight.w700)),
            //       Text(' of '),
            //       Text(data.purchaseItem.type.toString(),style: TextStyle(fontWeight: FontWeight.w700)),
            //       Text('('),
            //       Text(data.purchaseItem.variety.toString(),style: TextStyle(fontWeight: FontWeight.w700)),
            //       Text(')'),
            //       Text(' need be deliverd from '),
            //       Text(data.purchaseItem.farmer.fullname.toString(),style: TextStyle(fontWeight: FontWeight.w700)),
            //       Text(' To '),
            //       Text(data.purchaseItem.confirmedbuyer.fullname.toString(),style: TextStyle(fontWeight: FontWeight.w700)),
            //       Text(' on '),
            //       Text(data.purchaseItem.date.toString(),style: TextStyle(fontWeight: FontWeight.w700)),
            //       Text(' by...')
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
