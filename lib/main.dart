import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_shop/Counters/ItemQuantity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_app/Widgets/color.dart';

import 'Authentication/authenication.dart';
// import 'package:e_shop/Config/config.dart';
// import 'Authentication/authenication.dart';
import 'Config/config.dart';
import 'Screen/home.dart';
// import 'Config/config.dart';
// import 'Counters/cartitemcounter.dart';
// import 'Counters/changeAddresss.dart';
// import 'Counters/totalMoney.dart';
// import 'Store/storehome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ProjectApp.auth = FirebaseAuth.instance;
  ProjectApp.sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project App',
      // localizationsDelegates: [
      //   AppLocalizations.delegate, // Add this line
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      //   // AppStrings.delegate,
      // ],
      // supportedLocales: [
      //   const Locale('en', ''), // English, no country code
      //   const Locale('es', ''),
      //   const Locale('gu', ''),
      //   const Locale('hi', ''),
      // ],
      // locale: _locale,
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/home': (context) => Home(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/auth': (context) => AuthenticScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.green),
      home: ProjectApp.sharedPreferences.getString(ProjectApp.userUID) != null
          ? Home()
          : AuthenticScreen(),
    );
  }
}
