import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lead_management_system/Utils/StyleData.dart';
import 'package:lead_management_system/View/PendingLeadsPageView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'QueriesPageView.dart';
import 'SentForVerification.dart';
import 'VerifiedLeadsPageView.dart';


class ProfilePageView extends StatefulWidget {
  const ProfilePageView({super.key});

  @override
  State<ProfilePageView> createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  File? _image;
  List<DocumentSnapshot> ListOfLeads = [];
  List<DocumentSnapshot> ListOfLeads1 = [];
  List<DocumentSnapshot> ListOfUsers = [];
  List<DocumentSnapshot> ListOfConvertedLeads = [];
  var userType;
  String? employeeName;
  String? branchCode;
  String? employeeCode;
  int totalLeads = 0;
  int verifiedLeads = 0;
  int queryLeads = 0;
  int pendingLeads = 0;
  int sentForVerificationLeads = 0;
  DateTime? startDate;
  DateTime? endDate;

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

  void fetchLeadsdata() async {
    CollectionReference users =
    FirebaseFirestore.instance.collection('convertedLeads');
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userId = pref.getString("userID");
    setState(() {
      userType = pref.getString("logintype");
    });

    if (userType == "user") {
      QuerySnapshot querySnapshot =
      await users.where("userId", isEqualTo: userId).get();
      ListOfLeads = querySnapshot.docs;
      ListOfLeads1 = querySnapshot.docs;
    } else {
      QuerySnapshot querySnapshot = await users.get();
      ListOfLeads = querySnapshot.docs;
      ListOfLeads1 = querySnapshot.docs;
    }

    ListOfLeads.forEach((lead) {
      if (lead['VerificationStatus'] == "Verified" && lead["LeadID"].length > 1) {
        verifiedLeads++;
      } else if (lead['VerificationStatus'] == "Pending" && lead["LeadID"].length > 1) {
        pendingLeads++;
      }
      else if (lead['VerificationStatus'] == "Sent for Verification" && lead["LeadID"].length > 1) {
        sentForVerificationLeads++;

      }
    });

    ListOfLeads.forEach((lead) {
      if ( lead["LeadID"].length > 1 &&
          lead["VerificationStatus"] == "Pending" &&
          lead.data() is Map<String, dynamic> &&
          (lead.data() as Map<String, dynamic>).containsKey("Query") &&
          lead["Query"] != null) {
        queryLeads++;
      }
    });


    setState(() {
      totalLeads = verifiedLeads + pendingLeads + sentForVerificationLeads;
      ListOfConvertedLeads = ListOfLeads;
    });
  }

  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();

