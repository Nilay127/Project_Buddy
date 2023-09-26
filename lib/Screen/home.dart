import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_app/Authentication/authenication.dart';
import 'package:project_app/Config/config.dart';
import 'package:project_app/Screen/Assignments/assignment.dart';
import 'package:project_app/Screen/Assignments/newassignment.dart';
import 'package:project_app/Widgets/color.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_button/animated_button.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    double _screenwidth = MediaQuery.of(context).size.width,
        _screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color1,
        title: Text(
          'Home',
          style: TextStyle(color: color2),
        ),
        actions: [
          IconButton(
            color: color2,
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AuthenticScreen()),
                  (route) => false);
              await ProjectApp.sharedPreferences
                  .setString(ProjectApp.userUID, null);
              await ProjectApp.sharedPreferences
                  .setString(ProjectApp.userEmail, null);
              await ProjectApp.sharedPreferences
                  .setString(ProjectApp.userName, null);
              await ProjectApp.sharedPreferences
                  .setString(ProjectApp.userphone, null);
              await ProjectApp.sharedPreferences
                  .setString(ProjectApp.institute, null);
              await ProjectApp.sharedPreferences
                  .setString(ProjectApp.userpassword, null);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: _screenheight,
          decoration: BoxDecoration(color: Colors.grey.shade200),
          child: Column(
            children: [
              SizedBox(
                height: _screenheight / 30,
              ),


              Container(
                child:AnimatedButton(
                  width: _screenwidth /2.5,
                  height: _screenwidth /3,
                  child:Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0)
                    ),
                    child:
                    Text(
                      'Request new assignment',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        color: color2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  color: color1,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewAssignmnet()));

                  },
                  enabled: true,
                  shadowDegree: ShadowDegree.light,

                ),
              ),
              /*
              Center(
                  child: Container(
                width: _screenwidth / 2,
                height: _screenwidth / 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0), color: color1),
                child: InkWell(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Center(
                    child: Text(
                      "Request New   Assignment",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: color2,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewAssignmnet()));
                  },
                ),
              )),*/



              SizedBox(
                height: _screenheight / 30,
              ),
              Container(
                child:AnimatedButton(
                  width: _screenwidth /2.5,
                  height: _screenwidth /3,
                  child:Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0)
                    ),
                    child:
                    Text(
                      'Ongoing / Completed Assignments',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        color: color2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  color: color1,
                  onPressed: () {
                    Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Assignment()));

                  },
                  enabled: true,
                  shadowDegree: ShadowDegree.light,
                ),
              ),
              // Center(
              //     child: Container(
              //   width: _screenwidth / 2,
              //   height: _screenwidth / 2,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(100.0), color: color1),
              //   child: InkWell(
              //     borderRadius: BorderRadius.circular(100.0),
              //     child: Center(
              //       child: Text(
              //         "Ongoing / Completed Assignments",
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //             color: color2,
              //             fontWeight: FontWeight.bold,
              //             fontSize: 17.0),
              //       ),
              //     ),
              //     onTap: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => Assignment()));
              //     },
              //   ),
              // )),
              // SizedBox(
              //   height: _screenheight / 40,
              // ),


              // Text(
              //   'Request new assignment',
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     fontSize: 22,
              //     color: color2,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),

              SizedBox(
                height: _screenheight / 30,
              ),
              Center(
                  child: Container(
                width: _screenwidth / 1.3,
                height: _screenwidth / 5,
                decoration: BoxDecoration(border: Border.all(color: color2)),
                child: InkWell(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Connect Us On :",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: color2,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0),
                        ),
                        Image.network(
                          "https://www.freepnglogos.com/uploads/whatsapp-png-image-9.png",
                          height: _screenwidth / 5.5,
                          width: _screenwidth / 5.5,
                          fit: BoxFit.cover,
                        )
                      ],
                    ),
                  ),
                  onTap: () async {
                    var url = 'whatsapp://send?phone=+916353380829';
                    if (await canLaunch(url) != null) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
              )),
              SizedBox(
                height: _screenheight / 40,
              ),
              Center(
                  child: Container(
                width: _screenwidth / 1.3,
                height: _screenwidth / 5,
                decoration: BoxDecoration(border: Border.all(color: color2)),
                child: InkWell(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Connect Us On :",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: color2,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0),
                        ),
                        Image.network(
                          "https://1000logos.net/wp-content/uploads/2021/05/Gmail-logo.png",
                          height: _screenwidth / 5.5,
                          width: _screenwidth / 5.5,
                          fit: BoxFit.cover,
                        )
                      ],
                    ),
                  ),
                  onTap: () async {
                    var url = 'mailto:projectbuddy111@gmail.com';
                    if (await canLaunch(url) != null) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
              )),
              SizedBox(
                height: _screenheight / 40,
              ),
              Center(
                  child: Container(
                    width: _screenwidth / 1.3,
                    height: _screenwidth / 5,
                    decoration: BoxDecoration(border: Border.all(color: color2)),
                    child: InkWell(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Follow Us On :",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: color2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0),
                            ),
                            Image.network(
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Instagram_logo_2016.svg/768px-Instagram_logo_2016.svg.png",
                              height: _screenwidth / 5.5,
                              width: _screenwidth / 5.5,
                              fit: BoxFit.cover,
                            )
                          ],
                        ),
                      ),
                      onTap: () async {
                        var url = 'https://www.instagram.com/projectbuddyofficial/';
                        if (await canLaunch(url) != null) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                  )),
              SizedBox(
                height: _screenheight / 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}
