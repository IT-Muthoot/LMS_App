import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'View/ForgotPasswordView.dart';
import 'View/HomePageView.dart';
import 'View/RegisterPageView.dart';
import 'Utils/StyleData.dart';
import 'View/formPageVIiew.dart';
import 'background.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String? accessToken;
  bool isPasswordVisible = false;

  Future<String?> getAccessToken(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: SpinKitFadingCircle(
            color: Colors.white,
            size: 50.0,
          ),
        );
      },
    );
    var headers = {
      'X-PrettyPrint': '1',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'BrowserId=qnhrXMyBEe6lOh9ncfvoTw; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var data = {
      'grant_type': 'password',
      'client_id': '3MVG9WZIyUMp1ZfoWDelgr4puVA8Cbw2py9NcKnfiPbsdxV6CU1HXQssNTT2XpRFqPmQ8OX.F4ZbP_ziL2rmf',
      'client_secret': '4382921A497F5B4DED8F7E451E89D1228EE310F729F64641429A949D53FA1B84',
      'username': 'salesappuser@muthoothomefin.com',
      'password': 'Pass@123456F7aghs4Z5RxQ5hC2pktsSLJfq'
    };
    var dio = Dio();
    var response = await dio.request(
      'https://muthootltd.my.salesforce.com/services/oauth2/token',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {

      String jsonResponse = json.encode(response.data);
      Map<String, dynamic> jsonMap = json.decode(jsonResponse);
     accessToken = jsonMap['access_token'];

      // Store the access token locally
      saveAccessToken(accessToken!);
      print("AccessToken");
      print(accessToken);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePageView(),
        ),
      );
    }
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter correct credentials'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } finally {
      Navigator.pop(context); // Disabling the loader
      print(response.statusMessage);
    }
  }

  // Function to save the access token
  Future<void> saveAccessToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', token);
    print("Stored Access token");
    print(token);
  }


  void retrieveStoredCredentials() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? storedEmployeeCode = pref.getString("employeeCode");
    String? storedPassword = pref.getString("password");

    if (storedEmployeeCode != null && storedPassword != null) {
      empCodeController.text = storedEmployeeCode;
      passwordController.text = storedPassword;
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    retrieveStoredCredentials();
    super.initState();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController empCodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final loginformKey = GlobalKey<FormState>();

  UnderlineInputBorder enb =  UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:   const BorderSide(color:  Colors.black38)
  );
  UnderlineInputBorder focus =  UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:  const BorderSide(color: Color(0xff778287))
  );
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
                  "LOGIN",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: StyleData.buttonColor,
                      fontSize: 36
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              SizedBox(height:height * 0.03),
                Form(
                  key: loginformKey,
                  child: Column(
                    children: [
                      // Container(
                      //   alignment: Alignment.center,
                      //   margin: EdgeInsets.symmetric(horizontal: 40),
                      //   child: TextFormField(
                      //     controller: emailController,
                      //     style: const TextStyle(fontSize: 13,color: Colors.black54),
                      //     textInputAction: TextInputAction.next,
                      //     cursorColor: Colors.black87,
                      //     decoration: InputDecoration(
                      //         labelText: "Useremail",
                      //       labelStyle: TextStyle(
                      //         fontSize: 16,
                      //         color: Colors.black54
                      //       ),
                      //
                      //    prefixIcon: Icon(Icons.email_outlined,size: 18,color: Colors.black54),
                      //       focusedBorder: focus,
                      //       enabledBorder: enb,
                      //       contentPadding: const EdgeInsets.only(left: 5,),
                      //       hintStyle: const TextStyle(fontSize: 14,color: Colors.black54),
                      //     ),
                      //     validator: (value) {
                      //       String p =
                      //           r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      //
                      //       RegExp regExp = RegExp(p);
                      //
                      //       if (!regExp.hasMatch(value!)) {
                      //         return "Enter valid email id";
                      //       }
                      //
                      //       return null;
                      //     },
                      //   ),
                      // ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          controller: empCodeController,
                          inputFormatters: [
                            FilteringTextInputFormatter.singleLineFormatter,
                            LengthLimitingTextInputFormatter(7),
                            // Convert input to uppercase
                            UppercaseTextInputFormatter(),
                          ],
                          style: const TextStyle(fontSize: 13, color: Colors.black54),
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.black87,
                          decoration: InputDecoration(
                            labelText: "Employee Code",
                            labelStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                            prefixIcon: Icon(Icons.person_3_outlined, size: 18, color: Colors.black54),
                            focusedBorder: focus,
                            enabledBorder: enb,
                            contentPadding: const EdgeInsets.only(left: 5,),
                            hintStyle: const TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                          validator: (isusercodevalid) {
                            if (isusercodevalid.toString().isNotEmpty)
                              return null;
                            else
                              return 'Enter valid Employee code';
                          },
                        ),
                      ),

                      SizedBox(height:height * 0.03),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          controller: passwordController,
                          style: const TextStyle(fontSize: 13, color: Colors.black54),
                          cursorColor: Colors.black87,
                          decoration: InputDecoration(
                            focusedBorder: focus,
                            enabledBorder: enb,
                            labelText: "Password",
                            prefixIcon: Icon(Ionicons.lock_closed_outline, size: 18, color: Colors.black54),
                            contentPadding: const EdgeInsets.only(left: 5,),
                            hintStyle: const TextStyle(fontSize: 14, color: Colors.black54),
                            labelStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                color: Colors.black54,
                              ),
                              onPressed: () {
                                // Toggle the password visibility
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          obscureText: !isPasswordVisible,
                          validator: (isPasswordValid) {
                            if (isPasswordValid.toString().isNotEmpty)
                              return null;
                            else if (isPasswordValid!.length < 8) {
                              return 'Password must contain at least 8 characters';
                            } else
                              return 'Enter a valid password';
                          },
                        ),
                      ),
                    ],
                  ),
                ),


              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const ForgotPasswordView()),
                  );
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    "Forgot your password?",
                    style: TextStyle(
                      fontSize: 12,
                      color: StyleData.buttonColor,
                    ),
                  ),
                ),
              ),

              SizedBox(height:height * 0.05),

              GestureDetector(
                onTap: () async {
                  if (loginformKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Center(
                          child: SpinKitFadingCircle(
                            color: Colors.redAccent,
                            size: 50.0,
                          ),
                        );
                      },
                    );
                      SharedPreferences pref = await SharedPreferences.getInstance();
                    CollectionReference users = FirebaseFirestore.instance.collection('users');
                    print('Employee Code from controller: ${empCodeController.text}');
                         users.where("EmployeeCode", isEqualTo: empCodeController.text.toUpperCase())
                          .where("password", isEqualTo: passwordController.text)
                          .get()
                          .then((value)  {
                           print('Query snapshot: ${value.docs}');
                      if (value.docs.isNotEmpty) {
                            //  pref.setString("token", credential.user!.uid);
                              pref.setString("logintype",
                                  value.docs[0].get("userType") ?? "user");
                              pref.setString("userID", value.docs[0].get("userId"));
                             pref.getString("userID") ?? "";
                              print("USERIDPrint");
                            //  print(userId);
                       pref.setString("password", passwordController.text);
                       pref.setString("employeeCode", empCodeController.text);
                        getAccessToken(context);
                        print('Document exists with employee code: $empCodeController');
                      } else {
                        Navigator.pop(context);
                        customSuccessSnackBar("Enter valid credentials");
                      }
                    }).catchError((error) {
                      print('Error getting document: $error');
                    });
                    // try {
                    //   final credential = await FirebaseAuth.instance
                    //       .signInWithEmailAndPassword(
                    //       email: emailController.text,
                    //       password: passwordController.text);
                    //   if (credential.user!.uid != null) {
                    //     CollectionReference users = FirebaseFirestore
                    //         .instance
                    //         .collection('users');
                    //     users.where("userId", isEqualTo: credential.user!.uid).get()
                    //         .then((value) async {
                    //       print(value.docs[0].data());
                    //       SharedPreferences pref = await SharedPreferences.getInstance();
                    //       pref.setString("token", credential.user!.uid);
                    //       pref.setString("logintype",
                    //           value.docs[0].get("userType") ?? "user");
                    //       pref.setString("email", emailController.text);
                    //       pref.setString("password", passwordController.text);
                    //      getAccessToken(context);
                    //     });
                    //   }
                    // } on FirebaseAuthException catch (e) {
                    //   Navigator.pop(context);
                    //   if (e.code == 'user-not-found') {
                    //   } else if (e.code == 'wrong-password') {
                    //   }
                    //   customSuccessSnackBar("Enter valid credentials");
                    // }
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
                              // Color.fromARGB(255, 168, 2, 2),
                              // Color.fromARGB(255, 206, 122, 122)
                              Color.fromARGB(255, 255, 136, 34),
                              Color.fromARGB(255, 255, 177, 41)
                            ]
                        )
                    ),
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      "LOGIN",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()))
                  },
                  child: Text(
                    "Don't Have an Account? Sign up",
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
    print(msg);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: '',
          onPressed: () {
            // Code to execute.
          },
        ),
        content: Container(
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
                      Icons.error_outline_sharp,
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
        duration: const Duration(seconds: 3),
        // width:MediaQuery.of(context).size. width * 0.9, // Width of the SnackBar.
        // padding: const EdgeInsets.symmetric(
        //   horizontal: 8.0, // Inner padding for SnackBar content.
        // ),
        // behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor:StyleData.appBarColor2,
        // backgroundColor: const Color(0xffee5b5b),
      ),
    );
  }
}

class UppercaseTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text!.toUpperCase(),
      selection: newValue.selection,
    );
  }
}