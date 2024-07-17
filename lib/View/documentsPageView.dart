import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lead_management_system/View/HomePageView.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/Response/DropDownModel.dart';
import '../Model/apiurls.dart';
import '../Utils/CustomeSnackBar.dart';
import '../Utils/StyleData.dart';
import 'DocumentCheckListPageView.dart';

class DocumentPageView extends StatefulWidget {
  final bool isNewActivity;
  final bool isTechChecklist;
  final bool isPartiallyVerifiedLeads;
  final String visitID;
  final String docId;
  final String leadID;
  const DocumentPageView({Key? key,
    required this.visitID,required this.docId,required this.isNewActivity,required this.isTechChecklist,required this.leadID, required this.isPartiallyVerifiedLeads})
      : super(key: key);

  @override
  State<DocumentPageView> createState() => _DocumentPageViewState();
}

class _DocumentPageViewState extends State<DocumentPageView> {
  bool isVerification = false;
  XFile? pickedFile;
  String? accessToken;

  var userType;
  List<DocumentSnapshot> ListOfLeads = [];
  String? LeadID;
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
  String? email;
  String? firstName;
  String? middleName;
  String? lastName;
  String? additionalMobileNumber;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? landMark;
  String? city;
  String? district;
  String? pincode;
  String? postOffice;
  String? state;
  String? monthlyIncome;
  String? residentialStatus;
  String? residentialType;
  String? employeeCategory;
  String? customerProfile;
  String? salutaion;
  String? employeeCode;
  String? employeeName;
  String? ManagerCode;
  String? ManagerName;
  String? DSAConnectorCode;
  String? DSAConnectorName;
  String? CustomerStatus;
  String? latitude;
  String? longitude;
  String? leadAmount;
  String? ScheduledDate;
  String? scheduledTime;
  String? stateID;
  String? districtID;
  String? ReasonforDisinterest;
  String? propertyType;
  bool? isKycCheck;
  bool? isCrifCheck;
  var docData;

  String? ApplicationDocID;
  String? ApplicationDocID1;
  String? technicalChecklistStatus;

  String? selectedFilePathApplicationForm;
  String? selectedFilePathBankPassbook;
  String? selectedFilePathDateOfBirth;
  String? selectedFilePathLoginFeeCheque;
  String? selectedFilePathPassportPhoto;
  String? selectedFilePathPhotoIdProof;
  String? selectedFilePathResidenceProof;
  String? selectedFilePathSalarySlip;
  String? selectedFilePathSignatureProof;
  String? selectedFilePathCopyOfProperty;
  String? selectedFilePathTotalWorkExperience;
  String? selectedFilePathTotalQualificatioProof;

  String? VerificationStatus = "Pending";
  String VerificationStatusBy = "Pending";
  List<dynamic> mandatoryDocuments = [];
  List<dynamic> nonMandatoryDocuments = [];
  String? SelectedMandatoryDoc;
  bool documentCheck = false;
  bool isLoanApplicationDocument = false;
  bool isMandatoryDocument = false;
  bool isOptionalDocument = false;
  bool isMandatoryDocument1 = false;
  bool isOptionalDocument1 = false;
  String? isChecklist;
  Map<String, bool> documentCheckboxStates = {};
  Map<String, bool> nonMandocumentCheckboxStates = {};
  Map<String, String> uploadedFileNames = {};
  Map<String, String> uploadedFilePath = {};
  Map<String, String> uploadedFileNames1 = {};
  Map<String, String> uploadedFilePath1 = {};
  var checklistData;
  String? region;
  bool documentUploaded = false;
  bool documentUploaded1 = false;
  String uploadedFileName = '';
  String checklistName = '';
  String checklistName1 = '';
  int? mandatoryDocumentCount;
  int? nonMandatoryDocumentCount;
  int uploadedDocumentCount = 0;
  int uploadedDocumentCount1 = 0;
  XFile? pickedFileChecklist;
  FilePickerResult? pickedFiles;
  bool isTechChecklist = false;
  bool isTechChecklistNotExisting = false;
  String? LeadStatus;
  String? LeadCreatedDateTime;

  getLeadDetails() {
    if (!widget.isNewActivity) {
      CollectionReference users = FirebaseFirestore.instance.collection('convertedLeads');

      if (widget.visitID != null) {
        // If visitId exists, query with it
        users.where('VisitID', isEqualTo: widget.visitID).get().then((querySnapshot) async {
          if (querySnapshot.docs.isNotEmpty) {
            var value = querySnapshot.docs.first.data();
            setState(() {
              docData = value;
            });
            // Update your UI with fetched data
            updateUIWithFetchedData();
          }
        }).catchError((error) {
          // Handle errors
          print("Error fetching lead details: $error");
        });
      } else {
        // If visitId is null, proceed with existing logic
        users.doc(widget.docId).get().then((value) async {
          setState(() {
            docData = value.data();
          });
          // Update your UI with fetched data
        updateUIWithFetchedData();
        }).catchError((error) {
          // Handle errors
          print("Error fetching lead details: $error");
        });
      }
    } else {
      // setState(() {
      //   isFetching = false;
      // });
    }
  }

  Future<void> saveUploadedFileName(String fileName, String documentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(documentId, fileName);
  }
  Future<void> saveUploadedFileName1(String fileName, String documentId1) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(documentId1, fileName);
  }


  Future<String?> getUploadedFileName(String documentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(documentId);
  }
