import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lead_management_system/Utils/StyleData.dart';
import 'package:lead_management_system/View/ApplicantDetailsView.dart';
import 'package:lead_management_system/View/VisitPageView.dart';
import 'ProfilePageView.dart';
import 'dashbordPageView.dart';
import 'formPageVIiew.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

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


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(  onWillPop: () => Future.value(false),

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
              Icon(Icons.settings, size: 30),
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
