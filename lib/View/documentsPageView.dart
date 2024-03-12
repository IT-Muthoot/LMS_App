import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lead_management_system/View/HomePageView.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/StyleData.dart';
import 'ApplicantDetailsView.dart';
import 'VisitPageView.dart';

class DocumentPageView extends StatefulWidget {
  final String docId;
  const DocumentPageView({Key? key,
    required this.docId})
      : super(key: key);

  @override
  State<DocumentPageView> createState() => _DocumentPageViewState();
}

class _DocumentPageViewState extends State<DocumentPageView> {
  bool isVerification = false;
  
  Map<String, bool> checkboxValues = {
    'Application Form': false,
    'Bank Passbook(Latest 6 months)': false,
    'Date of Birth Proof': false,
    'Login Fee Cheque': false,
    'Passport Size Color Photograph': false,
    'Photo ID Proof': false,
    'Residence Proof'
        'Salary Slip 3 Month': false,
    'Signature Proof': false,
  };

  Map<String, bool> optionalCheckboxes = {
    'Copy of Property': false,
    'Qualification proof': false,
    'Sector Employee From 16 for Pvt': false,
    'Total Work Experience Proof(Min 3 years)': false,
    'Work Experience Proof(1 years)': false,
};

  var userType;
  List<DocumentSnapshot> ListOfLeads = [];
  String? LeadID;
  String? ApplicantFirstName;
  String? ApplicantLastName;
  String? ApplicantFullName;
  String? CustomerNumber;
  String? DateOfBirth;
  String? Gender;
  String? HomeFinBranchCode;
  String? LeadAmount;
  String? LeadSource;
  String? panCardNumber;
  String? salutation;
  String? productCategory;
  String? products;
  String? mobileNumber;
  String? aadharNumber;
  var docData;

