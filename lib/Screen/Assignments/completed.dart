import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_app/Config/config.dart';
import 'package:project_app/Widgets/loadingWidget.dart';

class Completed extends StatefulWidget {
  @override
  _CompletedState createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection("Assignments")
          .orderBy("publishedDate", descending: true)
          .snapshots(),
      builder: (context, dataSnapshot) {
        if (!dataSnapshot.hasData) {
          return Container(
            child: Center(
              child: circularProgress(),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: dataSnapshot.data.documents.length,
            itemBuilder: (BuildContext context, int i) {
              return Container(
                width: screenwidth,
                child: dataSnapshot.data.documents[i].data['uid'] ==
                        ProjectApp.sharedPreferences
                            .getString(ProjectApp.userUID)
                    ? dataSnapshot.data.documents[i].data['status'] == 4 ||
                            dataSnapshot.data.documents[i].data['status'] == 5
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                                top: 10.0,
                                bottom: 10.0),
                            child: Card(
                              elevation: 4.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0, top: 8.0),
                                    child: Text(
                                      "ID : " +
                                          dataSnapshot
                                              .data.documents[i].documentID,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0, top: 8.0),
                                    child: Text(
                                      "Title : " +
                                          dataSnapshot
                                              .data.documents[i].data['title'],
                                      style: TextStyle(
                                        fontSize: 17.0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0, top: 8.0),
                                    child: Text(
                                      "Budget : \$" +
                                          dataSnapshot
                                              .data.documents[i].data['budget'],
                                      style: TextStyle(
                                        fontSize: 17.0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0, top: 8.0),
                                    child: Text(
                                      "Due Date : " +
                                          dataSnapshot.data.documents[i]
                                              .data['duedate'],
                                      style: TextStyle(
                                        fontSize: 17.0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0, top: 8.0),
                                    child: Text(
                                      "Type : " +
                                          dataSnapshot
                                              .data.documents[i].data['type'],
                                      style: TextStyle(
                                        fontSize: 17.0,
                                      ),
                                    ),
                                  ),
                                  dataSnapshot.data.documents[i]
                                              .data['status'] ==
                                          4
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 8.0,
                                              top: 8.0,
                                              bottom: 8.0),
                                          child: Text(
                                            "Status : Completed",
                                            style: TextStyle(
                                              fontSize: 17.0,
                                            ),
                                          ),
                                        )
                                      : dataSnapshot.data.documents[i]
                                                  .data['status'] ==
                                              5
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8.0,
                                                            top: 8.0),
                                                    child: Text(
                                                      "Status : Rejected",
                                                      style: TextStyle(
                                                        fontSize: 17.0,
                                                      ),
                                                    )),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8.0,
                                                            top: 8.0,
                                                            bottom: 8.0),
                                                    child: Text(
                                                      "Reason : " +
                                                          dataSnapshot
                                                              .data
                                                              .documents[i]
                                                              .data['reason'],
                                                      style: TextStyle(
                                                        fontSize: 17.0,
                                                      ),
                                                    )),
                                              ],
                                            )
                                          : Padding(
                                              padding: EdgeInsets.all(0.0)),
                                ],
                              ),
                            ),
                          )
                        : Padding(padding: EdgeInsets.all(0.0))
                    : Padding(padding: EdgeInsets.all(0.0)),
              );
            },
          );
        }
      },
    );
  }
}
