import 'package:flutter/material.dart';

import 'StyleData.dart';

class CustomSnackBar{


  static errorSnackBarQ(String content,BuildContext context) {
    final snackdemo = SnackBar(
      content: Container(
          child: Row(
            children: [
              SizedBox(
                  height: 20,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/login_muthootlogo2.png',
                        color: StyleData.background,
                      ),
                      Image.asset(
                        'assets/images/login_muthootlogo.png',
                      //  color: Colors.white,
                      ),
                    ],
                  )),
              const SizedBox(
                width: 10,
              ),
              Text(
                content,
                style: const TextStyle(color: Colors.black,fontSize: 13),
              ),
            ],
          )),
      backgroundColor:content == "Feedback Successfully Submitted" ? Colors.green: StyleData.appBarColor2,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.all(5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackdemo);
  }

}