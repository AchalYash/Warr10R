import 'package:flutter/material.dart';

class PatientAuthentication extends StatefulWidget {
  @override
  _PatientAuthenticationState createState() => _PatientAuthenticationState();
}

class _PatientAuthenticationState extends State<PatientAuthentication> {

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
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
                    padding: EdgeInsets.only(left: 20,),
                    child: Text(
                      "Patient Authentication",
                      style: TextStyle(
                        fontSize: 21,
                        fontFamily: "Agus",
                      ),
                    ),
                  ),  //Patient Authentication
                  Container(
                    width: wd * 0.15,
                    height: ht * 0.11 - notificationBarHeight,
                    alignment: Alignment.center,
                    child: PopupMenuButton<int>(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      icon: Icon(Icons.more_vert),
                      offset: Offset(0, ht * 0.1),
                      onSelected: (int value) {
                        setState(() {
                          print(value);
                          _popupMenuSelection = value;
                        });
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                        const PopupMenuItem<int>(
                          value: 1,
                          child: Text('Logout'),
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: "Agus",
                            fontSize: 16,
                          ),
                        ),
                        const PopupMenuItem<int>(
                          value: 2,
                          child: Text('2'),
                        ),
                        const PopupMenuItem<int>(
                          value: 3,
                          child: Text('3'),
                        ),
                      ],
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
