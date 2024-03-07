import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/StyleData.dart';
import '../background.dart';
import '../login1.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController empNameController = TextEditingController();
  TextEditingController empCodeController = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController branchcode = TextEditingController();
  final registerformKey = GlobalKey<FormState>();

  final List<String> userType = [
    'RO',
    'RM',
  ];
  String? selectedUserType;


  List<DocumentSnapshot> ListOfUsers = [];
  var userType1;
  String? employeeName;

  Future<void> checkEmployeeCode(String enteredCode) async {
    try {
      DocumentSnapshot employeeListDoc =
      await FirebaseFirestore.instance.collection('employeeList').doc(enteredCode).get();
       print(employeeListDoc);
      if (employeeListDoc.exists) {
        // Assuming 'branchCode' is the field in the document containing the branch code
        setState(() {
          branchcode = employeeListDoc['branchCode'];
          print(branchcode);
        });
        // Employee code found, do something with the branch code
        print('Branch Code: $branchcode');
      } else {
        print('Employee code not found in employeeList collection');
        // Handle the case where the employee code is not found
      }
    } catch (e) {
      print('Error: $e');
    }
  }



  @override
  void initState() {
    // TODO: implement initState
   // fetchData();
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
                  "REGISTER",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: StyleData.buttonColor,
                      fontSize: 36
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Form(
                key: registerformKey,
                child: Column(
                  children: [
                    SizedBox(height: height * 0.03),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        controller: empCodeController,
                        decoration: InputDecoration(
                            labelText: "Employee Code *"
                        ),
                        onChanged: (value) {
                          checkEmployeeCode(value);
                        },
                        validator: (isusernamevalid) {
                          if (isusernamevalid.toString().isNotEmpty)
                            return null;
                          else
                            return 'Enter valid Employee code';
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        controller: empNameController,
                        readOnly: true,
                        decoration: InputDecoration(
                            labelText: "Employee Name *"
                        ),
                        // validator: (isusernamevalid) {
                        //   if (isusernamevalid.toString().isNotEmpty)
                        //     return null;
                        //   else
                        //     return 'Enter valid user name';
                        // },
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        controller: branchcode,
                        readOnly: true,
                        decoration: InputDecoration(
                            labelText: "Branch Code *"
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        controller: mobileNumber,
                        decoration: InputDecoration(
                            labelText: "Mobile Number *"
                        ),
                        validator: (isusernamevalid) {
                          if (isusernamevalid.toString().isNotEmpty)
                            return null;
                          else
                            return 'Enter valid mobile Number';
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            labelText: "Useremail *"
                        ),
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
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            labelText: "Password *"
                        ),
                        obscureText: true,
                        validator: (ispasswordvalid) {
                          if (ispasswordvalid.toString().isNotEmpty)
                            return null;
                          else
                            return 'Enter valid password';
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        controller: confirmpasswordController,
                        decoration: InputDecoration(
                            labelText: "Confirm Password *"
                        ),
                        obscureText: true,
                        validator: (isconfirmpasswordvalid) {
                          if (isconfirmpasswordvalid.toString().isNotEmpty)
                            return null;
                          else if (passwordController !=
                              confirmpasswordController) {
                            return 'Confirm password must match to the password';
                          } else
                            return 'Enter valid confirm password';
                        },
                      ),
                    ),
                    SizedBox(height: height * 0.05),
                  ],
                ),
              ),
             

              GestureDetector(
                onTap: () async {
                  print("Helloo");
                  if (registerformKey.currentState!.validate()) {
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
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      print("Helloo");
                      if (credential.user!.uid != "") {
                        CollectionReference users = FirebaseFirestore
                            .instance
                            .collection('users');

                        Map<String, dynamic> params = {
                          "EmployeeName": empNameController.text,
                          "EmployeeCode": empCodeController.text,
                          "MobileNumber": mobileNumber.text,
                          "email": emailController.text,
                          "password": passwordController.text,
                          "userId": credential.user!.uid,
                          "createdDate": Timestamp.now(),
                          "userType": "user",
                        };
                        users.add(params);
                        customSuccessSnackBar("Registered Successfully");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                        Navigator.pop(context);
                      }
                      Navigator.pop(context);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        customSuccessSnackBar("The password provided is too weak.");
                      } else if (e.code == 'email-already-in-use') {
                        customSuccessSnackBar("The account already exists for that email.");
                      }
                      Navigator.pop(context);
                    } catch (e) {
                      customSuccessSnackBar("Something went wrong, try again later");
                      print(e);
                    }
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
                      "SIGN UP",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: GestureDetector(
                  onTap: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()))
                  },
                  child: Text(
                    "Already Have an Account? Sign in",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: StyleData.buttonColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void customSuccessSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: '',
          onPressed: () {
            // Code to execute.
          },
        ),
        content: Container(

          // margin: const EdgeInsets.only(left: 10),
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.white)
          // ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 27,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white)
                    ),
                    child: const Icon(
                      Icons.error_rounded,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      width: 230,
                      child: Text(msg)),
                  const SizedBox(
                    width: 10,
                  ),

                  // Icon(Icons.done,color: Colors.white,)
                ])),
        duration: const Duration(seconds: 2),
        // width:MediaQuery.of(context).size. width * 0.9, // Width of the SnackBar.
        // padding: const EdgeInsets.symmetric(
        //   horizontal: 8.0, // Inner padding for SnackBar content.
        // ),
        // behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: const Color(0xfff88405),
        // backgroundColor: const Color(0xffee5b5b),
      ),
    );
  }
}
