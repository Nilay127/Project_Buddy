import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:project_app/Screen/Assignments/completed.dart';
import 'package:project_app/Screen/Assignments/ongoing.dart';
import 'package:project_app/Widgets/color.dart';

class Assignment extends StatefulWidget {
  @override
  _AssignmentState createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {
  @override
  Widget build(BuildContext context) {
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
          "Your Assignments",
          style: TextStyle(color: color2),
        ),
      ),
      body: Container(
        child: ContainedTabBarView(
          tabs: [
            Tab(
              icon: Icon(Icons.pending),
              text: "Ongoing",
            ),
            Tab(
              icon: Icon(Icons.star_rate),
              text: "Completed",
            ),
          ],
          tabBarProperties: TabBarProperties(
            height: 70.0,
            background: Container(
              decoration: BoxDecoration(color: color1),
            ),
            indicatorColor: color2,
            indicatorWeight: 6.0,
            labelColor: color2,
            unselectedLabelColor: color4,
          ),
          views: [Ongoing(), Completed()],
          onChange: (index) => print(index),
        ),
      ),
    );
  }
}
