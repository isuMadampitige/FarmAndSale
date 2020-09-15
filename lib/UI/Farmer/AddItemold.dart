import 'package:flutter/material.dart';

class AddItem extends StatelessWidget {
//final String url='https://thumbs-prod.si-cdn.com/stBm6HnSCr4lZYSZ_uwK0JNU33I=/800x600/filters:no_upscale()/https://public-media.si-cdn.com/filer/26/bb/26bb433f-b828-414b-b18f-53453c545e15/istock-939779058.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.8,
        backgroundColor: Colors.lightGreen,
        title: Text('Add Item'),
        actions: <Widget>[
          new IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              // Navigator.push(context,
              // MaterialPageRoute(builder: (context)=> HomePage()));
            },
          ),
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            //header//
            new UserAccountsDrawerHeader(
              accountName: Text('isuru'),
              accountEmail: Text('isuru12345@gmail.com'),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: new BoxDecoration(color: Colors.lightGreen),
            ),
            //body//
            InkWell(
              onTap: () {
                // Navigator.push(context,
                // MaterialPageRoute(builder: (context)=> FarmerProfile()));
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
              onTap: () {},
              child: ListTile(
                title: Text('Notification'),
                leading: Icon(
                  Icons.notifications,
                  color: Colors.lightGreen,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Statistics'),
                leading: Icon(
                  Icons.table_chart,
                  color: Colors.lightGreen,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Confirmed order'),
                leading: Icon(
                  Icons.shopping_basket,
                  color: Colors.lightGreen,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Login Out'),
                leading: Icon(
                  Icons.lock_open,
                  color: Colors.lightGreen,
                ),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('About'),
                leading: Icon(
                  Icons.help,
                  color: Colors.lightGreen,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: Center(
          child: Container(
            width: 320,
            height: 650,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Material(
                    //elevation: 10.0,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: Image.asset(
                      'images/tomato.jpg',
                      width: 120,
                      height: 140,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      hintText: 'Type',
                      fillColor: Colors.grey[100],
                      filled: true,
                      prefixIcon: Icon(Icons.person),
                    ),
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        //border: InputBorder.none,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        hintText: 'Quantity',
                        fillColor: Colors.grey[100],
                        filled: true,
                        prefixIcon: Icon(Icons.format_size)),
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        //border: InputBorder.none,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        hintText: 'Exp date',
                        fillColor: Colors.grey[100],
                        filled: true,
                        prefixIcon: Icon(Icons.date_range)),
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        //border: InputBorder.none,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        hintText: 'price range',
                        fillColor: Colors.grey[100],
                        filled: true,
                        prefixIcon: Icon(Icons.monetization_on)),
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 45,
                    child: RaisedButton(
                      onPressed: () {},
                      color: Colors.deepOrange,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      child: Text(
                        'Post',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
