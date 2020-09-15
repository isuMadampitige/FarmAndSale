// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong/latlong.dart';

// class LocationMap extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: new AppBar(
//         title: new Text('location'),
//         backgroundColor: Colors.lightGreen,
//       ),
//       body: new FlutterMap(
//         options: new MapOptions(
//           center: new LatLng(67.71, -74.00),
//           minZoom: 10.0,
//         ),
//         layers: [new TileLayerOptions(
//           urlTemplate: "https://{s}.tile.openStreetmap.org/{z}/{x}/{y}.png",
//           subdomains: ['a','b','c']
//         ),
//         new MarkerLayerOptions(
//           markers: [new Marker(
//             width: 45.0,
//             height: 45.0,
//             point: new LatLng(40.71, -74.00),
//             builder: (context) => new Container(
//               child: IconButton(
//                 icon: Icon(Icons.location_on),
//                 color: Colors.red,
//                 iconSize: 45.0,
//                 onPressed: (){
//                   print('marker taped');
//                 },
//               ),
//             )
//           )
//           ])
//         ]
//       ),
//     );
//   }

// }