  Future<void> _selectDate(BuildContext context, int type) async {
    final DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now, // Set the initialDate to today
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue, // Your custom yellow color
            hintColor: Color(0xff973232),
            colorScheme: ColorScheme.light(primary: Color(0xff973232)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Color(0xff973232),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        if (type == 1) {
          _startDateController.text = formatDate(pickedDate.toLocal().toString());
          startDate = pickedDate;
        } else {
          _endDateController.text = formatDate(pickedDate.toLocal().toString());
          endDate = pickedDate;
        }
      });
    }
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

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    final formatter = DateFormat('yyyy-MM-dd');
    _startDateController.text = formatter.format(DateTime.now()) ;
    _endDateController.text = formatter.format(DateTime.now());
    fetchLeadsdata();
    super.initState();
  }

  Widget buildPieChart() {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: verifiedLeads.toDouble(),
            title: '${verifiedLeads.toString()} Verified',
            color: Colors.green,
            radius: 70,
            titleStyle: TextStyle(fontSize: 12, color: Colors.black),
          ),
          PieChartSectionData(
            value: pendingLeads.toDouble(),
            title: '${pendingLeads.toString()} Pending',
            color: Colors.orange,
            radius: 70,
            titleStyle: TextStyle(fontSize: 12, color: Colors.black),
          ),
          PieChartSectionData(
            value: sentForVerificationLeads.toDouble(),
            title: '${sentForVerificationLeads.toString()} Sent for Verification',
            color: Colors.amber,
            radius: 70,
            titleStyle: TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                  ],
                ),

                  ],
                ),
              ),
            ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       Padding(
                         padding: EdgeInsets.only(right: 8.0),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.end,
                           children: [
                             Container(
                               height: height * 0.04,
                               width: width * 0.4,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(30.0),
                                 gradient: LinearGradient(
                                   colors: [
                                     Color.fromARGB(255, 236, 225, 215),
                                     Color.fromARGB(255, 227, 222, 215)
                                   ],
                                 ),
                               ),
                               child: Padding(
                                 padding: EdgeInsets.symmetric(horizontal: 8.0),
                                 child: TextFormField(
                                   controller: _startDateController,
                                   readOnly: true,
                                   onTap: () => _selectDate(context, 1),
                                   decoration: InputDecoration(
                                     labelText: '',
                                     suffixIcon: Icon(Icons.calendar_today, size: 20,),
                                     focusedBorder: InputBorder.none,
                                     border: InputBorder.none,
                                   ),
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ),
                       Padding(
                         padding: EdgeInsets.only(right: 8.0),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.end,
                           children: [
                             Container(
                               height: height * 0.04,
                               width: width * 0.4,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(30.0),
                                 gradient: LinearGradient(
                                   colors: [
                                     Color.fromARGB(255, 236, 225, 215),
                                     Color.fromARGB(255, 227, 222, 215)
                                   ],
                                 ),
                               ),
                               child: Padding(
                                 padding: EdgeInsets.symmetric(horizontal: 8.0),
                                 child: TextFormField(
                                   controller: _endDateController,
                                   readOnly: true,
                                   onTap: () => _selectDate(context,2),
                                   decoration: InputDecoration(
                                       labelText: '',
                                       suffixIcon: Icon(Icons.calendar_today,size: 20,),
                                       border: InputBorder.none
                                   ),
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                   SizedBox(
                     height: height * 0.03,
                   ),
                   GestureDetector(
                     onTap: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) => VerifiedLeadsPageView(),
                         ),
                       );
                     },
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Row(
                         children: [
                           SizedBox(
                             width: width * 0.8,
                             child: Row(
                               children: [
                                 Text("Verified",style: TextStyle(
                                   fontSize: 18,
                                   fontWeight: FontWeight.w400,
                                   color: Colors.green
                                 ),),
                                 Card(
                                   child: Container(
                                     color: Colors.white,
                                     child: Padding(
                                       padding: const EdgeInsets.all(2.0),
                                       child: Text('${verifiedLeads.toString()}',style: TextStyle(
                                           fontSize: 18,
                                           fontWeight: FontWeight.w400,
                                           color: Colors.green
                                       ),),
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           ),
                           Icon(Icons.navigate_next)
                         ],
                       ),
                     ),
                   ),
                   Divider(thickness: 0.75,color: Colors.grey,indent: 2,),
                   GestureDetector(
                     onTap: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) => SentForVerification(),
                         ),
                       );
                     },
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Row(
                         children: [
                           SizedBox(
                             width:width * 0.8,
                             child: Row(
                               children: [
                                 Text("Sent for Verification",style: TextStyle(
                                     fontSize: 18,
                                     fontWeight: FontWeight.w400,
                                     color: Colors.amber
                                 ),),
                                 Card(
                                   child: Container(
                                     color: Colors.white,
                                     child: Padding(
                                       padding: const EdgeInsets.all(2.0),
                                       child: Text('${sentForVerificationLeads.toString()}',style: TextStyle(
                                           fontSize: 18,
                                           fontWeight: FontWeight.w400,
                                           color: Colors.green
                                       ),),
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           ),
                           Icon(Icons.navigate_next)
                         ],
                       ),
                     ),
                   ),
                   Divider(thickness: 0.75,color: Colors.grey,indent: 2,),
                   GestureDetector(
                     onTap: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) => PendingLeadsPageView(),
                         ),
                       );
                     },
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Row(
                         children: [
                           SizedBox(
                             width:width * 0.8,
                             child: Row(
                               children: [
                                 Text("Pending",style: TextStyle(
                                     fontSize: 18,
                                     fontWeight: FontWeight.w400,
                                     color: Colors.orangeAccent
                                 ),),
                                 Card(
                                   child: Container(
                                     color: Colors.white,
                                     child: Padding(
                                       padding: const EdgeInsets.all(2.0),
                                       child: Text('${pendingLeads.toString()}',style: TextStyle(
                                           fontSize: 18,
                                           fontWeight: FontWeight.w400,
                                           color: Colors.green
                                       ),),
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           ),
                           Icon(Icons.navigate_next)
                         ],
                       ),
                     ),
                   ),
                   Divider(thickness: 0.75,color: Colors.grey,indent: 2,),
                   GestureDetector(
                     onTap: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) => QueryPageView(),
                         ),
                       );
                     },
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Row(
                         children: [
                           SizedBox(
                             width:width * 0.8,
                             child: Row(
                               children: [
                                 Text("Queries",style: TextStyle(
                                     fontSize: 18,
                                     fontWeight: FontWeight.w400,
                                     color: StyleData.appBarColor2
                                 ),),
                                 Card(
                                   child: Container(
                                     color: Colors.white,
                                     child: Padding(
                                       padding: const EdgeInsets.all(2.0),
                                       child: Text('${queryLeads.toString()}',style: TextStyle(
                                           fontSize: 18,
                                           fontWeight: FontWeight.w400,
                                           color: Colors.green
                                       ),),
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           ),
                           Icon(Icons.navigate_next)
                         ],
                       ),
                     ),
                   ),
                   Divider(thickness: 0.75,color: Colors.grey,indent: 2,),
                   Text(
                     'Total Leads: $totalLeads',
                     style: TextStyle(
                       fontSize: 18.0,
                       fontWeight: FontWeight.w400,
                       color: Colors.black,
                       // Add more styling properties as needed
                     ),
                   ),
                   SizedBox(
                     height: height * 0.03,
                   ),
                   Center(
                     child: Text('Verification Status',
                       style: TextStyle(
                       fontSize: 16.0,
                       fontWeight: FontWeight.w400,
                       color: StyleData.appBarColor2,
                       // Add more styling properties as needed
                     ),),
                   ),
                   SizedBox(
                     height: height * 0.03,
                   ),
                   Center(
                     child: Container(
                       height: 200,
                       width: 200,
                       child: buildPieChart(),
                     ),
                   ),
                 ],
               ),
             ),
          ],
        ),
      ),
    );
  }



}
class LeadStatus {
  final String status;
  final int count;

  LeadStatus(this.status, this.count);
}
