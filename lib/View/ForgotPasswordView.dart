import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lead_management_system/login1.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/StyleData.dart';
import '../background.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final passwordformKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  List<DocumentSnapshot> ListOfUsers = [];
  var userType;
  String? email;

  void getUserData(String email) async {
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
          print(ListOfUsers[i]['email']);
        }
      });
    } else {
      users.get().then((value) {
        setState(() {
          ListOfUsers = value.docs;
        });
        for (var i = 0; value.docs.length > i; i++) {
          print(ListOfUsers[i]['email']);
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Reset Password",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: StyleData.buttonColor,
                      fontSize: 36
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Form(
                key: passwordformKey,
                child: Column(
                  children: [
                    SizedBox(height: height * 0.03),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            labelText: "Useremail"
                        ),
                        onChanged: (value) {
                          getUserData(value);
                        },
                        validator: (value) {
                          String p =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                          RegExp regExp = RegExp(p);

                          if (!regExp.hasMatch(value!)) {
                            return "Enter valid email id";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height:height * 0.05),
              GestureDetector(
                onTap: () async {
                  print("Helloo");
                  if (passwordformKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Center(
                          child: SpinKitFadingCircle(
                            color: Colors.redAccent, // choose your preferred color
                            size: 50.0,
                          ),
                        );
                      },
                    );
                    FirebaseAuth.instance
                        .sendPasswordResetEmail(
                        email: emailController.text)
                        .then((_) {
                      //   EasyLoading.dismiss();
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) {
                            Future.delayed(const Duration(seconds: 3),
                                    () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const LoginScreen()),
                                  );
                                });
                            return Card(
                              color: Colors.white70,
                              borderOnForeground: true,
                              surfaceTintColor: Colors.white70,
                              child: Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(top: 30),
                                child: const AlertDialog(
                                  title: Text(
                                    "Password reset link has been successfully sent to your registered email",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            );
                          });
                    }).catchError((error) {
                      print(error);
                    });
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: width * 0.5,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                        gradient: new LinearGradient(
                            colors: [
                              //       Color.fromARGB(255, 255, 136, 34),
                              Color.fromARGB(255, 236, 139, 34),
                              Color.fromARGB(255, 255, 177, 41)
                            ]
                        )
                    ),
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      "Reset",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
