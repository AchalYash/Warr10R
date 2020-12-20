import 'package:flutter/material.dart';
import 'package:vaccine_distribution/Brains/Firebase.dart';

class PatientDashboard extends StatefulWidget {
  @override
  _PatientDashboardState createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {

  double ht, wd, notificationBarHeight;
  int _popupMenuSelection;


  @override
  void didChangeDependencies() {
    Size size = MediaQuery.of(context).size;
    ht = size.height;
    wd = size.width;
    notificationBarHeight = MediaQuery.of(context).padding.top;

    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  height: ht * 0.11,
                  width: wd,
                  padding: EdgeInsets.only(top: notificationBarHeight),
                  color: Colors.lightBlueAccent,
                  child: Row(
                    children: [
                      Container(
                        width: wd * 0.85,
                        height: ht * 0.11 - notificationBarHeight,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                          left: 20,
                        ),
                        child: Text(
                          FirebaseCustoms.auth.currentUser.displayName ?? "Dashboard",
                          style: TextStyle(
                            fontSize: 21,
                            fontFamily: "Agus",
                          ),
                        ),
                      ), //Patient DashBoard
                      Container(
                        width: wd * 0.15,
                        height: ht * 0.11 - notificationBarHeight,
                        alignment: Alignment.center,
                        child: PopupMenuButton<int>(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          icon: Icon(Icons.more_vert),
                          offset: Offset(0, ht * 0.1),
                          onSelected: (int value) {
                            setState(() {
                              print(value);
                              _popupMenuSelection = value;
                            });
                            switch(value) {
                              case 1:
                                FirebaseCustoms.logOut().then((value) {
                                  Navigator.pop(context);
                                });
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<int>>[
                            const PopupMenuItem<int>(
                              value: 1,
                              child: Text('Logout'),
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: "Agus",
                                fontSize: 16,
                              ),
                            ), //Logout
/*                        const PopupMenuItem<int>(
                              value: 2,
                              child: Text('2'),
                            ),
                            const PopupMenuItem<int>(
                              value: 3,
                              child: Text('3'),
                            ),*/
                          ], //PopUpMenu
                        ),
                      ),
/*                  GestureDetector(
                        onTap: (){
                          print('Logout');
                        },
                        child: Container(
                          width: wd * 0.15,
                          height: ht * 0.11 - notificationBarHeight,
                          alignment: Alignment.center,
                          child: Icon(Icons.more_vert),
                        ),
                      ),*/
                    ],
                  ), //AppBar
                ),
              ), //AppBar
            ],
          ),
        ),
      ),
    );
  }
}
