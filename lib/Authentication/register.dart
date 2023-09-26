import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_app/Authentication/register2.dart';
import 'package:project_app/Screen/home.dart';
import 'package:project_app/Widgets/color.dart';
import '../Widgets/customTextField.dart';
import '../DialogBox/errorDialog.dart';
import '../DialogBox/loadingDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import '../Store/storehome.dart';
import '../Config/config.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nametextEditingController =
      TextEditingController();
  final TextEditingController _emailtextEditingController =
      TextEditingController();
  final TextEditingController _passwordtextEditingController =
      TextEditingController();
  final TextEditingController _cpasswordtextEditingController =
      TextEditingController();
  final TextEditingController _phonetextEditingController =
      TextEditingController();
  final TextEditingController _countrycode = TextEditingController();
  final TextEditingController _addresstextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String userImageUrl = "";
  File _imageFile;
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
              height: 10.0,
            ),
            // InkWell(
            //   onTap: _selectAndPickImage,
            //   child: CircleAvatar(
            //     radius: _screenwidth * 0.15,
            //     backgroundColor: white,
            //     backgroundImage:
            //         _imageFile == null ? null : FileImage(_imageFile),
            //     child: _imageFile == null
            //         ? Icon(
            //             Icons.add_photo_alternate,
            //             size: _screenwidth * 0.15,
            //             color: Colors.grey,
            //           )
            //         : null,
            //   ),
            // ),
            // Container(
            //   alignment: Alignment.bottomCenter,
            //   child: Image.asset(
            //     "images/register.png",
            //     height: 120.0,
            //     width: 500.0,
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: Text(
            //     "Select logo",
            //     style:
            //         TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            //   ),
            // ),
            // SizedBox(
            //   height: 8.0,
            // ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _nametextEditingController,
                    data: Icons.person,
                    hintText: "Name",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _emailtextEditingController,
                    data: Icons.email,
                    hintText: "Email",
                    isObsecure: false,
                  ),
                  Container(
                    decoration: new BoxDecoration(
                      color: color4,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _countrycode,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        WhitelistingTextInputFormatter(new RegExp(('[0-9]'))),
                      ],
                      obscureText: false,
                      cursorColor: color2,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.add,
                          color: color2,
                        ),
                        focusColor: Theme.of(context).primaryColor,
                        hintText: "Country Code",
                      ),
                    ),
                  ),
                  Container(
                    decoration: new BoxDecoration(
                      color: color4,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _phonetextEditingController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        WhitelistingTextInputFormatter(new RegExp(('[0-9]'))),
                        LengthLimitingTextInputFormatter(10),
                      ],
                      obscureText: false,
                      cursorColor: color2,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.phone,
                          color: color2,
                        ),
                        focusColor: Theme.of(context).primaryColor,
                        hintText: "Phone Number",
                      ),
                    ),
                  ),
                  CustomTextField(
                    controller: _passwordtextEditingController,
                    data: Icons.vpn_key_outlined,
                    hintText: "Password",
                    isObsecure: show,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
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
                  CustomTextField(
                    controller: _cpasswordtextEditingController,
                    data: Icons.vpn_key,
                    hintText: "Confirm Password",
                    isObsecure: show,
                  ),
                  CustomTextField(
                    controller: _addresstextEditingController,
                    data: Icons.location_city,
                    hintText: "Institute Name",
                    isObsecure: false,
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
                  uploadAndSaveImage();
                  // _passwordtextEditingController.text ==
                  //         _cpasswordtextEditingController.text
                  //     ? _emailtextEditingController.text.isNotEmpty &&
                  //             _passwordtextEditingController.text.isNotEmpty &&
                  //             _nametextEditingController.text.isNotEmpty &&
                  //             _cpasswordtextEditingController.text.isNotEmpty &&
                  //             _phonetextEditingController.text.isNotEmpty &&
                  //             _addresstextEditingController.text.isNotEmpty
                  //         ? _registerUser()
                  //         : displayDialog("Please fill required information")
                  //     : displayDialog("Password do not match");
                },
                child: Text(
                  "Signup",
                  style: TextStyle(
                      color: color2,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
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

  Future<void> _selectAndPickImage() async {
    _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            message: msg,
          );
        });
  }

  Future<void> uploadAndSaveImage() async {
    // if (_imageFile == null) {
    //   showDialog(
    //       context: context,
    //       builder: (c) {
    //         return ErrorAlertDialog(
    //           message: "Please select your Image",
    //         );
    //       });
    // } else {
    _passwordtextEditingController.text == _cpasswordtextEditingController.text
        ? _emailtextEditingController.text.isNotEmpty &&
                _passwordtextEditingController.text.isNotEmpty &&
                _nametextEditingController.text.isNotEmpty &&
                _cpasswordtextEditingController.text.isNotEmpty &&
                _phonetextEditingController.text.isNotEmpty &&
                _addresstextEditingController.text.isNotEmpty &&
                _countrycode.text.isNotEmpty
            ? _phonetextEditingController.text.length == 10
                ? _registerUser()
                : displayDialog("Please write correct phone number")
            : displayDialog("Please fill required information")
        : displayDialog("Password do not match");
    // }
  }

  // uploadToStorage() async {
  //   showDialog(
  //       context: context,
  //       builder: (c) {
  //         return LoadingAlertDialog(
  //           message: "Registering",
  //         );
  //       });

  //   String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();

  //   StorageReference storageReference =
  //       FirebaseStorage.instance.ref().child(imageFileName);

  //   StorageUploadTask storageUploadTask = storageReference.putFile(_imageFile);

  //   StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;

  //   await taskSnapshot.ref.getDownloadURL().then((urlImage) {
  //     userImageUrl = urlImage;

  //     _registerUser();
  //   });
  // }

  FirebaseAuth _auth = FirebaseAuth.instance;
  void _registerUser() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
            message: "Registering",
          );
        });
    FirebaseUser firebaseUser;
    await _auth
        .createUserWithEmailAndPassword(
            email: _emailtextEditingController.text.trim(),
            password: _passwordtextEditingController.text.trim())
        .then((auth) {
      firebaseUser = auth.user;
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
      saveUserInfoToFireStore(firebaseUser).then((value) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c) => Home());
        Navigator.pushReplacement(context, route);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Registered successfully"),
        ));
      });
    }
  }

  Future saveUserInfoToFireStore(FirebaseUser fUser) async {
    Firestore.instance.collection("users").document(fUser.uid).setData({
      "uid": fUser.uid,
      "email": fUser.email,
      "name": _nametextEditingController.text.trim(),
      "password": _passwordtextEditingController.text.trim(),
      "phone": "+" +
          _countrycode.text.trim() +
          " " +
          _phonetextEditingController.text.trim(),
      "institute": _addresstextEditingController.text.trim(),
    });
    await ProjectApp.sharedPreferences.setString(ProjectApp.userUID, fUser.uid);
    await ProjectApp.sharedPreferences
        .setString(ProjectApp.userEmail, fUser.email);
    await ProjectApp.sharedPreferences
        .setString(ProjectApp.userName, _nametextEditingController.text);
    await ProjectApp.sharedPreferences.setString(ProjectApp.userphone,
        "+" + _countrycode.text + " " + _phonetextEditingController.text);
    await ProjectApp.sharedPreferences
        .setString(ProjectApp.institute, _addresstextEditingController.text);
    await ProjectApp.sharedPreferences.setString(
        ProjectApp.userpassword, _passwordtextEditingController.text);

    // await ProjectApp.sharedPreferences
    //     .setStringList(ProjectApp.userCartList, ["garbageValue"]);
  }
}
