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
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  List<DocumentSnapshot> ListOfUsers = [];
  var userType;
  String? email;
  bool isEmailExist= false;

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

  void checkIfEmailExists() {
    // Check if entered email is present in the list
    bool emailExists = ListOfUsers.any((user) => user['email'] == emailController.text);

    if (emailExists) {
      setState(() {
        isEmailExist = true;
      });
      customSuccessSnackBar("The email Id exists");
      // Show password text field or perform other actions as needed
      print("Email exists!");
    } else {
      customSuccessSnackBar("The email Id does not exists");
      // Email not found, handle accordingly
      print("Email does not exist!");
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    getUserData();
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        // SimpleHiddenDrawerController.of(context).open();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LoginScreen(),
                          ),
                        );

                      },
                      child:  Container(
                        child: Image.asset(
                          'assets/images/arrow.png',
                          color: StyleData.appBarColor2,
                        ),
                      ),),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        "Reset Password",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: StyleData.buttonColor,
                            fontSize: 30
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02,),
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
                        decoration: InputDecoration(labelText: "Useremail"),
                        readOnly: isEmailExist == false ? false : true,
                        onChanged: (value) {
                          // checkIfEmailExists(value);
                        },
                        validator: (value) {
                          // Your email validation logic
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Visibility(
                      visible: isEmailExist == false,
                      child: GestureDetector(
                        onTap: () {
                          checkIfEmailExists();
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            "Verify",
                            textAlign: TextAlign.center,

                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible:isEmailExist == true ,
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: "Password *",
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
                          validator: (ispasswordvalid) {
                            if (ispasswordvalid.toString().isNotEmpty)
                              return null;
                            else
                              return 'Enter valid password';
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible:isEmailExist == true ,
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          controller: confirmpasswordController,
                          decoration: InputDecoration(
                            labelText: "Confirm Password *",
                            suffixIcon: IconButton(
                              icon: Icon(
                                isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                color: Colors.black54,
                              ),
                              onPressed: () {
                                // Toggle the password visibility
                                setState(() {
                                  isConfirmPasswordVisible = !isConfirmPasswordVisible;
                                });
                              },
                            ),
                          ),
                          obscureText: !isConfirmPasswordVisible,
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
                    ),
                  ],
                ),
              ),
              SizedBox(height:height * 0.05),
              Visibility(
                visible: isEmailExist == true,
                child: GestureDetector(
                  onTap: () async {
                    print("Helloo");
                    if (passwordformKey.currentState!.validate() &&
                        passwordController.text == confirmpasswordController.text) {
                      CollectionReference users =
                      FirebaseFirestore.instance.collection("users");
                      DateTime now = DateTime.now();
                      print("Hello");
                      try {
                        Map<String, dynamic> params = {
                          'password': passwordController.text,
                          'confirmPassword': confirmpasswordController.text,
                          'updatedTime': Timestamp.fromDate(now),
                        };
                        users
                            .where('email', isEqualTo: emailController.text)
                            .get()
                            .then((querySnapshot) {
                          if (querySnapshot.docs.isNotEmpty) {
                            print(querySnapshot.docs.isNotEmpty);
                            users.doc(querySnapshot.docs.first.id).update(params).then((value) {
                              customSuccessSnackBar1("Password Reset successfully");
                              print("Data updated to Visits successfully");

                              // Navigate to LoginScreen after successful update
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            }).catchError((error) {
                              print("Failed to update data: $error");
                            });
                          } else {
                            // Handle the case where the email is not found
                            customSuccessSnackBar("Email not found");
                          }
                        }).catchError((error) {
                          print("Failed to update password: $error");
                        });
                      } catch (e) {
                        print(e);
                      }
                    } else {
                      // Show a snackbar or handle the case where passwords don't match
                      customSuccessSnackBar("Password & Confirm password don't match");
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
              ),
            ],
          ),
        ),
      ),
    );
  }
  void customSuccessSnackBar1(String msg) {
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
                      Icons.done_outline,
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
        backgroundColor: Colors.green,
        // backgroundColor: const Color(0xffee5b5b),
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
