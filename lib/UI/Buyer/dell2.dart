import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:login2/UI/Buyer/CategoricalItemDisplay.dart';
//import 'package:login2/productclass.dart';
import 'package:flutter/material.dart';
//import 'package:login2/UI/Buyer/ItemList.dart';
import 'package:login2/UI/Transpoter/transpoterhome.dart';
import 'package:login2/main.dart';
import 'package:login2/userclass.dart';

// class Category extends StatefulWidget {

//   Usr logeduser =new Usr();

//   Category({this.logeduser});

//   @override
//   _CategoryState createState() => _CategoryState();
// }

// class _CategoryState extends State<Category> {

//   BuildContext _context;
//   List<product> gridview;
//   bool isloading = true;
//   String category;

//   Future loadproduct() async {
//     //http.Response response =
//     await http
//         .get(
//       'http://34.87.38.40/purchaseItem/category',
//     )
//         .then((response) {
//       //print(response.body);
//       String content = response.body;
//       List prdct = json.decode(content);
//       print(response.statusCode);
//       if (response.statusCode == 200) {
//         setState(() {
//           gridview = prdct.map((json) => product.fromjson(json)).toList();
//                     isloading = false;
//                   });
//                   print(gridview[0]);
//                 }
//               });
//             }
          
          
//             @override
//             Widget build(BuildContext context) {
//               return Scaffold(
//                 appBar: AppBar(
//                   title: Text('Buyer'),
//                   backgroundColor: Colors.lightGreen,
//                 ),
//                 drawer: new Drawer(
//                   child: new ListView(
//                     children: <Widget>[
//                       //header//
//                       new UserAccountsDrawerHeader(
//                         accountName: Text(widget.logeduser.fullname),
//                         accountEmail: Text(widget.logeduser.mobilenumber),
//                         currentAccountPicture: GestureDetector(
//                           child: new CircleAvatar(
//                             backgroundColor: Colors.grey,
//                             child: Icon(
//                               Icons.person,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         decoration: new BoxDecoration(color: Colors.lightGreen),
//                       ),
//                       //body//
//                       InkWell(
//                         onTap: () {
//                           // Navigator.push(context,
//                           //     MaterialPageRoute(builder: (context) => FarmerProfile()));
//                         },
//                         child: ListTile(
//                           title: Text('My profile'),
//                           leading: Icon(Icons.person),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           // Navigator.push(context,
//                           //     MaterialPageRoute(builder: (context) => Notificate()));
//                         },
//                         child: ListTile(
//                           title: Text('Notification'),
//                           leading: Icon(Icons.notifications),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           // initState();
//                           // setState(() {
//                           //   isloading = false;
//                           // });
//                         },
//                         child: ListTile(
//                           title: Text('Statistics'),
//                           leading: Icon(Icons.table_chart),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                            Navigator.pushReplacement((context),
//                               MaterialPageRoute(builder: (context) =>Transpoterhome(logeduser: widget.logeduser,)));
//                         },
//                         child: ListTile(
//                           title: Text('Confirmed order'),
//                           leading: Icon(Icons.shopping_basket),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           Navigator.pushReplacement((context),
//                               MaterialPageRoute(builder: (context) => HomeScreen()));
//                         },
//                         child: ListTile(
//                           title: Text('Login Out'),
//                           leading: Icon(Icons.lock_open),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 //body:Center(child: Text('Buyer'),),
//                 body: Container(
//                   child: Products(),
//                 ),
//               );
//             }
//           }
          class Products extends StatefulWidget {

            int userid;
            Products(this.userid);
            @override
            _ProductsState createState() => _ProductsState();
          }
          
          class _ProductsState extends State<Products> {
          final list_item=[
            {"name":"Vegitables","pic":"images/veg.jpg","url":"http://34.87.38.40/purchaseItem/category/vegitable"},
            {"name":"Fruits","pic":"images/fruit.jpg","url":"http://34.87.38.40/purchaseItem/category/fruit"},
            {"name":"Spices","pic":"images/paper.jpg","url":"http://34.87.38.40/purchaseItem/category/spicies"},
            {"name":"Coconut","pic":"images/coconut.png","url":"http://34.87.38.40/purchaseItem/category/coconut"}, 
            {"name":"Tea","pic":"images/tea.jpg","url":"http://34.87.38.40/purchaseItem/category/tea"},
            {"name":"Other","pic":"images/rubber.jpg","url":"http://34.87.38.40/purchaseItem/category/other"},
            // {"name":"jf","pic":"images/avacado.jpg"},
            // {"name":"Other","pic":"images/banana.jpg"}, 
            // {"name":"Tddea","pic":"images/carret.jpg"},
            // {"name":"Rubsber","pic":"images/tomato.jpg"},
            // {"name":"Tddea","pic":"images/carret.jpg"},
            // {"name":"Rubsber","pic":"images/tomato.jpg"},
            
          
          ];
          
            @override
            Widget build(BuildContext context) {
              return GridView.builder(
                itemCount: list_item.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (BuildContext context,int index){
                  return Card(
                child: Hero(
                  tag: list_item[index]['name'],
                  child: Material(
                    child: InkWell(
                      onTap: (){
                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDisplay(list_item[index]['url'],widget.userid)));
                        
                      },
                      child: GridTile(
                        footer: Container(
                          color: Colors.black45,
                          child: ListTile(
                            leading: Text(
                              list_item[index]['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26.0,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                        child: Image.asset(list_item[index]['pic'],fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                ),
              );
                }
              );
            }
          }
          
          /////product class
          
//           class product extends StatelessWidget {
//             final product_name;
//             final product_pic;
//             String url;
          
//             product(
//               {
//                 this.product_name,
//                 this.product_pic,
//                 this.url
//               }
//             );
          
//             @override
//             Widget build(BuildContext context) {
              // return Card(
              //   child: Hero(
              //     tag: product_name,
              //     child: Material(
              //       child: InkWell(
              //         onTap: (){
              //           //Navigator.push(context, MaterialPageRoute(builder: (context)=>Itemcategory()));
              //         },
              //         child: GridTile(
              //           footer: Container(
              //             color: Colors.black45,
              //             child: ListTile(
              //               leading: Text(
              //                 product_name,
              //                 style: TextStyle(
              //                   fontWeight: FontWeight.bold,
              //                   fontSize: 26.0,
              //                   color: Colors.white
              //                 ),
              //               ),
              //             ),
              //           ),
              //           child: Image.asset(product_pic,fit: BoxFit.cover,),
              //         ),
              //       ),
              //     ),
              //   ),
              // );
//             }
          
//             static fromjson(json) {}
//  }
// class prodct  {
//   int purchase_item_id;
//   String type;
//   String quantity;
//   String location;
//   String exp_date;
//   String date;
//   BuildContext route;

//   prodct({
//     this.purchase_item_id,
//     this.type,
//     this.quantity,
//     this.location,
//     this.date,
//     this.exp_date,
//   });

//   factory prodct.fromjson(Map<String, dynamic> json) {
//     return prodct(
//       type: json['type'],
//       quantity: json['quantity'],
//       date: json['date'],
//       location: json['location'],
//       exp_date: json['exp_date'],
//     );
//   }
// }

