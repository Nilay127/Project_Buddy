import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_app/Screen/home.dart';
import 'package:project_app/Widgets/color.dart';
// import 'package:e_shop/Admin/adminLogin.dart';
import '../Widgets/customTextField.dart';
import '../DialogBox/errorDialog.dart';
import '../DialogBox/loadingDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import '../Store/storehome.dart';
import '../Config/config.dart';
import '../main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailtextEditingController =
      TextEditingController();
  final TextEditingController _passwordtextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool show = true;
  @override
  Widget build(BuildContext context) {
    double _screenwidth = MediaQuery.of(context).size.width,
        _screenheight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(color: Colors.grey.shade200),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: _screenheight / 17,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "assets/projectbuddy2.jpg",
                height: 200.0,
                width: 200.0,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Login to your account",
                style: TextStyle(color: color2, fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _emailtextEditingController,
                    data: Icons.email,
                    hintText: "Email",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _passwordtextEditingController,
                    data: Icons.vpn_key,
                    hintText: "Password",
                    isObsecure: show,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 0.0, bottom: 8.0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: show ? false : true,
                          onChanged: (bool value) {
                            setState(() {
                              if (value == true) {
                                show = false;
                              } else {
                                show = true;
                              }
                            });
                          },
                        ),
                        SizedBox(
                          width: 30.0,
                        ),
                        Text("Show password")
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: _screenwidth - 100.0,
              decoration: BoxDecoration(
                  color: color1, borderRadius: BorderRadius.circular(10.0)),
              child: TextButton(
                onPressed: () {
                  _emailtextEditingController.text.isNotEmpty &&
                          _passwordtextEditingController.text.isNotEmpty
                      ? loginUser()
                      : showDialog(
                          context: context,
                          builder: (c) {
                            return ErrorAlertDialog(
                              message: "Please fill required information",
                            );
                          });
                },
                child: Text(
                  "Sign in",
                  style: TextStyle(
                      color: color2,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 4.0,
              width: _screenwidth * 0.8,
              color: color1,
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  void loginUser() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
            message: "Authenticating",
          );
        });
    FirebaseUser firebaseUser;
    await _auth
        .signInWithEmailAndPassword(
            email: _emailtextEditingController.text.trim(),
            password: _passwordtextEditingController.text.trim())
        .then((authUser) {
      firebaseUser = authUser.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: error.message.toString(),
            );
          });
    });
    if (firebaseUser != null) {
      readData(firebaseUser).then((s) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Signed in successfully"),
        ));
        Route route = MaterialPageRoute(builder: (c) => Home());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future readData(FirebaseUser fUser) async {
    Firestore.instance
        .collection("users")
        .document(fUser.uid)
        .get()
        .then((dataSnapshot) async {
      await ProjectApp.sharedPreferences
          .setString(ProjectApp.userUID, dataSnapshot.data[ProjectApp.userUID]);
      await ProjectApp.sharedPreferences
          .setString(ProjectApp.userpassword, dataSnapshot.data['password']);

      await ProjectApp.sharedPreferences.setString(
          ProjectApp.userEmail, dataSnapshot.data[ProjectApp.userEmail]);
      await ProjectApp.sharedPreferences
          .setString(ProjectApp.userName, dataSnapshot.data['name']);
      await ProjectApp.sharedPreferences
          .setString(ProjectApp.userphone, dataSnapshot.data['phone']);

      await ProjectApp.sharedPreferences
          .setString(ProjectApp.institute, dataSnapshot.data['institute']);

      // print(ProjectApp.sharedPreferences.getString(ProjectApp.userName));
      // print(ProjectApp.sharedPreferences.getString(ProjectApp.userEmail));
      // print(ProjectApp.sharedPreferences.getString(ProjectApp.userUID));
      // print(
      //     ProjectApp.sharedPreferences.getString(ProjectApp.userAvatarUrl));
      // print(ProjectApp.sharedPreferences.getString(ProjectApp.userphone));
      // print(ProjectApp.sharedPreferences.getString(ProjectApp.addressID));

      // List<String> cartlist =
      //     dataSnapshot.data[ProjectApp.userCartList].cast<String>();
      // await ProjectApp.sharedPreferences
      //     .setStringList(ProjectApp.userCartList, ["garbageValue"]);
    });
  }
}
