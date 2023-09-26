import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_app/Config/config.dart';
import 'package:project_app/DialogBox/errorDialog.dart';
import 'package:project_app/DialogBox/loadingDialog.dart';
import 'package:project_app/DialogBox/popup.dart';
import 'package:project_app/Widgets/color.dart';
import 'package:project_app/Widgets/customTextField.dart';

enum Difficulty { easy, medium, hard, noidea }
enum Type { writing, coding, drawing, other }

class NewAssignmnet extends StatefulWidget {
  @override
  _NewAssignmnetState createState() => _NewAssignmnetState();
}

class _NewAssignmnetState extends State<NewAssignmnet> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final ctitle = TextEditingController();
  final cName = TextEditingController();
  final cPhoneNumber = TextEditingController();
  final cFlatNumber = TextEditingController();
  final carea = TextEditingController();
  final cCity = TextEditingController();
  final cState = TextEditingController();
  Difficulty _site = Difficulty.easy;
  Type _type = Type.writing;
  bool uploading = false;
  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            message: msg,
          );
        });
  }

  uploaddatatofirebase() async {
    await Firestore.instance.collection("Assignments").document().setData({
      "title": ctitle.text.trim(),
      if (_site == Difficulty.easy) "difficulty": "easy",
      if (_site == Difficulty.medium) "difficulty": "medium",
      if (_site == Difficulty.hard) "difficulty": "hard",
      if (_site == Difficulty.noidea) "difficulty": "no idea",
      "budget": cName.text.trim(),
      "brief": cState.text.trim(),
      "publishedDate": DateTime.now(),
      if (_type == Type.writing) "type": "writing",
      if (_type == Type.coding) "type": "coding",
      if (_type == Type.drawing) "type": "drawing",
      if (_type == Type.other) "type": cCity.text.trim(),
      "duedate": cFlatNumber.text.trim(),
      "status": 1,
      "uid": ProjectApp.sharedPreferences.getString(ProjectApp.userUID),
      "email": ProjectApp.sharedPreferences.getString(ProjectApp.userEmail),
      "phone": ProjectApp.sharedPreferences.getString(ProjectApp.userphone),
      "name": ProjectApp.sharedPreferences.getString(ProjectApp.userName),
    });
    setState(() {
      uploading = false;
    });
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (c) {
          return PopUp();
        });
  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Container(
          decoration: new BoxDecoration(),
        ),
        title: Text(
          "Requesting New Assignment",
          style: TextStyle(color: color2),
        ),
      ),
      body: uploading
          ? LoadingAlertDialog(
              message: "Sending Request..",
            )
          : SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(color: Colors.grey.shade200),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: ctitle,
                      hintText: "Assignment Title",
                      isObsecure: false,
                      data: Icons.title,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: screenwidth - 40.0,
                        child: Text(
                          "Assignment Difficulty",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 30.0,
                            child: ListTile(
                              title: const Text('Easy'),
                              leading: Radio(
                                value: Difficulty.easy,
                                groupValue: _site,
                                onChanged: (Difficulty value) {
                                  setState(() {
                                    _site = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Container(
                            height: 30.0,
                            child: ListTile(
                              title: const Text('Medium'),
                              leading: Radio(
                                value: Difficulty.medium,
                                groupValue: _site,
                                onChanged: (Difficulty value) {
                                  setState(() {
                                    _site = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Container(
                            height: 30.0,
                            child: ListTile(
                              title: const Text('Hard'),
                              leading: Radio(
                                value: Difficulty.hard,
                                groupValue: _site,
                                onChanged: (Difficulty value) {
                                  setState(() {
                                    _site = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Container(
                            height: 30.0,
                            child: ListTile(
                              title: const Text('No idea'),
                              leading: Radio(
                                value: Difficulty.noidea,
                                groupValue: _site,
                                onChanged: (Difficulty value) {
                                  setState(() {
                                    _site = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: cName,
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
                            Icons.attach_money,
                            color: color2,
                          ),
                          focusColor: Theme.of(context).primaryColor,
                          hintText: "Assignment Budget (Minimum \$15)",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: screenwidth - 40.0,
                        child: Text(
                          "Assignment Type",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        Container(
                          height: 30.0,
                          child: ListTile(
                            title: const Text('Writing'),
                            leading: Radio(
                              value: Type.writing,
                              groupValue: _type,
                              onChanged: (Type value) {
                                setState(() {
                                  _type = value;
                                });
                              },
                            ),
                          ),
                        ),
                        Container(
                          height: 30.0,
                          child: ListTile(
                            title: const Text('Coding'),
                            leading: Radio(
                              value: Type.coding,
                              groupValue: _type,
                              onChanged: (Type value) {
                                setState(() {
                                  _type = value;
                                });
                              },
                            ),
                          ),
                        ),
                        Container(
                          height: 30.0,
                          child: ListTile(
                            title: const Text('Drawing'),
                            leading: Radio(
                              value: Type.drawing,
                              groupValue: _type,
                              onChanged: (Type value) {
                                setState(() {
                                  _type = value;
                                });
                              },
                            ),
                          ),
                        ),
                        Container(
                          height: 30.0,
                          child: ListTile(
                            title: const Text('other'),
                            leading: Radio(
                              value: Type.other,
                              groupValue: _type,
                              onChanged: (Type value) {
                                setState(() {
                                  _type = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ]),
                    ),
                    _type == Type.other
                        ? CustomTextField(
                            controller: cCity,
                            hintText: "Describe your type",
                            isObsecure: false,
                            data: Icons.merge_type)
                        : Padding(padding: EdgeInsets.all(0.0)),
                    Container(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: cFlatNumber,
                        keyboardType: TextInputType.datetime,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        obscureText: false,
                        cursorColor: color2,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.view_day_rounded,
                            color: color2,
                          ),
                          focusColor: Theme.of(context).primaryColor,
                          hintText: "Due Date (Minimum 4-5 days) dd/mm/yyyy",
                        ),
                      ),
                    ),
                    CustomTextField(
                        controller: cState,
                        hintText: "Brief your Assignment",
                        isObsecure: false,
                        data: Icons.notes),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: screenwidth - 100.0,
                        decoration: BoxDecoration(
                            color: color3,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              uploading = true;
                            });
                            if (_type == Type.other) {
                              ctitle.text.isNotEmpty &&
                                      cName.text.isNotEmpty &&
                                      cFlatNumber.text.isNotEmpty &&
                                      cState.text.isNotEmpty &&
                                      cCity.text.isNotEmpty
                                  ? uploaddatatofirebase()
                                  : displayDialog(
                                      "Please fill all required information");
                            } else {
                              ctitle.text.isNotEmpty &&
                                      cName.text.isNotEmpty &&
                                      cState.text.isNotEmpty &&
                                      cFlatNumber.text.isNotEmpty
                                  ? uploaddatatofirebase()
                                  : displayDialog(
                                      "Please fill all required information");
                            }
                          },
                          child: Text(
                            "Request",
                            style: TextStyle(
                                color: color2,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
