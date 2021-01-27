import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:vaccine_distribution/UI/BootUp.dart';
import 'package:vaccine_distribution/UI/DisplayVialDetails.dart';
import 'package:vaccine_distribution/UI/PatientAuthentication.dart';
import 'package:vaccine_distribution/UI/WarriorDashboard.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      title: 'Warr10r',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        accentColor: Colors.lightBlueAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android :FadeTransitionBuilder(),
          },
        ),
      ),
      home: BootUp(),
    );
  }
}

class FadeTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(_, __, animation, ___, child) => FadeTransition(opacity: animation, child: child);
}

String dateFormatter(DateTime datetime) {
  return '${datetime.year}'
      '/${(datetime.month).toString().padLeft(2, '0')}'
      '/${(datetime.day).toString().padLeft(2, '0')}'
      ' - '
      '${(datetime.hour).toString().padLeft(2, '0')}'
      ':${(datetime.minute).toString().padLeft(2, '0')}'
      ':${(datetime.second).toString().padLeft(2, '0')}';
}