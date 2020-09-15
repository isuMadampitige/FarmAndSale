import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login2/Method/buyermethod.dart';
import 'package:login2/imagepickerClass.dart';
import 'package:http/http.dart' as http;
import 'package:login2/userclass.dart';

class BuyerProfile extends StatefulWidget {
//user.Usr logeduser;
  String farmer_id;
  int fid;
  Usr userfarmer;
  BuyerProfile({this.farmer_id, this.fid, this.userfarmer});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<BuyerProfile> {
  ImagePic ipic = new ImagePic();
  String farmer_id;
  bool isloading = true;
  bool approved =true;
  _ProfileState({this.farmer_id});
  Usr userfarmer;

  File _image;
//final String url='https://www.cropscience.bayer.com/-/media/bcs-inter/ws_globalportal/crop-science/smallholder-farming/smallholder-farming-in-india.jpg';

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('Image path $_image');
    });
  }

  Future uploadpic(BuildContext context) async {
    var url = 'http://34.87.38.40/profilePicture/uploadFile/farmer/' +
        widget.farmer_id.toString();
    print(url);
    var postBody = {
      "filename": ipic.filename,
      "fileDownloadUri": ipic.fileDownloadUri,
      "fileType": ipic.fileType,
      "size": ipic.size
      //'image': imageFile != null ? base64Encode(imageFile.readAsBytesSync()) : '',
    };

    final response = await http
        .post(
      Uri.encodeFull(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(postBody),
    )
        .then((response) {
      print(response.statusCode);
      print(response.body);

      final responseJson = json.decode(response.body);

      print(responseJson);

      setState(() {
        print("Profile picture uploaded");
        // Scaffold.of(context).showSnackBar(Snackbar(content:Text('profile picture Uploaded')));
      });
    });
  }

  Future _profileinfo() async {
    String url = 'http://34.87.38.40/buyer/' + widget.farmer_id.toString();

    print(url);

    await http.get(url).then((response) {
      print(response.statusCode);
      print(response.body);
      var json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        String content = response.body;
        //List prdct = json.decode(content);
        if (content == '[]') {
          NoItempopup(this.context,'Nothing To Show');
        } else {
          setState(() {
           // approved = json['confirmed'];
            //buyerlist = prdct.map((json) => Usr.fromJson(json)).toList();
            userfarmer = Usr.fromJsonbuyer(json);
            isloading = false;
          });
          print(userfarmer.fullname);
         // print(approved);
        }
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        print('error');
      } else if (response.statusCode >= 500) {
        ServerErrorPopup(this.context);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileinfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue.withOpacity(0.95),
        title: Text('Profile'),
        actions: <Widget>[
          new IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              // Navigator.push(context,
              // MaterialPageRoute(builder: (context)=> FarmerInfo()));
            },
          ),
        ],
      ),
      body: isloading
          ? Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height / 9 * 4,
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(1),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(350.0),
                        )),
                  ),
                ),
                Positioned(
                    top: 110,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: Column(children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, left: 30, right: 30),
                              child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)))))
                        ]))),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.blue.withOpacity(1.0),
                        child: ClipOval(
                          child: SizedBox(
                            width: 120,
                            height: 120,
                          ),
                        ),
                      )),
                ),
              ],
            )
          : Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    alignment: Alignment.center,
                    // width: MediaQuery.of(context).size.width / 12 *11 ,
                    height: MediaQuery.of(context).size.height / 9 * 4,
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.95),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(350.0),
                          //topLeft: Radius.circular(190)
                        )),
                  ),
                ),
                Positioned(
                  top: 110,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0, left: 30, right: 30),
                          child: Container(
                            // width: 370,
                            height: MediaQuery.of(context).size.height,
                            //color: Colors.green,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                // backgroundBlendMode: BlendMode.dstATop,
                                borderRadius: BorderRadius.only(
                                    //bottomLeft: Radius.circular(10),
                                    //bottomRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 100.0, left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: RatingBarIndicator(
                                            itemCount: 5,
                                            itemSize: 15,
                                            rating: userfarmer.starcount,
                                            itemPadding: EdgeInsets.all(0.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.edit,
                                          size: 20,
                                        ),
                                      ))
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 30, left: 2),
                                        child: Icon(
                                          Icons.location_on,
                                          size: 15,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 30, left: 10),
                                        child: Text(
                                          'Address:',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 30, left: 10),
                                        child: Text(
                                          userfarmer.address.toString(),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Align(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 30),
                                          //alignment: Alignment.centerRight,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {},
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 2),
                                        child: Icon(
                                          Icons.location_city,
                                          size: 15,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 10),
                                        child: Text(
                                          'District:',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 10),
                                        child: Text(
                                          userfarmer.district.toString(),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 2),
                                        child: Icon(
                                          Icons.email,
                                          size: 15,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 10),
                                        child: Text(
                                          'Mobile Number:',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 10),
                                        child: Text(
                                          userfarmer.mobilenumber.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Align(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          //alignment: Alignment.centerRight,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {},
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  // Row(
                                  //   children: <Widget>[
                                  //     Padding(
                                  //       padding: const EdgeInsets.only(
                                  //           top: 10, left: 2),
                                  //       child: Icon(
                                  //         Icons.phone,
                                  //         size: 15,
                                  //         color: Colors.grey,
                                  //       ),
                                  //     ),
                                  //     Padding(
                                  //       padding: const EdgeInsets.only(
                                  //           top: 10, left: 10),
                                  //       child: Text(
                                  //         'Mobile Number:',
                                  //         textAlign: TextAlign.left,
                                  //         style: TextStyle(
                                  //             color: Colors.grey,
                                  //             fontSize: 14.0,
                                  //             fontWeight: FontWeight.w400),
                                  //       ),
                                  //     ),
                                  //     Padding(
                                  //       padding: const EdgeInsets.only(
                                  //           top: 10, left: 10),
                                  //       child: Text(
                                  //         userfarmer.mobilenumber.toString(),
                                  //         style: TextStyle(
                                  //             color: Colors.black,
                                  //             fontSize: 14.0,
                                  //             fontWeight: FontWeight.w400),
                                  //       ),
                                  //     ),
                                  //     // Align(
                                  //     //   child: Padding(
                                  //     //     padding: const EdgeInsets.only(top: 0),
                                  //     //     //alignment: Alignment.centerRight,
                                  //     //     child: IconButton(
                                  //     //       icon: Icon(
                                  //     //         Icons.edit,
                                  //     //         color: Colors.white,
                                  //     //       ),
                                  //     //       onPressed: () {},
                                  //     //     ),
                                  //     //   ),
                                  //     // )
                                  //   ],
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: <Widget>[
                                  //     Padding(
                                  //       padding: const EdgeInsets.only(top: 20),
                                  //       child: RaisedButton(
                                  //         color: Colors.green,
                                  //         onPressed: () {
                                  //           Navigator.of(context).pop();
                                  //         },
                                  //         elevation: 4.0,
                                  //         splashColor: Colors.blueGrey,
                                  //         child: Text(
                                  //           'Cancel',
                                  //           style: TextStyle(
                                  //               color: Colors.white, fontSize: 16),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     Padding(
                                  //       padding:
                                  //           const EdgeInsets.only(left: 40, top: 20),
                                  //       child: RaisedButton(
                                  //         color: Colors.green,
                                  //         onPressed: () {
                                  //           uploadpic(context);
                                  //         },
                                  //         elevation: 4.0,
                                  //         splashColor: Colors.blueGrey,
                                  //         child: Text(
                                  //           'Submit',
                                  //           style: TextStyle(
                                  //               color: Colors.white, fontSize: 16),
                                  //         ),
                                  //       ),
                                  //     )
                                  //   ],
                                  // )

                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: approved? Container( 
                                            padding: EdgeInsets.only(
                                                top: 20, right: 20),
                                            alignment: Alignment.centerRight,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Text(
                                                  'Approved  ',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: Icon(
                                                    Icons.done,
                                                    color: Colors.white,
                                                    size: 10,
                                                  ),
                                                )
                                              ],
                                            )) : Container(
                                            padding: EdgeInsets.only(
                                                top: 20, right: 20),
                                            alignment: Alignment.centerRight,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Text(
                                                  'Pending  ',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: Icon(
                                                    Icons.priority_high,
                                                    color: Colors.white,
                                                    size: 10,
                                                  ),
                                                )
                                              ],
                                            )),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.blue,
                                  child: ClipOval(
                                    child: SizedBox(
                                      width: 120,
                                      height: 120,
                                      child: (_image != null)
                                          ? Image.file(_image, fit: BoxFit.fill)
                                          : Image.network(
                                              'https://www.cropscience.bayer.com/-/media/bcs-inter/ws_globalportal/crop-science/smallholder-farming/smallholder-farming-in-india.jpg',
                                              fit: BoxFit.fill,
                                            ),
                                    ),
                                  ),
                                )),
                          ),
                          Positioned(
                            right: 130,
                            top: 75,
                            child: Padding(
                              padding: EdgeInsets.only(top: 60),
                              child: IconButton(
                                icon: Icon(
                                  Icons.add_a_photo,
                                  size: 30.0,
                                ),
                                onPressed: () {
                                  getImage();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          userfarmer.fullname.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // Text('',
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 14.0,
                      //     ),
                      // )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
