import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:login2/Method/buyermethod.dart';
import 'package:login2/UI/Commenclass/Products.dart';
import 'package:login2/UI/Commenclass/locationclass.dart';

class Location extends StatefulWidget {
  int itm_id;
  // product prd2;

  //Location() : super();
  final String title = "Add Location";
  Location({this.itm_id});
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  product prd2;

  _LocationState({this.prd2});

  Locatin loc = new Locatin();
  // GoogleMapController mapController;

  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        draggable: true,
        infoWindow:
            InfoWindow(title: 'this is a title', snippet: 'this is a snippet'),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  @override
  void initState() {
    //_locationinfo();
    super.initState();
  }

  Future<int> _locationinfo() async {
    Map arr = {
      'item_id': widget.itm_id,
      'latitude': _lastMapPosition.latitude,
      'longitude': _lastMapPosition.longitude,
    };
    var js = jsonEncode(arr);
    var url = 'http://34.87.38.40/addLocation';
    //print(js);
    //print(arr);
    try {
      final response = await http.post(Uri.encodeFull(url),
          headers: {"Content-Type": "application/json"}, body: js);

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        setState(() {
          loc = Locatin.fromJson(json.decode(response.body));
        });
        await Popupmessage(
            context, "Successfully add the location", 'Success', false);
            //Navigator.popUntil(context, predicate)
      } else if (response.statusCode == 500) {
        ServerErrorPopup(context);
      } else {
        NetworkErrorPopup(context);
      }

      //print(user2.fullname);
      return int.parse(response.statusCode.toString());
      //return response;
    } catch (e) {
      NetworkErrorPopup(context);
      return 404;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.green[700],
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              myLocationEnabled: true,
              mapType: _currentMapType,
              markers: _markers,
              onCameraMove: _onCameraMove,
              myLocationButtonEnabled: true,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    // button(_onMapTypeButtonPressed, Icons.map),
                    // SizedBox(height: 16.0,),

                    // button(_onAddMarkerButtonPressed, Icons.add_location)
                    new FloatingActionButton(
                      heroTag: "btn1",
                      onPressed: _onMapTypeButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.map,
                        size: 36,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: new FloatingActionButton(
                        heroTag: "btn2",
                        onPressed: _onAddMarkerButtonPressed,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.add_location,
                          size: 36,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                _locationinfo();
              },
              color: Colors.deepOrange,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              child: Text(
                'add',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//         class Locatin{

//           double latitude;
//           double longitude;

//          Locatin({

//            this.latitude,
//            this.longitude,
//          });

//           factory Locatin.fromJson(Map<String, dynamic> json) {
//           return Locatin(
//                 //item_id: (json['item_id']),
//                 longitude: json['langtude'],
//                 latitude: json['longtude'],
//                );
//   }
// }
