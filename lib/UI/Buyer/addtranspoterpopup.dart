import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login2/Method/buyermethod.dart';
import 'package:login2/UI/Commenclass/transportreq.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Addtransportpopup extends StatefulWidget {
  String purchaseid;

  Addtransportpopup({this.purchaseid});

  @override
  _AddtransportpopupState createState() => _AddtransportpopupState();
}

class _AddtransportpopupState extends State<Addtransportpopup> {
  TextEditingController start = TextEditingController();
  TextEditingController end = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController sahrerable = TextEditingController();

  int _rval = -1;

  SharedPreferences spref;

  List<Transportdetails> tmplist;

  getsahre() async {
    spref = await SharedPreferences.getInstance();
  }

  senttrnsportreqest() async {
    Map arr = {
      'start': start.text,
      'end': end.text,
      'date': date.text,
      'sharable': sahrerable.text
    };

    var js = jsonEncode(arr);

    var url = 'http://34.87.38.40/transportRequest/' +
        spref.getInt('buyer_id').toString() +
        '/purchaseItem/' +
        widget.purchaseid;

        print(url);
        print(js);
    try{
    await http
        .post(url,
            headers: {"Content-Type": "application/json"},
            body: js)
        .then((response) async {
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        //_ackAlert(context);
        print('object');
        
        await ItemAddedpopup(context);
        Navigator.pop(context);
      }
      else if(response.statusCode>=400&&response.statusCode<500)
      {
        NetworkErrorPopup(context);
      }
      else if(response.statusCode>=500)
      {
        ServerErrorPopup(context);
      }
    });
    }
    catch(e){
      print(e);
      NetworkErrorPopup(context);
    }
  }

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsahre();
  }
final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
        return Scaffold(
            //color: Colors.transparent,
            body: Container(
              //margin: EdgeInsets.only(top: 20),
          //color: Colors.redAccent.withAlpha(10),
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.fromLTRB(30, 30, 30, 30),
            alignment: Alignment.topLeft,
            //height: 500,
            //color: Colors.redAccent.withOpacity(0.2),
            child: Form(
              key: _formKey,
                  child: ListView(
           // mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppBar(
                title: Text('Add Transport Notice'),
                backgroundColor: Colors.redAccent,
              ),
              
              Container(
                color: Colors.redAccent.withOpacity(0.2),
                width: 300,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Start:'),
                      Container(
                        alignment: Alignment.topLeft,
                        width: 150,
                        height: 50,
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty)
                              return 'This can not be empty';
                            // else if (value.length < 8)
                            //  return "Enter more than 8 character";
                            else
                              return null;
                          },
                          controller: start,
                          decoration: InputDecoration(
                              hintText: 'Type from where',
                              hintStyle: TextStyle(fontSize: 12)),
                        ),
                      )
                    ]),
              ),
              Container(
                color: Colors.redAccent.withOpacity(0.2),
                width: 300,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('End:'),
                      Container(
                        width: 150,
                        height: 50,
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty)
                              return 'This can not be empty';
                            
                            else
                              return null;
                          },
                          controller: end,
                          decoration: InputDecoration(
                              hintText: 'Type where to go',
                              hintStyle: TextStyle(fontSize: 12)),
                        ),
                      )
                    ]),
              ),
              Container(
                color: Colors.redAccent.withOpacity(0.2),
                width: 300,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Date:'),
                      Container(
                        width: 150,
                        height: 50,
                        child: TextFormField(
                          validator: (value) {
                              if (value.isEmpty)
                                return 'This can not be empty';
                              // else if (value.length < 8)
                              //  return "Enter more than 8 character";
                              else
                                return null;
                            },
                          keyboardType: TextInputType.datetime,
                          controller: date,
                          decoration: InputDecoration(
                              hintText: 'yyyy-mm-dd',
                              hintStyle: TextStyle(fontSize: 12)),
                        ),
                      )
                    ]),
              ),
              Container(
                color: Colors.redAccent.withOpacity(0.2),
                width: 300,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Shareable:'),
                      Container(
                        width: 150,
                        height: 50,
                        child: Row(
                          children: <Widget>[
                            Text('Yes'),
                            Radio(
                              value: 0,
                              onChanged: (val) {
                                setState(() {
                                  _rval = val;
                                  sahrerable.text = 'true';
                                });
                              },
                              groupValue: _rval,
                            ),
                            Text('No'),
                            Radio(
                              value: 1,
                              onChanged: (val) {
                                setState(() {
                                  _rval = val;
                                  sahrerable.text = 'false';
                                });
                              },
                              groupValue: _rval,
                            )
                          ],
                        ),
                      )
                    ]),
              ),
              Container(
                //color: Colors.redAccent.withOpacity(0.2),
                margin: EdgeInsets.all(10),
                //width: 300,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        tooltip: 'Send',
                        icon: Icon(
                          Icons.send,
                          color: Colors.redAccent,
                          size: 40,
                        ),
                        //color: Colors.redAccent,
                        onPressed: () {
                          if(_formKey.currentState.validate()){
                            if(_rval==-1){
                              Popupmessage(context, "Select share option", "Yes or No", true);
                            }
                            else{
                          print(widget.purchaseid);
                          int id = spref.getInt('buyer_id');
                          print(id);
                          senttrnsportreqest();}
                          }
                        },
                      )
                    ]),
              ),

              //RaisedButton(child: Text('data'),onPressed: _selectDate(),)
            ],
          ),
        ),
      ),
    ));
  }
}
