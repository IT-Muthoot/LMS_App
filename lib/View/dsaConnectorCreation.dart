import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lead_management_system/View/viewConnectorList.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/CustomeSnackBar.dart';
import '../Utils/StyleData.dart';
import 'HomePageView.dart';
import 'LoginPageView.dart';

class DSAConnectorCreationPage extends StatefulWidget {
  const DSAConnectorCreationPage({super.key});

  @override
  State<DSAConnectorCreationPage> createState() => _DSAConnectorCreationPageState();
}

class _DSAConnectorCreationPageState extends State<DSAConnectorCreationPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _Connector = TextEditingController(text: 'Connector');
  TextEditingController _employeeNameController = TextEditingController();
  TextEditingController _employeeCodeController = TextEditingController();
  TextEditingController _branchCodeController = TextEditingController();
  TextEditingController _branchNameController = TextEditingController();
  TextEditingController _regionController = TextEditingController();
  TextEditingController _connectorNameController = TextEditingController();
  TextEditingController _connectorCodeController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _panNumberController = TextEditingController();
  TextEditingController _adhaarNumberController = TextEditingController();
  DateTime now = DateTime.now();

  UnderlineInputBorder enb =  UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:   const BorderSide(color:  Colors.black38)
  );
  UnderlineInputBorder focus =  UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:  const BorderSide(color: Color(0xff298b28))
  );


  @override
  void initState() {
    super.initState();
    _loadEmployeeName();
  }



  Future<void> _loadEmployeeName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? employeeName = pref.getString("employeeName");
    String? employeeCode = pref.getString("empCode");
    String? branchCode = pref.getString("branchCode");
    String? region = pref.getString("region");
    String? branchName = pref.getString("branchName");
    print(region);
    print(branchName);
    if (employeeName != null) {
      _employeeNameController.text = employeeName;
      _employeeCodeController.text = employeeCode!;
      _branchCodeController.text = branchCode!;
      _regionController.text = region!;
      _branchNameController.text = branchName!;

    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        // Navigate to ApplicantDetailsView when back button is pressed
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePageView(Token: '',),
          ),
        );
        // Prevent the default back navigation
        return false;
      },
      child: SafeArea(child: Scaffold(
        appBar: AppBar(
          backgroundColor: StyleData.appBarColor2,
          leading: Padding(
            padding: const EdgeInsets.all(19.0),
            child: GestureDetector(
              onTap: (){
                // SimpleHiddenDrawerController.of(context).open();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomePageView(Token: '',),
                  ),
                );

              },
              child:  Container(
                child: Image.asset(
                  'assets/images/arrow.png',
                ),
              ),),
          ),
          title: Text("Add New Connector",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: StyleData.boldFont),),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.list, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ViewConnectorList(employeeCode : _employeeCodeController.text ),
                  ),
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.03,
                        ),
                        SizedBox(
                          width: width * 0.95,
                          child: TextFormField(
                            controller: _Connector,
                        readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Source Type',
                              hintText: '',
                              //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                              focusedBorder: focus,
                              enabledBorder: enb,
                              filled: true,
                              fillColor: StyleData.textFieldColor,
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: height * 0.01,
                        // ),
                        // SizedBox(
                        //   width: width * 0.95,
                        //   child: TextFormField(
                        //     controller: _employeeCodeController,
                        //     readOnly: true,
                        //     decoration: InputDecoration(
                        //       labelText: 'Employee Code',
                        //       hintText: '',
                        //       //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                        //       focusedBorder: focus,
                        //       enabledBorder: enb,
                        //       filled: true,
                        //       fillColor: StyleData.textFieldColor,
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: height * 0.01,
                        // ),
                        // SizedBox(
                        //   width: width * 0.95,
                        //   child: TextFormField(
                        //     controller: _employeeNameController,
                        //     readOnly: true,
                        //     decoration: InputDecoration(
                        //       labelText: 'Employee Name',
                        //       hintText: '',
                        //       //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                        //       focusedBorder: focus,
                        //       enabledBorder: enb,
                        //       filled: true,
                        //       fillColor: StyleData.textFieldColor,
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SizedBox(
                          width: width * 0.95,
                          child: TextFormField(
                            controller: _branchCodeController,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Branch Code',
                              hintText: '',
                              //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                              focusedBorder: focus,
                              enabledBorder: enb,
                              filled: true,
                              fillColor: StyleData.textFieldColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SizedBox(
                          width: width * 0.95,
                          child: TextFormField(
                            controller: _branchNameController,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Branch Name',
                              hintText: '',
                              //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                              focusedBorder: focus,
                              enabledBorder: enb,
                              filled: true,
                              fillColor: StyleData.textFieldColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SizedBox(
                          width: width * 0.95,
                          child: TextFormField(
                            controller: _regionController,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Region Name',
                              hintText: '',
                              //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                              focusedBorder: focus,
                              enabledBorder: enb,
                              filled: true,
                              fillColor: StyleData.textFieldColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SizedBox(
                          width: width * 0.95,
                          child: TextFormField(
                            controller: _connectorNameController,

                            decoration: InputDecoration(

                              labelText: 'Connector Name *',
                              hintText: '',
                              //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                              focusedBorder: focus,
                              enabledBorder: enb,
                              filled: true,
                              fillColor: StyleData.textFieldColor,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Customer Name required';
                              }
                              return null;
                            },
                          ),
                        ),
                        // SizedBox(
                        //   height: height * 0.01,
                        // ),
                        // SizedBox(
                        //   width: width * 0.95,
                        //   child: TextFormField(
                        //     controller: _connectorCodeController,
                        //
                        //     decoration: InputDecoration(
                        //
                        //       labelText: 'Connector Code *',
                        //       hintText: '',
                        //       //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                        //       focusedBorder: focus,
                        //       enabledBorder: enb,
                        //       filled: true,
                        //       fillColor: StyleData.textFieldColor,
                        //     ),
                        //     validator: (value) {
                        //       if (value == null || value.isEmpty) {
                        //         return 'Customer Code required';
                        //       }
                        //       return null;
                        //     },
                        //   ),
                        // ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SizedBox(
                          width: width * 0.95,
                          child: TextFormField(
                            controller: _mobileNumberController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            decoration: InputDecoration(
                              labelText: 'Mobile Number *',
                              hintText: '',
                              prefixText: '+91 ',
                              //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                              focusedBorder: focus,
                              enabledBorder: enb,
                              filled: true,
                              fillColor: StyleData.textFieldColor,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Mobile Number required';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SizedBox(
                          width: width * 0.95,
                          child: TextFormField(
                            controller: _panNumberController,
                            keyboardType: TextInputType.text,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9]+$')), // Allow only alphanumeric characters
                              LengthLimitingTextInputFormatter(10),
                              UppercaseTextInputFormatter(),
                            ],
                            decoration: InputDecoration(
                              labelText: 'PAN Number',
                              hintText: '',
                              //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                              focusedBorder: focus,
                              enabledBorder: enb,
                              filled: true,
                              fillColor: StyleData.textFieldColor,
                            ),

                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SizedBox(
                          width: width * 0.95,
                          child: TextFormField(
                            controller: _adhaarNumberController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(12),
                            ],
                            decoration: InputDecoration(
                              labelText: 'Aadhar Card Number',
                              hintText: '',
                              //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                              focusedBorder: focus,
                              enabledBorder: enb,
                              filled: true,
                              fillColor: StyleData.textFieldColor,
                            ),

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
              Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: StyleData.appBarColor2,
                ),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Validate PAN card if data is entered
                        if (_panNumberController.text.isNotEmpty) {
                          if (!isValidPanCard(_panNumberController.text) || _panNumberController.text.length < 10) {
                            CustomSnackBar.errorSnackBarQ("Please enter a valid PAN number", context);
                            return;
                          }
                        }

                        // Validate Aadhar number if data is entered
                        if (_adhaarNumberController.text.isNotEmpty) {
                          if (_adhaarNumberController.text.length != 12) {
                            CustomSnackBar.errorSnackBarQ("Please enter a valid 12-digit Aadhar number", context);
                            return;
                          }
                        }

                        try {
                          // Prepare the data to be added
                          Map<String, dynamic> connectorData = {
                            "employeeName": _employeeNameController.text,
                            "employeeCode": _employeeCodeController.text,
                            "regionName": _regionController.text,
                            "branchCode": _branchCodeController.text,
                            "branchName": _branchNameController.text,
                            "connectorName": _connectorNameController.text,
                          //  "connectorCode": _connectorCodeController.text,
                            "mobileNumber": _mobileNumberController.text,
                            "panNumber": _panNumberController.text,
                            "aadharNumber": _adhaarNumberController.text,
                            'createdDateTime':Timestamp.fromDate(now),
                            // Add other fields you want to include
                          };

                          // Add data to the 'newConnectors' collection
                          await FirebaseFirestore.instance.collection('newConnectors').add(connectorData);

                          // Show success message
                          _showAlertDialogSuccess(context);
                        } catch (error) {
                          // Handle any errors that occur during the write operation
                          CustomSnackBar.errorSnackBarQ("Please try again: $error", context);
                        }

                      } else {
                        CustomSnackBar.errorSnackBarQ("Please enter all the mandatory fields", context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    child: Text(
                      'Create',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      )),
    );
  }


  bool isValidPanCard(String panNumber) {
    RegExp panRegExp = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
    return panRegExp.hasMatch(panNumber);
  }

  void _showAlertDialogSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            backgroundColor: Colors.white,
            elevation: 0, // No shadow
            content: Container(
              height:200,
              width: 200,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child:
                    Container(
                      height: 80,
                      width: 65,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle
                      ),
                      child: Center(
                        child: Icon(Icons.done,color: Colors.white,),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Connector Added successfully', textAlign: TextAlign.center, style: TextStyle(color: Colors.black87,fontSize: 16,),),

                  SizedBox(height: 5),
                  SizedBox(
                    height: 25,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePageView(Token: '',),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text('OK', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
