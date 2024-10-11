import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lead_management_system/Model/Response/DropDownModel.dart';
import 'package:lead_management_system/Utils/StyleData.dart';
import 'package:lead_management_system/View/ApplicantDetailsView.dart';
import 'package:lead_management_system/View/VisitPageView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ProfilePageView.dart';
import 'dashbordPageView.dart';
import 'formPageVIiew.dart';

class HomePageView extends StatefulWidget {
  final String Token;
  const HomePageView({super.key,required this.Token,});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {



  int activeIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final List<Widget> _screens = [
    DashboardPageView(),
    //FormPageView(),
    VisitPageView(),
    ProfilePageView(),
  ];

  FirebaseMessaging _fcm = FirebaseMessaging.instance;
  String? FCMToken;

  Future<void> initialize() async {

    await _fcm.requestPermission();
    FCMToken = await _fcm.getToken();
    print('Token : $FCMToken');
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("fcmToken", FCMToken.toString());

    updateUserData(pref.getString("employeeCode") ?? "", pref.getString("fcmToken") ?? "");

  }

  // Future<void> updateUserData(String employeeCode, String fcmToken) async {
  //   CollectionReference users = FirebaseFirestore.instance.collection('users');
  //   print("Employee Code: $employeeCode");
  //
  //   try {
  //     var querySnapshot = await users
  //         .where("EmployeeCode", isEqualTo: employeeCode.toUpperCase())
  //         .get();
  //
  //     if (querySnapshot.docs.isNotEmpty) {
  //       var userId = querySnapshot.docs.first.id;
  //     //  print("User ID: $userId");
  //
  //       // Update the user document with the FCM token
  //       await users.doc(userId).update({"FCMToken": fcmToken});
  //       print("User data updated successfully");
  //     } else {
  //       print("User with EmployeeCode $employeeCode not found");
  //     }
  //   } catch (error) {
  //     print("Error updating user data: $error");
  //   }
  // }

  List employeeList = [];
  List outputList1 = [];
  var branchName;


  Future<void> updateUserData(String employeeCode, String fcmToken) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("Employee Code: $employeeCode");

    try {
      var querySnapshot = await users
          .where("EmployeeCode", isEqualTo: employeeCode.toUpperCase())
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs.first;
        var userId = userDoc.id;

        // Fetch EmployeeName, branchCode, Region
        var employeeName = userDoc['EmployeeName'];
        var employeeCode = userDoc['EmployeeCode'];
        var branchCode = userDoc['branchCode'];
        var region = userDoc['Region'];

        // Store the values in SharedPreferences
        await pref.setString("employeeName", employeeName);
        await pref.setString("empCode", employeeCode);
        await pref.setString("branchCode", branchCode);
        await pref.setString("region", region);

        print("Employee Name: $employeeName");
        print("Employee Code: $employeeCode");
        print("Branch Code: $branchCode");
        print("Region: $region");

        // Update the user document with the FCM token
        await users.doc(userId).update({"FCMToken": fcmToken});
        print("User data updated successfully");

        FirebaseFirestore.instance
            .collection("employeeMapping")
            .doc("employeeMapping")
            .get()
            .then((value) async {
          for (var element in value.data()!["employeeMapping"]) {
            setState(() {
              employeeList.add(element);
            });
          }

          setState(()  {
            outputList1 =
                employeeList.where((o) => o['EMP_CODE'] == employeeCode).toList();
            branchName = outputList1[0]['BRANCH'];
            print('Branch Name $branchName');
          });
          _storeBranchName(branchName);
        });
      } else {
        print("User with EmployeeCode $employeeCode not found");
      }
    } catch (error) {
      print("Error updating user data: $error");
    }
  }

  Future<void> _storeBranchName(String branchName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("branchName", branchName);
  }








  @override
  void initState() {
    // TODO: implement initState

    initialize();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        // Close the app when back button is pressed
        SystemNavigator.pop();
        return false; // Prevent default back button behavior
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Color.fromRGBO(245, 247, 249, 1),
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Color.fromRGBO(245, 247, 249, 1),
            index: 0,
            height: 50.0,
            items: <Widget>[
              Icon(Icons.home, size: 30),
              Icon(Icons.search, size: 30),
              Icon(Icons.view_list_sharp, size: 30),
            ],
            buttonBackgroundColor:  Color.fromARGB(255, 255, 136, 34),
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                activeIndex = index;
                switch (index) {
                  case 0:
                  // Home Screen
                    break;
                  case 1:
                  // Search Screen
                    break;
                  case 2:
                  // Favorite Screen
                    break;
                  case 3:
                  // Profile Screen
                    break;
                }
              });
            },
          ),

          body:_screens[activeIndex],
        ),

      ),
    );
  }
}