  void fetchdata() async {
    CollectionReference users =
    FirebaseFirestore.instance.collection('convertedLeads');
    users.doc(widget.docId).get().then((value) async {
      setState(() {
        docData = value.data();
      });
      ApplicantFirstName = docData["firstName"] ?? "";
      LeadID  = docData["LeadID"] ?? "";
      ApplicantLastName = docData["lastName"] ?? "";
      CustomerNumber = docData["customerNumber"] ?? "";
      DateOfBirth = docData["dateOfBirth"] ?? "";
      Gender = docData["gender"] ?? "";
      HomeFinBranchCode = docData["homeFinBranchCode"] ?? "";
      LeadAmount = docData["leadAmount"] ?? "";
      LeadSource = docData["leadSource"] ?? "";
      panCardNumber = docData["panCardNumber"] ?? "";
      aadharNumber = docData["aadharNumber"] ?? "";
      //  print(_leadSource.text);
      print(ApplicantFirstName);
      print(LeadID);

    });
    // CollectionReference users = FirebaseFirestore.instance.collection('convertedLeads');
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // // var userId = pref.getString("token");
    // var userId = pref.getString("userID");
    // setState(() {
    //   userType = pref.getString("logintype");
    // });
    // print(userType);
    // if (userType == "user") {
    //   users.where("userId", isEqualTo: userId).get().then((value) {
    //     setState(() {
    //       ListOfLeads = value.docs;
    //     });
    //     for (var i = 0; value.docs.length > i; i++) {
    //       print(value.docs[i].data());
    //       setState(() {
    //         LeadID = ListOfLeads[i]['LeadID'];
    //          ApplicantFirstName = ListOfLeads[i]['firstName'] ;
    //          ApplicantLastName = ListOfLeads[i]['lastName'] ;
    //         CustomerNumber = ListOfLeads[i]['customerNumber'];
    //         DateOfBirth = ListOfLeads[i]['dateOfBirth'];
    //         Gender = ListOfLeads[i]['gender'];
    //         HomeFinBranchCode = ListOfLeads[i]['homeFinBranchCode'];
    //         LeadAmount = ListOfLeads[i]['leadAmount'];
    //         LeadSource = ListOfLeads[i]['leadSource'];
    //         panCardNumber = ListOfLeads[i]['panCardNumber'];
    //         salutation = ListOfLeads[i]['salutation'];
    //         productCategory = ListOfLeads[i]['productCategory'];
    //         products = ListOfLeads[i]['products'];
    //         aadharNumber = ListOfLeads[i]['aadharNumber'];
    //         print(LeadID);
    //         print(ApplicantFirstName);
    //       });
    //     }
    //   });
    // } else {
    //   users.get().then((value) {
    //     setState(() {
    //       ListOfLeads = value.docs;
    //     });
    //     for (var i = 0; value.docs.length > i; i++) {
    //       print(value.docs[i].data());
    //     }
    //   });
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(child: WillPopScope(
      onWillPop: () async {
        // Exit the app when the back button is pressed
        SystemNavigator.pop();
        return false; // Prevents default back button behavior
      },
      child: Scaffold(
        appBar:  AppBar(
          backgroundColor: StyleData.appBarColor2,
          title: Text("Applicant Detail",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: StyleData.boldFont),),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(19.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ApplicantDetailsView(),
                  ),
                );
              },
              child:  Container(
                child: Image.asset(
                  'assets/images/arrow.png',
                ),
              ),),
          ),

        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Lead ID - ",style: TextStyle(color: Colors.black87,fontSize: 16,fontFamily: StyleData.boldFont),),
                              Text(LeadID ?? "",style: TextStyle(color: StyleData.appBarColor2,fontSize: 16,fontFamily: StyleData.boldFont),),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Row(
                            children: [
                              Text("Applicant Name",style: TextStyle(color: Colors.black38,fontSize: 13,),),
                              Spacer(),
                              Text((ApplicantFirstName ?? '') + ' ' + (ApplicantLastName ?? '') ?? "",style: TextStyle(color:Colors.black54,fontSize: 15,fontFamily: StyleData.boldFont),),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Mobile Number",style: TextStyle(color: Colors.black38,fontSize: 13,),),
                              Spacer(),
                              Text(CustomerNumber ?? "",style: TextStyle(color:Colors.black54,fontSize: 15,fontFamily: StyleData.boldFont),),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Date Of Birth",style: TextStyle(color: Colors.black38,fontSize: 13,),),
                              Spacer(),
                              Text(DateOfBirth ?? "",style: TextStyle(color:Colors.black54,fontSize: 15,fontFamily: StyleData.boldFont),),
                            ],
                          ),
                          Divider(
                            thickness: 0.4,
                          ),
                          Row(
                            children: [
                              Text("PAN Number",style: TextStyle(color: Colors.black38,fontSize: 13),),
                              Spacer(),
                              Text(panCardNumber ?? "",style: TextStyle(color:Colors.black54,fontSize: 15,fontFamily: StyleData.boldFont),),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Aadhar Number",style: TextStyle(color: Colors.black38,fontSize: 13),),
                              Spacer(),
                              Text(aadharNumber ?? "",style: TextStyle(color:Colors.black54,fontSize: 15,fontFamily: StyleData.boldFont),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              isVerification == false ?
              GestureDetector(
                onTap: () {
                  setState(() {
                    isVerification = true;
                  });
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
                              Color.fromARGB(255, 61, 169, 83),
                              Color.fromARGB(255, 131, 190, 143)
                            ]
                        )
                    ),
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      "Verify",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                  ),
                ),
              ) : SizedBox.shrink(),
              Visibility(
                visible: isVerification,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text("Required Documents *",style: TextStyle(color: Colors.black87,fontSize: 16,fontFamily: StyleData.boldFont),),
                      Card(
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: checkboxValues.keys.map((String key) {
                              return Row(
                                children: [

                                  Checkbox(
                                    value: checkboxValues[key],
                                    activeColor: StyleData.appBarColor,
                                    onChanged: (value) {
                                      setState(() {
                                        checkboxValues[key] = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    key,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Text("Optional Documents",style: TextStyle(color: Colors.black87,fontSize: 16,fontFamily: StyleData.boldFont),),
                      Card(
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: optionalCheckboxes.keys.map((String key) {
                              return Row(
                                children: [
                                  Checkbox(
                                    value: optionalCheckboxes[key],
                                    activeColor: StyleData.appBarColor,
                                    onChanged: (value) {
                                      setState(() {
                                        optionalCheckboxes[key] = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    key,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: isVerification,
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: StyleData.appBarColor2,
                  ),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HomePageView(),
                            ),
                          );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        elevation: 0,
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //
        //   },
        //   child: Icon(Icons.save),
        // ),
      ),
    )
    );
  }
}
