// import 'dart:convert';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hexcolor/hexcolor.dart';
//
// import '../Utils/NavigatorController.dart';
// import '../Utils/StyleData.dart';
// import 'NewVisitForm.dart';
// import 'formPageVIiew.dart';
//
//
// class LoginPageView extends StatefulWidget {
//   const LoginPageView({super.key});
//
//   @override
//   State<LoginPageView> createState() => _LoginPageViewState();
// }
//
// class _LoginPageViewState extends State<LoginPageView> {
//   TextEditingController email = TextEditingController();
//   TextEditingController password = TextEditingController();
//
//   Future<String?> getAccessToken() async {
//     var headers = {
//       'X-PrettyPrint': '1',
//       'Content-Type': 'application/x-www-form-urlencoded',
//       'Cookie': 'BrowserId=qnhrXMyBEe6lOh9ncfvoTw; CookieConsentPolicy=0:0; LSKey-c\$CookieConsentPolicy=0:0'
//     };
//     var data = {
//       'grant_type': 'password',
//       'client_id': '3MVG9u0ll7_j5qFxuFGIYQ4WguPM0jYjSJXprZRrAAOaI8q0BVKqxCt1dzjQ0tti3JDqnTeGjj1Dk7v9.QwnQ',
//       'client_secret': 'ED297E5AD800E43B413260D0C4C7CFA7F49D11CE440F2EBC88220064B32D51CD',
//       'username': 'itkrishnaprasad@muthootgroup.com',
//       'password': 'Karthikrishna@12y7630AbZERemUschpI8nDyy4d'
//     };
//     var dio = Dio();
//     var response = await dio.request(
//       'https://test.salesforce.com/services/oauth2/token',
//       options: Options(
//         method: 'POST',
//         headers: headers,
//       ),
//       data: data,
//     );
//
//     if (response.statusCode == 200) {
//       String accessToken = json.encode(response.data);
//       print(accessToken);
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => FormPageView(accessToken: accessToken),
//         ),
//       );
//     }
//     else {
//       print(response.statusMessage);
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return SafeArea(
//       child: Scaffold(
//           body: Stack(
//            children: [
//           Align(
//             alignment: Alignment.topRight,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Container(
//                 height: height * 0.035,
//                 child: Image.asset(
//                           'assets/images/login_muthootlogo.png',
//                         ),
//               ),
//             ),
//           ),
//              // Column(
//              //   mainAxisAlignment: MainAxisAlignment.start,
//              //   children: [
//              //     SizedBox(
//              //       height: height * 0.5,
//              //       width: width * 0.2,
//              //       child: Image.asset(
//              //         'assets/images/login_muthootlogo.png',
//              //       ),
//              //     ),
//              //   ],
//              // ),
//              Stack(
//                children: [
//                  Column(
//                    mainAxisAlignment: MainAxisAlignment.end,
//                    children: [
//                      Container(
//                        height: height * 0.85,
//                        width: double.infinity,
//                        decoration: BoxDecoration(
//                          color: HexColor("#F0EAD6"),
//                          borderRadius: const BorderRadius.only(
//                            topLeft: Radius.circular(40),
//                            topRight: Radius.circular(40),
//                          ),
//                        ),
//                        child: Padding(
//                          padding:  const EdgeInsets.fromLTRB(30, 20, 30, 20),
//                          child: Column(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: [
//                              Text(
//                                "Log In",
//                                style: GoogleFonts.poppins(
//                                  fontSize: 30,
//                                  fontWeight: FontWeight.bold,
//                                  color: HexColor("#973232"),
//                                ),
//                              ),
//                              const SizedBox(
//                                height: 20,
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.fromLTRB(15, 0, 0, 20),
//                                child: Column(
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: [
//                                    Text(
//                                      "Email",
//                                      style: GoogleFonts.poppins(
//                                        fontSize: 18,
//                                        color: HexColor("#8d8d8d"),
//                                      ),
//                                    ),
//                                    const SizedBox(
//                                      height: 10,
//                                    ),
//                                    TextField(
//                                      controller: email,
//                                      obscureText: false,
//                                      cursorColor: HexColor("#4f4f4f"),
//                                      decoration: InputDecoration(
//                                        hintText: "Enter your email",
//                                        fillColor: HexColor("#f0f3f1"),
//                                        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
//                                        hintStyle: GoogleFonts.poppins(
//                                          fontSize: 15,
//                                          color: HexColor("#8d8d8d"),
//                                        ),
//                                        border: OutlineInputBorder(
//                                          borderRadius: BorderRadius.circular(30),
//                                          borderSide: BorderSide.none,
//                                        ),
//                                        prefixIcon: const Icon(Icons.mail_outline),
//                                        prefixIconColor: HexColor("#4f4f4f"),
//                                        filled: true,
//                                      ),
//                                    ),
//                                    const SizedBox(
//                                      height: 10,
//                                    ),
//                                    Text(
//                                      "Password",
//                                      style: GoogleFonts.poppins(
//                                        fontSize: 18,
//                                        color: HexColor("#8d8d8d"),
//                                      ),
//                                    ),
//                                    const SizedBox(
//                                      height: 10,
//                                    ),
//                                    TextField(
//                                      controller: password,
//                                      obscureText: true,
//                                      cursorColor: HexColor("#4f4f4f"),
//                                      decoration: InputDecoration(
//                                        hintText: "**************",
//                                        fillColor: HexColor("#f0f3f1"),
//                                        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
//                                        hintStyle: GoogleFonts.poppins(
//                                          fontSize: 15,
//                                          color: HexColor("#8d8d8d"),
//                                        ),
//                                        border: OutlineInputBorder(
//                                          borderRadius: BorderRadius.circular(30),
//                                          borderSide: BorderSide.none,
//                                        ),
//                                        prefixIcon:const Icon(Icons.lock_outline),
//                                        prefixIconColor: HexColor("#4f4f4f"),
//                                        filled: true,
//                                      ),
//                                    ),
//                                    const SizedBox(
//                                      height: 10,
//                                    ),
//                                    GestureDetector(
//                                      onTap: () {
//                                        getAccessToken();
//                                      },
//                                      child: Padding(
//                                        padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
//                                        child: Container(
//                                          padding: const EdgeInsets.fromLTRB(0, 14, 0, 10),
//                                          height: 55,
//                                          width: 275,
//                                          decoration: BoxDecoration(
//                                            color: HexColor('#973232'),
//                                            borderRadius: BorderRadius.circular(30),
//                                          ),
//                                          child: Text(
//                                            "Submit",
//                                            textAlign: TextAlign.center,
//                                            style: GoogleFonts.poppins(
//                                              color: Colors.white,
//                                              fontSize: 18,
//                                              fontWeight: FontWeight.w600,
//                                            ),
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//                                  ],
//                                ),),
//                              Row(
//                                mainAxisAlignment: MainAxisAlignment.center,
//                                children: [
//                                  Text("Don't have an account?",
//                                      style: GoogleFonts.poppins(
//                                        fontSize: 15,
//                                        color: HexColor("#8d8d8d"),
//                                      )),
//                                  TextButton(
//                                      child: Text(
//                                        "Sign Up",
//                                        style: GoogleFonts.poppins(
//                                          fontSize: 15,
//                                          color: HexColor("#973232"),
//                                        ),
//                                      ),
//                                      onPressed: () {
//                                        // Navigator.push(
//                                        //   context,
//                                        //   MaterialPageRoute(
//                                        //     builder: (context) =>
//                                        //     const OTPVerificationPage(),
//                                        //   ),
//                                        // );
//                                      }
//
//                                  ),
//                                ],
//                              ),
//                            ],
//                          ),),),
//                    ],
//                  ),
//                  Visibility(
//                    visible: !(MediaQuery.of(context).viewInsets.bottom > 0),
//                    child: Positioned(
//                      bottom:55,
//                      left: 25,
//                      child: Column(
//                        children: [
//                          SizedBox(
//                            width: width * 0.84,
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              children: [
//                                Text(
//                                  'By proceeding, you agree to the ',
//                                  style: TextStyle(
//                                    color: HexColor("#8d8d8d"),
//                                    fontSize: 12,
//                                    fontFamily: 'Poppins',
//                                    fontWeight: FontWeight.w400,
//                                  ),
//                                  textAlign: TextAlign.center,
//                                ),
//                                InkWell(
//                                  onTap: (){
//                                    //   NavigatorController.pagePush(context, TermsAndConditionView());
//                                  },
//                                  child: Text(
//                                    'Terms & Conditions',
//                                    style: TextStyle(
//                                      color: HexColor("#D2042D"),
//                                      fontSize: 12,
//                                      fontFamily: 'Poppins',
//                                      fontWeight: FontWeight.w700,
//                                    ),
//                                    textAlign: TextAlign.center,
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                          SizedBox(
//                            width: width * 0.84,
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              children: [
//                                Text(
//                                  'and ',
//                                  style: TextStyle(
//                                    color: HexColor("#8d8d8d"),
//                                    fontSize: 12,
//                                    fontFamily: 'Poppins',
//                                    fontWeight: FontWeight.w400,
//                                  ),
//                                  textAlign: TextAlign.center,
//                                ),
//                                Text(
//                                  'Privacy Policy',
//                                  style: TextStyle(
//                                    color:StyleData.buttonColor,
//                                    fontSize: 12,
//                                    fontFamily: 'Poppins',
//                                    fontWeight: FontWeight.w700,
//                                  ),
//                                  textAlign: TextAlign.center,
//                                ),
//                              ],
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//                  Visibility(
//                    visible: !(MediaQuery.of(context).viewInsets.bottom > 0),
//                    child: Positioned(
//                      bottom:20,
//                      child: SizedBox(
//                        width: width,
//                        child: const Center(
//                          child: Text(
//                            '©2021 Muthoot Finance. All rights reserved',
//                            style: TextStyle(
//                              color: Color(0xFF837E93),
//                              fontSize: 11,
//                              fontFamily: 'Poppins',
//                              fontWeight: FontWeight.w400,
//                            ),
//                            textAlign: TextAlign.center,
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ],
//           )
//       ),
//
//     );
//   }
// }
