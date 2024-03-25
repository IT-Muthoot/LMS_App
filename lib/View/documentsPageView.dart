import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lead_management_system/View/HomePageView.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import '../Model/Response/DropDownModel.dart';
import '../Model/apiurls.dart';
import '../Utils/CustomeSnackBar.dart';
import '../Utils/StyleData.dart';
import 'ApplicantDetailsView.dart';
import 'VisitPageView.dart';

class DocumentPageView extends StatefulWidget {
  final String docId;
  final String visitID;
  const DocumentPageView({Key? key,
    required this.docId,required this.visitID})
      : super(key: key);

  @override
  State<DocumentPageView> createState() => _DocumentPageViewState();
}

class _DocumentPageViewState extends State<DocumentPageView> {
  bool isVerification = false;
  XFile? pickedFile;

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

  String? ApplicationDocID;
  String? ApplicationDocID1;

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
      ApplicationDocID = docData["Application_Form"] ?? "";
      //  print(_leadSource.text);
      print(ApplicantFirstName);
      print(ApplicationDocID);
      print(LeadID);

    });
  }

  String? selectedDoc;
  final List<DropDownData> _DocumentList = [];
  List<Map<String, dynamic>> listOfOtherDocuments = [];

  getDropDownDocumentData() {
    FirebaseFirestore.instance
        .collection("documentList")
        .doc('documentList')
        .get()
        .then((value) {
      for (var element in value.data()!['documentList']) {
        setState(() {
          _DocumentList
              .add(DropDownData(element['id'], element['title']));
        });
      }
    });
  }

  String? applicationForm,
      bankPassbook,
      dateOfBirthProof,
      passportSizePhoto,
      loginFeeCheque,
      photoIdProof,
      residenceProof,
      salarySlip,
      signatureProof,
      copyOfProperty,
      qualificationProof,
       sectorEmployeePvt,
      totalWorkExp,
      WorkExp;
  bool applicationFormClicked = false,
      bankPassbookClicked = false,
      dateOfBirthClicked = false,
      loginFeeChequeClicked = false,
      passportSizePhotoClicked = false,
      photoIdProofClicked = false,
      residenceProofClicked = false,
      salarySlipClicked = false,
      signatureProofClicked = false,
      copyOfPropertyClicked = false,
      qualificationProofClicked = false,
      sectorEmployeePvtClicked = false,
      totalWorkExpClicked = false,
      WorkExpClicked = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdata();
    updateDocumentStatus();
    getDropDownDocumentData();
  //  checkApplicationFormStatus();

  }
  Future<void> updateDocumentStatus() async {
    // Retrieve document IDs from Firestore
    var data = await FirebaseFirestore.instance.collection("convertedLeads").doc(widget.docId).get();

    setState(() {
      // Update the status variables based on retrieved document IDs
      if (data.exists) {
        applicationForm = data["Application_Form"] == null ? "Not Uploaded" : "Uploaded";
        bankPassbook = data["Bank_PassBook"] == null ? "Not Uploaded" : "Uploaded";
        dateOfBirthProof = data["Date_Of_Birth"] == null ? "Not Uploaded" : "Uploaded";
        loginFeeCheque = data["Login_Fee_Check"] == null ? "Not Uploaded" : "Uploaded";
        passportSizePhoto = data["Passport_Size_Photo"] == null ? "Not Uploaded" : "Uploaded";
        photoIdProof = data["Photo_Id_Proof"] == null ? "Not Uploaded" : "Uploaded";
        residenceProof = data["Residence_Proof"] == null ? "Not Uploaded" : "Uploaded";
        salarySlip = data["Salary_Slip"] == null ? "Not Uploaded" : "Uploaded";
        signatureProof = data["Signature_Proof"] == null ? "Not Uploaded" : "Uploaded";
        copyOfProperty = data["Copy_Of_Property"] == null ? "Not Uploaded" : "Uploaded";
        totalWorkExp = data["Total_Work_Experience"] == null ? "Not Uploaded" : "Uploaded";
        qualificationProof = data["Qualification_Proof"] == null ? "Not Uploaded" : "Uploaded";
        // Repeat this for other documents
      }
    });
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
            builder: (context) => ApplicantDetailsView(),
          ),
        );
        // Prevent the default back navigation
        return false;
      },
      child: SafeArea(child: Scaffold(
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
              // isVerification == false ?
              // GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       isVerification = true;
              //     });
              //   },
              //   child: Container(
              //     alignment: Alignment.centerRight,
              //     margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              //     child: Container(
              //       alignment: Alignment.center,
              //       height: 50.0,
              //       width: width * 0.5,
              //       decoration: new BoxDecoration(
              //           borderRadius: BorderRadius.circular(80.0),
              //           gradient: new LinearGradient(
              //               colors: [
              //                 // Color.fromARGB(255, 168, 2, 2),
              //                 // Color.fromARGB(255, 206, 122, 122)
              //                 Color.fromARGB(255, 61, 169, 83),
              //                 Color.fromARGB(255, 131, 190, 143)
              //               ]
              //           )
              //       ),
              //       padding: const EdgeInsets.all(0),
              //       child: Text(
              //         "Verify",
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontWeight: FontWeight.bold,
              //           fontSize: 16
              //         ),
              //       ),
              //     ),
              //   ),
              // ) : SizedBox.shrink(),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                Text(
                  "Required Documents",
                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: StyleData.boldFont,
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                const Text(
                  "Application Form *",
                  style: TextStyle(color: Colors.black38, fontSize: 13),
                ),
                SizedBox(
                  height: height * 0.001,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      applicationFormClicked= true;
                      bankPassbookClicked = false;
                      dateOfBirthClicked = false;
                      loginFeeChequeClicked = false;
                      passportSizePhotoClicked = false;
                      photoIdProofClicked = false;
                      residenceProofClicked = false;
                      salarySlipClicked = false;
                      signatureProofClicked = false;
                      copyOfPropertyClicked = false;
                      qualificationProofClicked = false;
                      sectorEmployeePvtClicked = false;
                      totalWorkExpClicked = false;
                      WorkExpClicked = false;
                    });
                    selectSource(height, width);
                  },
                  child: DottedBorder(
                    color: Colors.black87,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    padding: const EdgeInsets.all(6),
                    child: ClipRRect(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(12)),
                      child: Container(
                        height: height * 0.07,
                        width: width * 0.9,
                        color: Colors.grey[200],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  color: Colors.black54,
                                  size: 26,
                                ),
                                Text(
                                  "/",
                                  style: TextStyle(  color: Colors.black54,),
                                ),
                                Icon(Icons.arrow_circle_up_rounded,
                                    color: Colors.black54, size: 26),
                              ],
                            ),
                            SizedBox(height: height * 0.01),
                            Text(
                              applicationForm ?? "Application form",
                              style: TextStyle(
                                color: applicationForm != null ? Colors.red : Colors.grey,
                                fontSize: 12,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ), // Change the splash color to red
                ),

                SizedBox(
                  height: height * 0.006,
                ),
                const Text(
                  "Bank Passbook *",
                  style: TextStyle(color: Colors.black38, fontSize: 13),
                ),
                SizedBox(
                  height: height * 0.001,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      bankPassbookClicked = true;
                      applicationFormClicked = false;
                      dateOfBirthClicked = false;
                      loginFeeChequeClicked = false;
                      passportSizePhotoClicked = false;
                      photoIdProofClicked = false;
                      residenceProofClicked = false;
                      salarySlipClicked = false;
                      signatureProofClicked = false;
                      copyOfPropertyClicked = false;
                      qualificationProofClicked = false;
                      sectorEmployeePvtClicked = false;
                      totalWorkExpClicked = false;
                      WorkExpClicked = false;
                    });
                    selectSource(height, width);
                  },
                  child: DottedBorder(
                    color: Colors.black87,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    padding: const EdgeInsets.all(6),
                    child: ClipRRect(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(12)),
                      child: Container(
                          height: height * 0.07,
                          width: width * 0.9,
                          color: Colors.grey[200],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    color: Colors.black54,
                                    size: 26,
                                  ),
                                  Text(
                                    "/",
                                    style: TextStyle(  color: Colors.black54,),
                                  ),
                                  Icon(Icons.arrow_circle_up_rounded,
                                      color: Colors.black54, size: 26),
                                ],
                              ),
                              SizedBox(height: height * 0.01),
                              Text(
                                bankPassbook ??
                                    "Bank Passbook",
                                style: TextStyle(
                                  color: bankPassbook != null ? Colors.red : Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.006,
                ),
                const Text(
                  "Date Of Birth Proof *",
                  style: TextStyle(color: Colors.black38, fontSize: 13),
                ),
                SizedBox(
                  height: height * 0.001,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      dateOfBirthClicked = true;
                      bankPassbookClicked = false;
                      applicationFormClicked = false;
                      loginFeeChequeClicked = false;
                      passportSizePhotoClicked = false;
                      photoIdProofClicked = false;
                      residenceProofClicked = false;
                      salarySlipClicked = false;
                      signatureProofClicked = false;
                      copyOfPropertyClicked = false;
                      qualificationProofClicked = false;
                      sectorEmployeePvtClicked = false;
                      totalWorkExpClicked = false;
                      WorkExpClicked = false;
                    });
                    selectSource(height, width);
                  },
                  child: DottedBorder(
                    color: Colors.black87,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    padding: const EdgeInsets.all(6),
                    child: ClipRRect(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(12)),
                      child: Container(
                          height: height * 0.07,
                          width: width * 0.9,
                          color: Colors.grey[200],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    color: Colors.black54,
                                    size: 26,
                                  ),
                                  Text(
                                    "/",
                                    style: TextStyle(  color: Colors.black54,),
                                  ),
                                  Icon(Icons.arrow_circle_up_rounded,
                                      color: Colors.black54, size: 26),
                                ],
                              ),
                              SizedBox(height: height * 0.01),
                              Text(
                                dateOfBirthProof ??
                                    "Date of Birth proof",
                                style: TextStyle(
                                  color: dateOfBirthProof != null ? Colors.red : Colors.grey,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                ),
                                  SizedBox(
                                    height: height * 0.006,
                                  ),
                                  const Text(
                                    "Login Fee Cheque *",
                                    style: TextStyle(color: Colors.black38, fontSize: 13),
                                  ),
                                  SizedBox(
                                    height: height * 0.001,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        loginFeeChequeClicked = true;
                                        dateOfBirthClicked = false;
                                        bankPassbookClicked = false;
                                        applicationFormClicked = false;
                                        passportSizePhotoClicked = false;
                                        photoIdProofClicked = false;
                                        residenceProofClicked = false;
                                        salarySlipClicked = false;
                                        signatureProofClicked = false;
                                        copyOfPropertyClicked = false;
                                        qualificationProofClicked = false;
                                        sectorEmployeePvtClicked = false;
                                        totalWorkExpClicked = false;
                                        WorkExpClicked = false;
                                      });
                                      selectSource(height, width);
                                    },
                                    child: DottedBorder(
                                      color: Colors.black87,
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(12),
                                      padding: const EdgeInsets.all(6),
                                      child: ClipRRect(
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(12)),
                                        child: Container(
                                            height: height * 0.07,
                                            width: width * 0.9,
                                            color: Colors.grey[200],
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt,
                                                      color: Colors.black54,
                                                      size: 26,
                                                    ),
                                                    Text(
                                                      "/",
                                                      style: TextStyle(  color: Colors.black54,),
                                                    ),
                                                    Icon(Icons.arrow_circle_up_rounded,
                                                        color: Colors.black54, size: 26),
                                                  ],
                                                ),
                                                SizedBox(height: height * 0.01),
                                                Text(
                                                  loginFeeCheque ??
                                                      "Login Fee Cheque",
                                                  style: TextStyle(
                                                    color: loginFeeCheque != null ? Colors.red : Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                )
                                              ],
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.006,
                                  ),
                                  const Text(
                                    "Passport Size Photo *",
                                    style: TextStyle(color: Colors.black38, fontSize: 13),
                                  ),
                                  SizedBox(
                                    height: height * 0.001,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        passportSizePhotoClicked = true;
                                        dateOfBirthClicked = false;
                                        bankPassbookClicked = false;
                                        applicationFormClicked = false;
                                        loginFeeChequeClicked = false;
                                        photoIdProofClicked = false;
                                        residenceProofClicked = false;
                                        salarySlipClicked = false;
                                        signatureProofClicked = false;
                                        copyOfPropertyClicked = false;
                                        qualificationProofClicked = false;
                                        sectorEmployeePvtClicked = false;
                                        totalWorkExpClicked = false;
                                        WorkExpClicked = false;
                                      });
                                      selectSource(height, width);
                                    },
                                    child: DottedBorder(
                                      color: Colors.black87,
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(12),
                                      padding: const EdgeInsets.all(6),
                                      child: ClipRRect(
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(12)),
                                        child: Container(
                                            height: height * 0.07,
                                            width: width * 0.9,
                                            color: Colors.grey[200],
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt,
                                                      color: Colors.black54,
                                                      size: 26,
                                                    ),
                                                    Text(
                                                      "/",
                                                      style: TextStyle(  color: Colors.black54,),
                                                    ),
                                                    Icon(Icons.arrow_circle_up_rounded,
                                                        color: Colors.black54, size: 26),
                                                  ],
                                                ),
                                                SizedBox(height: height * 0.01),
                                                Text(
                                                  passportSizePhoto ??
                                                      "Passport Size Photo",
                                                  style: TextStyle(
                                                    color: passportSizePhoto != null ? Colors.red : Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                )
                                              ],
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.006,
                                  ),
                                  const Text(
                                    "Photo ID Proof *",
                                    style: TextStyle(color: Colors.black38, fontSize: 13),
                                  ),
                                  SizedBox(
                                    height: height * 0.001,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        photoIdProofClicked = true;
                                        passportSizePhotoClicked = false;
                                        dateOfBirthClicked = false;
                                        bankPassbookClicked = false;
                                        applicationFormClicked = false;
                                        loginFeeChequeClicked = false;
                                        residenceProofClicked = false;
                                        salarySlipClicked = false;
                                        signatureProofClicked = false;
                                        copyOfPropertyClicked = false;
                                        qualificationProofClicked = false;
                                        sectorEmployeePvtClicked = false;
                                        totalWorkExpClicked = false;
                                        WorkExpClicked = false;
                                      });
                                      selectSource(height, width);
                                    },
                                    child: DottedBorder(
                                      color: Colors.black87,
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(12),
                                      padding: const EdgeInsets.all(6),
                                      child: ClipRRect(
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(12)),
                                        child: Container(
                                            height: height * 0.07,
                                            width: width * 0.9,
                                            color: Colors.grey[200],
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt,
                                                      color: Colors.black54,
                                                      size: 26,
                                                    ),
                                                    Text(
                                                      "/",
                                                      style: TextStyle(  color: Colors.black54,),
                                                    ),
                                                    Icon(Icons.arrow_circle_up_rounded,
                                                        color: Colors.black54, size: 26),
                                                  ],
                                                ),
                                                SizedBox(height: height * 0.01),
                                                Text(
                                                  photoIdProof ??
                                                      "Photo ID Proof",
                                                  style: TextStyle(
                                                    color: photoIdProof != null ? Colors.red : Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                )
                                              ],
                                            )),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: height * 0.006,
                                  ),
                                  const Text(
                                    "Residence Proof *",
                                    style: TextStyle(color: Colors.black38, fontSize: 13),
                                  ),
                                  SizedBox(
                                    height: height * 0.001,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        residenceProofClicked = true;
                                        photoIdProofClicked = false;
                                        passportSizePhotoClicked = false;
                                        dateOfBirthClicked = false;
                                        bankPassbookClicked = false;
                                        applicationFormClicked = false;
                                        loginFeeChequeClicked = false;
                                        salarySlipClicked = false;
                                        signatureProofClicked = false;
                                        copyOfPropertyClicked = false;
                                        qualificationProofClicked = false;
                                        sectorEmployeePvtClicked = false;
                                        totalWorkExpClicked = false;
                                        WorkExpClicked = false;
                                      });
                                      selectSource(height, width);
                                    },
                                    child: DottedBorder(
                                      color: Colors.black87,
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(12),
                                      padding: const EdgeInsets.all(6),
                                      child: ClipRRect(
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(12)),
                                        child: Container(
                                            height: height * 0.07,
                                            width: width * 0.9,
                                            color: Colors.grey[200],
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt,
                                                      color: Colors.black54,
                                                      size: 26,
                                                    ),
                                                    Text(
                                                      "/",
                                                      style: TextStyle(  color: Colors.black54,),
                                                    ),
                                                    Icon(Icons.arrow_circle_up_rounded,
                                                        color: Colors.black54, size: 26),
                                                  ],
                                                ),
                                                SizedBox(height: height * 0.01),
                                                Text(
                                                  residenceProof ??
                                                      "Residence Proof",
                                                  style: TextStyle(
                                                    color: residenceProof != null ? Colors.red : Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                )
                                              ],
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.006,
                                  ),
                                  const Text(
                                    "Salary Slip *",
                                    style: TextStyle(color: Colors.black38, fontSize: 13),
                                  ),
                                  SizedBox(
                                    height: height * 0.001,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        salarySlipClicked = true;
                                        signatureProofClicked = false;
                                        residenceProofClicked = false;
                                        photoIdProofClicked = false;
                                        passportSizePhotoClicked = false;
                                        dateOfBirthClicked = false;
                                        bankPassbookClicked = false;
                                        applicationFormClicked = false;
                                        loginFeeChequeClicked = false;
                                        copyOfPropertyClicked = false;
                                        qualificationProofClicked = false;
                                        sectorEmployeePvtClicked = false;
                                        totalWorkExpClicked = false;
                                        WorkExpClicked = false;
                                      });
                                      selectSource(height, width);
                                    },
                                    child: DottedBorder(
                                      color: Colors.black87,
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(12),
                                      padding: const EdgeInsets.all(6),
                                      child: ClipRRect(
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(12)),
                                        child: Container(
                                            height: height * 0.07,
                                            width: width * 0.9,
                                            color: Colors.grey[200],
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt,
                                                      color: Colors.black54,
                                                      size: 26,
                                                    ),
                                                    Text(
                                                      "/",
                                                      style: TextStyle(  color: Colors.black54,),
                                                    ),
                                                    Icon(Icons.arrow_circle_up_rounded,
                                                        color: Colors.black54, size: 26),
                                                  ],
                                                ),
                                                SizedBox(height: height * 0.01),
                                                Text(
                                                  salarySlip ??
                                                      "Salary Slip",
                                                  style: TextStyle(
                                                    color: salarySlip != null ? Colors.red : Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                )
                                              ],
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.006,
                                  ),
                                  const Text(
                                    "Signature Proof *",
                                    style: TextStyle(color: Colors.black38, fontSize: 13),
                                  ),
                                  SizedBox(
                                    height: height * 0.001,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        signatureProofClicked = true;
                                        residenceProofClicked = false;
                                        photoIdProofClicked = false;
                                        passportSizePhotoClicked = false;
                                        dateOfBirthClicked = false;
                                        bankPassbookClicked = false;
                                        applicationFormClicked = false;
                                        loginFeeChequeClicked = false;
                                        salarySlipClicked = false;
                                        copyOfPropertyClicked = false;
                                        qualificationProofClicked = false;
                                        sectorEmployeePvtClicked = false;
                                        totalWorkExpClicked = false;
                                        WorkExpClicked = false;
                                      });
                                      selectSource(height, width);
                                    },
                                    child: DottedBorder(
                                      color: Colors.black87,
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(12),
                                      padding: const EdgeInsets.all(6),
                                      child: ClipRRect(
                                        borderRadius:
                                              const BorderRadius.all(Radius.circular(12)),
                                              child: Container(
                                                height: height * 0.07,
                                                width: width * 0.9,
                                                color: Colors.grey[200],
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt,
                                                      color: Colors.black54,
                                                      size: 26,
                                                    ),
                                                    Text(
                                                      "/",
                                                      style: TextStyle(  color: Colors.black54,),
                                                    ),
                                                    Icon(Icons.arrow_circle_up_rounded,
                                                        color: Colors.black54, size: 26),
                                                  ],
                                                ),
                                                SizedBox(height: height * 0.01),
                                                Text(
                                                  signatureProof ??
                                                      "Signature Proof",
                                                  style: TextStyle(
                                                    color: signatureProof != null ? Colors.red : Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                )
                                              ],
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.05,
                                  ),
                                  Text(
                                    "Optional Documents",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontFamily: StyleData.boldFont,
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  const Text(
                                    "Copy Of Property",
                                    style: TextStyle(color: Colors.black38, fontSize: 13),
                                  ),
                                  SizedBox(
                                    height: height * 0.001,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        copyOfPropertyClicked = true;
                                        applicationFormClicked= false;
                                        bankPassbookClicked = false;
                                        dateOfBirthClicked = false;
                                        loginFeeChequeClicked = false;
                                        passportSizePhotoClicked = false;
                                        photoIdProofClicked = false;
                                        residenceProofClicked = false;
                                        salarySlipClicked = false;
                                        signatureProofClicked = false;
                                        qualificationProofClicked = false;
                                        sectorEmployeePvtClicked = false;
                                        totalWorkExpClicked = false;
                                        WorkExpClicked = false;
                                      });
                                      selectSource(height, width);
                                    },
                                    child: DottedBorder(
                                      color: Colors.black87,
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(12),
                                      padding: const EdgeInsets.all(6),
                                      child: ClipRRect(
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(12)),
                                        child: Container(
                                          height: height * 0.07,
                                          width: width * 0.9,
                                          color: Colors.grey[200],
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.camera_alt,
                                                    color: Colors.black54,
                                                    size: 26,
                                                  ),
                                                  Text(
                                                    "/",
                                                    style: TextStyle(  color: Colors.black54,),
                                                  ),
                                                  Icon(Icons.arrow_circle_up_rounded,
                                                      color: Colors.black54, size: 26),
                                                ],
                                              ),
                                              SizedBox(height: height * 0.01),
                                              Text(
                                                copyOfProperty ?? "Copy Of Property",
                                                style: TextStyle(
                                                  color: copyOfProperty != null ? Colors.red : Colors.grey,
                                                  fontSize: 12,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ), // Change the splash color to red
                                  ),
                                  SizedBox(
                                    height: height * 0.006,
                                  ),
                                  const Text(
                                    "Total work experience",
                                    style: TextStyle(color: Colors.black38, fontSize: 13),
                                  ),
                                  SizedBox(
                                    height: height * 0.001,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        totalWorkExpClicked = true;
                                        copyOfPropertyClicked = false;
                                        applicationFormClicked= false;
                                        bankPassbookClicked = false;
                                        dateOfBirthClicked = false;
                                        loginFeeChequeClicked = false;
                                        passportSizePhotoClicked = false;
                                        photoIdProofClicked = false;
                                        residenceProofClicked = false;
                                        salarySlipClicked = false;
                                        signatureProofClicked = false;
                                        qualificationProofClicked = false;
                                        sectorEmployeePvtClicked = false;
                                        WorkExpClicked = false;
                                      });
                                      selectSource(height, width);
                                    },
                                    child: DottedBorder(
                                      color: Colors.black87,
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(12),
                                      padding: const EdgeInsets.all(6),
                                      child: ClipRRect(
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(12)),
                                        child: Container(
                                          height: height * 0.07,
                                          width: width * 0.9,
                                          color: Colors.grey[200],
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.camera_alt,
                                                    color: Colors.black54,
                                                    size: 26,
                                                  ),
                                                  Text(
                                                    "/",
                                                    style: TextStyle(  color: Colors.black54,),
                                                  ),
                                                  Icon(Icons.arrow_circle_up_rounded,
                                                      color: Colors.black54, size: 26),
                                                ],
                                              ),
                                              SizedBox(height: height * 0.01),
                                              Text(
                                                totalWorkExp ?? "Total Work Experience",
                                                style: TextStyle(
                                                  color: totalWorkExp != null ? Colors.red : Colors.grey,
                                                  fontSize: 12,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ), // Change the splash color to red
                                  ),
                                  SizedBox(
                                    height: height * 0.006,
                                  ),
                                  const Text(
                                    "Qualification Proof",
                                    style: TextStyle(color: Colors.black38, fontSize: 13),
                                  ),
                                  SizedBox(
                                    height: height * 0.001,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        qualificationProofClicked = true;
                                        totalWorkExpClicked = false;
                                        copyOfPropertyClicked = false;
                                        applicationFormClicked= false;
                                        bankPassbookClicked = false;
                                        dateOfBirthClicked = false;
                                        loginFeeChequeClicked = false;
                                        passportSizePhotoClicked = false;
                                        photoIdProofClicked = false;
                                        residenceProofClicked = false;
                                        salarySlipClicked = false;
                                        signatureProofClicked = false;
                                        sectorEmployeePvtClicked = false;
                                        WorkExpClicked = false;
                                      });
                                      selectSource(height, width);
                                    },
                                    child: DottedBorder(
                                      color: Colors.black87,
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(12),
                                      padding: const EdgeInsets.all(6),
                                      child: ClipRRect(
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(12)),
                                        child: Container(
                                          height: height * 0.07,
                                          width: width * 0.9,
                                          color: Colors.grey[200],
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.camera_alt,
                                                    color: Colors.black54,
                                                    size: 26,
                                                  ),
                                                  Text(
                                                    "/",
                                                    style: TextStyle(  color: Colors.black54,),
                                                  ),
                                                  Icon(Icons.arrow_circle_up_rounded,
                                                      color: Colors.black54, size: 26),
                                                ],
                                              ),
                                              SizedBox(height: height * 0.01),
                                              Text(
                                                qualificationProof ?? "Qualification Proof",
                                                style: TextStyle(
                                                  color: qualificationProof != null ? Colors.red : Colors.grey,
                                                  fontSize: 12,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ), // Change the splash color to red
                                  ),
                                  SizedBox(
                                    height: height * 0.03,
                                  ),
                                  Container(
                                    height: 55,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: StyleData.appBarColor2,
                                    ),

                                    child: Center(
                                      child: ElevatedButton(
                                        onPressed: () {
                                              if(applicationForm == "Uploaded" && bankPassbook == "Uploaded" && dateOfBirthProof == "Uploaded" && loginFeeCheque == "Uploaded"
                                                  && passportSizePhoto == "Uploaded" && photoIdProof == "Uploaded" && residenceProof == "Uploaded" && salarySlip == "Uploaded"
                                                  && signatureProof == "Uploaded"
                                              )
                                                {
                                                  _showAlertDialogSuccess(context);
                                                }
                                              else
                                                {
                                                  CustomSnackBar.errorSnackBarQ("Please upload Manadtory Documents", context);
                                                }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.save_outlined, color: Colors.white,),
                                            SizedBox(width: width * 0.025,),
                                            Text(
                                              'Save',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
              ),
              //
              // SizedBox(
              //   height:  height * 0.5,
              // ),
            ],
          ),
        ),
      )
      ),
    );
  }

  selectSource(height, width) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        barrierColor: Colors.blueGrey.withOpacity(0.7),
        backgroundColor: Colors.black,
        builder: (BuildContext context) {
          return SizedBox(
            height: height * 0.2,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: height * 0.015),
                child: ListView(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: StyleData.background,
                        child: const Center(
                          child: Icon(Icons.camera, color: Colors.black),
                        ),
                      ),
                      title: const Text("Take Camera",
                          style: TextStyle(color: Colors.white60)),
                      onTap: () async {
                        Navigator.pop(context);
                        var pickedFile = await ImagePicker().pickImage(
                            source: ImageSource.camera,
                            maxHeight: 640,
                            maxWidth: 820,
                            imageQuality: 60);
                        print(pickedFile);
                        if (applicationFormClicked) {
                          print("Yessss");
                          uploadOnDMS(pickedFile, "Application_Form");
                        } else if (bankPassbookClicked) {
                          uploadOnDMS(pickedFile, "Bank_Passbook");
                        }
                        else if (dateOfBirthClicked) {
                          uploadOnDMS(pickedFile, "Date_Of_Birth");
                        } else if (loginFeeChequeClicked) {
                          uploadOnDMS(pickedFile, "Login_Fee_Check");
                        } else if (passportSizePhotoClicked) {
                          uploadOnDMS(pickedFile, "Passport_Size_Photo");
                        } else if (photoIdProofClicked) {
                          uploadOnDMS(pickedFile, "Photo_Id_Proof");
                        } else if (residenceProofClicked) {
                          uploadOnDMS(pickedFile, "Residence_Proof");
                        } else if (salarySlipClicked) {
                          uploadOnDMS(pickedFile, "Salary_Slip");
                        } else if (signatureProofClicked) {
                          uploadOnDMS(pickedFile, "Signature_Proof");
                        } else if (copyOfPropertyClicked) {
                          uploadOnDMS(pickedFile, "Copy_Of_Property");
                        }else if (totalWorkExpClicked) {
                          uploadOnDMS(pickedFile, "Total_Work_Experience");
                        }else if (WorkExpClicked) {
                          uploadOnDMS(pickedFile, "Work_Experience");
                        }else if (qualificationProofClicked) {
                          uploadOnDMS(pickedFile, "Qualification_Proof");
                        }
                      },
                      trailing: Icon(
                        Icons.arrow_circle_right_rounded,
                        color: StyleData.background,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: SizedBox(
                          width: width * 0.7,
                          child: const Divider(
                            color: Colors.black26,
                            thickness: 0.4,
                          )),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: StyleData.background,
                        child: const Center(
                          child: Icon(
                            Icons.image,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      title: const Text(
                        "Select From Gallery",
                        style: TextStyle(color: Colors.white60),
                      ),
                      onTap: () async {
                        Navigator.pop(context);
                        FilePickerResult? pickedFiles =
                        await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
                          allowCompression: true,
                          allowMultiple: false,
                        );
                      //  pickedFiles?.files.first
                        print(pickedFiles);
                        if (applicationFormClicked) {
                          uploadOnDMS(pickedFiles?.files.first , "Application_Form");
                        } else if (bankPassbookClicked) {
                          uploadOnDMS(pickedFiles?.files.first, "Bank_PassBook");
                        }
                        else if (dateOfBirthClicked) {
                          uploadOnDMS(pickedFiles?.files.first , "Date_Of_Birth");
                        } else if (loginFeeChequeClicked) {
                          uploadOnDMS(pickedFiles?.files.first , "Login_Fee_Check");
                        } else if (passportSizePhotoClicked) {
                          uploadOnDMS(pickedFiles?.files.first , "Passport_Size_Photo");
                        } else if (photoIdProofClicked) {
                          uploadOnDMS(pickedFiles?.files.first , "Photo_Id_Proof");
                        } else if (residenceProofClicked) {
                          uploadOnDMS(pickedFiles?.files.first , "Residence_Proof");
                        } else if (salarySlipClicked) {
                          uploadOnDMS(pickedFiles?.files.first , "Salary_Slip");
                        } else if (signatureProofClicked) {
                          uploadOnDMS(pickedFiles?.files.first , "Signature_Proof");
                        } else if (copyOfPropertyClicked) {
                          uploadOnDMS(pickedFiles?.files.first , "Copy_Of_Property");
                        }else if (totalWorkExpClicked) {
                          uploadOnDMS(pickedFiles?.files.first , "Total_Work_Experience");
                        }else if (WorkExpClicked) {
                          uploadOnDMS(pickedFiles?.files.first , "Work_Experience");
                        }else if (qualificationProofClicked) {
                          uploadOnDMS(pickedFiles?.files.first , "Qualification_Proof");
                        }
                      },
                      trailing: Icon(
                        Icons.arrow_circle_right_rounded,
                        color: StyleData.background,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
  void uploadOnDMS(var pickedFile, String title) async {
    //New Implementation for saving application PDF
print("bhjkjhlknl");
    Dialogs.materialDialog(
        msg: 'Are you sure you want to upload this document?',
        title: "Alert",
        msgStyle:
        TextStyle(color: Colors.grey, fontFamily: StyleData.boldFont),
        titleStyle: const TextStyle(color: Colors.white),
        color: StyleData.appBarColor2,
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
              onTap: () async {
                Navigator.pop(context);
              SmartDialog.showLoading(msg: "Uploading Document");
                var dio = Dio();
                try {
                  FormData formData = FormData.fromMap({
                    "File": await MultipartFile.fromFile(
                      pickedFile!.path,
                      filename: pickedFile.name,
                  //    contentType: MediaType("pdf", "jpg"), //add this
                      contentType:  _getContentType(pickedFile.name), //add this
                    ),
                    "Title": widget.visitID,
                    "Description": "Document Verification",
                    "Tags": "HomeFin",
                    "IsPasswordProtected": "0",
                    "Password": "0",
                    "LUSR": "HomeFin",
                  });
                  print(formData);
                  formData.files.addAll([
                    MapEntry(
                        "File",
                        await MultipartFile.fromFile(pickedFile!.path,
                            filename: pickedFile.name,
                            contentType: MediaType('application', 'pdf')))
                  ]);
                  (dio.httpClientAdapter as DefaultHttpClientAdapter)
                      .onHttpClientCreate = (client) {
                    client.badCertificateCallback =
                        (X509Certificate cert, String host, int port) => true;
                  };
                  dio.options.headers['Content-Type'] = 'multipart/form-data';
                  // dio.options.headers['Host'] = '6cpduvi80d.execute-api.ap-south-1.amazonaws.com';

                  var response = await dio.post(
                    ApiUrls().uploadDoc,
                    data: formData,
                    onSendProgress: (int sent, int total) {
                      debugPrint("sent${sent.toString()}" +
                          " total${total.toString()}");
                    },
                  ).whenComplete(() {
                    debugPrint("complete:");
                  }).catchError((onError) {
                    debugPrint("complete1");
                    SmartDialog.dismiss();
                  });
                  print(response);
                  var data = json.decode(response.toString());
                  print(data);
                  FirebaseFirestore.instance
                      .collection("convertedLeads")
                      .doc(widget.docId)
                      .set({
                    title: data["docId"].toString(),
                  }, SetOptions(merge: true));
                  SmartDialog.dismiss();
                  if (applicationFormClicked) {
                    print(ApplicationDocID);
                    setState(() {
                      applicationForm ="Uploaded";
                    });

                  } else if (bankPassbookClicked) {
                    setState(() {
                      bankPassbook = "Uploaded";
                    });

                  }
                  else if (dateOfBirthClicked) {
                    setState(() {
                      dateOfBirthProof = "Uploaded";
                    });
                    // SharedPreferences prefs = await SharedPreferences.getInstance();
                    // await prefs.setString("dateOfBirthProof", "Uploaded");
                  } else if (loginFeeChequeClicked) {
                    setState(() {
                      loginFeeCheque = "Uploaded";
                    });
                  } else if (passportSizePhotoClicked) {
                    setState(() {
                      passportSizePhoto = "Uploaded";
                    });
                  } else if (photoIdProofClicked) {
                    setState(() {
                      photoIdProof = "Uploaded";
                    });
                  } else if (residenceProofClicked) {
                    setState(() {
                      residenceProof = "Uploaded";
                    });
                  } else if (salarySlipClicked) {
                    setState(() {
                      salarySlip = "Uploaded";
                    });

                  } else if (signatureProofClicked) {
                    setState(() {
                      signatureProof = "Uploaded";
                    });

                  } else if (copyOfPropertyClicked) {
                    setState(() {
                      copyOfProperty = "Uploaded";
                    });

                  }else if (totalWorkExpClicked) {
                    setState(() {
                      totalWorkExp = "Uploaded";
                    });
                  }else if (qualificationProofClicked) {
                    setState(() {
                      qualificationProof = "Uploaded";
                    });
                  }
                } catch (e) {
                  SmartDialog.dismiss();
                  debugPrint(e.toString());
                }
              },
              child: Container(
                height: 40,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                    child: Text('Yes',
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
          )
        ]);
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
              height:190,
              width: 200,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child:
                    Container(
                      height: 80,
                      width: 60,
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
                  Text('Documents uploaded Succesfully', textAlign: TextAlign.center, style: TextStyle(color: Colors.black87,fontSize: 18,),),
                  //  SizedBox(height: 8),
                  SizedBox(height: 5),
                  SizedBox(
                    height: 25,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ApplicantDetailsView(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
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
MediaType _getContentType(String fileName) {
  String extension = fileName.split('.').last.toLowerCase();
  if (extension == 'pdf') {
    return MediaType('application', 'pdf');
  } else if (extension == 'jpg' || extension == 'jpeg') {
    return MediaType('image', 'jpeg');
  } else if (extension == 'png') {
    return MediaType('image', 'png');
  } else {
    // Handle other file types here if needed
    return MediaType('application', 'octet-stream'); // Default content type
  }
}
