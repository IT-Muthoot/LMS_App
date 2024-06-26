import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/StyleData.dart';
import '../Utils/background.dart';
import 'LoginPageView.dart';


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

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isTermsAndConditionsChecked = false;

  final List<String> userType = [
    'RO',
    'RM',
  ];
  String? selectedUserType;


  List employeeList = [];
  List outputList1 = [];

  String? Designation;
  String? RegionName;
  String? ReportingManagerName;
  String? ReportingManagerCode;
  String? Zone;


//getting employee details from employeeMapping Collection
  getEmployee1Details(String emp) async {
    FirebaseFirestore.instance
        .collection("employeeMapping")
        .doc("employeeMapping")
        .get()
        .then((value) async {
      for (var element in value.data()!["employeeMapping"]) {
        setState(() {
          employeeList.add(element);
        });
      }
      setState(() {
        outputList1 =
            employeeList.where((o) => o['EMP_CODE'] == empCodeController.text).toList();
        empNameController.text = outputList1[0]['NAME'];
        branchcode.text = outputList1[0]['BRANCH CODE'];
        Designation = outputList1[0]['DSGN_NAME'];
        RegionName = outputList1[0]['REGION'];
        ReportingManagerName = outputList1[0]['Reporting Manager Name'];
        ReportingManagerCode = outputList1[0]['Reporting Manager Code'];
        Zone = outputList1[0]['ZONE'];
      });
  //    print("Output List " + outputList1.toString());

    });
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
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0),
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
                          inputFormatters: [
                            FilteringTextInputFormatter.singleLineFormatter,
                            LengthLimitingTextInputFormatter(7),
                            UppercaseInputFormatter(),
                          ],
                          onChanged: (empCode) {
                            if (empCode.isEmpty) {
                              empNameController.clear();
                              branchcode.clear();
                            } else {
                              getEmployee1Details(empCode);
                            }
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
                          validator: (isusernamevalid) {
                            if (isusernamevalid.toString().isNotEmpty)
                              return null;
                            else
                              return 'Enter valid Employee Name';
                          },
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
                          validator: (isusernamevalid) {
                            if (isusernamevalid.toString().isNotEmpty)
                              return null;
                            else
                              return 'Enter valid branch code';
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
                      Container(
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
                      SizedBox(height: height * 0.04),
                    ],
                  ),
                ),

                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Checkbox(
                        value: isTermsAndConditionsChecked,
                        onChanged: (newValue) {
                          setState(() {
                            isTermsAndConditionsChecked = newValue!;
                          });
                        },
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith<Color?>((states) {
                          if (states.contains(MaterialState.selected)) {
                            return Colors.grey; // Grey color when selected
                          }
                          return Colors.grey.withOpacity(0.4); // Grey color when unselected
                        }),
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'I agree to the ',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),

                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return SingleChildScrollView(
                                          child: Container(
                                            color: Colors.white,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 12.0,
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop(); // Close the bottom sheet
                                                  },
                                                  child: Icon(
                                                    Icons.close,
                                                    color: StyleData.buttonColor,
                                                  ),
                                                  style: ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    shape: CircleBorder(),
                                                    side: BorderSide(color: StyleData.buttonColor, width: 1),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        'PRIVACY POLICY',
                                                        style : TextStyle(
                                                          fontSize: 22,
                                                          fontWeight: FontWeight.w600,
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        'The Mobile App for Sales (Homefin Express) is developed by (Muthoot IT – CO South) for the exclusive use of the Sales staff who is working at various branches of Muthoot Homefin India Ltd by using the Employee Code and password given to them by the company. Nobody other than Branch Staff of Muthoot Homefin India Ltd can login to this application unless the Employee Code and password are provided to them by the company.'),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        'This privacy policy is to provide information to you, our client, on how your personal data is gathered and used within our practice, and the circumstances in which we may share it with third parties.'),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        'We use your Personal Information only for furnishing and improving the App. By using the app Homefin express, you accord to the collection and use of data in accordance with this policy.'),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: 12.0,
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        'WHAT INFORMATION DO WE COLLECT?',
                                                        style : TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w500,
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        'We collect information from you when you register on our app, site, place an order, subscribe to our newsletter, respond to a survey, fill out a form. When ordering or registering on our app or site, as appropriate, you may be asked to enter you’re: name, e-mail address, mailing address, phone number, and personal details.'),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        'Personal data collected directly from you:'),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        'This type of data is the personal data you provide us. You consent to provide us access to such personal data through your continued use of the Services or through interaction over the Platform. This includes:'),
                                                  ),
                                                ),

                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                                                    child: Text(
                                                        'Contact data: This includes your email addresses, phone numbers, and postal address.'),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                                                    child: Text(
                                                        'Identity and Profile-related Data: This includes personal information concerning the personal or material circumstances of an identified or identifiable User, e.g. name, gender, date of birth, password, password validation, employment verification information and other similar details shared via the Platform.'),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                                                    child: Text(
                                                        'KYC data: In connection with the Services and your use of the Platform, we may also require you to share, or we may collect identification documents issued by government or other authorities to you, including details of or pertaining to Aadhaar, PAN card, voter ID, and ration card.'),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                                                    child: Text(
                                                        'Financial data: This will include your past credit history, income details, details of loans issued, or otherwise applied for through the Platform, payments and repayments thereof, your bank account details and bank account statements.'),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                                                    child: Text(
                                                        'Personal data collected through your use of the Platform and from your device'),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: 12.0,
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        'WHAT DO WE USE YOUR INFORMATION FOR?',
                                                        style : TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w500,
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2.0,
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                                    child: Text(
                                                        'To personalize your experience (your information helps us to better respond to your individual needs)'
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                                    child: Text(
                                                        'To improve our App (we continually strive to improve our App offerings based on the information and feedback we receive from you)'
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                                    child: Text(
                                                        'To improve customer service (your information helps us to more effectively respond to your customer service requests and support needs)'
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                                    child: Text(
                                                        'To process transactions your information, whether public or private, will not be sold, exchanged, transferred, or given to any other company for any reason whatsoever, without your consent, other than for the express purpose of delivering the purchased product or service requested.'
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                                    child: Text(
                                                        'To administer a contest, promotion, survey or other site feature'
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                                    child: Text(
                                                        'To send periodic emails'
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                                    child: Text(
                                                        'The email address you provide may be used to send you information, respond to inquiries, and/or other requests or questions.'
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: 12.0,
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        'DO WE DISCLOSE ANY INFORMATION TO OUTSIDE PARTIES?',
                                                        style : TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w500,
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                                    child: Text(
                                                        'We do not sell, trade, or otherwise transfer to outside parties your personally identifiable information. This does not include trusted third parties who assist us in operating our App, conducting our business, or servicing you, so long as those parties agree to keep this information confidential. We may also release your information when we believe release is appropriate to comply with the law, enforce our app policies, or protect ours or others rights, property, or safety. However, non-personally identifiable visitor information may be provided to other parties for marketing, advertising, or other uses.'),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: 12.0,
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        'DO WE USE COOKIES?',
                                                        style : TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w500,
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                                    child: Text(
                                                        'No we are not using cookies.'),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 12.0,
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        'HOW DO WE PROTECT YOUR INFORMATION?',
                                                        style : TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w500,
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 8.0,),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                                    child: Text(
                                                        'We implement a variety of security measures to maintain the safety of your personal information when you enter, submit, or access your personal information.'),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                                    child: Text(
                                                        'If we make any material changes to this Privacy Policy, we will notify you either through the email address you have provided us, or by placing a prominent notice on our App.'),
                                                  ),
                                                ),


                                                SizedBox(height: 30.0,),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                                    child: Text(
                                                        'Contact Us'),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                                    child: Text(
                                                        'If you have any questions about this Privacy Policy, please contact us.'),
                                                  ),
                                                ),
                                                SizedBox(height: 30.0,),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                                    child: Text(
                                                        'Phone: 022-41010916'),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                                    child: Text(
                                                        'Email: applicationsupport@muthoothomefin.com”'),
                                                  ),
                                                ),

                                                SizedBox(height: 40.0,),

                                                Center(
                                                  child: SizedBox(
                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop(); // Close the bottom sheet
                                                      },
                                                      child: Text(
                                                        "Close",
                                                        style: TextStyle(
                                                          color: StyleData.buttonColor,
                                                        ),
                                                      ),
                                                      style: ElevatedButton.styleFrom(
                                                        elevation: 0,
                                                        side: BorderSide(color: StyleData.buttonColor, width: 1),
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: 60.0,
                                                ),

                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                  );
                                },
                                child: Text(
                                  'Privacy Policy',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '& ',
                                style: TextStyle(
                                  color: Colors.grey, // Grey color for the text
                                ),
                              ),

                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return SingleChildScrollView(
                                          child: Container(
                                            color: Colors.white,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 12.0,
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop(); // Close the bottom sheet
                                                  },
                                                  child: Icon(
                                                    Icons.close,
                                                    color: StyleData.buttonColor,
                                                  ),
                                                  style: ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    shape: CircleBorder(),
                                                    side: BorderSide(color: StyleData.buttonColor, width: 1),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        'TERMS AND CONDITIONS',
                                                        style : TextStyle(
                                                          fontSize: 22,
                                                          fontWeight: FontWeight.w600,
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10.0,),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        '1. Introduction',
                                                        style : TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w500,
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        'These Terms and Conditions govern your use of the Homefin Express App ("the App"), developed by Muthoot Team. By accessing or using the App, you agree to be bound by these Terms and Conditions. If you do not agree with any part of these Terms and Conditions, you must not use the App.'),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        '2. Use of the App',
                                                        style : TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w500,
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        '- The App is intended for use by Muthoot Homefin staff only and is to be used solely for the purpose of collecting customer details for home loan applications.'),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        '- You must not use the App for any unlawful or prohibited purpose.'),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        '3. Data Collection and Privacy',
                                                        style : TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w500,
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        '- The App collects customer details, including Aadhaar and PAN information, for the purpose of processing home loan applications.'),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        '- All data collected through the App is subject to the Company\'s Privacy Policy, which can be found on the Company\'s website.'),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        '4. Security',
                                                        style : TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w500,
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        '- You are responsible for maintaining the confidentiality of your login information and for all activities that occur under your account.'),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        '- You must notify the Company immediately of any unauthorized use of your account or any other breach of security.'),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        '5. Intellectual Property',
                                                        style : TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w500,
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        '- The App and all intellectual property rights related to it are owned by the Company.'),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        '- You may not reproduce, modify, distribute, or otherwise use any part of the App without the Company\'s prior written consent.'),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        '6. Disclaimer',
                                                        style : TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w500,
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        '- The Company makes no warranties or representations about the accuracy or completeness of the information provided through the App.'),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        '- The Company shall not be liable for any loss or damage arising from your use of the App.'),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        '7. Changes to Terms and Conditions',
                                                        style : TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w500,
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        '- The Company reserves the right to change these Terms and Conditions at any time without notice.'),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        '- Your continued use of the App after any such changes shall constitute your acceptance of the revised Terms and Conditions.'),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        '8. Governing Law',
                                                        style : TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w500,
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        '- These Terms and Conditions are governed by the laws of India.'),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8, // Set container width to 60% of screen width
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                    child: Text(
                                                        '- Any disputes arising out of or in connection with these Terms and Conditions shall be subject to the exclusive jurisdiction of the courts in India.'),
                                                  ),
                                                ),


                                                SizedBox(height: 40.0,),

                                                Center(
                                                  child: SizedBox(
                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop(); // Close the bottom sheet
                                                      },
                                                      child: Text(
                                                        "Close",
                                                        style: TextStyle(
                                                          color: StyleData.buttonColor,
                                                        ),
                                                      ),
                                                      style: ElevatedButton.styleFrom(
                                                        elevation: 0,
                                                        side: BorderSide(color: StyleData.buttonColor, width: 1),
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: 60.0,
                                                ),

                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                  );
                                },
                                child: Text(
                                  'Terms & Conditions',
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),




                Visibility(
                  visible: isTermsAndConditionsChecked == true,
                  child: GestureDetector(
                    onTap: () async {
                      print("Helloo");
                      if (registerformKey.currentState!.validate() ) {
                        if(passwordController.text == confirmpasswordController.text)
                          {
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
                               //   "MobileNumber": mobileNumber.text,
                                  "email": emailController.text,
                                  "password": passwordController.text,
                                  "branchCode": branchcode.text,
                                  "confirmPassword": confirmpasswordController.text,
                                  "designation": Designation,
                                  "Region": RegionName,
                                  "Zone": Zone,
                                  "ManagerName": ReportingManagerName,
                                  "ManagerCode": ReportingManagerCode,
                                  "userId": credential.user!.uid,
                                  "createdDate": Timestamp.now(),
                                  "userType": "user",
                                };
                                users.add(params);
                                customSuccessSnackBar1("Registered Successfully");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(Token: '',),
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
                        else
                        {
                          customSuccessSnackBar("Password & Confirm password must be same");
                        }
                      }
                      else
                      {
                        customSuccessSnackBar("Please enter all the details");
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
                ),

                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: GestureDetector(
                    onTap: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(Token: '',)))
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
                ),
                SizedBox(
                  height: height * 0.07,
                )
              ],
            ),
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

class UppercaseInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text!.toUpperCase(),
      selection: newValue.selection,
    );
  }
}