String? technicalDocumentStatus;
  int technicalChecklistCount = 0;
  String? QueryBy;

  void updateUIWithFetchedData() async {
    DateOfBirth = docData["dateOfBirth"] ?? "";
    LeadSource = docData["leadSource"] ?? "";
    email = docData["email"] ?? "";
    Gender = docData["gender"] ?? "";
    firstName = docData["firstName"] ?? "";
    middleName = docData["middleName"] ?? "";
    lastName = docData["lastName"] ?? "";
    additionalMobileNumber = docData["additionalNumber"] ?? "";
    addressLine1 = docData["addressLine1"] ?? "";
    addressLine2 = docData["addressLine2"] ?? "";
    addressLine3 = docData["addressLine3"] ?? "";
    landMark = docData["landmark"] ?? "";
    city = docData["city"] ?? "";
    district = docData["district"] ?? "";
    pincode = docData["pincode"] ?? "";
    postOffice = docData["postOffice"] ?? "";
    state= docData["state"] ?? "";
    productCategory = docData["productCategory"] ?? "";
    products = docData["products"] ?? "";
    monthlyIncome= docData["monthlyIncome"] ?? "";
    LeadAmount= docData["leadAmount"] ?? "";
    panCardNumber = docData["panCardNumber"] ?? "";
    aadharNumber= docData["aadharNumber"] ?? "";
    residentialStatus= docData["residentialStatus"] ?? "";
    residentialType = docData["residentialType"] ?? "";
    employeeCategory = docData["EmployeeCategory"] ?? "";
    customerProfile = docData["CustomerProfile"] ?? "";
    CustomerNumber = docData["customerNumber"] ?? "";
    propertyType = docData["propertyType"] ?? "";
    HomeFinBranchCode = docData["EmployeeBranchCode"] ?? "";
    salutation = docData["salutation"] ?? "";
    employeeName = docData["EmployeeName"] ?? "";
    employeeCode = docData["EmployeeCode"] ?? "";
    ManagerCode = docData["ManagerCode"] ?? "";
    ManagerName = docData["ManagerName"] ?? "";
    ManagerName = docData["ManagerName"] ?? "";
    isKycCheck = docData["ConsentKYC"] ?? "";
    isCrifCheck = docData["ConsentCRIF"] ?? "";
    DSAConnectorCode = docData["dsaConnectoreCode"] ?? "";
    DSAConnectorName = docData["dsaConnectorName"] ?? "";
    CustomerStatus = docData["CustomerStatus"] ?? "";
    latitude = docData["latitude"] ?? "";
    longitude = docData["longitude"] ?? "";
    ScheduledDate = docData["scheduledDate"] ?? "";
    scheduledTime = docData["scheduledTime"] ?? "";
    stateID = docData["stateID"] ?? "";
    districtID= docData["districtID"] ?? "";
    ReasonforDisinterest= docData["ReasonforDisinterest"] ?? "";
    VerificationStatus = docData['VerificationStatus'] ?? "";
    region = docData['Region'] ?? "";
    QueryBy = docData['QueryBy'] ?? "";
    isLoanApplicationDocument = docData["isLoanApplicationDocument"] == 'true' ? true : false;
    isMandatoryDocument = docData["isMandatoryDocument"] == 'true' ? true : false;
    isOptionalDocument = docData["isOptionalDocument"] == 'true' ? true : false;
    documentCheck = docData['isTechnicalChecklist'] == 'true' ? true : false;
    // Calculate the technicalChecklistCount and checklistCount
    technicalChecklistCount = docData.containsKey("technicalChecklistCount")
        ? (docData["technicalChecklistCount"] as int)
        : 0;
    int checklistCount = docData.keys
        .where((key) => key is String && key.endsWith("checklist"))
        .length;

    // Compare the counts and set technicalDocumentStatus
    if(technicalChecklistCount == 0)
      {
        technicalDocumentStatus = 'No Checklist';
      }
    else if (technicalChecklistCount == checklistCount) {
      technicalDocumentStatus = 'Fully Uploaded';
    } else {
      technicalDocumentStatus = 'Partially Uploaded';
    }
    print(technicalDocumentStatus);
 

    if(region != null)
      {
        _fetchDataFromFirestore();
        getLeadStatus();
      }
    else
      {

      }
  }

  Future<void> _fetchDataFromFirestore() async {
    try {
      // Access the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Access the "technicalChecklist" collection
      CollectionReference checklistCollection = firestore.collection('technicalChecklist');
      QuerySnapshot querySnapshot = await checklistCollection.get();
      bool dataFound = false;

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        for (int i = 0; i < documentSnapshot['technicalChecklist'].length; i++) {
          String? lowercaseRegion = region?.toLowerCase();
          String lowercaseProductCategory = productCategory!.toLowerCase();
          String lowercaseProducts = products!.toLowerCase();
          String lowercasePropertyType = propertyType!.toLowerCase();

          var technicalChecklistItem = documentSnapshot['technicalChecklist'][i];

          if (technicalChecklistItem.keys.any((k) => k.toString().toLowerCase() == lowercaseRegion)) {
            var regionKey = technicalChecklistItem.keys.firstWhere((k) => k.toString().toLowerCase() == lowercaseRegion);
            var regionData = technicalChecklistItem[regionKey];
            if (regionData.keys.any((k) => k.toString().toLowerCase() == lowercaseProductCategory)) {
              var productCategoryKey = regionData.keys.firstWhere((k) => k.toString().toLowerCase() == lowercaseProductCategory);
              var productData = regionData[productCategoryKey];
              if (productData.keys.any((k) => k.toString().toLowerCase() == lowercaseProducts)) {
                var productsKey = productData.keys.firstWhere((k) => k.toString().toLowerCase() == lowercaseProducts);
                var productsData = productData[productsKey];
                if (productsData.keys.any((k) => k.toString().toLowerCase() == lowercasePropertyType)) {
                  var propertyTypeKey = productsData.keys.firstWhere((k) => k.toString().toLowerCase() == lowercasePropertyType);
                  var propertyData = productsData[propertyTypeKey];
                  setState(() {
                    mandatoryDocuments = propertyData['Mandatory'] ?? [];
                    nonMandatoryDocuments = propertyData['Non Mandatory'] ?? [];
                    dataFound = true;
                    isTechChecklistNotExisting = false;  // Data found, set to false
                  });
                  return; // Exit the loop early if data is found
                }
              }
            }
          }
        }
      }

      // If no data was found, set the boolean and show error message
      if (!dataFound) {
        setState(() {
          isTechChecklistNotExisting = true;  // No data found, set to true
        });
        CustomSnackBar.errorSnackBarQ("Technical Checklist Not Available", context);
      }

    } catch (e) {
      CustomSnackBar.errorSnackBarQ("Technical Checklist Not Available", context);
      setState(() {
        isTechChecklistNotExisting = true;  // Error occurred, set to true
      });
     // log('Error fetching data: $e');
    }
  }





  // Future<void> _fetchDataFromFirestore() async {
  //   try {
  //     // Access the Firestore instance
  //     FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  //     // Access the "documentChecklist" collection
  //     CollectionReference checklistCollection = firestore.collection('documentChecklist');
  //     QuerySnapshot querySnapshot = await checklistCollection.get();
  //     for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
  //       for(int i = 0; i < documentSnapshot['documentChecklist'].length; i++){
  //         String? uppercaseRegion = region?.toUpperCase();
  //         // print('Value at index $i: ${documentSnapshot['documentChecklist'][0]} \n');
  //         documentSnapshot['documentChecklist'][i].forEach((key, value) {
  //           // print('Key: $key');
  //           if(key == uppercaseRegion) {
  //             setState(() {
  //               mandatoryDocuments = value[productCategory][products][propertyType]['Mandatory'];
  //               log(mandatoryDocuments.toString());
  //             });
  //           }
  //         });
  //       }
  //     }
  //   } catch (e) {
  //     CustomSnackBar.errorSnackBarQ("Technical Checklist Not Available", context);
  //     setState(() {
  //       isTechChecklist = true;
  //     });
  //     log('Error fetching data: $e');
  //   }
  // }

  var data;
  Future<String?> leadCreation() async {
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('access_token');
    var headers = {
      'Authorization':  'Bearer ${prefs.getString('access_token') ?? ''}',
      //  'Authorization':  'Bearer ${widget.accessToken ?? ''}',
      'Content-Type': 'application/json',
      'Cookie': 'BrowserId=qnhrXMyBEe6lOh9ncfvoTw; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    SharedPreferences pref =
    await SharedPreferences.getInstance();
    if( CustomerStatus == "Interested" ) {
     data = json.encode({
        "LastName": lastName ?? "",
        "FirstName": firstName ?? "",
        "MiddleName": middleName ?? "",
        "Salutation": salutation ?? "",
        "Email": email ?? "",
        "Phone": CustomerNumber ?? "",
        "HfinBranchcode": HomeFinBranchCode,
        "Product": productCategory,
        "Purpose": products ?? "",
        "DSAorConnectorName": DSAConnectorName ?? "",
        "DSAorConnectorCode": DSAConnectorCode ?? "",
        "LeadSource": LeadSource,
        "Interest": CustomerStatus ?? "",
        "Amount": LeadAmount ?? "",
        "DateOfBirth": DateOfBirth ?? "",
        "Gender": Gender ?? "",
        "AdditionalMobile": additionalMobileNumber ?? "",
        "ResidentStatus": residentialStatus ?? "",
        "ResidentType": residentialType ?? "",
        "Nationality": "Indian",
        "CustomerProfile": customerProfile ?? "",
        "MonthlyIncome": monthlyIncome ?? "",
        "EmployerCategory": employeeCategory ?? "",
        "Pan": panCardNumber ?? "",
        "Aadhaar": aadharNumber ?? "",
        "Address1": addressLine1 ?? "",
        "Address2": addressLine2 ?? "",
        "Address3": addressLine3 ?? "",
        "Landmark": landMark ?? "",
        "City": city ?? "",
        "State": stateID ?? "",
        "District": districtID ?? "",
        "PostalName": postOffice ?? "",
        "Pincode": pincode ?? "",
        "Country": "1",
        "Latitude": latitude,
        "Longitude": longitude,
        "ScheduleDate": ScheduledDate,
        "scheduleTime": scheduledTime,
        "AssignedSM": ManagerName,
        "LeadOwner": ManagerName,
        "PropertyType": propertyType,
        "ConsentForCrif": isCrifCheck,
        "ConsentForKyc": isKycCheck,
      //  "IsDocumentCollected": true,
        "isDirectLeads": true,
        "Createdby": employeeName,
        "CreatedbyCode": employeeCode
      });
    } else {
      data = json.encode({
        "LastName": lastName ?? "",
        "FirstName": firstName ?? "",
        "MiddleName": middleName ?? "",
        "Salutation": salutation ?? "",
        "Email": email ?? "",
        "Phone": CustomerNumber ?? "",
        "HfinBranchcode": HomeFinBranchCode,
        "DSAorConnectorName": DSAConnectorName ?? "",
        "DSAorConnectorCode": DSAConnectorCode ?? "",
        "LeadSource": LeadSource,
        "Interest": CustomerStatus ?? "",
        "ReasonforDisinterest": ReasonforDisinterest ?? "",
        "Latitude": latitude,
        "Longitude": longitude,
        "ScheduleDate": ScheduledDate,
        "scheduleTime": scheduledTime,
        "AssignedSM": ManagerName,
        "LeadOwner": ManagerName,
        "Createdby": employeeName,
        "CreatedbyCode": employeeCode
      });
    }

   // print(data);
    var dio = Dio();
    var response = await dio.request(
   ApiUrls().leadCreationProduction,
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    try {
      if (response.statusCode == 200) {
        //  Navigator.pop(context);
        var responseMap = response.data;
        String statusMessage = responseMap['statusMessage'];
        int statusCode = responseMap['statusCode'];

        if (statusMessage == "Lead created successfully" && statusCode == 200) {
          print(json.encode(responseMap));

          String sfLeadId = responseMap['SFleadId'];
          setState(() {
            LeadID = sfLeadId;
          });

          print("Lead ID");
          print(LeadID);
        _showAlertDialogSuccess2(context);
          updateDataToVisitFirestore();
          //  Navigator.pop(context);
        } else {
          _showAlertDialogSuccess1(context);
          Navigator.pop(context);
          _showToast('Error: Please try again');
        }
      } else {
        Navigator.pop(context);
        print("hjdjnvfv1223");
        //_showAlertDialogSuccess1(context);
        _showToast('Error: ${response.statusCode}');
        // _showAlertDialogSuccess1(context);
      }
    } catch (e) {
      Navigator.pop(context);
      print("hjdjnvfv");
      _showToast('Error: $e');
      print("Error: $e");
    }
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> getToken()
  async {
    var headers = {
      'X-PrettyPrint': '1',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'BrowserId=qnhrXMyBEe6lOh9ncfvoTw; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var data = {
      'grant_type': 'password',
      'client_id': ApiUrls().clientIdProduction,
      'client_secret': ApiUrls().clientSecretProduction,
      'username': ApiUrls().userNameProduction,
      'password': ApiUrls().passwordProduction
      // 'grant_type': 'password',
      // 'client_id': '3MVG9ct5lb5FGJTNKeeA63nutsPt.67SWB9mzXh9na.RBlkmz2FxM4KH31kKmHWMWQHD1y2apE9qmtoRtiQ9R',
      // 'client_secret': 'E9DDAF90143A7B4C6CA622463EFDA17843174AB347FD74A6905F853CD2406BDE',
      // 'username': 'itkrishnaprasad@muthootgroup.com.dev2',
      // 'password': 'Karthikrishna@127jb7htnfs8WigpiW5SOP6I7qZ'
    };
    var dio = Dio();
    var response = await dio.request(
      ApiUrls().accessTokenProduction,
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    String? accessToken;
    if (response.statusCode == 200) {

      String jsonResponse = json.encode(response.data);
      Map<String, dynamic> jsonMap = json.decode(jsonResponse);
      accessToken = jsonMap['access_token'];

      // Store the access token locally
      saveAccessToken(accessToken!);
      print("AccessToken");
      print(accessToken);
    }
  }
  Future<void> saveAccessToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', token);
    print("Stored Access token");
    print(token);
  }
  Future<void> getLeadStatus()
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Authorization':  'Bearer ${prefs.getString('access_token') ?? ''}',
      'Cookie': 'BrowserId=qnhrXMyBEe6lOh9ncfvoTw; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var data = '''''';
    var dio = Dio();
    var response = await dio.request(
      'https://muthootltd--muthootdo.sandbox.my.salesforce.com/services/apexrest/getLeadStatus/${widget.leadID}',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      data: data,
    );
    if (response.statusCode == 200) {
      var responseData = json.decode(response.data);
      var status = responseData['Status'];
      var createdTime = responseData['Date'];
      setState(() {
        LeadStatus = status;
        LeadCreatedDateTime = createdTime;
      });
      print(LeadStatus);
      print(LeadCreatedDateTime);
      print(json.encode(response.data));
    }
    else {
      print(response.statusMessage);
    }
  }


  Future<void> updateDataToLeadsFirestore() async {
    CollectionReference convertedLeads = FirebaseFirestore.instance.collection("convertedLeads");
    DateTime now = DateTime.now();
    print("Hello");
    try{
      Map<String, dynamic> params = {
        'LeadID' : LeadID,
        'VerificationStatus' : 'Sent for Verification',
        'VerifiedBy':  'Pending with SM',
        'isLoanApplicationDocument' : isLoanApplicationDocument,
        'isMandatoryDocument' : isMandatoryDocument,
        'isOptionalDocument' : isOptionalDocument,
        'isTechnicalChecklist':documentCheck,
        'technicalChecklistCount':mandatoryDocuments.length,
        'updatedTime':Timestamp.fromDate(now),
      };
      convertedLeads.where('VisitID', isEqualTo: widget.visitID).get().then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
        //  print(querySnapshot.docs.isNotEmpty);
          convertedLeads.doc(querySnapshot.docs.first.id).update(params).then((value) {
            print("Data updated to Visits successfully");
         //   _showAlertDialogSuccess2(context);
            //  Navigator.pop(context);
          }).catchError((error) {
            print("Failed to update data: $error");
          });
        } else {
          // Navigator.pop(context);
        }
      }).catchError((error) {
        print("Failed to check if customerNumber exists: $error");
      });

    }catch(e){
      print(e);
    };
  }
  Future<void> updateDataToLeadsFirestore1() async {
    CollectionReference convertedLeads = FirebaseFirestore.instance.collection("convertedLeads");
    DateTime now = DateTime.now();
    print("Hello");
    try{
      Map<String, dynamic> params = {
        'VerificationStatus' : 'Sent for Verification',
        'isLoanApplicationDocument' : isLoanApplicationDocument,
        'isMandatoryDocument' : isMandatoryDocument,
        'isOptionalDocument' : isOptionalDocument,
        'isTechnicalChecklist':documentCheck,
        'technicalChecklistCount':mandatoryDocuments.length,
        'updatedTime':Timestamp.fromDate(now),
      };
      if ( (technicalDocumentStatus == "Fully Uploaded" && QueryBy == "Query By SM") || (technicalDocumentStatus == "Fully Uploaded")) {
        params['VerifiedBy'] = 'Pending with SM'; // Replace 'YourValueHere' with the actual value for VerifiedBy
      }else if ( (technicalDocumentStatus == "Partially Uploaded" && QueryBy == "Query By SM") || (technicalDocumentStatus == "Partially Uploaded"))
        {
          params['VerifiedBy'] = 'Pending with SM';
        }

      convertedLeads.where('VisitID', isEqualTo: widget.visitID).get().then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
      //    print(querySnapshot.docs.isNotEmpty);
          convertedLeads.doc(querySnapshot.docs.first.id).update(params).then((value) {
            print("Data updated to Visits successfully");
            _showAlertDialogSuccess2(context);
            //  Navigator.pop(context);
          }).catchError((error) {
            print("Failed to update data: $error");
          });
        } else {
          // Navigator.pop(context);
        }
      }).catchError((error) {
        print("Failed to check if customerNumber exists: $error");
      });

    }catch(e){
    //  print(e);
    };
  }
  void viewUploadedFile(String documentId) {
    final filePath = uploadedFilePath[documentId];
    if (filePath != null) {
      OpenFile.open(filePath);
    } else {
      print('No file to view');
    }
  }
  void viewUploadedFile1(String documentId) {
    final filePath = uploadedFilePath1[documentId];
    if (filePath != null) {
      OpenFile.open(filePath);
    } else {
      print('No file to view');
    }
  }

  Future<void> updateDataToVisitFirestore() async {
    CollectionReference convertedLeads = FirebaseFirestore.instance.collection("LeadCreation");
    DateTime now = DateTime.now();
    print("Hello");
    try{
      Map<String, dynamic> params = {
        'LeadID' : LeadID,
        'VerificationStatus' : 'Sent for Verification',
        'updatedTime':Timestamp.fromDate(now),
      };
      convertedLeads.where('visitID', isEqualTo: widget.visitID).get().then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          print(querySnapshot.docs.isNotEmpty);
          convertedLeads.doc(querySnapshot.docs.first.id).update(params).then((value) {
            print("Data updated to Visits successfully");

            updateDataToLeadsFirestore();
            //  Navigator.pop(context);
          }).catchError((error) {
            print("Failed to update data: $error");
          });
        } else {
          // Navigator.pop(context);
        }
      }).catchError((error) {
        print("Failed to check if customerNumber exists: $error");
      });

    }catch(e){
      print(e);
    };
  }

  void fetchLeadChecklistDetails() async {
    CollectionReference leadsCollection = FirebaseFirestore.instance.collection('convertedLeads');

    QuerySnapshot leadSnapshot = await leadsCollection
        .where('VisitID', isEqualTo: widget.visitID)
        .limit(1)
        .get();

    if (leadSnapshot.docs.isNotEmpty) {
      // If lead details found, extract the checklist data
      checklistData = leadSnapshot.docs.first.data();
      // Iterate through mandatory documents to update uploadedFileNames
      for (int index = 0; index < mandatoryDocuments.length; index++) {
        final document = mandatoryDocuments[index];
        final documentId = document['ID'].toString();
        final documentTitle = mandatoryDocuments[index]['Title'];
        final checklistTitle = '$documentTitle-checklist';

        // Check if checklistTitle exists in the checklist data
        if (checklistData.containsKey(checklistTitle) && checklistData[checklistTitle].isNotEmpty) {
          // If checklist exists and is not empty, update uploadedFileNames accordingly
          setState(() {
            uploadedFileNames[documentId] = 'Uploaded'; // You can set any string you want
          });
        }

      }
      for (int index = 0; index < nonMandatoryDocuments.length; index++) {
        final document = nonMandatoryDocuments[index];
        final documentId = document['ID'].toString();
        final documentTitle = nonMandatoryDocuments[index]['Title'];
        final checklistTitle = '$documentTitle-checklist';

        // Check if checklistTitle exists in the checklist data
        if (checklistData.containsKey(checklistTitle) && checklistData[checklistTitle].isNotEmpty) {
          // If checklist exists and is not empty, update uploadedFileNames accordingly
          setState(() {
            uploadedFileNames1[documentId] = 'Uploaded'; // You can set any string you want
          });
        }

      }
    }
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


  void viewFile(String documentId) {
    final fileName = uploadedFileNames[documentId];
    if (fileName != null) {
      final filePath = '/path/to/uploaded/files/$fileName'; // Update this with the actual path where you store files
      OpenFile.open(filePath);
    } else {
      // Handle case where file is not found
      print("File not found: $fileName");
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  // fetchdata();
    getToken();
    getLeadDetails();
   updateDocumentStatus();
    getDropDownDocumentData();
  //  checkApplicationFormStatus();

  }
  Future<void> updateDocumentStatus() async {
    // Retrieve document IDs from Firestore
    var querySnapshot = await FirebaseFirestore.instance
        .collection("convertedLeads")
        .where("VisitID", isEqualTo: widget.visitID)
        .get();
    setState(() {
      // Update the status variables based on retrieved document IDs
      if (querySnapshot.docs.isNotEmpty) {
        var data = querySnapshot.docs[0].data();

        applicationForm = (data["Application_Form"] != null && data["Application_Form"].isNotEmpty) ? "Uploaded" : "Not Uploaded";
        bankPassbook = (data["Bank_Passbook"] != null && data["Bank_Passbook"].isNotEmpty) ? "Uploaded" : "Not Uploaded";
        dateOfBirthProof = (data["Date_Of_Birth"] != null && data["Date_Of_Birth"].isNotEmpty) ? "Uploaded" : "Not Uploaded";
        loginFeeCheque = (data["Login_Fee_Check"] != null && data["Login_Fee_Check"].isNotEmpty) ? "Uploaded" : "Not Uploaded";
        passportSizePhoto = (data["Passport_Size_Photo"] != null && data["Passport_Size_Photo"].isNotEmpty) ? "Uploaded" : "Not Uploaded";
        photoIdProof = (data["Photo_Id_Proof"] != null && data["Photo_Id_Proof"].isNotEmpty) ? "Uploaded" : "Not Uploaded";
        residenceProof = (data["Residence_Proof"] != null && data["Residence_Proof"].isNotEmpty) ? "Uploaded" : "Not Uploaded";
        salarySlip = (data["Salary_Slip"] != null && data["Salary_Slip"].isNotEmpty) ? "Uploaded" : "Not Uploaded";
        signatureProof = (data["Signature_Proof"] != null && data["Signature_Proof"].isNotEmpty) ? "Uploaded" : "Not Uploaded";
        copyOfProperty = (data["Copy_Of_Property"] != null && data["Copy_Of_Property"].isNotEmpty) ? "Uploaded" : "Not Uploaded";
        totalWorkExp = (data["Total_Work_Experience"] != null && data["Total_Work_Experience"].isNotEmpty) ? "Uploaded" : "Not Uploaded";
        qualificationProof = (data["Qualification_Proof"] != null && data["Qualification_Proof"].isNotEmpty) ? "Uploaded" : "Not Uploaded";
        // Repeat this for other documents
      } else {
        // Handle case where no matching document is found
        // You might want to set the status variables to some default value or handle it differently
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
        Navigator.pop(context);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => HomePageView(),
        //   ),
        // );
        // Prevent the default back navigation
        return false;
      },
      child: SafeArea(child: Scaffold(
        appBar:  AppBar(
          backgroundColor: StyleData.appBarColor2,
          title: Text("Document Upload",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: StyleData.boldFont),),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(19.0),
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         ApplicantDetailsView(),
                //   ),
                // );
              },
              child:  Container(
                child: Image.asset(
                  'assets/images/arrow.png',
                ),
              ),),
          ),

        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // SizedBox(
                    //   height: height * 0.01,
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible:   widget.leadID.isNotEmpty,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Lead ID : ",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      widget.leadID,
                                      style: TextStyle(
                                        color: StyleData.appBarColor2,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Visibility(
                                   visible :  widget.leadID.isNotEmpty,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Lead Status : ",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                       LeadStatus ?? "" ,
                                        style: TextStyle(
                                          color: StyleData.appBarColor2,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Row(
                                //   children: [
                                //     Text(
                                //       "Document Status : ",
                                //       style: TextStyle(
                                //         color: Colors.black87,
                                //         fontSize: 14,
                                //       ),
                                //     ),
                                //     Text(
                                //       technicalDocumentStatus ?? "" ,
                                //       style: TextStyle(
                                //         color: StyleData.appBarColor2,
                                //         fontSize: 14,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Text(
                            'Product: $productCategory',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            'Purpose Of Loan: $products',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            'Property Type: $propertyType',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            'Region: $region',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Divider(),
                          Visibility(
                            visible: widget.isPartiallyVerifiedLeads == false,
                            child: Column(
                                children : [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: isLoanApplicationDocument,
                                      activeColor: StyleData.appBarColor,
                                      onChanged: (value) {
                                        setState(() {
                                          isLoanApplicationDocument = value!;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Loan Application Document',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Visibility(
                                    visible: isLoanApplicationDocument,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Checkbox(
                                              value: isMandatoryDocument,
                                              activeColor: StyleData.appBarColor,
                                              onChanged: (value) {
                                                setState(() {
                                                  isMandatoryDocument = value!;
                                                });
                                              },
                                            ),
                                            Text(
                                              'Mandatory Documents',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        Visibility(
                                          visible: isMandatoryDocument,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

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
                                                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                                                    child: Stack(
                                                      children: [
                                                        Container(
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
                                                                    style: TextStyle(
                                                                      color: Colors.black54,
                                                                    ),
                                                                  ),
                                                                  Icon(Icons.arrow_circle_up_rounded,
                                                                      color: Colors.black54, size: 26),
                                                                ],
                                                              ),
                                                              SizedBox(height: height * 0.01),
                                                              Text(
                                                                applicationForm ?? "Application form",
                                                                style: TextStyle(
                                                                  color: applicationForm == "Uploaded" ? Colors.green : Colors.red,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        if (selectedFilePathApplicationForm != null)
                                                          Positioned(
                                                            right: 10,
                                                            top: height * 0.015,
                                                            child: IconButton(
                                                              icon: Icon(Icons.remove_red_eye),
                                                              onPressed: () {
                                                                OpenFile.open(selectedFilePathApplicationForm);
                                                              },
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
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
                                                  bankPassbook == "Uploaded" ? selectSource(height, width)  : (bankPassbook == "Uploaded" && widget.leadID != null) ? "" : selectSource(height, width);
                                                },
                                                child: DottedBorder(
                                                  color: Colors.black87,
                                                  borderType: BorderType.RRect,
                                                  radius: const Radius.circular(12),
                                                  padding: const EdgeInsets.all(6),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    const BorderRadius.all(Radius.circular(12)),
                                                    child: Stack(
                                                      children: [
                                                        Container(
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
                                                                    color: bankPassbook == "Uploaded" ? Colors.green : Colors.red,
                                                                    fontSize: 12,
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                        if (selectedFilePathBankPassbook != null)
                                                          Positioned(
                                                            right: 10,
                                                            top: height * 0.015,
                                                            child: IconButton(
                                                              icon: Icon(Icons.remove_red_eye),
                                                              onPressed: () {
                                                                OpenFile.open(selectedFilePathBankPassbook);
                                                              },
                                                            ),
                                                          ),
                                                      ],
                                                    ),
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
                                                  dateOfBirthProof == "Uploaded" ? selectSource(height, width)  : (dateOfBirthProof == "Uploaded" && widget.leadID != null) ? "" : selectSource(height, width);
                                                },
                                                child: DottedBorder(
                                                  color: Colors.black87,
                                                  borderType: BorderType.RRect,
                                                  radius: const Radius.circular(12),
                                                  padding: const EdgeInsets.all(6),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    const BorderRadius.all(Radius.circular(12)),
                                                    child: Stack(
                                                        children:[
                                                          Container(
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
                                                                      color: dateOfBirthProof == "Uploaded" ? Colors.green : Colors.red,
                                                                      fontSize: 12,
                                                                    ),
                                                                  )
                                                                ],
                                                              )),
                                                          if (selectedFilePathDateOfBirth != null)
                                                            Positioned(
                                                              right: 10,
                                                              top: height * 0.015,
                                                              child: IconButton(
                                                                icon: Icon(Icons.remove_red_eye),
                                                                onPressed: () {
                                                                  OpenFile.open(selectedFilePathDateOfBirth);
                                                                },
                                                              ),
                                                            ),
                                                        ]
                                                    ),
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
                                                  loginFeeCheque == "Uploaded" ? selectSource(height, width)  : (loginFeeCheque == "Uploaded" && widget.leadID != null) ? "" : selectSource(height, width);
                                                },
                                                child: DottedBorder(
                                                  color: Colors.black87,
                                                  borderType: BorderType.RRect,
                                                  radius: const Radius.circular(12),
                                                  padding: const EdgeInsets.all(6),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    const BorderRadius.all(Radius.circular(12)),
                                                    child: Stack(
                                                        children: [
                                                          Container(
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
                                                                      color: loginFeeCheque == "Uploaded" ? Colors.green : Colors.red,
                                                                      fontSize: 12,
                                                                    ),
                                                                  )
                                                                ],
                                                              )),
                                                          if (selectedFilePathLoginFeeCheque != null)
                                                            Positioned(
                                                              right: 10,
                                                              top: height * 0.015,
                                                              child: IconButton(
                                                                icon: Icon(Icons.remove_red_eye),
                                                                onPressed: () {
                                                                  OpenFile.open(selectedFilePathLoginFeeCheque);
                                                                },
                                                              ),
                                                            ),
                                                        ]
                                                    ),
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
                                                  passportSizePhoto == "Uploaded" ? selectSource(height, width)  : (passportSizePhoto == "Uploaded" && widget.leadID != null) ? "" : selectSource(height, width);
                                                },
                                                child: DottedBorder(
                                                  color: Colors.black87,
                                                  borderType: BorderType.RRect,
                                                  radius: const Radius.circular(12),
                                                  padding: const EdgeInsets.all(6),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    const BorderRadius.all(Radius.circular(12)),
                                                    child: Stack(
                                                      children:[
                                                        Container(
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
                                                                    color: passportSizePhoto == "Uploaded" ? Colors.green : Colors.red,
                                                                    fontSize: 12,
                                                                  ),
                                                                )
                                                              ],
                                                            )),
                                                        if (selectedFilePathPassportPhoto != null)
                                                          Positioned(
                                                            right: 10,
                                                            top: height * 0.015,
                                                            child: IconButton(
                                                              icon: Icon(Icons.remove_red_eye),
                                                              onPressed: () {
                                                                OpenFile.open(selectedFilePathPassportPhoto);
                                                              },
                                                            ),
                                                          ),
                                                      ],
                                                    ),
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
                                                  photoIdProof == "Uploaded" ? selectSource(height, width)  : (photoIdProof == "Uploaded" && widget.leadID != null) ? "" : selectSource(height, width);
                                                },
                                                child: DottedBorder(
                                                  color: Colors.black87,
                                                  borderType: BorderType.RRect,
                                                  radius: const Radius.circular(12),
                                                  padding: const EdgeInsets.all(6),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    const BorderRadius.all(Radius.circular(12)),
                                                    child: Stack(
                                                        children: [
                                                          Container(
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
                                                                      color: photoIdProof == "Uploaded" ? Colors.green : Colors.red,
                                                                      fontSize: 12,
                                                                    ),
                                                                  )
                                                                ],
                                                              )),
                                                          if (selectedFilePathPhotoIdProof != null)
                                                            Positioned(
                                                              right: 10,
                                                              top: height * 0.015,
                                                              child: IconButton(
                                                                icon: Icon(Icons.remove_red_eye),
                                                                onPressed: () {
                                                                  OpenFile.open(selectedFilePathPhotoIdProof);
                                                                },
                                                              ),
                                                            ),
                                                        ]
                                                    ),
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
                                                  residenceProof == "Uploaded" ? selectSource(height, width)  : (residenceProof == "Uploaded" && widget.leadID != null) ? "" : selectSource(height, width);
                                                },
                                                child: DottedBorder(
                                                  color: Colors.black87,
                                                  borderType: BorderType.RRect,
                                                  radius: const Radius.circular(12),
                                                  padding: const EdgeInsets.all(6),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    const BorderRadius.all(Radius.circular(12)),
                                                    child: Stack(
                                                        children:[
                                                          Container(
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
                                                                      color: residenceProof == "Uploaded" ? Colors.green : Colors.red,
                                                                      fontSize: 12,
                                                                    ),
                                                                  )
                                                                ],
                                                              )),
                                                          if (selectedFilePathResidenceProof != null)
                                                            Positioned(
                                                              right: 10,
                                                              top: height * 0.015,
                                                              child: IconButton(
                                                                icon: Icon(Icons.remove_red_eye),
                                                                onPressed: () {
                                                                  OpenFile.open(selectedFilePathResidenceProof);
                                                                },
                                                              ),
                                                            ),
                                                        ]
                                                    ),
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
                                                  salarySlip == "Uploaded" ? selectSource(height, width)  : (salarySlip == "Uploaded" && widget.leadID != null) ? "" : selectSource(height, width);
                                                },
                                                child: DottedBorder(
                                                  color: Colors.black87,
                                                  borderType: BorderType.RRect,
                                                  radius: const Radius.circular(12),
                                                  padding: const EdgeInsets.all(6),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    const BorderRadius.all(Radius.circular(12)),
                                                    child: Stack(
                                                        children:[
                                                          Container(
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
                                                                      color: salarySlip == "Uploaded" ? Colors.green : Colors.red,
                                                                      fontSize: 12,
                                                                    ),
                                                                  )
                                                                ],
                                                              )),
                                                          if (selectedFilePathSalarySlip != null)
                                                            Positioned(
                                                              right: 10,
                                                              top: height * 0.015,
                                                              child: IconButton(
                                                                icon: Icon(Icons.remove_red_eye),
                                                                onPressed: () {
                                                                  OpenFile.open(selectedFilePathSalarySlip);
                                                                },
                                                              ),
                                                            ),
                                                        ]
                                                    ),
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
                                                  signatureProof == "Uploaded" ? selectSource(height, width)  : (signatureProof == "Uploaded" && widget.leadID != null) ? "" : selectSource(height, width);
                                                },
                                                child: DottedBorder(
                                                  color: Colors.black87,
                                                  borderType: BorderType.RRect,
                                                  radius: const Radius.circular(12),
                                                  padding: const EdgeInsets.all(6),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    const BorderRadius.all(Radius.circular(12)),
                                                    child: Stack(
                                                        children: [
                                                          Container(
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
                                                                      color: signatureProof == "Uploaded" ? Colors.green : Colors.red,
                                                                      fontSize: 12,
                                                                    ),
                                                                  )
                                                                ],
                                                              )),
                                                          if (selectedFilePathSignatureProof != null)
                                                            Positioned(
                                                              right: 10,
                                                              top: height * 0.015,
                                                              child: IconButton(
                                                                icon: Icon(Icons.remove_red_eye),
                                                                onPressed: () {
                                                                  OpenFile.open(selectedFilePathSignatureProof);
                                                                },
                                                              ),
                                                            ),
                                                        ]
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.001,
                                        ),
                                        Row(
                                          children: [
                                            Checkbox(
                                              value: isOptionalDocument,
                                              activeColor: StyleData.appBarColor,
                                              onChanged: (value) {
                                                setState(() {
                                                  isOptionalDocument = value!;
                                                });
                                              },
                                            ),
                                            Text(
                                              'Optional Documents',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        Visibility(
                                            visible: isOptionalDocument ,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
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
                                                    copyOfProperty == "Uploaded" ? selectSource(height, width)  : (copyOfProperty == "Uploaded" && widget.leadID != null) ? "" : selectSource(height, width);
                                                  },
                                                  child: DottedBorder(
                                                    color: Colors.black87,
                                                    borderType: BorderType.RRect,
                                                    radius: const Radius.circular(12),
                                                    padding: const EdgeInsets.all(6),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                      const BorderRadius.all(Radius.circular(12)),
                                                      child: Stack(
                                                          children:[
                                                            Container(
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
                                                                      color: copyOfProperty == "Uploaded" ? Colors.green : Colors.red,
                                                                      fontSize: 12,
                                                                    ),
                                                                  ),

                                                                ],
                                                              ),
                                                            ),
                                                            if (selectedFilePathCopyOfProperty != null)
                                                              Positioned(
                                                                right: 10,
                                                                top: height * 0.015,
                                                                child: IconButton(
                                                                  icon: Icon(Icons.remove_red_eye),
                                                                  onPressed: () {
                                                                    OpenFile.open(selectedFilePathCopyOfProperty);
                                                                  },
                                                                ),
                                                              ),
                                                          ]

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
                                                    totalWorkExp == "Uploaded" ? selectSource(height, width)  : (totalWorkExp == "Uploaded" && widget.leadID != null) ? "" : selectSource(height, width);
                                                  },
                                                  child: DottedBorder(
                                                    color: Colors.black87,
                                                    borderType: BorderType.RRect,
                                                    radius: const Radius.circular(12),
                                                    padding: const EdgeInsets.all(6),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                      const BorderRadius.all(Radius.circular(12)),
                                                      child: Stack(
                                                          children:[
                                                            Container(
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
                                                                      color: totalWorkExp == "Uploaded" ? Colors.green : Colors.red,
                                                                      fontSize: 12,
                                                                    ),
                                                                  ),

                                                                ],
                                                              ),
                                                            ),
                                                            if (selectedFilePathTotalWorkExperience != null)
                                                              Positioned(
                                                                right: 10,
                                                                top: height * 0.015,
                                                                child: IconButton(
                                                                  icon: Icon(Icons.remove_red_eye),
                                                                  onPressed: () {
                                                                    OpenFile.open(selectedFilePathTotalWorkExperience);
                                                                  },
                                                                ),
                                                              ),
                                                          ]

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
                                                    qualificationProof == "Uploaded" ? selectSource(height, width)  : (qualificationProof == "Uploaded" && widget.leadID != null) ? "" : selectSource(height, width);
                                                  },
                                                  child: DottedBorder(
                                                    color: Colors.black87,
                                                    borderType: BorderType.RRect,
                                                    radius: const Radius.circular(12),
                                                    padding: const EdgeInsets.all(6),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                      const BorderRadius.all(Radius.circular(12)),
                                                      child: Stack(
                                                          children:[
                                                            Container(
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
                                                                      color: qualificationProof == "Uploaded" ? Colors.green : Colors.red,
                                                                      fontSize: 12,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            if (selectedFilePathTotalQualificatioProof != null)
                                                              Positioned(
                                                                right: 10,
                                                                top: height * 0.015,
                                                                child: IconButton(
                                                                  icon: Icon(Icons.remove_red_eye),
                                                                  onPressed: () {
                                                                    OpenFile.open(selectedFilePathTotalQualificatioProof);
                                                                  },
                                                                ),
                                                              ),
                                                          ]

                                                      ),
                                                    ),
                                                  ), // Change the splash color to red
                                                ),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                            ]
                            ),
                          ),

                          //
                          // SizedBox(height: height * 0.005),
                          Visibility(
                              visible : !isTechChecklistNotExisting,
                              child: Column(
                            children : [
                          Row(
                          children: [
                            Checkbox(
                            value: documentCheck,
                            activeColor: StyleData.appBarColor,
                            onChanged: (value) {
                              setState(() {
                                documentCheck = value!;
                              });
                              fetchLeadChecklistDetails();
                            },
                          ),
                          Text(
                            'Technical Document',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Visibility(
                      visible: documentCheck == true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: isMandatoryDocument1,
                                activeColor: StyleData.appBarColor,
                                onChanged: (value) {
                                  setState(() {
                                    isMandatoryDocument1 = value!;
                                  });
                                },
                              ),
                              Text(
                                'Mandatory Documents',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: isMandatoryDocument1,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: mandatoryDocuments.length,
                                itemBuilder: (context, index) {
                                  final document = mandatoryDocuments[index];
                                  final documentId = document['ID'].toString();
                                  mandatoryDocumentCount = mandatoryDocuments.length;

                                  documentCheckboxStates.putIfAbsent(documentId, () => false);

                                  return ListTile(
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(mandatoryDocuments[index]['Title']),
                                        if (uploadedFileNames.containsKey(documentId)) // Check if filename is available
                                          Text(
                                            uploadedFileNames[documentId] ?? '', // Display uploaded filename
                                            style:TextStyle(color:  uploadedFileNames[documentId] == "Uploaded" ? Colors.green : Colors.green, fontSize: 12.0),
                                          ),
                                        Divider()
                                      ],
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (uploadedFileNames[documentId] != null && uploadedFileNames[documentId] != "Uploaded" ) // Show view icon only if file is uploaded
                                          IconButton(
                                            icon: Icon(Icons.remove_red_eye),
                                            onPressed: () {
                                              viewUploadedFile(documentId); // Implement this method to view the file
                                            },
                                          ),
                                        IconButton(
                                          icon: Icon(Icons.attach_file),
                                          onPressed: () {
                                            selectSourceChecklist(height, width, mandatoryDocuments[index]['Title'], documentId,"");
                                            // if (uploadedFileNames[documentId] != "Uploaded") {
                                            //   selectSourceChecklist(height, width, mandatoryDocuments[index]['Title'], documentId);
                                            // }
                                          },
                                        ),
                                      ],
                                    ),

                                  );

                                }
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Visibility(
                      visible: documentCheck == true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: isOptionalDocument1,
                                activeColor: StyleData.appBarColor,
                                onChanged: (value) {
                                  setState(() {
                                    isOptionalDocument1 = value!;
                                  });
                                },
                              ),
                              Text(
                                'Non Mandatory Documents',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: isOptionalDocument1,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: nonMandatoryDocuments.length,
                                itemBuilder: (context, index) {
                                  final document1 = nonMandatoryDocuments[index];
                                  final documentId1 = document1['ID'].toString();
                                  nonMandatoryDocumentCount = nonMandatoryDocuments.length;

                                  nonMandocumentCheckboxStates.putIfAbsent(documentId1, () => false);

                                  return ListTile(
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(nonMandatoryDocuments[index]['Title']),
                                        if (uploadedFileNames1.containsKey(documentId1)) // Check if filename is available
                                          Text(
                                            uploadedFileNames1[documentId1] ?? '', // Display uploaded filename
                                            style:TextStyle(color:  uploadedFileNames1[documentId1] == "Uploaded" ? Colors.green : Colors.green, fontSize: 12.0),
                                          ),
                                        Divider()
                                      ],
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (uploadedFileNames1[documentId1] != null && uploadedFileNames1[documentId1] != "Uploaded" ) // Show view icon only if file is uploaded
                                          IconButton(
                                            icon: Icon(Icons.remove_red_eye),
                                            onPressed: () {
                                              viewUploadedFile1(documentId1); // Implement this method to view the file
                                            },
                                          ),
                                        IconButton(
                                          icon: Icon(Icons.attach_file),
                                          onPressed: () {
                                            selectSourceChecklist(height, width, nonMandatoryDocuments[index]['Title'], "",documentId1);
                                            // if (uploadedFileNames[documentId] != "Uploaded") {
                                            //   selectSourceChecklist(height, width, mandatoryDocuments[index]['Title'], documentId);
                                            // }
                                          },
                                        ),
                                      ],
                                    ),

                                  );

                                }
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                            ]
                          ))

                        ],
                      ),
                    ),
              
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            
            widget.leadID != null && widget.isTechChecklist ?
    (technicalDocumentStatus == "Fully Uploaded" && VerificationStatus == "Verified") ?
   Container(
  height: 55,
  width: double.infinity,
  decoration: BoxDecoration(
    color: StyleData.appBarColor2,
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children:[
      ElevatedButton(
        onPressed: () {
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
) :
            Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                color: StyleData.appBarColor2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[
                  ElevatedButton(
                    onPressed: () {
                      if (documentCheck && !isAnyMandatoryDocumentUploaded()) {
                        showError("Please upload at least one technical document.");
                      } else {
                        updateLeadData1();
                      }

                      // Navigator.push(
                      //     context,
                      // MaterialPageRoute(
                      //     builder: (context) => DocumentChecklistPageView(
                      //         docId:widget.docId,
                      //         leadId: widget.leadID,
                      //         isNewActivity: false,
                      //         isUpdateActivity:true
                      //     )));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Update',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ) :
            Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                color: StyleData.appBarColor2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[
                  ElevatedButton(
                    onPressed: () {
                      if(
                      // applicationFormClicked == true && bankPassbookClicked == true &&
                      // dateOfBirthClicked == true &&
                      // loginFeeChequeClicked == true &&
                      // passportSizePhotoClicked == true &&
                      // photoIdProofClicked == true &&
                      // residenceProofClicked == true &&
                      // salarySlipClicked == true &&
                      // signatureProofClicked == true
                          // &&
                          applicationForm ==  "Uploaded" && bankPassbook ==  "Uploaded" && dateOfBirthProof ==  "Uploaded" &&
                          loginFeeCheque ==  "Uploaded" &&
                          passportSizePhoto ==  "Uploaded" &&
                          photoIdProof ==  "Uploaded" &&
                          residenceProof == "Uploaded" &&
                          salarySlip == "Uploaded" &&
                          signatureProof == "Uploaded"
                      )
                        {
                          if (documentCheck && !isAnyMandatoryDocumentUploaded()) {
                            showError("Please upload at least one technical document.");
                          } else {
                            updateLeadData();
                          }
                        }
                      else
                        {
                          CustomSnackBar.errorSnackBarQ("Please upload all the Mandatory Document", context);
                        }


                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]
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
                        if(pickedFile != null)
                          {
                            // setState(() {
                            //   selectedFilePathApplicationForm = pickedFile.path;
                            // });
                            setState(() {
                              if (applicationFormClicked) {
                                selectedFilePathApplicationForm = pickedFile.path;
                              } else if (bankPassbookClicked) {
                                selectedFilePathBankPassbook = pickedFile.path;
                            } else if (dateOfBirthClicked) {
                              selectedFilePathDateOfBirth = pickedFile.path;
                            }
                              else if (loginFeeChequeClicked) {
                                selectedFilePathLoginFeeCheque = pickedFile.path;
                              }
                              else if (passportSizePhotoClicked) {
                                selectedFilePathPassportPhoto = pickedFile.path;
                              }
                              else if (photoIdProofClicked) {
                                selectedFilePathPhotoIdProof = pickedFile.path;
                              }
                              else if (residenceProofClicked) {
                                selectedFilePathResidenceProof = pickedFile.path;
                              }
                              else if (salarySlipClicked) {
                                selectedFilePathSalarySlip = pickedFile.path;
                              }
                              else if (signatureProofClicked) {
                                selectedFilePathSignatureProof = pickedFile.path;
                              }
                              else if (copyOfPropertyClicked) {
                                selectedFilePathCopyOfProperty = pickedFile.path;
                              }
                              else if (totalWorkExpClicked) {
                                selectedFilePathTotalWorkExperience = pickedFile.path;
                              }
                              else if (qualificationProofClicked) {
                                selectedFilePathTotalQualificatioProof = pickedFile.path;
                              }
                            });
                          }
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
                        if(pickedFiles != null && pickedFiles.files.isNotEmpty)
                          {
                            // setState(() {
                            //   selectedFilePathApplicationForm = pickedFiles.files.first.path;
                            // });
                            setState(() {
                              if (applicationFormClicked) {
                                selectedFilePathApplicationForm = pickedFiles.files.first.path;
                              } else if (bankPassbookClicked) {
                                selectedFilePathBankPassbook = pickedFiles.files.first.path;
                              }
                              else if (loginFeeChequeClicked) {
                                selectedFilePathLoginFeeCheque =pickedFiles.files.first.path;
                              }
                              else if (passportSizePhotoClicked) {
                                selectedFilePathPassportPhoto = pickedFiles.files.first.path;
                              }
                              else if (photoIdProofClicked) {
                                selectedFilePathPhotoIdProof = pickedFiles.files.first.path;
                              }
                              else if (residenceProofClicked) {
                                selectedFilePathResidenceProof = pickedFiles.files.first.path;
                              }
                              else if (salarySlipClicked) {
                                selectedFilePathSalarySlip = pickedFiles.files.first.path;
                              }
                              else if (signatureProofClicked) {
                                selectedFilePathSignatureProof = pickedFiles.files.first.path;
                              }
                              else if (copyOfPropertyClicked) {
                                selectedFilePathCopyOfProperty = pickedFiles.files.first.path;
                              }
                              else if (totalWorkExpClicked) {
                                selectedFilePathTotalWorkExperience = pickedFiles.files.first.path;
                              }
                              else if (qualificationProofClicked) {
                                selectedFilePathTotalQualificatioProof = pickedFiles.files.first.path;
                              }
                            });
                          }
                        if (applicationFormClicked) {
                          uploadOnDMS(pickedFiles?.files.first , "Application_Form");
                        } else if (bankPassbookClicked) {
                          uploadOnDMS(pickedFiles?.files.first, "Bank_Passbook");
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

  selectSourceChecklist(height, width,title, String documentId, String documentId1) {
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
                        if (pickedFile != null) {
                          uploadOnDMSChecklist(pickedFile,title,documentId,documentId1);
                        } else {
                          // Handle case where user canceled image picking
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
                        pickedFiles =
                        await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
                          allowCompression: true,
                          allowMultiple: false,
                        );
                        //  pickedFiles?.files.first
                        print(pickedFiles!.files.first.name);
                        uploadOnDMSChecklist(pickedFiles!.files.first, title,documentId,documentId1);
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

  void uploadOnDMSChecklist(var pickedFile, String title, String documentId, String documentId1) async {
    print("bhjkjhlknl");
    print(pickedFile);
    Dialogs.materialDialog(
        msg: 'Are you sure you want to upload this document?',
        title: "Alert",
        msgStyle: TextStyle(color: Colors.grey, fontFamily: StyleData.boldFont),
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
                var headers = {
                  'Content-Type': 'application/x-www-form-urlencoded',
                  'AuthToken': ApiUrls().AuthToken
                };
                var dio = Dio();
                var response = await dio.request(
                  ApiUrls().authGenerate,
                  options: Options(
                    method: 'GET',
                    headers: headers,
                  ),
                );

                if (response.statusCode == 200) {
                  print(json.encode(response.data));
                  String jsonResponse = json.encode(response.data);
                  Map<String, dynamic> jsonMap = json.decode(jsonResponse);
                  accessToken = jsonMap['access_token'];
                }
                else {
                  print(response.statusMessage);
                }
                try {
                  FormData formData = FormData.fromMap({
                    "File": await MultipartFile.fromFile(
                      pickedFile!.path,
                      filename: pickedFile.name,
                      contentType: _getContentType(pickedFile.name), // add this
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
                  // dio.options.headers['Content-Type'] = 'multipart/form-data';
                  dio.options.headers['AuthToken'] =  ApiUrls().AuthToken;
                  dio.options.headers['Authorization'] = 'Bearer ${accessToken ?? ''}';
                  var response = await dio.post(
                    ApiUrls().uploadDoc,
                    data: formData,
                    onSendProgress: (int sent, int total) {
                      debugPrint("sent${sent.toString()}" +
                          " total${total.toString()}");
                    },
                  ).whenComplete(() {
                  }).catchError((onError) {
                    debugPrint("complete1");
                    SmartDialog.dismiss();
                  });
                  print(response);
                  var data = json.decode(response.toString());
                  print(data);

                  SmartDialog.dismiss();
                  if (data["status"] == 0) {
                    CustomSnackBar.errorSnackBarQ(data["message"], context);
                  } else {
                    FirebaseFirestore.instance
                        .collection("convertedLeads")
                        .where("VisitID", isEqualTo: widget.visitID) // Check if visitID matches
                        .get()
                        .then((QuerySnapshot snapshot) {
                      if (snapshot.docs.isNotEmpty) {
                        // If there's a matching document, set the value
                        FirebaseFirestore.instance
                            .collection("convertedLeads")
                            .doc(snapshot.docs[0].id)
                            .set({
                          '$title-checklist': data["docId"].toString(),
                        },
                            SetOptions(merge: true));

                        setState(() {
                          documentUploaded = true;
                          uploadedFileNames[documentId] = pickedFile.name;
                          uploadedFilePath[documentId] = pickedFile.path;
                          checklistName = title;
                          uploadedDocumentCount++;
                          documentUploaded1 = true;
                          uploadedFileNames1[documentId1] = pickedFile.name;
                          uploadedFilePath1[documentId1] = pickedFile.path;
                          checklistName1 = title;
                          uploadedDocumentCount1++;
                        });
                        saveUploadedFileName(pickedFile.name, documentId);
                        saveUploadedFileName1(pickedFile.name, documentId1);
                      } else {
                        CustomSnackBar.errorSnackBarQ("No such document found", context);
                      }
                    })
                        .catchError((error) {
                      CustomSnackBar.errorSnackBarQ("Something went wrong, Please Try Again", context);
                      print("Error: $error");
                    });
                  }
                } catch (e) {
                  SmartDialog.dismiss();
                  CustomSnackBar.errorSnackBarQ("Something went wrong, Please Try Again", context);
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
        ]
    );
  }




  void uploadOnDMS(var pickedFile, String title) async {
    print("bhjkjhlknl");
    Dialogs.materialDialog(
        msg: 'Are you sure you want to upload this document?',
        title: "Alert",
        msgStyle: TextStyle(color: Colors.grey, fontFamily: StyleData.boldFont),
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
                var headers = {
                  'Content-Type': 'application/x-www-form-urlencoded',
                  'AuthToken': ApiUrls().AuthToken
                };
                var dio = Dio();
                var response = await dio.request(
                  ApiUrls().authGenerate,
                  options: Options(
                    method: 'GET',
                    headers: headers,
                  ),
                );

                if (response.statusCode == 200) {
                  print(json.encode(response.data));
                  String jsonResponse = json.encode(response.data);
                  Map<String, dynamic> jsonMap = json.decode(jsonResponse);
                  accessToken = jsonMap['access_token'];
                }
                else {
                  print(response.statusMessage);
                }
                try {
                  FormData formData = FormData.fromMap({
                    "File": await MultipartFile.fromFile(
                      pickedFile!.path,
                      filename: pickedFile.name,
                      contentType: _getContentType(pickedFile.name), // add this
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
                  // dio.options.headers['Content-Type'] = 'multipart/form-data';
                  dio.options.headers['AuthToken'] =  ApiUrls().AuthToken;
                  dio.options.headers['Authorization'] = 'Bearer ${accessToken ?? ''}';
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

                  SmartDialog.dismiss();
                  if (data["status"] == 0) {
                    CustomSnackBar.errorSnackBarQ(data["message"], context);
                  } else {
                    FirebaseFirestore.instance
                        .collection("convertedLeads")
                        .where("VisitID", isEqualTo: widget.visitID) // Check if visitID matches
                        .get()
                        .then((QuerySnapshot snapshot) {
                      if (snapshot.docs.isNotEmpty) {
                        // If there's a matching document, set the value
                        FirebaseFirestore.instance
                            .collection("convertedLeads")
                            .doc(snapshot.docs[0].id) // Use the ID of the first matching document
                            .set({
                          title: data["docId"].toString(),
                        },
                            SetOptions(merge: true));
                      } else {
                        // Handle case where no matching document is found
                        // Perhaps show an error message or take appropriate action
                      }
                    })
                        .catchError((error) {
                      // Handle errors
                      print("Error: $error");
                    });

                    if (data["docId"].toString().isNotEmpty) {
                      if (applicationFormClicked) {
                        print(ApplicationDocID);
                        setState(() {
                          applicationForm = "Uploaded";
                        });
                      } else if (bankPassbookClicked) {
                        setState(() {
                          bankPassbook = "Uploaded";
                        });
                      } else if (dateOfBirthClicked) {
                        setState(() {
                          dateOfBirthProof = "Uploaded";
                        });
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
                      } else if (totalWorkExpClicked) {
                        setState(() {
                          totalWorkExp = "Uploaded";
                        });
                      } else if (qualificationProofClicked) {
                        setState(() {
                          qualificationProof = "Uploaded";
                        });
                      }
                    } else {
                      CustomSnackBar.errorSnackBarQ("Something went wrong, Please Try Again", context);
                    }
                  }
                } catch (e) {
                  SmartDialog.dismiss();
                  CustomSnackBar.errorSnackBarQ("Something went wrong, Please Try Again", context);
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

  void updateLeadData1() async {
    //New Implementation for saving application PDF
    print("bhjkjhlknl");
    Dialogs.materialDialog(
        msg: 'Are you sure you want to submit the lead details',
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
                // setState(() {
                //   isLeadsUpdateData = true;
                // });
                updateDataToLeadsFirestore1();
                Navigator.pop(context);
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

  void updateLeadData() async {
    //New Implementation for saving application PDF
    print("bhjkjhlknl");
    Dialogs.materialDialog(
        msg: 'Are you sure you want to submit the lead details',
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
                // setState(() {
                //   isLeadsUpdateData = true;
                // });
                leadCreation();
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
  void _showAlertDialogSuccess3(BuildContext context) {
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
                  Text('Sent for Verification', textAlign: TextAlign.center,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  // Row(
                  //   children: [
                  //     Text('Lead ID - ', textAlign: TextAlign.center,style: TextStyle(color: Colors.black87),),
                  //     Text('$LeadID', textAlign: TextAlign.center,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold)),
                  //   ],
                  // ),
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
  void _showAlertDialogSuccess2(BuildContext context) {
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
                  Text('Submitted successfully', textAlign: TextAlign.center,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold)),
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
  void _showAlertDialogSuccess1(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
                Text('Something went wrong', textAlign: TextAlign.center,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold)),
                //  SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Please try again', textAlign: TextAlign.center,style: TextStyle(color: Colors.black87),),
                    Text('$LeadID', textAlign: TextAlign.center,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 5),
                SizedBox(
                  height: 25,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
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
        );
      },
    );
  }
  bool isAnyMandatoryDocumentUploaded() {
    for (var document in mandatoryDocuments) {
      final documentId = document['ID'].toString();
      final documentTitle = document['Title'];
      if (uploadedFileNames.containsKey(documentId) || uploadedFileNames[documentId] == "Uploaded") {
        return true;
      }
    }
    return false;
  }
  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor:StyleData.appBarColor3,
    ));
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
