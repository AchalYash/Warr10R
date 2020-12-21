import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as qrScanner;
import 'package:vaccine_distribution/Brains/Firebase.dart';

final PageController _warriorPageCtrl = PageController();

class WarriorPageOffset extends ChangeNotifier  {

  double _offset = 0, _page = 0;

  double get offset => _offset;
  double get page => _page;

  WarriorPageOffset(PageController pageController)  {
    pageController.addListener(() {
      _offset = pageController.offset;
      _page = pageController.page;
      notifyListeners();
    });
  }
}

final pageOffsetProvider = ChangeNotifierProvider<WarriorPageOffset>((ref) => WarriorPageOffset(_warriorPageCtrl));

// ignore: must_be_immutable
class WarriorDashBoard extends ConsumerWidget {
  WarriorDashBoard(this.context, this.ht, this.wd, this.notificationBarHeight);
  final double ht, wd, notificationBarHeight;
  final BuildContext context;

  void dispose() {
    _warriorPageCtrl.dispose();
  }

  @override
  Widget build(BuildContext context, watch) {

    final pageOffset = watch(pageOffsetProvider);
    final double p1 = (wd - pageOffset._offset) / wd, p2 = (pageOffset._offset) / wd;
    final Color c1 = Color.fromRGBO((255 * p1).round(), (255 * p1).round(), (255 * p1).round(), 1);
    final Color c2 = Color.fromRGBO((255 * p2).round(), (255 * p2).round(), (255 * p2).round(), 1);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: ht * 0.13,
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
                        "Precisely Random",
                        // FirebaseCustoms.auth.currentUser.displayName ?? "Dashboard",
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
                          print(value);
                          switch (value) {
                            case 1:
                            //ToDo: Implement Details ShowCase
                              break;
                            case 2:
                              FirebaseCustoms.logOut().then((value) {
                                Navigator.pop(context);
                              });
                              break;
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<int>>[
                          const PopupMenuItem<int>(
                            value: 1,
                            child: Text('Details'),
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: "Agus",
                              fontSize: 16,
                            ),
                          ), //Logout
                          const PopupMenuItem<int>(
                            value: 2,
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
                  ],
                ), //AppBar
              ),
            ), //AppBar
            Positioned(
              top: ht * 0.13,
              height: ht * 0.06,
              child: Stack(
                children: [
                  Container(
                    height: ht * 0.05,
                    width: wd,
                    color: Colors.lightBlueAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: ht * 0.03,
                          width: wd/2,
                          child: Text(
                            "History",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Agus",
                              fontSize: p1 * 5 + 16,
                              color: c1,
                            ),
                          ),
                        ),
                        Container(
                          height: ht * 0.03,
                          width: wd/2,
                          child: Text(
                            "Add Record",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Agus",
                              fontSize: p2 * 5 + 16,
                              color: c2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: ht * 0.05,
                    left: pageOffset._offset/2,
                    child: Container(
                      height: 2.5,
                      width: wd/2,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: ht * 0.19,
              child: Container(
                height: ht * 0.81,
                width: wd,
                child: PageView(
                  controller: _warriorPageCtrl,
                  pageSnapping: true,
                  children: [
                    Scaffold(
                      backgroundColor: Colors.white,
                      body: Stack(
                        children: [
                          Container(
                            height: ht * 0.81,
                            width: wd,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      floatingActionButton: Transform.translate(
                        offset: Offset(-10, -10),
                        child: FloatingActionButton(
                          onPressed: () async {
                            await Permission.camera.request();
                            String newScanString = await qrScanner.scan();
                            print(newScanString);
                          },
                          child: Icon(Icons.add),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Positioned(
                          top: ht * 0,
                          child: Container(
                            height: ht * 0.81,
                            width: wd,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class WarriorDashboard extends StatefulWidget {
  @override
  _WarriorDashboardState createState() => _WarriorDashboardState();
}

class _WarriorDashboardState extends State<WarriorDashboard> {
  double ht, wd, notificationBarHeight;
  int _popupMenuSelection;  //ToDo: Remove if Unused
  PageController warriorPageCtrl;

  @override
  void initState() {
    super.initState();
    warriorPageCtrl = PageController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Size size = MediaQuery.of(context).size;
    ht = size.height;
    wd = size.width;
    notificationBarHeight = MediaQuery.of(context).padding.top;
  }

  @override
  void dispose() {
    super.dispose();
    warriorPageCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {

    print(warriorPageCtrl.offset);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                      padding: EdgeInsets.only(
                        left: 20,
                      ),
                      child: Text(
                        "Precisely Random",
                        // FirebaseCustoms.auth.currentUser.displayName ?? "Dashboard",
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
                          switch (value) {
                            case 1:
                              //ToDo: Implement Details ShowCase
                              break;
                            case 2:
                              FirebaseCustoms.logOut().then((value) {
                                Navigator.pop(context);
                              });
                              break;
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<int>>[
                          const PopupMenuItem<int>(
                            value: 1,
                            child: Text('Details'),
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: "Agus",
                              fontSize: 16,
                            ),
                          ), //Logout
                          const PopupMenuItem<int>(
                            value: 2,
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
            Positioned(
              top: ht * 0.11,
              height: ht * 0.07,
              child: Stack(
                children: [
                  Container(
                    height: ht * 0.065,
                    width: wd,
                    color: Colors.lightBlueAccent,
                    child: Row(),
                  ),
                ],
              ),
            ),
            Positioned(
              top: ht * 0.18,
              child: Container(
                height: ht * 0.82,
                width: wd,
                child: PageView(
                  controller: warriorPageCtrl,
                  pageSnapping: true,
                  children: [
                    Scaffold(
                      backgroundColor: Colors.white,
                      body: Stack(
                        children: [
                          Positioned(
                            top: ht * 0,
                            child: Container(
                              height: ht * 0.1,
                              width: wd,
                              // color: Colors.black12,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 16.0),
                                    child: Text(
                                      "History",
                                      style: TextStyle(
                                        fontFamily: "Agus",
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    indent: wd * 0.15,
                                    endIndent: wd * 0.15,
                                    thickness: 2.5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      floatingActionButton: Transform.translate(
                        offset: Offset(-10, -10),
                        child: FloatingActionButton(
                          onPressed: () async {
                            await Permission.camera.request();
                            String newScanString = await qrScanner.scan();
                            print(newScanString);
                          },
                          child: Icon(Icons.add),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Positioned(
                          top: ht * 0,
                          child: Container(
                            height: ht * 0.1,
                            width: wd,
                            // color: Colors.black12,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 16.0),
                                  child: Text(
                                    "Add Patient",
                                    style: TextStyle(
                                      fontFamily: "Agus",
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                                Divider(
                                  indent: wd * 0.15,
                                  endIndent: wd * 0.15,
                                  thickness: 2.5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
