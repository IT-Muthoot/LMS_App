import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  Future<void> updateUserData(String employeeCode, String fcmToken) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    print("Employee Code: $employeeCode");

    try {
      var querySnapshot = await users
          .where("EmployeeCode", isEqualTo: employeeCode.toUpperCase())
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userId = querySnapshot.docs.first.id;
        print("User ID: $userId");

        // Update the user document with the FCM token
        await users.doc(userId).update({"FCMToken": fcmToken});
        print("User data updated successfully");
      } else {
        print("User with EmployeeCode $employeeCode not found");
      }
    } catch (error) {
      print("Error updating user data: $error");
    }
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

          body:  _screens[activeIndex],
        ),

      ),
    );
  }
}
