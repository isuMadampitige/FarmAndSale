import 'dart:convert';
import 'package:login2/UI/Commenclass/vehicledetails.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login2/UI/Buyer/byuerhome.dart';
import 'package:login2/UI/Commenclass/filter.dart';
import 'package:login2/UI/Transpoter/transportreqtransporter.dart';

Future<void> ServerErrorPopup(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        //titlePadding: EdgeInsets.fromLTRB(80, 5, 80, 2),
        //contentPadding: EdgeInsets.fromLTRB(40, 2, 40, 5),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: Container(
          child: Text(
            'Internal Server Error',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        content: Container(
          child: const Text(
            'Unfortunately Server Is not responding!.please Try again.',
            style: TextStyle(fontSize: 12.0),
          ),
        ),
      );
    },
  );
}

Future<void> NetworkErrorPopup(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        //titlePadding: EdgeInsets.fromLTRB(80, 5, 80, 2),
        //contentPadding: EdgeInsets.fromLTRB(40, 2, 40, 5),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: Container(
          child: Text(
            'Network Error',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        content: Container(
          child: const Text(
            'Some thing Wrong! with your network Connection, Please Check before retry.',
            style: TextStyle(fontSize: 12.0),
          ),
        ),
      );
    },
  );
}

Future<void> SentRequestPopup(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Request sent'),
        content: const Text(
            'Your request has been successfully send to the Farmer,You Will receive Confirmation from Farmer'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> NoItempopup(BuildContext context,String content) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: EdgeInsets.fromLTRB(24, 12, 24, 5),
        contentPadding: EdgeInsets.fromLTRB(24, 5, 24, 12),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: Container(
          child: Text(
            'No Item',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        content: Container(
          child:  Text(
            content,
            style: TextStyle(fontSize: 12.0),
          ),
        ),
      );
    },
  );
}

Future<bool> deletepopup(BuildContext context){
  return showDialog(
    context: context,
    builder: (BuildContext context){ return AlertDialog(
      title: Text('Delete'),
        content: const Text(
            'Are You sure you want to delete The Item'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              //http.delete('url');
              Navigator.of(context).pop();
              return true;
              
            },
          ),
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              
              Navigator.of(context).pop();
              return false;
            },
          ),

        ],
    );}
  );
}

Future<void> ItemAddedpopup(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: EdgeInsets.fromLTRB(24, 12, 24, 5),
        contentPadding: EdgeInsets.fromLTRB(24, 5, 24, 12),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: Container(
          child: Text(
            'Success',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        content: Container(
          child: const Text(
            'Your Item Has Successfully added.',
            style: TextStyle(fontSize: 12.0),
          ),
        ),
      );
    },
  );
}

