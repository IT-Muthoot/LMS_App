
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lead_management_system/Model/apiurls.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Utils/NavigatorController.dart';
import '../../Utils/StyleData.dart';
import '../Utils/LocalStorage.dart';
import 'HomePageView.dart';
import 'LoginPageView.dart';

class SplashView extends StatefulWidget {
  final String Token;
  SplashView( {super.key,required this.Token,});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  String? version = "";
  String? accessToken;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User> handleSignInEmail(String username, String password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: username, password: password);
    final User user = result.user!;
    print(user);
    return user;
  }

  _checkInternet() async {
    // PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
    //   setState(() {
    //     version = packageInfo.version;
    //   });
    // });
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    List<ConnectivityResult> result = await Connectivity().checkConnectivity();

    print(result);
    if (result[0] == ConnectivityResult.mobile) {

      handleSignInEmail("itcoblr@muthootgroup.com", "Muthoot@123\$")
          .then((value) {
        startApp();
      });
    } else if (result[0] == ConnectivityResult.wifi) {

      handleSignInEmail("itcoblr@muthootgroup.com", "Muthoot@123\$")
          .then((value) {
        startApp();
      });
    } else if (result[0] == ConnectivityResult.none) {
      print("Dat 5");
      Dialogs.materialDialog(
          msg: 'Please check your internet and try again!',
          title: "No Internet Connection",
          msgStyle:
          TextStyle(color: Colors.white, fontFamily: StyleData.boldFont),
          titleStyle: const TextStyle(color: Colors.white),
          color: StyleData.backgroundDropdown,
          context: context,
          titleAlign: TextAlign.center,
          msgAlign: TextAlign.center,
          barrierDismissible: false,
          dialogWidth: kIsWeb ? 0.3 : null,
          onClose: (value) {},
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: InkWell(
                onTap: () {
                  SystemNavigator.pop();
                },
                child: Container(
                  height: 40,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                      child: Text('Cancel',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: StyleData.boldFont,
                              fontSize: 12))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _checkInternet();
                },
                child: Container(
                  height: 40,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                      child: Text('Retry',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: StyleData.boldFont,
                              fontSize: 12))),
                ),
              ),
            )
          ]);
    }
  }

  startApp() async {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        version = packageInfo.version;
      });
    });
    print(version);
    print(DateTime.now().day);
    print(DateTime.now().month);
    print(DateTime.now().year);
    LocalStore().get("employeeCode").then((value) {

      Future.delayed(const Duration(seconds: 1), () async {
        var headers = {
          'X-PrettyPrint': '1',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Cookie': 'BrowserId=qnhrXMyBEe6lOh9ncfvoTw; CookieConsentPolicy=0:0; LSKey-c\$CookieConsentPolicy=0:0'
        };
        var data = {
          'grant_type': 'password',
          'client_id': ApiUrls().clientIdUAT,
          'client_secret': ApiUrls().clientSecretUAT,
          'username': ApiUrls().userNameUAT,
          'password': ApiUrls().passwordUAT
        };
        var dio = Dio();
        var response = await dio.request(
          ApiUrls().accessTokenUAT,
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
          NavigatorController.pagePush(
              context, value == "" ?
          LoginScreen(Token : widget.Token)
              : HomePageView(Token : widget.Token));
        }
      });
    });
    // if ((DateTime.now().day >= 21 && DateTime.now().day <= 23 )&&
    //     DateTime.now().month == 2 &&
    //     DateTime.now().year == 2024 )
    // {
    //   var docSnapshot = await FirebaseFirestore.instance
    //       .collection('app_version')
    //       .doc('app_version')
    //       .get();
    //   var appVersionFromFirestore = docSnapshot.data()?['app_version'];
    //   print(appVersionFromFirestore);
    //   print(version);
    //   int firebaseVersion = getExtendedVersionNumber(appVersionFromFirestore); // return 102003
    //   int appVersion = getExtendedVersionNumber(version!);
    //   if (firebaseVersion > appVersion) {
    //     print(docSnapshot.data());
    //     Dialogs.materialDialog(
    //         msg: 'New update available!',
    //         title: "Update",
    //         msgStyle:
    //         TextStyle(color: Colors.white, fontFamily: StyleData.boldFont),
    //         titleStyle: const TextStyle(color: Colors.white),
    //         color: StyleData.backgroundDropdown,
    //         context: context,
    //         titleAlign: TextAlign.center,
    //         msgAlign: TextAlign.center,
    //         barrierDismissible: false,
    //         dialogWidth: kIsWeb ? 0.3 : null,
    //         onClose: (value) {},
    //         actions: [
    //           Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 30),
    //             child: InkWell(
    //               onTap: () {
    //                 SystemNavigator.pop();
    //               },
    //               child: Container(
    //                 height: 40,
    //                 width: 50,
    //                 decoration: BoxDecoration(
    //                     color: Colors.white,
    //                     borderRadius: BorderRadius.circular(5)),
    //                 child: Center(
    //                     child: Text('ok',
    //                         style: TextStyle(
    //                             color: Colors.black,
    //                             fontFamily: StyleData.boldFont,
    //                             fontSize: 12))),
    //               ),
    //             ),
    //           ),
    //           // Padding(
    //           //   padding: const EdgeInsets.symmetric(horizontal: 30),
    //           //   child: InkWell(
    //           //     onTap: () {
    //           //       Navigator.pop(context);
    //           //       // SystemNavigator.pop();
    //           //       // LaunchReview.launch(
    //           //       //     androidAppId: "com.muthoot.muthootloanassist",
    //           //       //     iOSAppId: "com.muthoot.muthootloanassist");
    //           //     },
    //           //     child: Container(
    //           //       height: 40,
    //           //       width: 50,
    //           //       decoration: BoxDecoration(
    //           //           color: Colors.white,
    //           //           borderRadius: BorderRadius.circular(5)),
    //           //       child: Center(
    //           //           child: Text('Update',
    //           //               style: TextStyle(
    //           //                   color: Colors.black,
    //           //                   fontFamily: StyleData.boldFont,
    //           //                   fontSize: 12))),
    //           //     ),
    //           //   ),
    //           // )
    //           // IconsButton(
    //           //   onPressed: () {
    //           //     Navigator.pop(context);
    //           //     LaunchReview.launch(
    //           //         androidAppId: "com.muthoot.muthootloanassist",
    //           //         iOSAppId: "com.muthoot.muthootloanassist");
    //           //   },
    //           //   text: "Update",
    //           //   iconData: Icons.update,
    //           //   color: Color(0xFFC5322C),
    //           //   textStyle: TextStyle(color: Colors.white),
    //           //   iconColor: Colors.white,
    //           // ),
    //         ]);
    //   } else {
    //     print(docSnapshot.data());
    //     LocalStore().get("employeeCode").then((value) {
    //       Future.delayed(const Duration(seconds: 1), () async {
    //         var headers = {
    //           'X-PrettyPrint': '1',
    //           'Content-Type': 'application/x-www-form-urlencoded',
    //           'Cookie': 'BrowserId=qnhrXMyBEe6lOh9ncfvoTw; CookieConsentPolicy=0:0; LSKey-c\$CookieConsentPolicy=0:0'
    //         };
    //         var data = {
    //           'grant_type': 'password',
    //           'client_id': '3MVG9u0ll7_j5qFxuFGIYQ4WguPM0jYjSJXprZRrAAOaI8q0BVKqxCt1dzjQ0tti3JDqnTeGjj1Dk7v9.QwnQ',
    //           'client_secret': 'ED297E5AD800E43B413260D0C4C7CFA7F49D11CE440F2EBC88220064B32D51CD',
    //           'username': 'itkrishnaprasad@muthootgroup.com',
    //           'password': 'Karthikrishna@12y7630AbZERemUschpI8nDyy4d'
    //         };
    //         var dio = Dio();
    //         var response = await dio.request(
    //           'https://test.salesforce.com/services/oauth2/token',
    //           options: Options(
    //             method: 'POST',
    //             headers: headers,
    //           ),
    //           data: data,
    //         );
    //
    //         if (response.statusCode == 200) {
    //
    //           String jsonResponse = json.encode(response.data);
    //           Map<String, dynamic> jsonMap = json.decode(jsonResponse);
    //           accessToken = jsonMap['access_token'];
    //
    //           // Store the access token locally
    //           saveAccessToken(accessToken!);
    //           print("AccessToken");
    //           print(accessToken);
    //           NavigatorController.pagePush(
    //               context, value == "" ?
    //           LoginScreen()
    //               : HomePageView());
    //         }
    //       });
    //     });
    //   }
    // var docSnapshot = await FirebaseFirestore.instance
    //     .collection('app_version')
    //     .doc('app_version')
    //     .get();
  //   if (docSnapshot.exists) {
  //     Map<String, dynamic>? data = docSnapshot.data();
  //     var value = data?['app_version'];
  //     int firebaseVersion = getExtendedVersionNumber(value); // return 102003
  //     int appVersion = getExtendedVersionNumber(version!);
  //     print(appVersion);
  //     print("Verisono8u8394");
  //     print(firebaseVersion);
  //
  //     // if (firebaseVersion > appVersion) {
  //     //   Dialogs.materialDialog(
  //     //       msg: 'New update available! Please download new version and uninstall old version(${version}) then install downloaded app-${value ?? ""}.',
  //     //       title: "Update Available",
  //     //       msgStyle:
  //     //       TextStyle(color: Colors.white, fontFamily: StyleData.boldFont),
  //     //       titleStyle: const TextStyle(color: Colors.white),
  //     //       color: StyleData.backgroundDropdown,
  //     //       context: context,
  //     //       titleAlign: TextAlign.center,
  //     //       msgAlign: TextAlign.center,
  //     //       barrierDismissible: false,
  //     //       dialogWidth: kIsWeb ? 0.3 : null,
  //     //       onClose: (value) {},
  //     //       actions: [
  //     //         Padding(
  //     //           padding: const EdgeInsets.symmetric(horizontal: 30),
  //     //           child: InkWell(
  //     //             onTap: () {
  //     //               SystemNavigator.pop();
  //     //             },
  //     //             child: Container(
  //     //               height: 40,
  //     //               width: 50,
  //     //               decoration: BoxDecoration(
  //     //                   color: Colors.white,
  //     //                   borderRadius: BorderRadius.circular(5)),
  //     //               child: Center(
  //     //                   child: Text('Cancel',
  //     //                       style: TextStyle(
  //     //                           color: Colors.black,
  //     //                           fontFamily: StyleData.boldFont,
  //     //                           fontSize: 12))),
  //     //             ),
  //     //           ),
  //     //         ),
  //     //         Padding(
  //     //           padding: const EdgeInsets.symmetric(horizontal: 30),
  //     //           child: InkWell(
  //     //             onTap: () {
  //     //               Navigator.pop(context);
  //     //               SystemNavigator.pop();
  //     //               FirebaseFirestore.instance
  //     //                   .collection('Latest App URL')
  //     //                   .doc('Latest App URL')
  //     //                   .get()
  //     //                   .then((value) {
  //     //                 _launchURL(value.data()!["app_url"].toString());
  //     //               });
  //     //               Fluttertoast.showToast(msg: "Downloading...");
  //     //             },
  //     //             child: Container(
  //     //               height: 40,
  //     //               width: 50,
  //     //               decoration: BoxDecoration(
  //     //                   color: Colors.white,
  //     //                   borderRadius: BorderRadius.circular(5)),
  //     //               child: Center(
  //     //                   child: Text('Download',
  //     //                       style: TextStyle(
  //     //                           color: Colors.black,
  //     //                           fontFamily: StyleData.boldFont,
  //     //                           fontSize: 12))),
  //     //             ),
  //     //           ),
  //     //         )
  //     //         // IconsButton(
  //     //         //   onPressed: () {
  //     //         //     Navigator.pop(context);
  //     //         //     LaunchReview.launch(
  //     //         //         androidAppId: "com.muthoot.muthootloanassist",
  //     //         //         iOSAppId: "com.muthoot.muthootloanassist");
  //     //         //   },
  //     //         //   text: "Update",
  //     //         //   iconData: Icons.update,
  //     //         //   color: Color(0xFFC5322C),
  //     //         //   textStyle: TextStyle(color: Colors.white),
  //     //         //   iconColor: Colors.white,
  //     //         // ),
  //     //       ]);
  //     // } else {
  //     //   if (mounted) {
  //     //     LocalStore().get("employeeCode").then((value) {
  //     //
  //     //             Future.delayed(const Duration(seconds: 1), () async {
  //     //               var headers = {
  //     //                 'X-PrettyPrint': '1',
  //     //                 'Content-Type': 'application/x-www-form-urlencoded',
  //     //                 'Cookie': 'BrowserId=qnhrXMyBEe6lOh9ncfvoTw; CookieConsentPolicy=0:0; LSKey-c\$CookieConsentPolicy=0:0'
  //     //               };
  //     //               var data = {
  //     //                 'grant_type': 'password',
  //     //                 'client_id': '3MVG9WZIyUMp1ZfoWDelgr4puVA8Cbw2py9NcKnfiPbsdxV6CU1HXQssNTT2XpRFqPmQ8OX.F4ZbP_ziL2rmf',
  //     //                 'client_secret': '4382921A497F5B4DED8F7E451E89D1228EE310F729F64641429A949D53FA1B84',
  //     //                 'username': 'salesappuser@muthoothomefin.com',
  //     //                // 'password': 'Karthikrishna@12y7630AbZERemUschpI8nDyy4d'
  //     //                'password': 'Pass@123456F7aghs4Z5RxQ5hC2pktsSLJfq'
  //     //               };
  //     //               var dio = Dio();
  //     //               var response = await dio.request(
  //     //                 'https://muthootltd.my.salesforce.com/services/oauth2/token',
  //     //                 options: Options(
  //     //                   method: 'POST',
  //     //                   headers: headers,
  //     //                 ),
  //     //                 data: data,
  //     //               );
  //     //
  //     //               if (response.statusCode == 200) {
  //     //
  //     //                 String jsonResponse = json.encode(response.data);
  //     //                 Map<String, dynamic> jsonMap = json.decode(jsonResponse);
  //     //                 accessToken = jsonMap['access_token'];
  //     //
  //     //                 // Store the access token locally
  //     //                 saveAccessToken(accessToken!);
  //     //                 print("AccessToken");
  //     //                 print(accessToken);
  //     //                 NavigatorController.pagePush(
  //     //                     context, value == "" ?
  //     //                 LoginScreen()
  //     //                     : HomePageView());
  //     //               }
  //     //             });
  //     //           });
  //     //   }
  //     // }
  // } else {
  // Dialogs.materialDialog(
  // msg: 'This app is not accessible now.',
  // title: "Access Unavailable",
  // msgStyle:
  // TextStyle(color: Colors.white, fontFamily: StyleData.boldFont),
  // titleStyle: const TextStyle(color: Colors.white),
  // color: StyleData.backgroundDropdown,
  // context: context,
  // titleAlign: TextAlign.center,
  // msgAlign: TextAlign.center,
  // barrierDismissible: false,
  // dialogWidth: kIsWeb ? 0.3 : null,
  // onClose: (value) {},
  // );
  // }
  }

_launchURL(String _url) async {
  final Uri url = Uri.parse(_url);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

  Future<void> saveAccessToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', token);
    print("Stored Access token");
    print(token);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  _checkInternet();
   // startApp();
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => NavigatorController.disableBackBt(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 13, right: 15),
                        child: SizedBox(
                            height: height * 0.4,
                            child: Lottie.asset('assets/jsons/spalsh.json',))),
                      ),
                    SizedBox(
                        child: Image.asset(
                          'assets/images/HomeFin.png',
                          height: height * 0.1,
                          fit: BoxFit.fill,
                        )),
                    SizedBox(
                      height: height * 0.08,
                    )

                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                child: SizedBox(
                  width: width,
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                            height: height * 0.015,
                            child: Image.asset(
                              'assets/images/login_muthootlogo.png',
                            )),
                        Text(
                          'V$version',
                          style: TextStyle(color: Colors.black38, fontSize: 10),
                        )
                      ],
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

int getExtendedVersionNumber(String version) {
  List versionCells = version.split('.');
  versionCells = versionCells.map((i) => int.parse(i)).toList();
  return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
}
