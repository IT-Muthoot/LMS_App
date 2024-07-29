import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lead_management_system/Model/apiurls.dart';
import 'package:lead_management_system/View/HomePageView.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';



import '../Model/DatabaseHelper.dart';
import '../Model/Response/DropDownModel.dart';
import '../Model/leadDataModel.dart';
import '../Utils/CustomeSnackBar.dart';
import '../Utils/StyleData.dart';
import 'ApplicantDetailsView.dart';
import 'documentsPageView.dart';

class NewLeadPageView extends StatefulWidget {
  final bool isNewActivity;
  final bool isUpdateActivity;
  final String docId;
  final String visitId;
 // String? accessToken;

   NewLeadPageView({Key? key,
    required this.isNewActivity,
    required this.isUpdateActivity,
    required this.visitId,
   // required this.accessToken,
    required this.docId})
      : super(key: key);

  @override
  State<NewLeadPageView> createState() => _NewLeadPageViewState();
}

class _NewLeadPageViewState extends State<NewLeadPageView> {

  final _formKey = GlobalKey<FormState>();
  bool checkBoxValue = false;
  String selectedRadioButtonValue = 'Male';
  String? customerStatus;
  String? latitue;
  String? longitude;
  String? scheduledDate;
  String? scheduledTime;

  bool isCustomerInfo = false;
  bool isAddressInfo = false;
  bool isLeadInfo = false;
  bool isProfileInfo = false;
  bool areCustomerFieldsFilled = false;
  bool areAddressFieldsFilled = false;
  bool areLeadsFieldsFilled = false;
  bool areProfileFieldsFilled = false;

  bool areFieldsFilled = false;
  bool consentCRIF = false;
  bool consentKYC = false;
  bool consentAccountAgregator = false;
  var userType;
  List<DocumentSnapshot> ListOfLeads = [];
  List<Map<dynamic, dynamic>> ListOfDSANames = [];
  var docData;
  bool isFetching = true;
  String? leadSource;
  String? branchCode;

  String? DSAConnectorName;
  String? DSAConnectorCode1;
  List<dynamic> _PostcodeList = [];
  String? selectedPostCode;
  String? visitID;

  String? selectedProductType;
  bool isDateOfBirth = false;

  //textfields
  TextEditingController textEditingController = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController middleName = TextEditingController();
  TextEditingController customerNumber = TextEditingController();
  TextEditingController _additionalPhoneNumber = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _dateOfBirth = TextEditingController();
  TextEditingController _nationality = TextEditingController(text: 'Indian');
  TextEditingController _addressLine1 = TextEditingController();
  TextEditingController _addressLine2 = TextEditingController();
  TextEditingController _addressLine3 = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _landMark = TextEditingController();
  TextEditingController _district = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _pincode = TextEditingController();
  TextEditingController _postOffice = TextEditingController();
  TextEditingController _leadSource = TextEditingController();
  TextEditingController _homeFinBranchCode = TextEditingController(text: 'KALY037');
  TextEditingController _leadAmount = TextEditingController();
  TextEditingController monthlyIncomeOfApplicant = TextEditingController();
  TextEditingController aadharCardNumber = TextEditingController();
  TextEditingController panCardNumber = TextEditingController();

  TextEditingController _customerStatusController = TextEditingController();

  bool isLeadsDataSaved = false;
  bool isLeadsUpdateData = false;
  bool isClickNext = false;
  String? selfieImageURl;
  String? selfieCapturedDateTime;

  final List<String> _residentialType= [
    'Self owned',
    'Parent owned',
    'Rented',
  ];
  String? _selectedResidentialType;
  final List<String> _residentialStatus= [
    'Resident',
    'Non Resident',
  ];
  String? _selectedResidentialStatus;

  //final List<DropDownData> _customerProfileList = [];

  //dropdowns
  // getDropDownCustProfileData() {
  //   FirebaseFirestore.instance
  //       .collection("customerProfile")
  //       .doc('customerProfile')
  //       .get()
  //       .then((value) {
  //     for (var element in value.data()!['customerProfile']) {
  //       setState(() {
  //         _customerProfileList
  //             .add(DropDownData(element['id'], element['title']));
  //       });
  //     }
  //   });
  // }
 // String? _selectedCustomerProfile;

  // final List<DropDownData> _employeeCategoryList = [];

  // getDropDownEmpCategoryData() {
  //   FirebaseFirestore.instance
  //       .collection("employeeCategory")
  //       .doc('employeeCategory')
  //       .get()
  //       .then((value) {
  //     for (var element in value.data()!['employeeCategory']) {
  //       setState(() {
  //         _employeeCategoryList
  //             .add(DropDownData(element['id'], element['title']));
  //       });
  //     }
  //   });
  // }
 // String? _selectedEmployeeCategory;

  final List<DropDownData> _salutationList = [];

  getDropDownSalutationData() {
    FirebaseFirestore.instance
        .collection("salutation")
        .doc('salutation')
        .get()
        .then((value) {
      for (var element in value.data()!['salutation']) {
        setState(() {
          _salutationList
              .add(DropDownData(element['id'], element['title']));
        });
      }
    });
  }
  String? _selectedSalutation;

  final List<String> _gender= [
    'Male',
    'Female',
  ];
  String? _selectedGender;

  final List<String> _propertyType = [
    'Apartment',
    'Villa',
    'House',
    'Plot',
  ];
  String? _selectedPropertyType;


  final List<String> purposeVisit = [
    'Document Pick up',
    'Lead Capture',
  ];
  String? selectedPurpose;
  String? reasonDisInterest;

  String? selectedProductValue;
  final List<DropDownProductData> _productsList = [];
// final List<DropDownData> _productsList = [];
  String? selectedProdut;
  getDropDownProductsData() {
    FirebaseFirestore.instance
        .collection("products")
        .doc('products')
        .get()
        .then((value) {
      for (var element in value.data()!['products']) {
        setState(() {
          _productsList
              .add(DropDownProductData(element['id'], element['title'],element['type']));
        });
      }
    });
  }

//function to select the date for date of birth
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue, // Your custom yellow color
            hintColor: Color(0xff973232),
            colorScheme: ColorScheme.light(primary: Color(0xff973232) ),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Color(0xff973232),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _dateOfBirth.text = formatDate(pickedDate.toLocal().toString());
      });
    }
  }

  String? _selectedCustomerProfile = 'Formal Salaried';
  String? _selectedEmployeeCategory = 'Partnership';
  List<String> _customerProfileList = [
    'Formal Salaried',
    'Informal Salaried',
    'Formal SEP',
    'Informal SEP',
    'Formal SENP',
    'Informal SENP',
    'Not Working(NA)',
  ];

  Map<String, List<String>> _employeeCategoryList = {
    'Formal Salaried': [
      'Partnership',
      'Proprietorship(formal)',
      'Private Limited(Formal)',
      'Central Govt./State Govt./PSU',
      'Others',
    ],
    'Informal Salaried': [
      'Partnership',
      'Proprietorship(Informal)',
      'Others',
    ],
    'Formal SEP': ['LLP'],
    'Informal SEP': ['HUF'],
    'Formal SENP': ['Others'],
    'Informal SENP': ['Others'],
    'Not Working(NA)': ['Not Working(NA)'],
  };

  var StateId;
  var DistrictID;

  //Additional details

  UnderlineInputBorder enb =  UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:   const BorderSide(color:  Colors.black38)
  );
  UnderlineInputBorder focus =  UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:  const BorderSide(color: Color(0xff778287))
  );


  //function to check if the mandatory filelds are filled
  void checkCustomerFieldsFilled() {
    if (_selectedSalutation != null &&
        firstName.text.isNotEmpty &&
        lastName.text.isNotEmpty &&
        customerNumber.text.isNotEmpty  && _email.text.isNotEmpty &&
        _dateOfBirth.text.isNotEmpty &&  _selectedGender != null) {
      setState(() {
        areCustomerFieldsFilled = true;
      });
    } else {
      setState(() {
        areCustomerFieldsFilled = false;
      });
    }
  }
  void checkAddressFieldsFilled() {
    if (_addressLine1.text.isNotEmpty &&
        _addressLine2.text.isNotEmpty  && _addressLine3.text.isNotEmpty &&
        _city.text.isNotEmpty && _landMark.text.isNotEmpty && _pincode.text.isNotEmpty && selectedPostCode != null &&
    _selectedResidentialType != null && _selectedResidentialStatus != null
    ) {
      setState(() {
        areAddressFieldsFilled = true;
      });
    } else {
      setState(() {
        areAddressFieldsFilled = false;
      });
    }
  }

  void checkLeadsFieldsFilled() {
    if ( _leadAmount.text.isNotEmpty && selectedProductValue != null && selectedProdut != null && _selectedPropertyType != null) {
      setState(() {
        areLeadsFieldsFilled = true;
      });
    } else {
      setState(() {
        areLeadsFieldsFilled = false;
      });
    }
  }

  void checkProfileFieldsFilled() {
    if ( _selectedEmployeeCategory != null && _selectedCustomerProfile != null && aadharCardNumber.text.isNotEmpty && panCardNumber.text.isNotEmpty ) {
      setState(() {
        areProfileFieldsFilled = true;
      });
    } else {
      setState(() {
        areProfileFieldsFilled = false;
      });
    }
  }