Future Filterdialog(BuildContext context, String id, String tid) {
  TextEditingController priceper1km = TextEditingController();
  //priceper1km.text=tid;
  String url = 'http://34.87.38.40/transportRequest/'+tid+'/requestAdverts/'+id;
  String url2='http://34.87.38.40/Ttr';
  print(url);
  sendreq()  {
    Map arr = {
      'transporter_id':id,
      'transport_request_id':tid,
      'price_per_1km': priceper1km.text,
      
    };
    print(arr);
    var content = jsonEncode(arr);
    print(content);
    try {
      http
          .post(Uri.encodeFull(url2),
              headers: {"Content-Type": "application/json"}, body: content)
          .then((response) async {
        print(response.body);
        print(response.statusCode);
        if (response.statusCode == 200) {
          Navigator.pop(context);
          await Popupmessage(context, 'Your Requset has been sent', 'Success', false);
          await SentRequestPopup(context);
         // Navigator.push(context, MaterialPageRoute(builder: (content)=>Buyerhome()));
          Navigator.pop(context);
          //refkey.currentState.reassemble();
          Transportreqtranporter().createState();
          
        } else if (response.statusCode >= 400 && response.statusCode < 500) {
         // Navigator.pop(context);
          NetworkErrorPopup(context);
        } else if (response.statusCode >= 500) {
         // Navigator.pop(context);
          ServerErrorPopup(context);
        }
      });
    } catch (e) {
      print(e);
      //Navigator.pop(context);
      NetworkErrorPopup(context);
    }
  }
  List<dynamic> details1;
  loadMyapprovevehicle() {
    var url = 'http://34.87.38.40/vehicle/'+id.toString()+'/approved';
    try{
    http.get(url).then((response) {
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var content = jsonDecode(response.body);
        print(content);
        
          details1 = content.map((json) => Vehicle.fromjson(json)).toList();
        
       // isloading1 = false;
        print(details1[0].vehicle_id);
        print(details1[0].transporter.fullname);
      } else if (response.statusCode == 500) {
        ServerErrorPopup(context);
      } else {
        NetworkErrorPopup(context);
      }
    });}
    catch(e){
      Popupmessage(context, e.toString(), 'Error', true);
    }
  }
  loadMyapprovevehicle();
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add Your Price'),
        content: Container(
          height: 300,
          width: 300,
          child: PageView(
            children: <Widget>[
              Container(
                height: 200,
                width: 250,
                child: ListView(
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: 150,
                            height: 50,
                            child: TextFormField(
                              controller: priceper1km,
                              decoration: InputDecoration(
                                  hintText: 'Type Price per',
                                  hintStyle: TextStyle(fontSize: 12)),
                            ),
                          ),
                          Text('/1 Km:'),
                        ]),
                        
                  ],
                ),
              ),
              ListView.builder(itemCount: details1.length,itemBuilder: (context,index){return
              Container(child: Text('data'),);},),
               Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: 150,
                            height: 50,
                            child: TextFormField(
                              controller: priceper1km,
                              decoration: InputDecoration(
                                  hintText: 'Type Price per',
                                  hintStyle: TextStyle(fontSize: 12)),
                            ),
                          ),
                          Text('/1 Km:'),
                        ]),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.send),
            onPressed: () {
              sendreq();
              
            },
          ),
        ],
      );
    },
  );
}

Future<void> Errorshow(BuildContext context,String content) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        //titlePadding: EdgeInsets.fromLTRB(80, 5, 80, 2),
        //contentPadding: EdgeInsets.fromLTRB(40, 2, 40, 5),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: Container(
          child: Text(
            'Oops!',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        content: Container(
          child:  Text(
            content,
            style: TextStyle(fontSize: 12.0),
          ),
        ),
      );
    },
  );
}

Future<void> Popupmessage(BuildContext context,String content,String header,bool isaError) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        //titlePadding: EdgeInsets.fromLTRB(80, 5, 80, 2),
        //contentPadding: EdgeInsets.fromLTRB(40, 2, 40, 5),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: Container(
          child: Row(
            children: <Widget>[
              Text(
                header,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left:10.0),
                child: isaError ? Icon(Icons.error,color: Colors.red):Icon(Icons.done,color: Colors.green),
              )
            ],
          ),
        ),
        content: Container(
          child:  Text(
            content,
            style: TextStyle(fontSize: 12.0),
          ),
        ),
      );
    },
  );
}

int varietypic(String variety){
 switch (variety) {
  case 'Isna':
    {
      return 0;
    }
  break;
  
  case 'Kondor':
    {
      return 1;
    }
  break;
  case 'Lyra':
    {
      return 2;
    }
    break;
    case 'Sante':
    {
      return 3;
    }
    break;
    case 'Raja':
    {
      return 4;
    }
    break;
    case 'Desiree':
    {
      return 5;
    }
    break;
    case 'Graenola':
    {
      return 6;
    }
    break;
    case 'Hillstar':
    {
      return 2;
    }
    break;
  default:
    {
      return 3;
    }
    break;
}

}
//'Raja', 'Lyra', 'Graenola', 'Sante','Kuoni','Desiree','Hillstar','Kondor','Isna'
// 'images/isna.jpg',
//      'images/kondor.jpg',
//      'images/lyra.jpg',
//      'images/sante.jpg',
//      'images/raja.jpg',
//      'images/Desiree.jpg',
//      'images/granola.jpg',
