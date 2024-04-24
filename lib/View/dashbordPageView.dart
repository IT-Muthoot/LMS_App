import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lead_management_system/Utils/StyleData.dart';
import 'package:lead_management_system/View/formPageVIiew.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginPageView.dart';
import 'ApplicantDetailsView.dart';
import 'NewLeadPageView.dart';
import 'VisitPageView.dart';

class DashboardPageView extends StatefulWidget {
  const DashboardPageView({super.key});

  @override
  State<DashboardPageView> createState() => _DashboardPageViewState();
}

class _DashboardPageViewState extends State<DashboardPageView> {

  List<DocumentSnapshot> ListOfLeads = [];
  List<DocumentSnapshot> ListOfSavedLeads = [];
  List<DocumentSnapshot> ListOfUsers = [];
  var userType;
  String? employeeName;
  String? branchCode;
  ScrollController _scrollController = ScrollController();

  void fetchdata() async {
    CollectionReference users = FirebaseFirestore.instance.collection('LeadCreation');
    SharedPreferences pref = await SharedPreferences.getInstance();
  //  var userId = pref.getString("token");
    var userId = pref.getString("userID");
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
         // print(value.docs[i].data());
         //     log(value.docs[i].data().toString());
          // print("hgdhgjd");
          // print(ListOfUsers[i]['EmployeeName']);
          if( pref.getString("employeeCode") == ListOfUsers[i]['EmployeeCode'])
            {
              setState(() {
            //    print("jhkjlkada");
                employeeName = ListOfUsers[i]['EmployeeName'];
                branchCode = ListOfUsers[i]['branchCode'];
                pref.setString("branchcode", ListOfUsers[i]['branchCode']);
                pref.setString("employeeName", ListOfUsers[i]['EmployeeName']);

                pref.setString("managerName", ListOfUsers[i]['ManagerName']);
                pref.setString("ManagerCode", ListOfUsers[i]['ManagerCode']);
                pref.setString("Region", ListOfUsers[i]['Region']);
                pref.setString("Zone", ListOfUsers[i]['Zone']);
                pref.setString("designation", ListOfUsers[i]['designation']);
                // print("EMployee Name");
                // print(employeeName);
                // print(branchCode);
                // print(pref.getString("ManagerCode"));
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

  void fetchSaveddata() async {
    CollectionReference users = FirebaseFirestore.instance.collection('convertedLeads');
    SharedPreferences pref = await SharedPreferences.getInstance();
    //  var userId = pref.getString("token");
    var userId = pref.getString("userID");
    setState(() {
      userType = pref.getString("logintype");
    });
    print(userType);
    if (userType == "user") {
      users.where("userId", isEqualTo: userId).get().then((value) {
        setState(() {
          ListOfSavedLeads = value.docs;
        });
        for (var i = 0; value.docs.length > i; i++) {
          print(value.docs[i].data());
        }
      });
    } else {
      users.get().then((value) {
        setState(() {
          ListOfSavedLeads = value.docs;
        });
        for (var i = 0; value.docs.length > i; i++) {
          print(value.docs[i].data());
        }
      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    fetchdata();
    fetchSaveddata();
   // getdata();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body:SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: height * 0.089,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: StyleData.buttonColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/login_muthootlogo.png',
                              width: width * 0.1,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.logout_sharp,
                                color: Colors.white,
                                size: 25.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                       // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Welcome! ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // WidgetSpan(
                                //   child: SizedBox(height: 8), // Add some space between the lines
                                // ),
                                TextSpan(
                                  text: employeeName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ],
                            ),
                          ),
            
                          // SizedBox(
                          //   width: width * 0.1,
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02,),
                SizedBox(
                  width: width * 2,
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FormPageView(),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color:  Colors.white,
                                child: Container(
                                  width: width * 0.4,
                                  height: height * 0.15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 60,
                                          child: Image.asset(
                                            'assets/images/Visit.png',
                                            width: 60,
                                            height: 40,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Visit Form',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.015,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ApplicantDetailsView(),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color:  Colors.white,
                                child: Container(
                                  width: width * 0.4,
                                  height: height * 0.15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 60,
                                          child: Image.asset(
                                            'assets/images/leads1.png',
                                            width: 40,
                                            height: 40,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Applicant details',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.015,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Latest Visits",
                        style:TextStyle(
                          fontSize: 18,
                          color:Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  VisitPageView(),
                            ),
                          );
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                              fontSize: 12,
                              color:Colors.blue,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.42,
                  width: MediaQuery.of(context).size.width,
                  child:ListOfLeads.isNotEmpty ?
                  Scrollbar(
                    thickness: 8.5,
                    thumbVisibility: true,
                    controller: _scrollController,
                    child:
            
                    ListView.builder(
                      controller: _scrollController,
                      itemCount: ListOfLeads.length > 4 ? 4 : ListOfLeads.length,
                      itemBuilder: (context, index) {
                        ListOfLeads.sort((a, b) => DateTime.parse(b['visitDate']).compareTo(DateTime.parse(a['visitDate'])));
                        return (ListOfLeads[index]["LeadID"] ?? "").length <= 1 ?
                        // && ListOfLeads[index]["customerStatus"] == "Interested"
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewLeadPageView(
                                        isNewActivity: false,
                                        isUpdateActivity: true,
                                        docId: ListOfLeads[index].id,
                                        visitId: ListOfLeads[index]["visitID"],
                                     //   saveddocId: ListOfSavedLeads[index].id,
                                      )
                                  ));
                            },
                            child: Card(
                            elevation: 0.5,
                            child: Container(
                              color: Colors.white,
                              margin: EdgeInsets.all(8),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text("Name : ",
                                                style: TextStyle(fontSize: 15, color: Colors.blueGrey, // Optional: Set the underline color
                                                )),
                                            Text(ListOfLeads[index]["firstName"] + " " + ListOfLeads[index]["lastName"],
                                                style: TextStyle(fontSize: 16, color: StyleData.appBarColor,decoration: TextDecoration.underline,decorationColor: StyleData.appBarColor, // Optional: Set the underline color
                                                  decorationThickness: 1.0, decorationStyle: TextDecorationStyle.solid,)),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Icon(Icons.calendar_month),
                                            Text("Visit Date :", style: TextStyle(fontSize: 15, color: Colors.blueGrey, )),
                                            Text(
                                            formatDate(ListOfLeads[index]["visitDate"])
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("Customer Status : ",
                                                style: TextStyle(fontSize: 15, color: Colors.blueGrey, // Optional: Set the underline color
                                                )),
                                            Text( ListOfLeads[index]["customerStatus"] ?? "",
                                                style: TextStyle(fontSize: 16, color: Colors.black,)),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("Visit ID : ",
                                                style: TextStyle(fontSize: 15, color: Colors.blueGrey, // Optional: Set the underline color
                                                )),
                                            Text( ListOfLeads[index]["visitID"] ?? "",
                                                style: TextStyle(fontSize: 16, color: Colors.black,)),
                                          ],
                                        ),
                                      ],
                                    ),
                                 //   (ListOfLeads[index]["LeadID"] ?? "").length <= 1 ?
                                    Positioned(
                                      top: 10,
                                      right: 20,
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/next.png',
                                            width: 30,
                                          ),
                                          Text(
                                            'Convert',
                                            style: TextStyle(fontSize: 12,color: StyleData.appBarColor,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    )
                                    //     :
                                    // Positioned(
                                    //   top: 10,
                                    //   right: 20,
                                    //   child: Column(
                                    //     children: [
                                    //       Image.asset(
                                    //         'assets/images/Correct.png',
                                    //         width: 25,
                                    //       ),
                                    //       Text(
                                    //         'Converted',
                                    //         style: TextStyle(fontSize: 12,color: StyleData.appBarColor,fontWeight: FontWeight.bold),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                                                  ),
                          ) : SizedBox.shrink();
                      },
                    ),
                  )
                      : Center(
                        child: const Text(
                                          'No results found',
                                          style: TextStyle(fontSize: 20),
                                        ),
                      ),
                ),
              ],
            ),
          ),


      )
    );
  }
  String formatDate(String dateString) {
    try {
      // Assuming dateString is in the format 'yyyy-MM-dd HH:mm:ss.SSS'
      DateTime date = DateTime.parse(dateString);

      final formatter = DateFormat('yyyy-MM-dd');
      return formatter.format(date);
    } catch (e) {
      print("Error parsing date: $e");
      return " --";
    }
  }
}
