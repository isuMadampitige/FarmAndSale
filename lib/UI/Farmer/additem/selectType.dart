import 'package:flutter/material.dart';
import 'package:login2/UI/Commenclass/Products.dart';
import 'package:login2/UI/Farmer/additem/ItemDiscription.dart';

class SelectType extends StatefulWidget {
  int id;
  product typ;

  SelectType({this.typ, this.id});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<SelectType> {
  get prd => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[30],
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 55),
              child: Text(
                'Select a Type',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 600,
              padding: EdgeInsets.all(30),
              child: GridView.count(
                crossAxisCount: 2,
                children: <Widget>[
                  Card(
                  
                    margin: EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () {
                        widget.typ.type = 'pumkin';
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemDiscrip(
                                    prd: widget.typ,
                                    fid: widget.id,
                                  ),
                            ));
                      },
                      splashColor: Colors.green,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset('images/pumpkin.jpg',height: 100,),
                            Text(
                              "Pumpkin",
                              style: new TextStyle(fontSize: 17),
                              
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () {
                        widget.typ.type = 'potato';
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemDiscrip(
                                    prd: widget.typ,
                                    fid: widget.id,
                                  ),
                            ));
                      },
                      splashColor: Colors.green,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset('images/potato.jpg'),
                            Text(
                              "Potato",
                              style: new TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemDiscrip()));
                      },
                      splashColor: Colors.green,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset('images/leaks.jpg',height: 100,),
                            Text(
                              "Leaks",
                              style: new TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(8),
                    child: InkWell(

                      onTap: () {
                        widget.typ.type = 'radish';
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemDiscrip()));
                      },
                      splashColor: Colors.green,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset('images/radish.jpg',height: 100,),
                            Text(
                              "Radish",
                              style: new TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () {
                        widget.typ.type = 'carrot';
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemDiscrip()));
                      },
                      splashColor: Colors.green,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset('images/carrot.jpg',height: 100,),
                            Text(
                              "Carrot",
                              style: new TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () {
                        widget.typ.type = 'tomato';
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemDiscrip()));
                      },
                      splashColor: Colors.green,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset('images/tomato.jpg',height: 100,),
                            Text(
                              "Tomato",
                              style: new TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
