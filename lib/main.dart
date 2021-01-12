import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:vaccine_distribution/Beauty/BootUp.dart';
import 'package:vaccine_distribution/Beauty/PatientAuthentication.dart';
import 'package:vaccine_distribution/Beauty/WarriorDashboard.dart';

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