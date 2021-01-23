import 'package:flutter/material.dart';
import 'package:vaccine_distribution/BackEnd/Firebase.dart';

class PatientDashboard extends StatefulWidget {
  @override
  _PatientDashboardState createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  double ht, wd, notificationBarHeight;
  int _popupMenuSelection; //  Todo: Remove If Unused
  List<Map<String, String>> patientRecords = [
    {
      "dt": DateTime.now().toString(),
      "type": "Pfyser-2D", //Vaccine Type
      "doc": "Dr34Gty6HYertr7",
      "center": "Central Hospital",
      "vail": "js6f6sish8sh8s", //Vaccine Vial ID
    },
    {
      "dt": DateTime.now().toString(),
      "type": "Pfyser-9R", //Vaccine Type
      "doc": "Dr36Ghy6ry5rt7y",
      "center": "State Hospital",
      "vail": "g56fhut67ghty6", //Vaccine Vial ID
    }
  ];

  List<String> precautions = [
    "Pain",
    "Redness",
    "Itching",
    "Swelling",
    "Fever",
    "Headache",
    "Stiffness in Arm",
    "Malaise",
  ];

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
                              //ToDo: Refresh List UI
                              break;
                            case 2:
                              //ToDo: Display Patient Details
                              break;
                            case 3:
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
                            child: Text('Refresh'),
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: "Agus",
                              fontSize: 16,
                            ),
                          ), //Logout
                          const PopupMenuItem<int>(
                            value: 2,
                            child: Text('Details'),
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: "Agus",
                              fontSize: 16,
                            ),
                          ), //Logout
                          const PopupMenuItem<int>(
                            value: 3,
                            child: Text('Logout'),
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: "Agus",
                              fontSize: 16,
                            ),
                          ), //Logout
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
              height: ht * 0.89,
              width: wd,
              child: (patientRecords.isNotEmpty && patientRecords != null)
                  ? Container(
                      height: ht * 0.89,
                      width: wd,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(
                            vertical: 32.0, horizontal: 16.0),
                        children: patientRecords.map((record) {
                          DateTime dt = DateTime.parse(record["dt"]);
                          String dateTime =
                              "${dt.day}/${dt.month}/${dt.year} - ${dt.hour}:${dt.minute}";
                          bool isExpanded = false;
                          return Padding(
                            padding: const EdgeInsets.only(top: 32.0),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: ht * 0.1,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Text(
                                      record["type"],
                                      style: TextStyle(
                                        fontFamily: "Agus",
                                        fontSize: 21,
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                  ), //Vaccine Type
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 16.0,
                                      left: 16.0,
                                      bottom: 16.0,
                                    ),
                                    child: Text(
                                      dateTime,
                                      style: TextStyle(
                                        fontFamily: "Agus",
                                        fontSize: 16,
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                  ), //Date-Time
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8.0,
                                      left: 16.0,
                                    ),
                                    child: Text(
                                      "Doctor:  ${record["doc"]}",
                                      style: TextStyle(
                                        fontFamily: "Agus",
                                        fontSize: 16,
                                      ),
                                    ),
                                  ), //Doctor
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8.0,
                                      left: 16.0,
                                      bottom: 16.0,
                                    ),
                                    child: Text(
                                      "Center:  ${record["center"]}",
                                      style: TextStyle(
                                        fontFamily: "Agus",
                                        fontSize: 16,
                                      ),
                                    ),
                                  ), //Center
                                  ExpansionTile(
                                    title: Text(
                                      "Vial:  ${record["vail"]}",
                                      style: TextStyle(
                                        fontFamily: "Agus",
                                        fontSize: 16,
                                      ),
                                    ),
                                    childrenPadding: EdgeInsets.only(
                                      left: 32.0,
                                      bottom: 8.0,
                                    ),
                                    expandedAlignment: Alignment.centerLeft,
                                    expandedCrossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: precautions.map((precaution) {
                                      return Text(
                                        precaution,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: "Agus",
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  Divider(
                                    color: Colors.black,
                                    thickness: isExpanded ? 0.0 : 0.45,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  : Container(
                      height: ht * 0.89,
                      child: Center(
                        child: Text(
                          "No Records Found",
                          style: TextStyle(
                            fontFamily: "Agus",
                            fontSize: wd * 0.065,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
