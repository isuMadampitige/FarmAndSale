import 'package:flutter/material.dart';

class Aboutas extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 600,
          width: 330,
          //color: Colors.lightGreen[300],
          decoration: BoxDecoration(
                        color: Colors.green[200],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))
                    ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Material(
                                elevation: 10.0,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                                child: Image.asset(
                                  'images/logo4.png',
                                  width: 80,
                                  height: 80,
                                )),
              ),
              Text('Version 1.0.0'),
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: Text('We are Undergraduate Students of university of Ruhuna, Department of computer science.We are Developing system for the agricultural field. We have built both web and mobile based applications for the end users.Farmers,Buyers,Transporters are can create accounts and carry out there business activities',
                    style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
          
        ),
      ),
    );
  }

}