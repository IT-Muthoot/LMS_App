import 'package:flutter/material.dart';
import 'package:lead_management_system/Utils/StyleData.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
                "assets/images/top1.png",
                color: StyleData.appBarColor2,
                width: size.width
              // width: double.infinity,
              // fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
                "assets/images/top2.png",
                color: StyleData.appBarColor2,
                width: size.width
            ),
          ),
          Positioned(
            top: 50,
            left: 30,
            child: Image.asset(
                "assets/images/login_muthootlogo.png",
                width: size.width * 0.1
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
                "assets/images/bottom1.png",
                color: StyleData.appBarColor2,
                width: size.width
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
                "assets/images/bottom2.png",
                color: StyleData.appBarColor2,
                width: size.width
            ),
          ),
          child
        ],
      ),
    );
  }
}