String? SalutaionID;
  String? BranchCode1;



  getLeadDetails() {
    if (!widget.isNewActivity) {
      CollectionReference users = FirebaseFirestore.instance.collection('convertedLeads');

      if (widget.visitId != null) {
        // If visitId exists, query with it
        users.where('VisitID', isEqualTo: widget.visitId).get().then((querySnapshot) async {
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
      setState(() {
        isFetching = false;
      });
    }
  }

  void updateUIWithFetchedData() async {
    _dateOfBirth.text = docData["dateOfBirth"] ?? "";
    _email.text = docData["email"] ?? "";
    _selectedGender = docData["gender"] ?? "";
    middleName.text = docData["middleName"] ?? "";
    _additionalPhoneNumber.text = docData["additionalNumber"] ?? "";
    _addressLine1.text = docData["addressLine1"] ?? "";
    _addressLine2.text = docData["addressLine2"] ?? "";
    _addressLine3.text = docData["addressLine3"] ?? "";
    _landMark.text = docData["landmark"] ?? "";
    _city.text = docData["city"] ?? "";
    _district.text = docData["district"] ?? "";
    _pincode.text = docData["pincode"] ?? "";
    _state.text = docData["state"] ?? "";
    selectedProductValue = docData["productCategory"] ?? "";
    selectedProdut = docData["products"] ?? "";
    _selectedPropertyType = docData["propertyType"] ?? "";
    monthlyIncomeOfApplicant.text = docData["monthlyIncome"] ?? "";
    _leadAmount.text = docData["leadAmount"] ?? "";
    panCardNumber.text = docData["panCardNumber"] ?? "";
    aadharCardNumber.text = docData["aadharNumber"] ?? "";
    _selectedResidentialStatus = docData["residentialStatus"] ?? "";
    _selectedResidentialType = docData["residentialType"] ?? "";
    _selectedEmployeeCategory = docData["EmployeeCategory"] ?? "";
    _selectedCustomerProfile = docData["CustomerProfile"] ?? "";
    consentKYC = docData["ConsentKYC"] ?? "";
    consentCRIF = docData["ConsentCRIF"] ?? "";
    isLeadsDataSaved = docData["isLeadSaved"] ?? "";
    print("hgjhghgh");
    print(isLeadsDataSaved);
    setState(() {
      selectedPostCode = docData["postOffice"] ?? "";
    });
    print(selectedPostCode);
  }


  getdata() {
    if (!widget.isNewActivity) {
      CollectionReference users =
      FirebaseFirestore.instance.collection('LeadCreation');
      users.doc(widget.docId).get().then((value) async {
        setState(() {
          docData = value.data();
        });
        _selectedSalutation = docData["salutation"] ?? "";
        firstName.text  = docData["firstName"] ?? "";
        middleName.text  = docData["middleName"] ?? "";
        lastName.text = docData["lastName"] ?? "";
        customerNumber.text = docData["customerNumber"] ?? "";
        _leadSource.text= docData["leadSource"] ?? "";
        customerStatus = docData["customerStatus"] ?? "";
        _customerStatusController.text= docData["customerStatus"] ?? "";
        reasonDisInterest = docData["ReasonforDisinterest"] ?? "";
        latitue= docData["latitude"] ?? "";
        longitude= docData["longitude"] ?? "";
        scheduledDate= docData["visitDate"] ?? "";
        scheduledTime= docData["visitTime"] ?? "";
        // DSAConnectorName = docData["leadSource"] == "DSA"
        //     ? docData["dsaName"] ?? ""
        //     : docData["connectorName"] ?? "";
        DSAConnectorName = docData["leadSource"] == "DSA"
            ? docData["dsaName"] ?? ""
            : docData["leadSource"] == "Marketing Campaign"
            ? docData["compaignName"] ?? ""
            : docData["leadSource"] == "Builder"
            ? docData["builderName"] ?? ""
            : docData["leadSource"] == "Customer Referral"
            ? docData["customerName"] ?? ""
            : docData["leadSource"] == "Employee Referral"
            ? docData["referralEmpName"] ?? ""
            : docData["leadSource"] == "Connector"
            ? docData["connectorName"] ?? ""
            : "";
        DSAConnectorCode1 = docData["DSAConnectorCode"] ?? "";
        visitID = docData["visitID"] ?? "";
        BranchCode1 = docData["EmployeeBranchCode"] ?? "";
        selfieImageURl = docData["selfie"] ?? "";
        selfieCapturedDateTime = docData["SelfieDateTime"] ?? "";
          print(visitID);
      //   if (visitID != null) {
      // // Call function to get lead details
      //    getLeadDetails();
      //   }

        print("123DSACONMARNAME");
        print(DSAConnectorName);
        print(DSAConnectorCode1);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.getString('branchcode');
        print( prefs.getString('branchcode'));
        setState(() {
           leadSource = _leadSource.text;
           branchCode = prefs.getString('branchcode') ?? "";
           print("Lead SOurce");
           print(leadSource);
        });
      });
    } else {
      setState(() {
        isFetching = false;
      });
    }
  }

  // Account Aggregator

  Future<void> callAARedirectionLink() async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var data = {
      "fiuID": ApiUrls().fiuID,
      "redirection_key": ApiUrls().redirection_key,
      "userId": ApiUrls().userId,
    };
    var dio = Dio();
    try {
      var response = await dio.request(
        ApiUrls().authAccAggregatorUAT,
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        var responseData = response.data; // Already a map
        var token = responseData['token'];
        print('Token: $token');

        var headers = {
          'Authorization': 'Bearer ${token ?? ""}',
          'Content-Type': 'application/json'
        };
        var data = json.encode({
          "clienttrnxid": ApiUrls().clienttrnxid,
          "fiuID": ApiUrls().fiuID,
          "userId": ApiUrls().userId,
          "aaCustomerHandleId": ApiUrls().aaCustomerHandleId,
          // "aaCustomerMobile": "8971560421",
          "aaCustomerMobile": "8921051758",
          "sessionId": ApiUrls().sessionId,
          "Integrated_trigger_sms_email": "Y",
          "fipid": "fipuat@citybank",
          "useCaseid": "226"
        });
        var dio = Dio();
        var response1 = await dio.request(
          'https://uatapp.finduit.in/api/FIU/RedirectAA',
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: data,
        );

        if (response1.statusCode == 200) {
          print(json.encode(response1.data));
        }
        else {
          print(response1.statusMessage);
        }



      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  List<DocumentSnapshot> ListOfSavedLeads = [];

  String? LeadID;

  // Future<String?> leadCreation() async {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return Center(
  //         child: SpinKitFadingCircle(
  //           color: Colors.redAccent, // choose your preferred color
  //           size: 50.0,
  //         ),
  //       );
  //     },
  //   );
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.getString('access_token');
  //   var headers = {
  //  'Authorization':  'Bearer ${prefs.getString('access_token') ?? ''}',
  //   //  'Authorization':  'Bearer ${widget.accessToken ?? ''}',
  //     'Content-Type': 'application/json',
  //     'Cookie': 'BrowserId=qnhrXMyBEe6lOh9ncfvoTw; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
  //   };
  //   SharedPreferences pref =
  //   await SharedPreferences.getInstance();
  //  // print(widget.accessToken);
  //   print(customerStatus);
  //   print(selectedProductValue);
  //   var data = json.encode({
  //       "LastName": lastName.text,
  //       "FirstName": firstName.text,
  //       "MiddleName":middleName.text,
  //       "Salutation": _selectedSalutation ?? "",
  //       "Email": _email.text,
  //       "Phone": customerNumber.text,
  //       "HfinBranchcode": BranchCode1,
  //       "Product": selectedProductValue,
  //       "Purpose": selectedProdut ?? "",
  //       "DSAorConnectorName": DSAConnectorName,
  //       "DSAorConnectorCode": DSAConnectorCode1 ?? "",
  //       "LeadSource":leadSource,
  //       "Interest": customerStatus,
  //       "Amount": _leadAmount.text,
  //       "DateOfBirth": _dateOfBirth.text,
  //       "Gender": _selectedGender ?? "",
  //       "ResidentStatus":  _selectedResidentialStatus ?? "",
  //       "ResidentType":_selectedResidentialType ?? "",
  //       "Nationality": _nationality.text,
  //       "CustomerProfile": _selectedCustomerProfile ?? "",
  //       "MonthlyIncome": monthlyIncomeOfApplicant.text,
  //       "EmployerCategory": _selectedEmployeeCategory ?? "",
  //       "Pan": panCardNumber.text,
  //       "Aadhaar": aadharCardNumber.text,
  //       "Address1":_addressLine1.text,
  //       "Address2": _addressLine2.text,
  //       "Address3": _addressLine3.text,
  //       "Landmark": _landMark.text,
  //       "City": _city.text,
  //       "State": StateId,
  //       "District": DistrictID,
  //       "PostalName": selectedPostCode ?? "",
  //       "Pincode": _pincode.text,
  //       "Country": "1",
  //       "Latitude":latitue.toString(),
  //       "Longitude": longitude.toString(),
  //       "ScheduleDate": scheduledDate,
  //       "scheduleTime": DateFormat("HH:mm:ss").format(DateFormat("h:mm a").parse(scheduledTime ?? "")),
  //       "AssignedSM": pref.getString("managerName"),
  //       "LeadOwner": pref.getString("managerName"),
  //       "ConsentForCrif":consentCRIF,
  //       "ConsentForKyc": consentKYC,
  //       "IsDocumentCollected": true,
  //       "isDirectLeads": true
  //   });
  //
  //  print(data);
  //   var dio = Dio();
  //   var response = await dio.request(
  //     'https://muthootltd.my.salesforce.com/services/apexrest/LeadCreationTest/',
  //     options: Options(
  //       method: 'POST',
  //       headers: headers,
  //     ),
  //     data: data,
  //   );
  //   try {
  //     if (response.statusCode == 200) {
  //     //  Navigator.pop(context);
  //       var responseMap = response.data;
  //       String statusMessage = responseMap['statusMessage'];
  //       int statusCode = responseMap['statusCode'];
  //
  //       if (statusMessage == "Lead created successfully" && statusCode == 200) {
  //         print(json.encode(responseMap));
  //
  //         String sfLeadId = responseMap['SFleadId'];
  //         setState(() {
  //           LeadID = sfLeadId;
  //         });
  //
  //         print("Lead ID");
  //         print(LeadID);
  //         updateDataToFirestore();
  //       //  Navigator.pop(context);
  //       } else {
  //          _showAlertDialogSuccess1(context);
  //         Navigator.pop(context);
  //         print("hjdjnvfv");
  //         _showToast('Error: Please try again');
  //       }
  //     } else {
  //       Navigator.pop(context);
  //       print("hjdjnvfv");
  //       //_showAlertDialogSuccess1(context);
  //       _showToast('Error: ${response.statusCode}');
  //       // _showAlertDialogSuccess1(context);
  //     }
  //   } catch (e) {
  //     Navigator.pop(context);
  //     print("hjdjnvfv");
  //     _showToast('Error: $e');
  //     print("Error: $e");
  //   }
  // }

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

  // Future<void> updateDataToVisitFirestore() async {
  //   CollectionReference convertedLeads = FirebaseFirestore.instance.collection("LeadCreation");
  //   DateTime now = DateTime.now();
  //   print("Hello");
  //   try{
  //     Map<String, dynamic> params = {
  //       'LeadID' : LeadID,
  //       'updatedTime':Timestamp.fromDate(now),
  //     };
  //     convertedLeads.where('customerNumber', isEqualTo: customerNumber.text).get().then((querySnapshot) {
  //       if (querySnapshot.docs.isNotEmpty) {
  //         print(querySnapshot.docs.isNotEmpty);
  //         convertedLeads.doc(querySnapshot.docs.first.id).update(params).then((value) {
  //           print("Data updated to Visits successfully");
  //         //  Navigator.pop(context);
  //         }).catchError((error) {
  //           print("Failed to update data: $error");
  //         });
  //       } else {
  //          // Navigator.pop(context);
  //       }
  //     }).catchError((error) {
  //       print("Failed to check if customerNumber exists: $error");
  //     });
  //
  //   }catch(e){
  //     print(e);
  //   };
  //
  //
  // }

  Future<void> updateDataToFirestore() async {
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
    print(StateId);
    print("StateId34556");
    CollectionReference convertedLeads =
    FirebaseFirestore.instance.collection("convertedLeads");
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userId = pref.getString("userID");
    DateTime now = DateTime.now();
    print("Hello");
    try {
      // Build the parameters for the update
      Map<String, dynamic> params = {
        'CustomerStatus': customerStatus,
        'ReasonforDisinterest': reasonDisInterest,
        'salutation': _selectedSalutation,
        'firstName': firstName.text,
        'lastName': lastName.text,
        'middleName': middleName.text,
        'customerNumber': customerNumber.text,
        'email': _email.text,
        'additionalNumber': _additionalPhoneNumber.text,
        'dateOfBirth': _dateOfBirth.text,
        'gender': _selectedGender,
        'addressLine1': _addressLine1.text,
        'addressLine2': _addressLine2.text,
        'addressLine3': _addressLine3.text,
        'city': _city.text,
        'landmark': _landMark.text,
        'state': _state.text,
        'district': _district.text,
        'stateID':   pref.getString("stateID") ?? "",
        'districtID':  pref.getString("districtID") ?? "",
        'postOffice': selectedPostCode ?? "",
        'pincode': _pincode.text,
        'residentialType': _selectedResidentialType ?? "",
        'residentialStatus': _selectedResidentialStatus ?? "",
        'homeFinBranchCode': BranchCode1,
        'leadAmount': _leadAmount.text,
        'leadSource': _leadSource.text,
        'productCategory': selectedProductValue ?? "",
        'products': selectedProdut ?? "",
        'propertyType': _selectedPropertyType ?? "",
        'CustomerProfile': _selectedCustomerProfile ?? "",
        'EmployeeCategory': _selectedEmployeeCategory ?? "",
        'monthlyIncome': monthlyIncomeOfApplicant.text,
        'aadharNumber': aadharCardNumber.text,
        'panCardNumber': panCardNumber.text,
        'ConsentCRIF': consentCRIF,
        'ConsentKYC': consentKYC,
        'VisitID': visitID ?? "",
        'LeadID': "-",
        'VerificationStatus': "Pending",
        'userId': userId,
        'EmployeeName': pref.getString("employeeName"),
        'EmployeeCode': pref.getString("employeeCode"),
        'EmployeeBranchCode': BranchCode1,
        'ManagerName': pref.getString("managerName"),
        'ManagerCode': pref.getString("ManagerCode"),
        'Region': pref.getString("Region"),
        'Zone': pref.getString("Zone"),
        'Designation': pref.getString("designation"),
        'createdDateTime': Timestamp.fromDate(now),
        'isLeadSaved': true,
        'dsaConnectorName': DSAConnectorName,
        'selfieImageURl' : selfieImageURl ?? "",
      'selfieCapturedDateTime' : selfieCapturedDateTime ?? "",
        'dsaConnectoreCode': DSAConnectorCode1,
        'latitude': latitue.toString(),
        'longitude': longitude.toString(),
        'scheduledDate': scheduledDate,
        'scheduledTime': DateFormat("HH:mm:ss")
            .format(DateFormat("h:mm a").parse(scheduledTime ?? "")),
      };
      print(params);

      // Query to find the document based on the visit ID
      QuerySnapshot querySnapshot = await convertedLeads
          .where('VisitID', isEqualTo: visitID)
          .get();

      // Check if there's a document with the given visit ID
      if (querySnapshot.docs.isNotEmpty) {
        // Update the existing document with the new parameters
        await convertedLeads.doc(querySnapshot.docs.first.id).update(params);
        print("Data updated successfully");
        Navigator.pop(context);
        _showAlertDialogSuccess(context);

      } else {
        // Add a new document since no existing document with the given visit ID was found
        await convertedLeads.add(params);
        print("Data added successfully");
        Navigator.pop(context);
        _showAlertDialogSuccess(context);

      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> updateLeadsDataToFirestore() async {
    print(StateId);
    print("StateId34556");
    CollectionReference convertedLeads =
    FirebaseFirestore.instance.collection("convertedLeads");
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userId = pref.getString("userID");
    DateTime now = DateTime.now();
    print("Hello");
    try {
      // Build the parameters for the update
      Map<String, dynamic> params = {
        'CustomerStatus': customerStatus,
        'ReasonforDisinterest': reasonDisInterest,
        'salutation': _selectedSalutation,
        'firstName': firstName.text,
        'lastName': lastName.text,
        'middleName': middleName.text,
        'customerNumber': customerNumber.text,
        'email': _email.text,
        'additionalNumber': _additionalPhoneNumber.text,
        'dateOfBirth': _dateOfBirth.text,
        'gender': _selectedGender,
        'addressLine1': _addressLine1.text,
        'addressLine2': _addressLine2.text,
        'addressLine3': _addressLine3.text,
        'city': _city.text,
        'landmark': _landMark.text,
        'state': _state.text,
        'district': _district.text,
        'stateID':   pref.getString("stateID") ?? "",
        'districtID':  pref.getString("districtID") ?? "",
        'postOffice': selectedPostCode ?? "",
        'pincode': _pincode.text,
        'residentialType': _selectedResidentialType ?? "",
        'residentialStatus': _selectedResidentialStatus ?? "",
        'homeFinBranchCode': BranchCode1,
        'leadAmount': _leadAmount.text,
        'leadSource': _leadSource.text,
        'productCategory': selectedProductValue ?? "",
        'products': selectedProdut ?? "",
        'propertyType': _selectedPropertyType ?? "",
        'CustomerProfile': _selectedCustomerProfile ?? "",
        'EmployeeCategory': _selectedEmployeeCategory ?? "",
        'monthlyIncome': monthlyIncomeOfApplicant.text,
        'aadharNumber': aadharCardNumber.text,
        'panCardNumber': panCardNumber.text,
        'ConsentCRIF': consentCRIF,
        'ConsentKYC': consentKYC,
        'VisitID': visitID ?? "",
        'LeadID': "-",
        'VerificationStatus': "Pending",
        'userId': userId,
        'EmployeeName': pref.getString("employeeName"),
        'EmployeeCode': pref.getString("employeeCode"),
        'EmployeeBranchCode': BranchCode1,
        'ManagerName': pref.getString("managerName"),
        'ManagerCode': pref.getString("ManagerCode"),
        'Region': pref.getString("Region"),
        'Zone': pref.getString("Zone"),
        'Designation': pref.getString("designation"),
        'createdDateTime': Timestamp.fromDate(now),
        'isLeadSaved': true,
        'dsaConnectorName': DSAConnectorName,
        'dsaConnectoreCode': DSAConnectorCode1,
        'latitude': latitue.toString(),
        'longitude': longitude.toString(),
        'scheduledDate': scheduledDate,
        'scheduledTime': DateFormat("HH:mm:ss")
            .format(DateFormat("h:mm a").parse(scheduledTime ?? "")),
      };
      print(params);

      // Query to find the document based on the visit ID
      QuerySnapshot querySnapshot = await convertedLeads
          .where('VisitID', isEqualTo: visitID)
          .get();

      // Check if there's a document with the given visit ID
      if (querySnapshot.docs.isNotEmpty) {
        // Update the existing document with the new parameters
        await convertedLeads.doc(querySnapshot.docs.first.id).update(params);
        print("Data updated successfully");
      }
    } catch (e) {
      print("Error: $e");
    }
  }




  // Future<void> getToken()
  // async {
  //   var headers = {
  //     'X-PrettyPrint': '1',
  //     'Content-Type': 'application/x-www-form-urlencoded',
  //     'Cookie': 'BrowserId=qnhrXMyBEe6lOh9ncfvoTw; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
  //   };
  //   var data = {
  //     'grant_type': 'password',
  //     'client_id': '3MVG9WZIyUMp1ZfoWDelgr4puVA8Cbw2py9NcKnfiPbsdxV6CU1HXQssNTT2XpRFqPmQ8OX.F4ZbP_ziL2rmf',
  //     'client_secret': '4382921A497F5B4DED8F7E451E89D1228EE310F729F64641429A949D53FA1B84',
  //     'username': 'salesappuser@muthoothomefin.com',
  //     'password': 'Pass@123456F7aghs4Z5RxQ5hC2pktsSLJfq'
  //   };
  //   var dio = Dio();
  //   var response = await dio.request(
  //     'https://muthootltd.my.salesforce.com/services/oauth2/token',
  //     options: Options(
  //       method: 'POST',
  //       headers: headers,
  //     ),
  //     data: data,
  //   );
  //
  //   String? accessToken;
  //   if (response.statusCode == 200) {
  //
  //     String jsonResponse = json.encode(response.data);
  //     Map<String, dynamic> jsonMap = json.decode(jsonResponse);
  //     accessToken = jsonMap['access_token'];
  //
  //     // Store the access token locally
  //     saveAccessToken(accessToken!);
  //     print("AccessToken");
  //     print(accessToken);
  //   }
  // }
  // Future<void> saveAccessToken(String token) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('access_token', token);
  //   print("Stored Access token");
  //   print(token);
  // }



  _saveSelectedPostCode(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedPostCode', value);
  }
  _loadSelectedPostCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedPostCode = prefs.getString('selectedPostCode');
    });
  }

  initState() {
    // TODO: implement initState
    super.initState();
    //getToken();
  //  print(widget.accessToken);
    getDropDownProductsData();
    getDropDownSalutationData();
    getdata();
   getLeadDetails();
    _loadSelectedPostCode();
   // fetchLeadData(widget.visitId);
    //getDropdownConnectorData();
  //  getDropDownEmpCategoryData();
   // getDropDownCustProfileData();
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
      child: SafeArea(
        child: Scaffold(
          appBar:  AppBar(
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
                  child: Image.asset(
                    'assets/images/arrow.png',
                  ),),
            ),
            title: Text("New Lead",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: StyleData.boldFont),),
            centerTitle: true,

          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: height * 0.01),
                            Row(
                              children: [
                                Checkbox(
                                  value: consentCRIF,
                                  activeColor: StyleData.appBarColor,
                                  onChanged: (value) {
                                    setState(() {
                                      consentCRIF = value!;
                                    });
                                  },
                                ),
                                Text(
                                  'Consent for getting CRIF',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: consentKYC,
                                  activeColor: StyleData.appBarColor,
                                  onChanged: (value) {
                                    setState(() {
                                      consentKYC = value!;
                                    });
                                  },
                                ),
                                Text(
                                  'Consent for getting KYC',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: consentAccountAgregator,
                                  activeColor: StyleData.appBarColor,
                                  onChanged: (value) {
                                    setState(() {
                                      consentAccountAgregator = value!;
                                    });
                                  },
                                ),
                                Text(
                                  'Consent for Account Aggregator',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Visibility(
                                visible: consentAccountAgregator,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton.icon(
                                    onPressed: () {
                                      callAARedirectionLink();
                                    },
                                    icon: Icon(Icons.sms, color: Colors.grey),
                                    label: Text(
                                      'Send SMS',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.grey[300],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.03),
                            Visibility(
                              visible: consentCRIF == true && consentKYC == true,
                                child: Column(
                              children: [
                                Card(
                                  elevation: 3,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isCustomerInfo = !isCustomerInfo;
                                        isAddressInfo = false;
                                        isLeadInfo = false;
                                        isProfileInfo = false;
                                      });
                                    },
                                    child: Container(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: height * 0.05,
                                                width: width * 1,
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/icons8-customer-48.png',
                                                      width: width * 0.08,
                                                      height: height * 0.04,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.05,
                                                    ),
                                                    Text("Customer Information",style: TextStyle(color: StyleData.appBarColor,fontWeight: FontWeight.bold,fontSize: 16),),
                                                    Spacer(),
                                                    areCustomerFieldsFilled || isLeadsDataSaved == true
                                                        ? Icon(Icons.check_circle_sharp, color: Colors.green, size: 22,)
                                                        : Icon(Icons.arrow_drop_down_circle_rounded, color: StyleData.buttonColor, size: 22,)
                                                  ],
                                                ),
                                              ),
                                              // SizedBox(height: height * 0.015),
                                              Visibility(
                                                  visible:  isCustomerInfo == true,
                                                  child: Column(
                                                    children: [
                                                      IgnorePointer(
                                                        ignoring : true,
                                                        child: DropdownButtonFormField2<String>(
                                                          value: _selectedSalutation,
                                                          onChanged: (String? newValue) {
                                                            setState(() {
                                                              _selectedSalutation = newValue;
                                                              checkCustomerFieldsFilled();
                                                            });
                                                          },
                                                          items: _salutationList
                                                              .map((DropDownData item){
                                                            return DropdownMenuItem(
                                                              value: item.title,
                                                              child: Text(
                                                                item.title,
                                                                style: const TextStyle(
                                                                  color: Color(0xFF393939),
                                                                  fontSize: 15,
                                                                  fontFamily: 'Poppins',
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                          style: const TextStyle(
                                                            color: Color(0xFF393939),
                                                            fontSize: 15,
                                                            fontFamily: 'Poppins',
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                          //   hint: const Text('Select an option'),
                                                          decoration: InputDecoration(
                                                            labelText: 'Salutation *',
                                                            hintText: 'Select an option',
                                                            //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                            focusedBorder: focus,
                                                            enabledBorder: enb,
                                                            filled: true,
                                                            fillColor: StyleData.textFieldColor,
                                                          ),
                                                        ),
                                                      ),
                                                      TextFormField(
                                                        controller: firstName,
                                                        readOnly: true,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            checkCustomerFieldsFilled();
                                                          });
                                                        },
                                                        decoration: InputDecoration(
                                                          labelText: 'First Name *',
                                                          hintText: 'Enter First Name',
                                                          //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                          focusedBorder: focus,
                                                          enabledBorder: enb,
                                                          filled: true,
                                                          fillColor: StyleData.textFieldColor,
                                                        ),
                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return 'Please enter your first name';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      TextFormField(
                                                        controller: middleName,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            checkCustomerFieldsFilled();
                                                          });
                                                        },
                                                        decoration: InputDecoration(
                                                          labelText: 'Middle Name',
                                                          hintText: 'Enter Middle Name',
                                                          //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                          focusedBorder: focus,
                                                          enabledBorder: enb,
                                                          filled: true,
                                                          fillColor: StyleData.textFieldColor,
                                                        ),
                                                        // validator: (value) {
                                                        //   if (value == null || value.isEmpty) {
                                                        //     return 'Please enter your middle name';
                                                        //   }
                                                        //   return null;
                                                        // },
                                                      ),
                                                      TextFormField(
                                                        controller: lastName,
                                                        readOnly: true,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            checkCustomerFieldsFilled();
                                                          });
                                                        },
                                                        decoration: InputDecoration(
                                                          labelText: 'Last Name *',
                                                          hintText: 'Enter Last Name',
                                                          //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                          // border: InputBorder.none,
                                                          focusedBorder: focus,
                                                          enabledBorder: enb,
                                                          filled: true,
                                                          fillColor: StyleData.textFieldColor,
                                                        ),
                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return 'Please enter your last name';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      TextFormField(
                                                        controller: customerNumber,
                                                        readOnly: true,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            checkCustomerFieldsFilled();
                                                          });
                                                        },
                                                        decoration: InputDecoration(
                                                          labelText: 'Customer Phone *',
                                                          hintText: 'Enter Customer Phone',
                                                          //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                          //  border: InputBorder.none,
                                                          focusedBorder: focus,
                                                          enabledBorder: enb,
                                                          filled: true,
                                                          fillColor: StyleData.textFieldColor,
                                                        ),
                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return 'Please enter your mobile number';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      TextFormField(
                                                        controller: _email,
                          
                                                        onChanged: (value) {
                                                          setState(() {
                                                           checkCustomerFieldsFilled();
                                                          });
                                                        },
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Enter email';
                                                          }
                                                          // Check if email contains '@'
                                                          if (!value.contains('@')) {
                                                            return 'Enter a valid email address (missing "@")';
                                                          }
                                                          // Check if email contains space
                                                          if (value.contains(' ')) {
                                                            return 'Email cannot contain spaces';
                                                          }
                                                          // Additional validation for Gmail format
                                                          if (!value.endsWith('.com')) {
                                                            return 'Enter a valid Gmail address';
                                                          }
                                                          return null;
                                                        },
                                                        decoration: InputDecoration(
                                                          labelText: 'Email*',
                                                          hintText: 'Enter email',
                                                          //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                          focusedBorder: focus,
                                                          enabledBorder: enb,
                                                          filled: true,
                                                          fillColor: StyleData.textFieldColor,
                                                        ),
                                                      ),
                                                      TextFormField(
                                                        controller: _additionalPhoneNumber,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            // checkFieldsFilled();
                                                          });
                                                        },
                                                        keyboardType: TextInputType.phone,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter.digitsOnly,
                                                          LengthLimitingTextInputFormatter(10),
                                                        ],
                                                        decoration: InputDecoration(
                                                          labelText: 'Additional Phone Number',
                                                          hintText: 'Enter Phone Number',
                                                          prefixText: '+91 ',
                                                          //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                          focusedBorder: focus,
                                                          enabledBorder: enb,
                                                          filled: true,
                                                          fillColor: StyleData.textFieldColor,
                                                        ),
                                                      ),
                                                      TextFormField(
                                                        //   focusNode: _dateFocus,
                                                        controller: _dateOfBirth,
                                                        readOnly: true,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            checkCustomerFieldsFilled();
                                                          });
                                                        },
                                                        onTap: () => _selectDate(context),
                                                        decoration: InputDecoration(
                                                          labelText: 'Date Of Birth *',
                                                          suffixIcon: Icon(Icons.calendar_today),
                                                          focusedBorder: focus,
                                                          enabledBorder: enb,
                                                          filled: true,
                                                          fillColor: StyleData.textFieldColor,
                                                        ),
                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return 'Please enter Date of Birth';
                                                          }
                                                          // Parsing the selected date
                                                          DateTime selectedDate = DateTime.parse(value);
                          
                                                          // Calculating age
                                                         int age = DateTime.now().year - selectedDate.year;
                          
                                                          // Checking if age falls within the specified range
                                                          if (age < 18 || age > 70) {
                                                            setState(() {
                                                              isDateOfBirth = true;
                                                            });
                                                            return 'Age should fall between 18 and 70 years old.';
                                                          }
                          
                                                          return null;
                                                        },
                          
                                                      ),
                                                      DropdownButtonFormField2<String>(
                                                        value: _selectedGender,
                                                        onChanged: (String? newValue) {
                                                          setState(() {
                                                            _selectedGender = newValue;
                                                            if (_selectedSalutation == "Mr") {
                                                              _selectedGender = "Male";
                                                            } else if (_selectedSalutation == "Mrs" || _selectedSalutation == "Miss." || _selectedSalutation == "Ms." || _selectedSalutation == "Smt." ||  _selectedSalutation == "Kumari."  ) {
                                                              _selectedGender = "Female";
                                                            }
                                                            checkCustomerFieldsFilled();
                                                          });
                                                        },
                                                        validator: (String? value) { // Fix the type of value
                                                          if (value == null || value.isEmpty) { // Handle null safety
                                                            return 'Select Gender';
                                                          }
                                                          return null;
                                                        },
                                                        items: _gender
                                                            .map((String item){
                                                          return DropdownMenuItem(
                                                            value: item,
                                                            child: Text(
                                                              item.toString(),
                                                              style: const TextStyle(
                                                                color: Color(0xFF393939),
                                                                fontSize: 15,
                                                                fontFamily: 'Poppins',
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          );
                                                        }).toList(),
                                                        style: const TextStyle(
                                                          color: Color(0xFF393939),
                                                          fontSize: 15,
                                                          fontFamily: 'Poppins',
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                        //   hint: const Text('Select an option'),
                                                        decoration: InputDecoration(
                                                          labelText: 'Gender *',
                                                          hintText: 'Select an option',
                                                          //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                          focusedBorder: focus,
                                                          enabledBorder: enb,
                                                          filled: true,
                                                          fillColor: StyleData.textFieldColor,
                                                        ),
                                                      ),
                                                      TextFormField(
                                                        controller: _customerStatusController,
                                                        //  initialValue: selectedDSACode1,
                                                        readOnly: true,
                                                        decoration: InputDecoration(
                                                          labelText: 'Customer Status',
                                                          hintText: '',
                                                          focusedBorder: focus,
                                                          enabledBorder: enb,
                                                          filled: true,
                                                          fillColor: StyleData.textFieldColor,
                                                        ),
                                                      ),
                                                      SizedBox(height: height * 0.02),
                                                      Visibility(
                                                        visible: areCustomerFieldsFilled || isLeadsDataSaved == true,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            if(areCustomerFieldsFilled)
                                                            {
                                                              setState(() {
                                                                isAddressInfo = !isAddressInfo;
                                                                isCustomerInfo = false;
                                                                isLeadInfo = false;
                                                                isProfileInfo = false;
                                                              });
                                                            }},
                                                          child: Align(
                                                            alignment: Alignment.bottomRight,
                                                            child: Icon(
                                                              Icons.arrow_circle_down,
                                                              color: Colors.yellow.shade800, // Set your desired arrow color
                                                              size: 22,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                                Card(
                                  elevation: 3,
                                  child: GestureDetector(
                                    onTap: () {
                                      if(areCustomerFieldsFilled || isLeadsDataSaved == true)
                                      {
                                        setState(() {
                                          isAddressInfo = !isAddressInfo;
                                          isCustomerInfo = false;
                                          isLeadInfo = false;
                                          isProfileInfo = false;
                                        });
                                      }
                                    },
                                    child: Container(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: height * 0.05,
                                                width: width * 1,
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/address.png',
                                                      width: width * 0.08,
                                                      height: height * 0.04,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.05,
                                                    ),
                                                    Text("Address Information",style: TextStyle(color: StyleData.appBarColor,fontWeight: FontWeight.bold,fontSize: 16),),
                                                    Spacer(),
                                                    areAddressFieldsFilled || isLeadsDataSaved == true
                                                        ? Icon(Icons.check_circle_sharp, color: Colors.green, size: 22,)
                                                        : Icon(Icons.arrow_drop_down_circle_rounded, color: StyleData.buttonColor, size: 22,)
                                                  ],
                                                ),
                                              ),
                                              // SizedBox(height: height * 0.015),
                                              Visibility(
                                                  visible:  isAddressInfo == true,
                                                  child: Column(
                                                    children: [
                                                      TextFormField(
                                                        controller: _addressLine1,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            checkAddressFieldsFilled();
                                                          });
                                                        },
                                                        decoration: InputDecoration(
                                                          labelText: 'Address Line 1 *',
                                                          hintText: 'Enter Address Line 1',
                                                          //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                          //   border: InputBorder.none,
                                                          focusedBorder: focus,
                                                          enabledBorder: enb,
                                                          filled: true,
                                                          fillColor: StyleData.textFieldColor,
                                                        ),
                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return 'Please enter Address Line 1';
                                                          }
                                                          if (value.length > 30) {
                                                            return 'Address Line 1 must not exceed 30 characters';
                                                          }
                                                          return null;
                                                        },
                                                        inputFormatters: [
                                                          LengthLimitingTextInputFormatter(30), // Restrict input to 30 characters
                                                        ],
                                                     //   maxLength: 30, // Setting maximum character length
                                                      ),
                          
                                                      TextFormField(
                                                        controller: _addressLine2,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            checkAddressFieldsFilled();
                                                          });
                                                        },
                                                        decoration: InputDecoration(
                                                          labelText: 'Address Line 2 *',
                                                          hintText: 'Enter Address Line 2',
                                                          //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                          //   border: InputBorder.none,
                                                          focusedBorder: focus,
                                                          enabledBorder: enb,
                                                          filled: true,
                                                          fillColor: StyleData.textFieldColor,
                                                        ),
                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return 'Please enter address line 2';
                                                          }
                                                          if (value.length > 30) {
                                                            return 'Address Line 2 must not exceed 30 characters';
                                                          }
                                                          return null;
                                                        },
                                                        inputFormatters: [
                                                          LengthLimitingTextInputFormatter(30), // Restrict input to 30 characters
                                                        ],
                                                      ),
                                                      TextFormField(
                                                        controller: _addressLine3,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            checkAddressFieldsFilled();
                                                          });
                                                        },
                                                        decoration: InputDecoration(
                                                          labelText: 'Address Line 3 *',
                                                          hintText: 'Enter Address Line 3',
                                                          //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                          //   border: InputBorder.none,
                                                          focusedBorder: focus,
                                                          enabledBorder: enb,
                                                          filled: true,
                                                          fillColor: StyleData.textFieldColor,
                                                        ),
                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return 'Please enter address line 3';
                                                          }
                                                          if (value.length > 30) {
                                                            return 'Address Line 3 must not exceed 30 characters';
                                                          }
                                                          return null;
                                                        },
                                                        inputFormatters: [
                                                          LengthLimitingTextInputFormatter(30), // Restrict input to 30 characters
                                                        ],
                                                      ),
                                                      TextFormField(
                                                        controller: _city,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            checkAddressFieldsFilled();
                                                          });
                                                        },
                                                        decoration: InputDecoration(
                                                          labelText: 'City/Town/Village *',
                                                          hintText: 'Enter City/Town/Village',
                                                          //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                          //   border: InputBorder.none,
                                                          focusedBorder: focus,
                                                          enabledBorder: enb,
                                                          filled: true,
                                                          fillColor: StyleData.textFieldColor,
                                                        ),
                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return 'Please enter your City/Town/Village';
                                                          }
                                                          return null;
                                                        },
                                                        inputFormatters: [
                                                          LengthLimitingTextInputFormatter(20), // Restrict input to 30 characters
                                                        ],
                                                      ),
                                                      TextFormField(
                                                        controller: _landMark,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            checkAddressFieldsFilled();
                                                          });
                                                        },
                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return 'Please enter landmark';
                                                          }
                                                          return null;
                                                        },
                                                        decoration: InputDecoration(
                                                          labelText: 'Landmark *',
                                                          hintText: 'Enter Landmark',
                                                          //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                          //   border: InputBorder.none,
                                                          focusedBorder: focus,
                                                          enabledBorder: enb,
                                                          filled: true,
                                                          fillColor: StyleData.textFieldColor,
                                                        ),
                                                        inputFormatters: [
                                                          LengthLimitingTextInputFormatter(20), // Restrict input to 30 characters
                                                        ],
                                                      ),
                                                      TextFormField(
                                                        controller: _pincode,
                                                        onChanged: (value) async {
                                                          setState(() {
                                                            checkAddressFieldsFilled();
                                                          });
                                                          if (value.length == 6) {
                                                            final String jsonContent = await rootBundle
                                                                .loadString('assets/jsons/citylist.json');
                          
                                                            final List<dynamic> jsonData =
                                                            json.decode(jsonContent);
                          
                                                            var listSearchData = jsonData
                                                                .where((item) => item['PC'].toString().toLowerCase().contains(value.toLowerCase()))
                                                                .toList();
                          
                                                            print("Helloooooooooo");
                                                            print(listSearchData);
                                                            if (listSearchData.isNotEmpty) {
                                                              selectedPostCode = null;
                                                              setState(() {
                                                                _PostcodeList =
                                                                    listSearchData.map((e) => e).toList();
                                                              });
                          
                                                              print("List Drop Data");
                                                              var districtNames = listSearchData
                                                                  .map((e) => e["D"].toString())
                                                                  .toSet() // Convert to a set to remove duplicates
                                                                  .first;
                                                              var districtID = listSearchData
                                                                  .map((e) => e["DI"].toString())
                                                                  .toSet() // Convert to a set to remove duplicates
                                                                  .first; // Take the first element
                          
                                                              print(districtNames);
                                                              print(districtID);
                          
                                                              var stateName = listSearchData
                                                                  .map((e) => e["S"].toString())
                                                                  .toSet() // Convert to a set to remove duplicates
                                                                  .first;
                                                              var stateID = listSearchData
                                                                  .map((e) => e["SI"].toString())
                                                                  .toSet() // Convert to a set to remove duplicates
                                                                  .first; // Take the first element
                          
                                                              print(stateName);
                                                              print(stateID);
                          
                                                              setState(() {
                                                                _district.text = districtNames;
                                                                _state.text = stateName;
                                                                StateId = stateID;
                                                                DistrictID = districtID;
                                                              });
                                                              SharedPreferences pref = await SharedPreferences.getInstance();
                                                              pref.setString("stateID", StateId);
                                                              pref.setString("districtID", DistrictID);
                                                            } else {
                                                              _PostcodeList.clear();
                                                              //  showToastMessage('Enter correct pincode');
                                                            }
                                                          }
                                                        },
                                                        keyboardType: TextInputType.phone,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter.singleLineFormatter,
                                                          LengthLimitingTextInputFormatter(6),
                                                        ],
                                                        decoration: InputDecoration(
                                                          labelText: 'Pincode *',
                                                          hintText: 'Enter Pincode',
                                                          //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                          //  border: InputBorder.none,
                                                          focusedBorder: focus,
                                                          enabledBorder: enb,
                                                          filled: true,
                                                          fillColor: StyleData.textFieldColor,
                                                        ),
                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return 'Please enter pincode';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      DropdownButtonFormField2(
                                                        dropdownStyleData:DropdownStyleData(
                                                          decoration: BoxDecoration(
                                                            //     color: StyleData.buttonColor,
                                                              borderRadius: BorderRadius.circular(10)
                          
                                                          ),
                                                          maxHeight: 200,
                                                        ) ,
                                                        // isExpanded: true,
                                                        // isDense: true,
                                                        decoration: InputDecoration(
                                                          labelText: 'Post Office *',
                                                          hintText: 'Select an option',
                                                          //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                          focusedBorder: focus,
                                                          enabledBorder: enb,
                                                          filled: true,
                                                          fillColor: StyleData.textFieldColor,
                                                        ),
                                                        validator: (value) {
                                                          if (selectedPostCode == null) {
                                                            return "Select Post Office";
                                                          }
                                                          return null;
                                                        },
                                                        value: selectedPostCode,
                                                        onChanged: (value) {
                                                          // checkAddressFieldsFilled();
                                                          setState(() {
                                                            selectedPostCode = value as String?;
                                                            _saveSelectedPostCode(selectedPostCode!);
                                                          });
                                                        },
                          
                                                        items: _PostcodeList.map((dynamic item) {
                                                          return DropdownMenuItem(
                                                            value: item["PO"],
                                                            child: Text(
                                                              item["PO"],
                                                              style: const TextStyle(
                                                                color: Color(0xFF393939),
                                                                fontSize: 15,
                                                                fontFamily: 'Poppins',
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          );
                                                        }).toList(),
                                                        style: const TextStyle(
                                                          color: Color(0xFF393939),
                                                          fontSize: 15,
                                                          fontFamily: 'Poppins',
                                                          fontWeight: FontWeight.w400,
                                                        ),
                          
                                                        // items:
                                                        //     _PostcodeList.map((dynamic item) {
                                                        //   return DropdownMenuItem<dynamic>(
                                                        //     value: item,
                                                        //     child: Text(
                                                        //       item,
                                                        //       style: const TextStyle(color: Colors.white),
                                                        //     ),
                                                        //   );
                                                        // }).toList(),
                                                      ),
                                                      TextFormField(
                                                        controller: _district,
                                                        readOnly: true,
                                                        // onChanged: (value) {
                                                        //   setState(() {
                                                        //     checkAddressFieldsFilled();
                                                        //   });
                                                        // },
                                                        decoration: InputDecoration(
                                                          labelText: 'District *',
                                                          hintText: 'Enter District',
                                                          //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                          //   border: InputBorder.none,
                                                          focusedBorder: focus,
                                                          enabledBorder: enb,
                                                          filled: true,
                                                          fillColor: StyleData.textFieldColor,
                                                        ),
                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return 'Please enter your district';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      TextFormField(
                                                        controller: _state,
                                                        readOnly: true,
                                                        // onChanged: (value) {
                                                        //   setState(() {
                                                        //     checkAddressFieldsFilled();
                                                        //   });
                                                        // },
                                                        decoration: InputDecoration(
                                                          labelText: 'State *',
                                                          hintText: '',
                                                          //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                          //   border: InputBorder.none,
                                                          focusedBorder: focus,
                                                          enabledBorder: enb,
                                                          filled: true,
                                                          fillColor: StyleData.textFieldColor,
                                                        ),
                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return 'Please enter your State';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      DropdownButtonFormField2<String>(
                                                        value:_selectedResidentialType,
                                                        onChanged: (String? newValue) {
                                                          setState(() {
                                                            _selectedResidentialType = newValue;
                                                            checkAddressFieldsFilled();
                                                          });
                                                        },
                                                        items: _residentialType
                                                            .map((String item){
                                                          return DropdownMenuItem(
                                                            value: item,
                                                            child: Text(
                                                              item.toString(),
                                                              style: const TextStyle(
                                                                color: Color(0xFF393939),
                                                                fontSize: 15,
                                                                fontFamily: 'Poppins',
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          );
                                                        }).toList(),
                                                        style: const TextStyle(
                                                          color: Color(0xFF393939),
                                                          fontSize: 15,
                                                          fontFamily: 'Poppins',
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                        //   hint: const Text('Select an option'),
                                                        decoration: InputDecoration(
                                                          labelText: 'Residential Type *',
                                                          hintText: 'Select an option',
                                                          //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                          // border: InputBorder.none,
                                                          focusedBorder: focus,
                                                          enabledBorder: enb,
                                                          filled: true,
                                                          fillColor: StyleData.textFieldColor,
                                                        ),
                                                      ),
                                                      DropdownButtonFormField2<String>(
                                                        value:_selectedResidentialStatus,
                                                        onChanged: (String? newValue) {
                                                          setState(() {
                                                            _selectedResidentialStatus = newValue;
                                                            checkAddressFieldsFilled();
                                                          });
                                                        },
                                                        items: _residentialStatus
                                                            .map((String item){
                                                          return DropdownMenuItem(
                                                            value: item,
                                                            child: Text(
                                                              item.toString(),
                                                              style: const TextStyle(
                                                                color: Color(0xFF393939),
                                                                fontSize: 15,
                                                                fontFamily: 'Poppins',
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          );
                                                        }).toList(),
                                                        style: const TextStyle(
                                                          color: Color(0xFF393939),
                                                          fontSize: 15,
                                                          fontFamily: 'Poppins',
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                        //   hint: const Text('Select an option'),
                                                        decoration: InputDecoration(
                                                          labelText: 'Residential Status *',
                                                          hintText: 'Select an option',
                                                          //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                          // border: InputBorder.none,
                                                          focusedBorder: focus,
                                                          enabledBorder: enb,
                                                          filled: true,
                                                          fillColor: StyleData.textFieldColor,
                                                        ),
                                                      ),
                                                      SizedBox(height: height * 0.02),
                                                      Visibility(
                                                        visible: areAddressFieldsFilled,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            if(areAddressFieldsFilled)
                                                            {
                                                              setState(() {
                                                                isLeadInfo = !isLeadInfo;
                                                                isCustomerInfo = false;
                                                                isAddressInfo = false;
                                                                isProfileInfo = false;
                                                              });
                                                            }},
                                                          child: Align(
                                                            alignment: Alignment.bottomRight,
                                                            child: Icon(
                                                              Icons.arrow_circle_down,
                                                              color: Colors.yellow.shade800, // Set your desired arrow color
                                                              size: 22,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                          
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                                Card(
                                  elevation: 3,
                                  child: GestureDetector(
                                    onTap: () {
                                      if(areAddressFieldsFilled || isLeadsDataSaved == true)
                                        setState(() {
                                          isLeadInfo = !isLeadInfo;
                                          isCustomerInfo = false;
                                          isAddressInfo = false;
                                          isProfileInfo = false;
                                        });
                                    },
                                    child: Container(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: height * 0.05,
                                                width: width * 1,
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/icons8-details-48.png',
                                                      width: width * 0.08,
                                                      height: height * 0.04,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.05,
                                                    ),
                                                    Text("Lead Details",style: TextStyle(color: StyleData.appBarColor,fontWeight: FontWeight.bold,fontSize: 16),),
                                                    Spacer(),
                                                    areLeadsFieldsFilled || isLeadsDataSaved == true
                                                        ? Icon(Icons.check_circle_sharp, color: Colors.green, size: 22,)
                                                        : Icon(Icons.arrow_drop_down_circle_rounded, color: StyleData.buttonColor, size: 22,)
                                                  ],
                                                ),
                                              ),
                                              // SizedBox(height: height * 0.015),
                                              Visibility(
                                                  visible:  isLeadInfo == true,
                                                  child: Column(
                                                    children: [
                                                      TextFormField(
                                                        controller: _leadSource,
                                                        readOnly: true,
                                                        decoration: InputDecoration(
                                                          labelText: 'Lead Source',
                                                          hintText: '',
                                                          //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                          //  border: InputBorder.none,
                                                          focusedBorder: focus,
                                                          enabledBorder: enb,
                                                          filled: true,
                                                          fillColor: StyleData.textFieldColor,
                                                        ),
                                                      ),
                                                      TextFormField(
                                                        //  controller: branchCode,
                                                        initialValue: BranchCode1,
                                                        readOnly: true,
                                                        decoration: InputDecoration(
                                                          labelText: 'Home Fin Branch Code',
                                                          hintText: '',
                                                          //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                          //  border: InputBorder.none,
                                                          focusedBorder: focus,
                                                          enabledBorder: enb,
                                                          filled: true,
                                                          fillColor: StyleData.textFieldColor,
                                                        ),
                                                      ),
                                                      TextFormField(
                                                        controller: _leadAmount,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            checkLeadsFieldsFilled();
                                                          });
                                                        },
                                                        decoration: InputDecoration(
                                                          labelText: 'Lead Amount *',
                                                          hintText: 'Enter Lead Amount',
                                                          //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                          //  border: InputBorder.none,
                                                          focusedBorder: focus,
                                                          enabledBorder: enb,
                                                          filled: true,
                                                          fillColor: StyleData.textFieldColor,
                                                        ),
                                                        keyboardType: TextInputType.number,
                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return 'Please enter Lead Amount';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'Product Category *',
                                                            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Radio(
                                                                value: 'Home Loan',
                                                                groupValue: selectedProductValue,
                                                                onChanged: (value) {
                                                                  setState(() {
                                                                    selectedProductValue = 'Home Loan';
                                                                    selectedProdut = null; // Reset selectedProdut when switching categories
                                                                    checkLeadsFieldsFilled();
                                                                  });
                                                                },
                                                                activeColor: StyleData.appBarColor,
                                                              ),
                                                              Text(
                                                                'Home Loan',
                                                                style: TextStyle(fontSize: 16),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Radio(
                                                                value: 'Non-Home Loan',
                                                                groupValue: selectedProductValue,
                                                                onChanged: (value) {
                                                                  setState(() {
                                                                    selectedProductValue = 'Non-Home Loan';
                                                                    selectedProdut = null; // Reset selectedProdut when switching categories
                                                                    checkLeadsFieldsFilled();
                                                                  });
                                                                },
                                                                activeColor: StyleData.appBarColor,
                                                              ),
                                                              Text(
                                                                'Non-Home Loan',
                                                                style: TextStyle(fontSize: 18),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      selectedProductValue == 'Home Loan'  ?
                                                      SizedBox(
                                                        width: width * 1,
                                                        child: DropdownButtonFormField2<String>(
                                                          value: selectedProdut,
                                                          onChanged: (String? newValue) {
                                                            setState(() {
                                                              selectedProdut = newValue;
                                                              checkLeadsFieldsFilled();
                                                            });
                                                          },
                                                          validator: (value) {
                                                            if (value == null || value.isEmpty) {
                                                              return 'Please select product';
                                                            }
                                                            return null;
                                                          },
                                                          items: _productsList.where((item) => item.type == 1)
                                                              .map((DropDownProductData item){
                                                            return DropdownMenuItem(
                                                              value: item.title,
                                                              child: Text(
                                                                item.title.length > 30
                                                                    ? item.title.substring(0, 31) + '...'  // adjust the length as needed
                                                                    : item.title,
                                                                style: const TextStyle(
                                                                  color: Color(0xFF393939),
                                                                  fontSize: 15,
                                                                  fontFamily: 'Poppins',
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                          style: const TextStyle(
                                                            color: Color(0xFF393939),
                                                            fontSize: 15,
                                                            fontFamily: 'Poppins',
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                          //   hint: const Text('Select an option'),
                                                          decoration: InputDecoration(
                                                            labelText: 'Purpose Of Loan *',
                                                            hintText: 'Select an option',
                                                            //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                            //  border: InputBorder.none,
                                                            focusedBorder: focus,
                                                            enabledBorder: enb,
                                                            filled: true,
                                                            fillColor:StyleData.textFieldColor,
                                                          ),
                                                        ),
                                                      )
                                                          :
                                                      SizedBox(
                                                        width: width * 1,
                                                        child: DropdownButtonFormField2<String>(
                                                          value: selectedProdut,
                                                          onChanged: (String? newValue) {
                                                            setState(() {
                                                              selectedProdut = newValue;
                                                              checkLeadsFieldsFilled();
                                                            });
                                                          },
                                                          validator: (value) {
                                                            if (value == null || value.isEmpty) {
                                                              return 'Please select product';
                                                            }
                                                            return null;
                                                          },
                                                          items: _productsList.where((item) => item.type == 2)
                                                              .map((DropDownProductData item){
                                                            return DropdownMenuItem(
                                                              value: item.title,
                                                              child: Text(
                                                                item.title.length > 20
                                                                    ? item.title.substring(0, 27) + '...'  // adjust the length as needed
                                                                    : item.title,
                                                                style: const TextStyle(
                                                                  color: Color(0xFF393939),
                                                                  fontSize: 15,
                                                                  fontFamily: 'Poppins',
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                          style: const TextStyle(
                                                            color: Color(0xFF393939),
                                                            fontSize: 15,
                                                            fontFamily: 'Poppins',
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                          //   hint: const Text('Select an option'),
                                                          decoration: InputDecoration(
                                                            labelText: 'Purpose Of Loan *',
                                                            hintText: 'Select an option',
                                                            //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                            //  border: InputBorder.none,
                                                            focusedBorder: focus,
                                                            enabledBorder: enb,
                                                            filled: true,
                                                            fillColor:StyleData.textFieldColor,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: width * 1,
                                                        child: DropdownButtonFormField2<String>(
                                                          value: _selectedPropertyType,
                                                          onChanged: (String? newValue) {
                                                            setState(() {
                                                              _selectedPropertyType = newValue;
                                                              checkLeadsFieldsFilled();
                                                            });
                                                          },
                                                          items: _propertyType
                                                              .map((String item){
                                                            return DropdownMenuItem(
                                                              value: item,
                                                              child: Text(
                                                                item.toString(),
                                                                style: const TextStyle(
                                                                  color: Color(0xFF393939),
                                                                  fontSize: 15,
                                                                  fontFamily: 'Poppins',
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                          style: const TextStyle(
                                                            color: Color(0xFF393939),
                                                            fontSize: 15,
                                                            fontFamily: 'Poppins',
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                          //   hint: const Text('Select an option'),
                                                          decoration: InputDecoration(
                                                            labelText: 'Property Type *',
                                                            hintText: 'Select an option',
                                                            //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                            //  border: InputBorder.none,
                                                            focusedBorder: focus,
                                                            enabledBorder: enb,
                                                            filled: true,
                                                            fillColor:StyleData.textFieldColor,
                                                          ),
                                                          validator: (value) {
                                                            if (value == null || value.isEmpty) {
                                                              return 'Please select property type';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(height: height * 0.02),
                                                      Visibility(
                                                        visible: areLeadsFieldsFilled,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            if(areLeadsFieldsFilled || isLeadsDataSaved == true)
                                                            {
                                                              setState(() {
                                                                isProfileInfo = !isProfileInfo;
                                                                isLeadInfo = false;
                                                                isCustomerInfo = false;
                                                                isAddressInfo = false;
                                                              });
                                                            }},
                                                          child: Align(
                                                            alignment: Alignment.bottomRight,
                                                            child: Icon(
                                                              Icons.arrow_circle_down,
                                                              color: Colors.yellow.shade800, // Set your desired arrow color
                                                              size: 22,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                                Card(
                                  elevation: 3,
                                  child: GestureDetector(
                                    onTap: () {
                                      if(areLeadsFieldsFilled || isLeadsDataSaved == true)
                                      {
                                        setState(() {
                                          isProfileInfo = !isProfileInfo;
                                          isLeadInfo = false;
                                          isCustomerInfo = false;
                                          isAddressInfo = false;
                                        });
                                      }
                                    },
                                    child: Container(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: height * 0.05,
                                                width: width * 1,
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/profiling.png',
                                                      width: width * 0.08,
                                                      height: height * 0.04,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.05,
                                                    ),
                                                    Text("Profiling Stage",style: TextStyle(color: StyleData.appBarColor,fontWeight: FontWeight.bold,fontSize: 16),),
                                                    Spacer(),
                                                    areProfileFieldsFilled || isLeadsDataSaved == true
                                                        ? Icon(Icons.check_circle_sharp, color: Colors.green, size: 22,)
                                                        : Icon(Icons.arrow_drop_down_circle_rounded, color: StyleData.buttonColor, size: 22,)
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: height * 0.005),
                                              Visibility(
                                                visible:  isProfileInfo == true,
                                                child: Container(
                                                    color: Colors.white,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Column(
                                                        children: [
                                                          Column(
                                                            children: [
                                                              DropdownButtonFormField2<String>(
                                                                value: _selectedCustomerProfile,
                                                                onChanged: (String? newValue) {
                                                                  setState(() {
                                                                    _selectedCustomerProfile = newValue;
                                                                    // Reset employer category when customer profile changes
                                                                    _selectedEmployeeCategory = _employeeCategoryList[newValue]![0];
                                                                    checkProfileFieldsFilled();
                                                                  });
                                                                },
                                                                items: _customerProfileList
                                                                    .map<DropdownMenuItem<String>>((String value) {
                                                                  return DropdownMenuItem<String>(
                                                                    value: value,
                                                                    child: Text(value),
                                                                  );
                                                                }).toList(),
                                                                style: const TextStyle(
                                                                  color: Color(0xFF393939),
                                                                  fontSize: 15,
                                                                  fontFamily: 'Poppins',
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                                //   hint: const Text('Select an option'),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Customer Profile *',
                                                                  hintText: 'Select an option',
                                                                  //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                                  focusedBorder: focus,
                                                                  enabledBorder: enb,
                                                                  filled: true,
                                                                  fillColor: StyleData.textFieldColor,
                                                                ),
                                                              ),
                                                              SizedBox(height: height * 0.01,),
                                                              DropdownButtonFormField2<String>(
                                                                value: _selectedEmployeeCategory,
                                                                onChanged: (String? newValue) {
                                                                  setState(() {
                                                                    _selectedEmployeeCategory = newValue;
                                                                    checkProfileFieldsFilled();
                                                                  });
                                                                },
                                                                items: _employeeCategoryList[_selectedCustomerProfile]!
                                                                    .map<DropdownMenuItem<String>>((String value) {
                                                                  return DropdownMenuItem<String>(
                                                                    value: value,
                                                                    child: Text(value),
                                                                  );
                                                                }).toList(),
                                                                style: const TextStyle(
                                                                  color: Color(0xFF393939),
                                                                  fontSize: 15,
                                                                  fontFamily: 'Poppins',
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                                //   hint: const Text('Select an option'),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Employee Category *',
                                                                  hintText: 'Select an option',
                                                                  //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                                  focusedBorder: focus,
                                                                  enabledBorder: enb,
                                                                  filled: true,
                                                                  fillColor: StyleData.textFieldColor,
                                                                ),
                                                              ),
                                                              // DropdownButtonFormField2<String>(
                                                              //   value: _selectedCustomerProfile,
                                                              //   onChanged: (String? newValue) {
                                                              //     setState(() {
                                                              //       _selectedCustomerProfile = newValue;
                                                              //       checkProfileFieldsFilled();
                                                              //     });
                                                              //   },
                                                              //   validator: (value) {
                                                              //     if (value == null || value.isEmpty) {
                                                              //       return 'Please select customer profile';
                                                              //     }
                                                              //     return null;
                                                              //   },
                                                              //   items: _customerProfileList
                                                              //       .map((DropDownData item){
                                                              //     return DropdownMenuItem(
                                                              //       value: item.title,
                                                              //       child: Text(
                                                              //         item.title,
                                                              //         style: const TextStyle(
                                                              //           color: Color(0xFF393939),
                                                              //           fontSize: 15,
                                                              //           fontFamily: 'Poppins',
                                                              //           fontWeight: FontWeight.w400,
                                                              //         ),
                                                              //       ),
                                                              //     );
                                                              //   }).toList(),
                                                              //   style: const TextStyle(
                                                              //     color: Color(0xFF393939),
                                                              //     fontSize: 15,
                                                              //     fontFamily: 'Poppins',
                                                              //     fontWeight: FontWeight.w400,
                                                              //   ),
                                                              //   //   hint: const Text('Select an option'),
                                                              //   decoration: InputDecoration(
                                                              //     labelText: 'Customer Profile *',
                                                              //     hintText: 'Select an option',
                                                              //     //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                              //     focusedBorder: focus,
                                                              //     enabledBorder: enb,
                                                              //     filled: true,
                                                              //     fillColor: StyleData.textFieldColor,
                                                              //   ),
                                                              // ),
                                                              // SizedBox(height: height * 0.01,),
                                                              // DropdownButtonFormField2<String>(
                                                              //   value: _selectedEmployeeCategory,
                                                              //   onChanged: (String? newValue) {
                                                              //     setState(() {
                                                              //       _selectedEmployeeCategory = newValue;
                                                              //       checkProfileFieldsFilled();
                                                              //     });
                                                              //   },
                                                              //   validator: (value) {
                                                              //     if (value == null || value.isEmpty) {
                                                              //       return 'Please select Employee category';
                                                              //     }
                                                              //     return null;
                                                              //   },
                                                              //   items: _employeeCategoryList
                                                              //       .map((DropDownData item){
                                                              //     return DropdownMenuItem(
                                                              //       value: item.title,
                                                              //       child: Text(
                                                              //         item.title,
                                                              //         style: const TextStyle(
                                                              //           color: Color(0xFF393939),
                                                              //           fontSize: 15,
                                                              //           fontFamily: 'Poppins',
                                                              //           fontWeight: FontWeight.w400,
                                                              //         ),
                                                              //       ),
                                                              //     );
                                                              //   }).toList(),
                                                              //   style: const TextStyle(
                                                              //     color: Color(0xFF393939),
                                                              //     fontSize: 15,
                                                              //     fontFamily: 'Poppins',
                                                              //     fontWeight: FontWeight.w400,
                                                              //   ),
                                                              //   //   hint: const Text('Select an option'),
                                                              //   decoration: InputDecoration(
                                                              //     labelText: 'Employee Category *',
                                                              //     hintText: 'Select an option',
                                                              //     //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                              //     focusedBorder: focus,
                                                              //     enabledBorder: enb,
                                                              //     filled: true,
                                                              //     fillColor: StyleData.textFieldColor,
                                                              //   ),
                                                              // ),
                                                              SizedBox(height: height * 0.01,),
                                                              TextFormField(
                                                                controller: monthlyIncomeOfApplicant,
                                                                onChanged: (String? newValue) {
                                                                  setState(() {
                                                                    checkProfileFieldsFilled();
                                                                  });
                                                                },
                                                                validator: (value) {
                                                                  if (value == null || value.isEmpty) {
                                                                    return 'Please enter monthly income';
                                                                  }
                                                                  return null;
                                                                },
                                                                decoration: InputDecoration(
                                                                  labelText: 'Monthly Income Of the Applicant *',
                                                                  hintText: 'Enter monthly income',
                                                                  //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                                  // border: InputBorder.none,
                          
                                                                  focusedBorder: focus,
                                                                  enabledBorder: enb,
                                                                  filled: true,
                                                                  fillColor: StyleData.textFieldColor,
                                                                ),
                                                                keyboardType: TextInputType.number,
                                                                // inputFormatters: [
                                                                // FilteringTextInputFormatter.digitsOnly,
                                                                // LengthLimitingTextInputFormatter(12),]
                                                              ),
                                                              SizedBox(height: height * 0.01,),
                                                              TextFormField(
                                                                controller: aadharCardNumber,
                                                                onChanged: (String? newValue) {
                                                                  setState(() {
                                                                    checkProfileFieldsFilled();
                                                                  });
                                                                },
                                                                decoration: InputDecoration(
                                                                  labelText: 'Aadhar Card Number *',
                                                                  hintText: 'Enter Aadhar number',
                                                                  //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                                  // border: InputBorder.none,
                                                                  focusedBorder: focus,
                                                                  enabledBorder: enb,
                                                                  filled: true,
                                                                  fillColor: StyleData.textFieldColor,
                                                                ),
                                                                keyboardType: TextInputType.number,
                                                                inputFormatters: [
                                                                  FilteringTextInputFormatter.digitsOnly,
                                                                  LengthLimitingTextInputFormatter(12),
                                                                ],
                                                                validator: (value) {
                                                                  if (value == null || value.isEmpty) {
                                                                    return 'Aadhar Card Number is required';
                                                                  } else if (value.length != 12) {
                                                                    return 'Aadhar Card Number must be 12 digits';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                              SizedBox(height: height * 0.01,),
                                                              TextFormField(
                                                                controller: panCardNumber,
                                                                onChanged: (String? newValue) {
                                                                  setState(() {
                                                                    checkProfileFieldsFilled();
                                                                  });
                                                                },
                                                                decoration: InputDecoration(
                                                                  labelText: 'Pan Card Number *',
                                                                  hintText: 'Enter Pan number',
                                                                  focusedBorder: focus,
                                                                  enabledBorder: enb,
                                                                  filled: true,
                                                                  fillColor: StyleData.textFieldColor,
                                                                ),
                                                                keyboardType: TextInputType.text,
                                                                inputFormatters: [
                                                                  FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9]+$')), // Allow only alphanumeric characters
                                                                  LengthLimitingTextInputFormatter(10),
                                                                  UppercaseTextInputFormatter(),
                                                                ],
                                                                validator: (value) {
                                                                  if (value == null || value.isEmpty) {
                                                                    return 'Pan Card Number is required';
                                                                  } else if (!isValidPanCard(value) || value.length < 10) {
                                                                    return 'Invalid Pan Card Number';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                          
                                                              SizedBox(height: height * 0.01,),
                          
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ),
                          
                          
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    ElevatedButton(
                      onPressed: () {
                        // DateFormat formatter = DateFormat('dd-MM-yyyy');
                        // DateTime dob = formatter.parse(_dateOfBirth.text);
                        if(isLeadsDataSaved == true && isLeadsUpdateData == false)
                        {
                          if(aadharCardNumber.text.length == 12 && panCardNumber.text.length == 10 && isValidPanCard(panCardNumber.text) ) {
                            if(_email.text.endsWith('.com') && !_email.text.contains(' ') && _email.text.contains('@'))
                            {
                              if((DateTime.now().year - DateTime.parse(_dateOfBirth.text).year).toInt() < 18 || (DateTime.now().year - DateTime.parse(_dateOfBirth.text).year).toInt() > 70 )
                                //   int age = DateTime.now().year - dob.year;
                                //   if (age < 18 || age > 70)
                                  {
                                CustomSnackBar.errorSnackBarQ("Age should fall between 18 and 70 years old.", context);
                              }
                              else {
                                updateLeadData();
                              }
                            }else{
                              CustomSnackBar.errorSnackBarQ("Please enter valid email", context);
                            }
                          }else{
                            CustomSnackBar.errorSnackBarQ("Please enter valid Profiling details", context);
                          }
                          //CustomSnackBar.errorSnackBarQ("Lead details already saved", context);
                        }else {
                          if (_formKey.currentState!.validate() &&
                              areCustomerFieldsFilled == true && areLeadsFieldsFilled == true
                              && areAddressFieldsFilled == true && areProfileFieldsFilled == true || isLeadsUpdateData == true ) {
                            if(aadharCardNumber.text.length == 12 &&  panCardNumber.text.length == 10 && isValidPanCard(panCardNumber.text)) {
                              if(_email.text.endsWith('.com') && !_email.text.contains(' ') && _email.text.contains('@'))
                              {
                                if((DateTime.now().year - DateTime.parse(_dateOfBirth.text).year).toInt() < 18 || (DateTime.now().year - DateTime.parse(_dateOfBirth.text).year).toInt() > 70 )
                                {
                                  CustomSnackBar.errorSnackBarQ("Age should fall between 18 and 70 years old.", context);
                                }
                                else {
                                  setState(() {
                                    isClickNext = true;
                                  });
                                  updateDataToFirestore();
                                }
                              }else{
                                CustomSnackBar.errorSnackBarQ("Please enter valid email", context);
                              }
                            }else{
                              CustomSnackBar.errorSnackBarQ("Please enter valid Profiling details", context);
                            }
                          }
                          else {
                            CustomSnackBar.errorSnackBarQ("Please enter all the mandatory fields", context);
                          }
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
                    SizedBox(
                      height: 55, // Adjust the height of the SizedBox to match the height of the Container
                      child: VerticalDivider(
                        thickness: 1.5,
                        color: Colors.black, // Set the color of the divider
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // DateFormat formatter = DateFormat('dd-MM-yyyy');
                        // DateTime dob = formatter.parse(_dateOfBirth.text);
                        if(isLeadsDataSaved == true || isClickNext == true )
                        {
                          if(aadharCardNumber.text.length == 12 && panCardNumber.text.length == 10 && isValidPanCard(panCardNumber.text) ) {
                            if(_email.text.endsWith('.com') && !_email.text.contains(' ') && _email.text.contains('@'))
                            {
                              if((DateTime.now().year - DateTime.parse(_dateOfBirth.text).year).toInt() < 18 || (DateTime.now().year - DateTime.parse(_dateOfBirth.text).year).toInt() > 70 )
                              {
                                CustomSnackBar.errorSnackBarQ("Age should fall between 18 and 70 years old.", context);

                              }
                              else {
                                updateLeadsDataToFirestore();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DocumentPageView(
                                            docId: widget.docId,
                                            visitID: widget.visitId,
                                            isNewActivity: false,
                                            leadID: '',
                                            isTechChecklist : false,
                                            isPartiallyVerifiedLeads : false
                                        )));
                              }
                            }else{
                              CustomSnackBar.errorSnackBarQ("Please enter and save valid email", context);
                            }
                          }else{
                            CustomSnackBar.errorSnackBarQ("Please enter and save valid Profiling details", context);
                          }
                        }else{
                          CustomSnackBar.errorSnackBarQ("Please save the lead details", context);
                        }
                        // if(isClickNext == true || )
                        //   {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => DocumentPageView(
                        //                 docId: widget.docId,
                        //                 visitID: widget.visitId,
                        //                 isNewActivity: false
                        //             )));
                        //   }
                        // else {
                        //   CustomSnackBar.errorSnackBarQ("Please Save the lead Details", context);
                        // }

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_forward, color: Colors.white,),
                          SizedBox(width: width * 0.025,),
                          Text(
                            'Next',
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
      ),
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
  void updateLeadData() async {
    //New Implementation for saving application PDF
    print("bhjkjhlknl");
    Dialogs.materialDialog(
        msg: 'Are you sure you want to make the changes in the lead details?',
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
                setState(() {
                  isClickNext = true;
                });
                Navigator.pop(context);
                updateDataToFirestore();
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
                  Text('Lead details saved successfully', textAlign: TextAlign.center,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold)),
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
                        Navigator.pop(context);
                      //  Navigator.pop(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         ApplicantDetailsView(),
                        //   ),
                        // );
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

  bool isValidPanCard(String panNumber) {
    RegExp panRegExp = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
    return panRegExp.hasMatch(panNumber);
  }
  String formatDate(String dateString) {
    try {
      // Assuming dateString is in the format 'yyyy-MM-dd HH:mm:ss.SSS'
      DateTime date = DateTime.parse(dateString);

      final formatter = DateFormat('yyyy-MM-dd');
      // int age = DateTime.now().year - dob.year;
      // if(age < 18 || age > 70 )
      return formatter.format(date);
    } catch (e) {
      print("Error parsing date: $e");
      return " --";
    }
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