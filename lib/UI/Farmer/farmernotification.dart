import 'package:flutter/material.dart';
import 'package:login2/Method/getnotification.dart';
import 'package:login2/UI/Commenclass/notification.dart';
import 'package:login2/UI/Commenclass/notificationcard.dart';

class Notificate extends StatefulWidget {
  List<Notifications> notifications;
  Notificate({this.notifications});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Notificatiionstate();
  }
}

class _Notificatiionstate extends State<Notificate> {
  bool isloading = true;
  
  List<Notifications> notifications;
  assignnotification() async {
    notifications = await getnotification('farmer');
    if(notifications!=null){
    setState(() {
      isloading = false;
    });
    }
  }

  @override
  void initState() {
    assignnotification();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Notifications",
          style: TextStyle(color: Colors.black,fontSize: 17),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: RefreshIndicator(
        onRefresh: ()async {
          await Duration(seconds: 2);
          assignnotification();
          
        },
        child: Container(
          alignment: Alignment.center,
          height: double.maxFinite,
          child: isloading
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return Notificationcard(data: notifications[index],role: 'farmer',);
                  },
                  itemCount: notifications.length,
                ),
        ),
      ),
    );
  }
}
