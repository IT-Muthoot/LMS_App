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
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/Response/DropDownModel.dart';
import '../Model/apiurls.dart';
import '../Utils/CustomeSnackBar.dart';
import '../Utils/StyleData.dart';
import 'DocumentCheckListPageView.dart';

class DocumentPageView extends StatefulWidget {
  final bool isNewActivity;
  final bool isTechChecklist;
  final String visitID;
  final String docId;
  final String leadID;
  const DocumentPageView({Key? key,
    required this.visitID,required this.docId,required this.isNewActivity,required this.isTechChecklist,required this.leadID})
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
  bool? isKycCheck;
  bool? isCrifCheck;
  var docData;

  String? ApplicationDocID;
  String? ApplicationDocID1;

  String? selectedFilePathApplicationForm;

  String? VerificationStatus = "Pending";
  String VerificationStatusBy = "Pending";
  List<dynamic> mandatoryDocuments = [];
  String? SelectedMandatoryDoc;
  bool documentCheck = false;
  String? isChecklist;
  Map<String, bool> documentCheckboxStates = {};
  Map<String, String> uploadedFileNames = {};
  var checklistData;
  String? region;
  bool documentUploaded = false;
  String uploadedFileName = '';
  String checklistName = '';
  int? mandatoryDocumentCount;
  int uploadedDocumentCount = 0;
  XFile? pickedFileChecklist;
  FilePickerResult? pickedFiles;

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


  Future<String?> getUploadedFileName(String documentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(documentId);
  }


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
    HomeFinBranchCode = docData["EmployeeBranchCode"] ?? "";
    salutation = docData["salutation"] ?? "";
    employeeName = docData["EmployeeName"] ?? "";
    employeeCode = docData["EmployeeCode"] ?? "";
    ManagerCode = docData["ManagerCode"] ?? "";
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

