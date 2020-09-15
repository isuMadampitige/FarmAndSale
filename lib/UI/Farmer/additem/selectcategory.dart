
import 'package:flutter/material.dart';
import 'package:login2/UI/Commenclass/Products.dart';
import 'package:login2/UI/Farmer/additem/selectType.dart';

product test = product();

class SelectCategory extends StatefulWidget {
  product details ;
  int id;
  SelectCategory({this.details, this.id});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<SelectCategory> {
  get typ => null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[30],
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 55),
              child: Text(
                'Select a Category',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 600,
              padding: EdgeInsets.all(50),
              child: GridView.count(
                crossAxisCount: 2,
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.all(8),
                    child: InkWell(
                      onTap: ()  {
                         widget.details = product(category: 'vegetable');
                         print(widget.details.category);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SelectType(
                                    typ: widget.details,
                                    id: widget.id,
                                  ),
                            ));
                      },
                      splashColor: Colors.green,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset('images/veg.jpg'),
                            Text(
                              "vegitable",
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
                      onTap: () {},
                      splashColor: Colors.green,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset(
                              'images/fruit.jpg',
                              width: 100,
                              height: 100,
                            ),
                            Text(
                              "Fruit",
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
                      onTap: () {},
                      splashColor: Colors.green,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset(
                              'images/paper.jpg',
                              width: 100,
                              height: 100,
                            ),
                            Text(
                              "Spiceis",
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
                      onTap: () {},
                      splashColor: Colors.green,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset(
                              'images/coconut.png',
                              width: 100,
                              height: 100,
                            ),
                            Text(
                              "Coconut",
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
                      onTap: () {},
                      splashColor: Colors.green,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset('images/tea.jpg'),
                            Text(
                              "Tea",
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
                      onTap: () {},
                      splashColor: Colors.green,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset('images/veg.jpg'),
                            Text(
                              "vegitable",
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
