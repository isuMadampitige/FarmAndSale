import 'package:flutter/material.dart';
//import 'package:login2/UI/Buyer/CategoricalItemDisplay.dart';

class HorizontalList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 80.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            image_location: 'images/veg.jpg',
            image_caption: 'vegitables',
            cat_url:'http://34.87.38.40/purchaseItem/category/vegitable'
          ),
          Category(
            image_location: 'images/fruit.jpg',
            image_caption: 'fruits',
            cat_url:'http://34.87.38.40/purchaseItem/category/fruit'
          ),
          Category(
            image_location: 'images/paper.jpg',
            image_caption: 'spicies',
            cat_url:'http://34.87.38.40/purchaseItem/category/spicies'
          ),
          Category(
            image_location: 'images/coconut.png',
            image_caption: 'coconuts',
            cat_url:'http://34.87.38.40/purchaseItem/category/coconut'
          ),
          Category(
            image_location: 'images/tea.jpg',
            image_caption: 'tea',
            cat_url:'http://34.87.38.40/purchaseItem/category/tea'
          )
        ],
      ),
    );
  }
}
class Category extends StatelessWidget{
  final String image_location; 
  final String image_caption;
  final String cat_url;

  Category({
    this.image_location,
    this.image_caption,
    this.cat_url,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(onTap: (){
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDisplay(cat_url, 1)));
      },
      child: Container(
          width: 100.0,
          child: ListTile(
             title: Image.asset(image_location,
             width:100.0,
             height:50.0),
             subtitle: Container(
               alignment: Alignment.topCenter,
               child: Text(image_caption),
             ),
          ),
      ),
      ),
    );
  }
}