    if(region != null)
      {
        _fetchDataFromFirestore();
      }
    else
      {

      }
  }


  Future<void> _fetchDataFromFirestore() async {
    try {
      // Access the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Access the "documentChecklist" collection
      CollectionReference checklistCollection = firestore.collection('documentChecklist');
      QuerySnapshot querySnapshot = await checklistCollection.get();
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        for(int i = 0; i < documentSnapshot['documentChecklist'].length; i++){
          String? uppercaseRegion = region?.toUpperCase();
          // print('Value at index $i: ${documentSnapshot['documentChecklist'][0]} \n');
          documentSnapshot['documentChecklist'][i].forEach((key, value) {
            // print('Key: $key');
            if(key == uppercaseRegion) {
              setState(() {
                mandatoryDocuments = value[productCategory][products]['Mandatory'];
                log(mandatoryDocuments.toString());
              });
            }
          });
        }
      }
    } catch (e) {
      CustomSnackBar.errorSnackBarQ("Technical Checklist Not Available", context);
      log('Error fetching data: $e');
    }
  }

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
        "ConsentForCrif": isCrifCheck,
        "ConsentForKyc": isKycCheck,
        "IsDocumentCollected": true,
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

    print(data);
    var dio = Dio();
    var response = await dio.request(
   // 'https://muthootltd.my.salesforce.com/services/apexrest/LeadCreationTest/',
      'https://muthootltd--muthootdo.sandbox.my.salesforce.com/services/apexrest/LeadCreationTest/',
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
          print("hjdjnvfv");
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
      // 'grant_type': 'password',
      // 'client_id': '3MVG9WZIyUMp1ZfoWDelgr4puVA8Cbw2py9NcKnfiPbsdxV6CU1HXQssNTT2XpRFqPmQ8OX.F4ZbP_ziL2rmf',
      // 'client_secret': '4382921A497F5B4DED8F7E451E89D1228EE310F729F64641429A949D53FA1B84',
      // 'username': 'salesappuser@muthoothomefin.com',
      // 'password': 'Pass@123456F7aghs4Z5RxQ5hC2pktsSLJfq'
      'grant_type': 'password',
      'client_id': '3MVG9ct5lb5FGJTNKeeA63nutsPt.67SWB9mzXh9na.RBlkmz2FxM4KH31kKmHWMWQHD1y2apE9qmtoRtiQ9R',
      'client_secret': 'E9DDAF90143A7B4C6CA622463EFDA17843174AB347FD74A6905F853CD2406BDE',
      'username': 'itkrishnaprasad@muthootgroup.com.dev2',
      'password': 'Karthikrishna@1YSRHLEtF4pMRkpOd6aSCeVHDB'
    };
    var dio = Dio();
    var response = await dio.request(
   //   'https://muthootltd.my.salesforce.com/services/oauth2/token',
      'https://muthootltd--muthootdo.sandbox.my.salesforce.com/services/oauth2/token',
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



  Future<void> updateDataToLeadsFirestore() async {
    CollectionReference convertedLeads = FirebaseFirestore.instance.collection("convertedLeads");
    DateTime now = DateTime.now();
    print("Hello");
    try{
      Map<String, dynamic> params = {
        'LeadID' : LeadID,
        'VerificationStatus' : 'Sent for Verification',
        'updatedTime':Timestamp.fromDate(now),
      };
      convertedLeads.where('VisitID', isEqualTo: widget.visitID).get().then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          print(querySnapshot.docs.isNotEmpty);
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
        'updatedTime':Timestamp.fromDate(now),
      };
      convertedLeads.where('VisitID', isEqualTo: widget.visitID).get().then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          print(querySnapshot.docs.isNotEmpty);
          convertedLeads.doc(querySnapshot.docs.first.id).update(params).then((value) {
            print("Data updated to Leads successfully");
            _showAlertDialogSuccess3(context);
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

  Future<void> updateDataToVisitFirestore() async {
    CollectionReference convertedLeads = FirebaseFirestore.instance.collection("LeadCreation");
    DateTime now = DateTime.now();
    print("Hello");
    try{
      Map<String, dynamic> params = {
        'LeadID' : LeadID,
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
        if (checklistData.containsKey(checklistTitle)) {
          // If checklist exists, update uploadedFileNames accordingly
          setState(() {
            uploadedFileNames[documentId] = 'Uploaded'; // You can set any string you want
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

        applicationForm = data["Application_Form"] == null ? "Not Uploaded" : "Uploaded";
        bankPassbook = data["Bank_Passbook"] == null ? "Not Uploaded" : "Uploaded";
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
        body: SingleChildScrollView(
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
                                  // Column(
                                  //   children: [
                                  //     Image.file(File(selectedFilePathApplicationForm!)),
                                  //     Text(selectedFilePathApplicationForm ?? "No file selected"),
                                  //   ],
                                  // ),
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
                                  SizedBox(height: height * 0.01),
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
                                        'Technical Checklist',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                      visible: documentCheck,
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
                                                      style: TextStyle(color: Colors.red, fontSize: 12.0),
                                                    ),
                                                  Divider()
                                                ],
                                              ),
                                              trailing: IconButton(
                                                  icon: Icon(Icons.attach_file),
                                                  onPressed: () {
                                                    selectSourceChecklist(height, width,mandatoryDocuments[index]['Title'],documentId);
                                                  }
                                                //mandatoryDocuments[index]
                                              ),
                                            );

                                          }
                                      )
                                  ),
                                ],
                              ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              widget.leadID != null && widget.isTechChecklist ?
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
                        updateLeadData1();
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
                        updateLeadData();
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
                        if(pickedFile != null)
                          {
                            setState(() {
                              selectedFilePathApplicationForm = pickedFile.path;
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
                            setState(() {
                              selectedFilePathApplicationForm = pickedFiles.files.first.path;
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

  selectSourceChecklist(height, width,title, String documentId) {
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
                          uploadOnDMSChecklist(pickedFile,title,documentId);
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
                        uploadOnDMSChecklist(pickedFiles!.files.first, title,documentId);
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

  void uploadOnDMSChecklist(var pickedFile, String title,String documentId) async {
    print("bhjkjhlknl");
    print(pickedFile);
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
                  }).catchError((onError) {
                    debugPrint("complete1");
                    SmartDialog.dismiss();
                  });
                  print(response);
                  var data = json.decode(response.toString());
                  print(data);
                  FirebaseFirestore.instance
                      .collection("convertedLeads")
                      .where("LeadID", isEqualTo: widget.visitID) // Check if visitID matches
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

                      setState(()  {
                        documentUploaded = true;
                        uploadedFileNames[documentId] = pickedFile.name;
                        checklistName = title;
                        uploadedDocumentCount++;
                      });
                      saveUploadedFileName(pickedFile.name,documentId);
                    } else {
                      CustomSnackBar.errorSnackBarQ("No such document found", context);
                    }
                  })
                      .catchError((error) {
                    CustomSnackBar.errorSnackBarQ("Something went wrong,Please Try Again", context);
                    print("Error: $error");
                  });

                  SmartDialog.dismiss();
                } catch (e) {
                  SmartDialog.dismiss();
                  CustomSnackBar.errorSnackBarQ("Something went wrong,Please Try Again", context);
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
                  // FirebaseFirestore.instance
                  //     .collection("convertedLeads")
                  //     .doc(widget.docId)
                  //     .set({
                  //   title: data["docId"].toString(),
                  // },
                  //     SetOptions(merge: true));
                  SmartDialog.dismiss();
                  if(data["docId"].toString().isNotEmpty)
                    {
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
                    }
                  else
                    {
                      CustomSnackBar.errorSnackBarQ("Something went wrong,Please Try Again", context);
                    }
                } catch (e) {
                  SmartDialog.dismiss();
                  CustomSnackBar.errorSnackBarQ("Something went wrong,Please Try Again", context);
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
                  Text('Lead details saved successfully', textAlign: TextAlign.center,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text('Lead ID - ', textAlign: TextAlign.center,style: TextStyle(color: Colors.black87),),
                      Text('$LeadID', textAlign: TextAlign.center,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold)),
                    ],
                  ),
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
