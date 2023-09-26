import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
import '../Widgets/color.dart';
import '../Config/config.dart';

class AuthenticScreen extends StatefulWidget {
  @override
  _AuthenticScreenState createState() => _AuthenticScreenState();
}

class _AuthenticScreenState extends State<AuthenticScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: new BoxDecoration(color: color1),
            ),
            title: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Project Buddy",
                  style: TextStyle(
                    fontSize: 40.0,
                    color: color2,
                  ),
                ),
              ],
            ),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    "Login",
                    style: TextStyle(color: color2),
                  ),
                  icon: Icon(
                    Icons.lock,
                    color: color2,
                  ),
                  // text: "Login",
                ),
                Tab(
                  child: Text(
                    "Register",
                    style: TextStyle(color: color2),
                  ),
                  icon: Icon(
                    Icons.person,
                    color: color2,
                  ),
                  // text: "Register",
                )
              ],
              indicatorColor: color2,
              indicatorWeight: 5.0,
            ),
          ),
          body: Container(
            decoration: new BoxDecoration(color: color4),
            child: TabBarView(
              children: [
                Login(),
                Register(),
              ],
            ),
          ),
        ));
  }
}
