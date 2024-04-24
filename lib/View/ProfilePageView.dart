import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lead_management_system/Utils/StyleData.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfilePageView extends StatefulWidget {
  const ProfilePageView({super.key});

  @override
  State<ProfilePageView> createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  File? _image;
  List<DocumentSnapshot> ListOfLeads = [];
  List<DocumentSnapshot> ListOfUsers = [];
  List<DocumentSnapshot> ListOfConvertedLeads = [];
  var userType;
  String? employeeName;
  String? branchCode;
  String? employeeCode;

  void getUserData() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userId = pref.getString("token");
    setState(() {
      userType = pref.getString("logintype");
    });
    print(userType);
    if (userType == "user") {
      users.where("userId", isEqualTo: userId).get().then((value) {
        setState(() {
          ListOfUsers = value.docs;
        });
        for (var i = 0; value.docs.length > i; i++) {
          print(value.docs[i].data());
          print("hgdhgjd");
          print(ListOfUsers[i]['EmployeeName']);
          if( pref.getString("employeeCode") == ListOfUsers[i]['EmployeeCode'])
          {
            setState(() {
              employeeName = ListOfUsers[i]['EmployeeName'];
              branchCode = ListOfUsers[i]['branchCode'];
              employeeCode = ListOfUsers[i]['EmployeeCode'];
              pref.setString("branchcode", ListOfUsers[i]['branchCode']);
              print("EMployee Name");
              print(employeeName);
              print(branchCode);
            });
          }
        }
      });
    } else {
      users.get().then((value) {
        setState(() {
          ListOfUsers = value.docs;
        });
        for (var i = 0; value.docs.length > i; i++) {
          //  print(ListOfUsers[i]['EmployeeName']);
        }
      });
    }
  }

  void fetchdata() async {
    CollectionReference users = FirebaseFirestore.instance.collection('LeadCreation');
    SharedPreferences pref = await SharedPreferences.getInstance();
    // var userId = pref.getString("token");
    var userId = pref.getString("userID");
    print("userIDlkkk");
    print("userId");
    setState(() {
      userType = pref.getString("logintype");
    });
    print(userType);
    if (userType == "user") {
      users.where("userId", isEqualTo: userId).get().then((value) {
        setState(() {
          ListOfLeads = value.docs;
        });
        for (var i = 0; value.docs.length > i; i++) {
          print(value.docs[i].data());
        }
      });
    } else {
      users.get().then((value) {
        setState(() {
          ListOfLeads = value.docs;
        });
        for (var i = 0; value.docs.length > i; i++) {
          print(value.docs[i].data());
        }
      });
    }
  }

  void fetchLeadsdata() async {
    CollectionReference users = FirebaseFirestore.instance.collection('convertedLeads');
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userId = pref.getString("userID");
    setState(() {
      userType = pref.getString("logintype");
    });
    print(userType);
    if (userType == "user") {
      users.where("userId", isEqualTo: userId).get().then((value) {
        setState(() {
          ListOfConvertedLeads = value.docs;

        });
        for (var i = 0; value.docs.length > i; i++) {
          print(value.docs[i].data());
        }
      });
    } else {
      users.get().then((value) {
        setState(() {
          ListOfConvertedLeads = value.docs;
        });
        for (var i = 0; value.docs.length > i; i++) {
          print(value.docs[i].data());
        }

      });
    }
  }

  List<DocumentSnapshot> visits = [];
  DateTime fromDate = DateTime.now().subtract(Duration(days: 7));
  DateTime toDate = DateTime.now();

  // Function to fetch data from Firebase
  Future<void> fetchVisitData() async {
    // Implement Firebase query to fetch data from LeadCreation and convertedLeads collections
    QuerySnapshot leadCreationSnapshot = await FirebaseFirestore.instance
        .collection('LeadCreation')
        .where('createdDateTime',
        isGreaterThanOrEqualTo: fromDate,
        isLessThanOrEqualTo: toDate)
        .get();

    QuerySnapshot convertedLeadsSnapshot = await FirebaseFirestore.instance
        .collection('convertedLeads')
        .where('createdDateTime',
        isGreaterThanOrEqualTo: fromDate,
        isLessThanOrEqualTo: toDate)
        .get();

    setState(() {
      visits = leadCreationSnapshot.docs + convertedLeadsSnapshot.docs;
    });
  }

  // Function to process data and calculate daily visit counts
  Map<DateTime, int> calculateDailyVisits() {
    Map<DateTime, int> dailyVisits = {};
    for (var visit in visits) {
      DateTime visitDate = visit['createdDateTime'].toDate();
      DateTime normalizedDate =
      DateTime(visitDate.year, visitDate.month, visitDate.day);
      dailyVisits.update(normalizedDate, (value) => value + 1, ifAbsent: () => 1);
    }
    return dailyVisits;
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    fetchLeadsdata();
    fetchdata();
    fetchVisitData();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    int numberOfVisits = ListOfLeads.length;
    int numberOfLeadsConverted = ListOfConvertedLeads.length;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: StyleData.appBarColor2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: _image != null
                          ? ClipOval(
                        child: Image.file(
                          _image!,
                          width: 96,
                          height: 96,
                          fit: BoxFit.cover,
                        ),
                      )
                          : Icon(
                        Icons.person,
                        size: 40,
                        color: StyleData.appBarColor2,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.04,
                    ),
                Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                        children: [
                          TextSpan(
                            text: employeeName,
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // RichText(
                    //   text: TextSpan(
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 18.0,
                    //     ),
                    //     children: [
                    //       TextSpan(
                    //         text: employeeCode,
                    //         style: TextStyle(
                    //           fontWeight: FontWeight.w200,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),

                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.3,
            ),

            Center(
              child: Text(
                "Coming Soon"
              ),
            )
            // Center(
            //   child: Card(
            //     elevation: 4, // Adjust elevation as needed
            //     margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Adjust margin as needed
            //     child: Container(
            //       color: Colors.white,
            //       child: Padding(
            //         padding: const EdgeInsets.all(16.0),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               "Total Number of Visits: ",
            //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            //               // Adjust style as needed
            //             ),
            //             Text(
            //               "$numberOfVisits",
            //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: StyleData.appBarColor2),
            //               // Adjust style as needed
            //             ),
            //             SizedBox(height: 10),
            //             Text(
            //               "Leads Converted: ",
            //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            //               // Adjust style as needed
            //             ),
            //             Text(
            //               "$numberOfLeadsConverted",
            //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: StyleData.appBarColor2),
            //               // Adjust style as needed
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // )

          ],
        ),
      ),
    );
  }
}
