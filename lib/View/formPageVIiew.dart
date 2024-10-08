import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:lead_management_system/View/HomePageView.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import '../Model/Response/DropDownModel.dart';
import '../Model/apiurls.dart';
import '../Utils/ChangeNotifier.dart';
import '../Utils/CustomeSnackBar.dart';
import '../Utils/StyleData.dart';
import 'VisitPageView.dart';
import 'package:path/path.dart' as path;



class FormPageView extends StatefulWidget {
  // String? accessToken;
  FormPageView({Key? key,
  //  this.accessToken
  }) : super(key: key);
  @override
  _FormPageViewState createState() => _FormPageViewState();
}

class _FormPageViewState extends State<FormPageView> {
  final _formKey = GlobalKey<FormState>();
  bool isCustomerInfo = false;
  bool isVisitInfo = false;
  bool isAddressInfo = false;
  bool isOtherInfo = false;
  bool areCustomerFieldsFilled = false;
  bool areVisitFieldsFilled = false;
  bool areAddressFieldsFilled = false;
  bool areOtherFieldsFilled = false;

  bool isLeadSourceSelected = false;

  String? globalImageUrl;


  //Textfields
  TextEditingController textEditingController = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController middleName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController customerNumber = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _addressLine1 = TextEditingController();
  TextEditingController _addressLine2 = TextEditingController();
  TextEditingController _addressLine3 = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _pincode = TextEditingController();
  TextEditingController _reasonNotInterested = TextEditingController();

  //Additional details
  TextEditingController _customerName = TextEditingController();
  TextEditingController _customerMobileNumber = TextEditingController();
  TextEditingController _employeeName = TextEditingController();
  TextEditingController _employeeCode = TextEditingController();
  TextEditingController _builderName = TextEditingController();
  TextEditingController _crmLeadId = TextEditingController();

  UnderlineInputBorder enb = UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.black38)
  );
  UnderlineInputBorder focus = UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xff298b28))
  );

  File? startimage;
  File? startimage1;
  Position? currentposition;
  String? currentAddress;
  bool _isVisible = false;
  CameraController? _controller;


  List<DocumentSnapshot> ListOfLeads = [];
  List outputList1 = [];
  var userType;
  String? fetchMobileNumber;

//Dropdowns fetching from firebase
//   getDropDownLeadData() {
//     FirebaseFirestore.instance
//         .collection("leadSource")
//         .doc('leadSource')
//         .get()
//         .then((value) {
//       for (var element in value.data()!['leadSource']) {
//         setState(() {
//           _leadSourceList
//               .add(DropDownData(element['id'], element['title']));
//         });
//       }
//     });
//   }
//   final List<DropDownData> _leadSourceList = [];
  String? _selectedLeadSource;

  // final List<DropDownData> _leadSourceList = [];
  final List<DropDownData> _leadDSAList = [];


  final List<Map<String, dynamic>> _leadSourceList = [
    {"title": "DSA", "id": 1},
    {"title": "Connector", "id": 2},
    {"title": "Marketing Campaign", "id": 3},
    {"title": "Employee Referral", "id": 4},
    {"title": "Builder", "id": 5},
    {"title": "Customer Referral", "id": 6},
    {"title": "Direct Sourcing", "id": 7},
    {"title": "Cross-Sell", "id": 8},
  ];


  // getDropDownConnectorData() {
  //   FirebaseFirestore.instance
  //       .collection("connectorName")
  //       .doc('connectorName')
  //       .get()
  //       .then((value) {
  //     for (var element in value.data()!['connectorName']) {
  //       setState(() {
  //         _leadConnectorList
  //             .add(DropDownData(int.parse(element['id']), element['title']));
  //       });
  //     }
  //   });
  // }

  Future<List<DropDownData>> getDropDownConnectorData() async {
    var document = await FirebaseFirestore.instance
        .collection("connectorName")
        .doc('connectorName')
        .get();

    List<DropDownData> tempList = [];
    for (var element in document.data()!['connectorName']) {
      tempList.add(DropDownData(int.parse(element['id']), element['title']));
    }
    return tempList;
  }

  Future<void> _fetchConnectorData() async {
    List<DropDownData> data = await getDropDownConnectorData();
    setState(() {
      _leadConnectorList.clear();
      _leadConnectorList.addAll(data);
    });
  }

  String? _selectedConnector;
  final List<DropDownData> _leadConnectorList = [];
  String? ConnectorCode;

  // getDropDownDSAData() {
  //   FirebaseFirestore.instance
  //       .collection("dsaName")
  //       .doc('dsaName')
  //       .get()
  //       .then((value) {
  //     for (var element in value.data()!['dsaName']) {
  //       setState(() {
  //         _leadDSAList
  //             .add(DropDownData(int.parse(element['id']), element['title']));
  //       });
  //     }
  //   });
  // }

  getDropDownDSAData() async {
    var document = await FirebaseFirestore.instance
        .collection("dsaName")
        .doc('dsaName')
        .get();

    List<DropDownData> tempList = [];
    for (var element in document.data()!['dsaName']) {
      tempList.add(DropDownData(int.parse(element['id']), element['title']));
    }

    setState(() {
      _leadDSAList.clear(); // Clear the existing list
      _leadDSAList.addAll(tempList); // Add new items to the existing list
    });
  }


  String? _selectedDSA;
  String? selectedDSACode;
  String? selectedDSACode1;
  TextEditingController selectedDSACodeController = TextEditingController();
  String? ConnectorCode1;
  TextEditingController ConnectorCodeController = TextEditingController();

  getDropDownCampaignData() {
    FirebaseFirestore.instance
        .collection("campaignName")
        .doc('campaignName')
        .get()
        .then((value) {
      for (var element in value.data()!['campaignName']) {
        setState(() {
          _leadCampaignList
              .add(DropDownData(int.parse(element['id']), element['title']));
        });
      }
    });
  }

  String? _selectedCampaign;
  final List<DropDownData> _leadCampaignList = [];

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

  final List<DropDownData> _salutationList = [];
  String? _selectedSalutation;

  final List<String> purposeVisit = [
    //   'Document Pick up',
    'Lead Capture',
  ];
  String? selectedPurpose;

  final List<String> customerStatus = [
    'Interested',
    'Not Interested',
  ];
  String? selectedCustomerStatus;

  String? visitID;
  String? accesstoken;


  //visit creation
  Future<String?> visitCreation() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: SpinKitFadingCircle(
            color: Colors.white,
            size: 50.0,
          ),
        );
      },
    );
    print("Printing Token");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('access_token');
    print(prefs.getString('access_token'));
    var headers = {
      //  'Authorization':  'Bearer ${widget.accessToken ?? ''}',
      'Authorization': 'Bearer ${prefs.getString('access_token') ?? ''}',
      //  'Authorization':  'Bearer 00DBl000000BtkL!AQEAQFmo5RMkh7ViBWHS35EPX9gPCPYVCDKI08CBXrvmvPpbYgknhcxYlJML6Dl1ZJg5N0uOCZJy4OH_9OVq7mT6tvQF9UBf',
      'Content-Type': 'application/json',
      'Cookie': 'BrowserId=qnhrXMyBEe6lOh9ncfvoTw; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    print("Printing Token 1");
    var data = json.encode({
      "FirstName": firstName.text,
      "LastName": lastName.text,
      "Phone": customerNumber.text,
      "PurposeOfvisit": selectedPurpose ?? "",
      "CustomerStatus": selectedCustomerStatus ?? "",
      "ScheduledVisit": _dateController.text,
      // "Latitude": latitude.toString(),
      // "Longitude": longitude.toString(),
      "Latitude": (latitude
          ?.toString()
          ?.isNotEmpty == true ? latitude.toString() : "19.024651"),
      "Longitude": (longitude
          ?.toString()
          ?.isNotEmpty == true ? longitude.toString() : "72.8447167"),
    });
    print(data);
    var dio = Dio();
    var response = await dio.request(
      // ApiUrls().visitCreationProduction,
      ApiUrls().visitCreationUAT,
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    //  print(data);
    if (response.statusCode == 200) {
      print("Printing Token 2");
      print(json.encode(response.data));


      String jsonResponse = response.data;
      Map<String, dynamic> decodedResponse = json.decode(jsonResponse);
      String visitIdResponse = decodedResponse['visitId'];
      print(visitIdResponse);

      setState(() {
        visitID = visitIdResponse;
      });

      Navigator.pop(context);
      addDataToFirestore();

      // _showAlertDialogSuccess(context);
    }
    else {
      Navigator.pop(context);
      print("Nhuhujnj");
      print(response.statusMessage);
    }
  }

  String? selectedPostCode;

//Functions for selecting date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            // Your custom yellow color
            hintColor: Color(0xff973232),
            colorScheme: ColorScheme.light(primary: Color(0xff973232)),
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
        _dateController.text = formatDate(pickedDate.toLocal().toString());
        if (_dateController.text.isNotEmpty &&
            _timeController.text.isNotEmpty) {
          setState(() {
            areVisitFieldsFilled = true;
          });
        } else {
          setState(() {
            areVisitFieldsFilled = false;
          });
        }
      });
    }
  }

  //Functions for selecting time
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xff973232),
            // Your custom yellow color
            hintColor: Colors.blueGrey.shade200,
            colorScheme: ColorScheme.light(primary: Color(0xff973232)),
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

    // if (pickedTime != null) {
    //   setState(() {
    //     _timeController.text = pickedTime.format(context);
    //     if (_dateController.text.isNotEmpty &&
    //         _timeController.text.isNotEmpty) {
    //       setState(() {
    //         areVisitFieldsFilled = true;
    //       });
    //     } else {
    //       setState(() {
    //         areVisitFieldsFilled = false;
    //       });
    //     }
    //   });
    // }

    if (pickedTime != null) {
      setState(() {
        // Format time with AM/PM
        String formattedTime = pickedTime.hour >= 12
            ? '${pickedTime.hourOfPeriod}:${pickedTime.minute} PM'
            : '${pickedTime.hourOfPeriod}:${pickedTime.minute} AM';

        _timeController.text = formattedTime;

        // Check if both date and time are filled
        if (_dateController.text.isNotEmpty &&
            _timeController.text.isNotEmpty) {
          areVisitFieldsFilled = true;
        } else {
          areVisitFieldsFilled = false;
        }
      });
    }
  }


  //Function to check is all the fields are filled
  void checkCustomerFieldsFilled() {
    if (_selectedSalutation != null &&
        firstName.text.isNotEmpty &&
        lastName.text.isNotEmpty &&
        customerNumber.text.isNotEmpty) {
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
        _addressLine2.text.isNotEmpty && _addressLine3.text.isNotEmpty &&
        _city.text.isNotEmpty && _pincode.text.isNotEmpty) {
      setState(() {
        areAddressFieldsFilled = true;
      });
    } else {
      setState(() {
        areAddressFieldsFilled = false;
      });
    }
  }

  void checkOtherFieldsFilled() {
    if (selectedPurpose != null &&
        selectedCustomerStatus != null) {
      setState(() {
        areOtherFieldsFilled = true;
      });
    } else {
      setState(() {
        areOtherFieldsFilled = false;
      });
    }
  }


//fetching the visits details from leadcreation collection
//   void fetchLeads() async {
//     CollectionReference users = FirebaseFirestore.instance.collection('LeadCreation');
//
//     users.get().then((value) {
//       setState(() {
//         ListOfLeads = value.docs;
//       });
//       for (var i = 0; value.docs.length > i; i++) {
//     //    print(value.docs[i].data());
//       }
//     });
//   }

  Future<void> fetchLeads() async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection(
          'LeadCreation');
      QuerySnapshot querySnapshot = await users.get();

      setState(() {
        ListOfLeads = querySnapshot.docs;
      });

      // for (var i = 0; i < querySnapshot.docs.length; i++) {
      //
      // }
    } catch (e) {
      print("Failed to fetch leads: $e");
    }
  }


  bool isCustomerMobileExist = false;

  void fetchAllCustomerMobile(String mobileNumber) {
    List<String> allCustomerMobiles = [];

    for (var lead in ListOfLeads) {
      var customerMobile = lead['customerNumber'];
      if (customerMobile != null && customerMobile.isNotEmpty) {
        allCustomerMobiles.add(customerMobile);
      }
    }
    bool isMobileExists = allCustomerMobiles.contains(mobileNumber);
    print("All Customer Mobiles: $allCustomerMobiles");
    print("Mobile Number $mobileNumber exists: $isMobileExists");

    if (isMobileExists) {
      CustomSnackBar.errorSnackBarQ("Mobile number already Exists", context);
    } else {
      visitCreation();
    }
  }


  // adding visit data to the lead creation collection
  CollectionReference leadsCreation = FirebaseFirestore.instance.collection(
      "LeadCreation");

  Future<void> addDataToFirestore() async {
    // Upload image to Firebase Storage

    Fluttertoast.showToast(msg: 'Image uploaded successfully');

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
    SharedPreferences pref =
    await SharedPreferences.getInstance();
    var userId = pref.getString("userID");
    DateTime now = DateTime.now();


    print("Hello");
    Map<String, dynamic> params = {
      'salutation': _selectedSalutation,
      'firstName': firstName.text,
      'middleName': middleName.text,
      'lastName': lastName.text,
      'customerNumber': customerNumber.text,
      'visitDate': _dateController.text,
      'visitTime': _timeController.text,
      'customerName': _customerName.text,
      'CustomerMobile': _customerMobileNumber.text,
      'builderName': _builderName.text,
      'CRMLeadID': _crmLeadId.text,
      'leadSource': _selectedLeadSource,
      'dsaName': _selectedDSA,
      'connectorName': _selectedConnector,
      'compaignName': _selectedCampaign,
      'purposeVisit': selectedPurpose,
      'customerStatus': selectedCustomerStatus,
      'ReasonforDisinterest': _reasonNotInterested.text,
      'DSAConnectorCode': _selectedLeadSource == 'DSA'
          ? selectedDSACode1
          : _selectedLeadSource == 'Connector'
          ? ConnectorCode1
          : _selectedLeadSource == 'Employee Referral'
          ? _employeeCode.text
          : _selectedLeadSource == 'Customer Referral' ? _customerMobileNumber
          .text : "",
      'referralEmpCode': _employeeCode.text,
      'referralEmpName': _employeeName.text,
      'latitude': (latitude
          ?.toString()
          ?.isNotEmpty == true ? latitude.toString() : "19.024651"),
      'longitude': (longitude
          ?.toString()
          ?.isNotEmpty == true ? longitude.toString() : "72.8447167"),
      'address': locationController.text,
      'LeadID': "-",
      'visitID': visitID,
      'userId': userId,
      'selfie': globalImageUrl,
      'SelfieDateTime': currentDateTime,
      'EmployeeName': pref.getString("employeeName"),
      'EmployeeCode': pref.getString("employeeCode"),
      'EmployeeBranchCode': pref.getString("branchcode"),
      'createdDateTime': Timestamp.fromDate(now),
    };
    // if (_selectedLeadSource == 'DSA') {
    //   params['DSAConnectorCode'] = _selectedDSACode;
    // } else if (_selectedLeadSource == 'Connector') {
    //   params['DSAConnectorCode'] = _selectedConnectorCode;
    // } else {
    //   // Handle other cases if needed
    //   params['DSAConnectorCode'] = null; // Set to null or handle accordingly
    // }
    leadsCreation.add(params).then((value) {
      print("Data added successfully");
      // Navigate to the VisitPageView upon successful data addition
      Navigator.pop(context);
      _showAlertDialogSuccess(context);
    }).catchError((error) {
      print("Failed to add data: $error");
      // Handle error if needed
    });
  }


//fetching the location infomation
  TextEditingController locationController = TextEditingController();
  String latitude = '';
  String longitude = '';

  void getLocation() async {
    print("Getting location");
    try {
      Position position = await Geolocator.getCurrentPosition(
          forceAndroidLocationManager: true,
          desiredAccuracy: LocationAccuracy.lowest);

      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);

      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark firstPlacemark = placemarks.first;
        String address = "${firstPlacemark.subThoroughfare} ${firstPlacemark
            .thoroughfare}, "
            "${firstPlacemark.subLocality}, ${firstPlacemark.locality}, "
            "${firstPlacemark.administrativeArea} ${firstPlacemark
            .postalCode}, "
            "${firstPlacemark.country}";

        setState(() {
          locationController.text = address;
          latitude = position.latitude.toString();
          longitude = position.longitude.toString();
          print("Address: $address");
          print("Address: $latitude");
          print("Address: $longitude");
        });
      } else {
        print("No address available");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void requestLocationPermission() async {
    try{
    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      getLocation();
    } else {
      print("Location permission denied");
    }
  }catch(err){
    print(err);
  }}
  List<String> stateValues = [];
  List<String> districts  = [];
  List<String> postOffice  = [];


Future<void> getToken()
async {
  var headers = {
    'X-PrettyPrint': '1',
    'Content-Type': 'application/x-www-form-urlencoded',
    'Cookie': 'BrowserId=qnhrXMyBEe6lOh9ncfvoTw; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
  };
  var data = {
    'grant_type': 'password',
    'client_id': ApiUrls().clientIdUAT,
    'client_secret': ApiUrls().clientSecretUAT,
    'username': ApiUrls().userNameUAT,
    'password': ApiUrls().passwordUAT
    // 'grant_type': 'password',
    // 'client_id': '3MVG9ct5lb5FGJTNKeeA63nutsPt.67SWB9mzXh9na.RBlkmz2FxM4KH31kKmHWMWQHD1y2apE9qmtoRtiQ9R',
    // 'client_secret': 'E9DDAF90143A7B4C6CA622463EFDA17843174AB347FD74A6905F853CD2406BDE',
    // 'username': 'itkrishnaprasad@muthootgroup.com.dev2',
    // 'password': 'Karthikrishna@127jb7htnfs8WigpiW5SOP6I7qZ'
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
  Future<void> _fetchData() async {
    List<DropDownData> data = await getDropDownDSAData();
    setState(() {
      // Creating a new list to avoid modifying the final list directly
      _leadDSAList.clear();
      _leadDSAList.addAll(data);
    });
  }

@override
  void initState() {
    // TODO: implement initState
  //getDropDownDSAData();
  _fetchData();
  _fetchConnectorData();
  getDropDownSalutationData();
  getDropDownCampaignData();
  getToken();
    fetchLeads();

 // getDropDownLeadData();
   // getDropDownLeadData();
   // getDropDownConnectorData();


    super.initState();
  getLocation();
    requestLocationPermission();
   // getAccessToken();
  }






  Map<String, dynamic> docData = {};
  String? currentDateTime;


//   Future<void> getStartImage(ImageSource source) async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       Fluttertoast.showToast(msg: 'Please enable Your Location Service');
//       return;
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         Fluttertoast.showToast(msg: 'Location permissions are denied');
//         return;
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       Fluttertoast.showToast(
//           msg: 'Location permissions are permanently denied, we cannot request permissions.');
//       return;
//     }
//
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//
//     try {
//       List<Placemark> placemarks =
//       await placemarkFromCoordinates(position.latitude, position.longitude);
//
//       Placemark place = placemarks[0];
//       Placemark place1 = placemarks[1];
//       setState(() {
//         currentposition = position;
//         currentDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
//         currentAddress =
//         "${place1.name},${place.street},${place.subLocality},${place1.thoroughfare}, ${place.postalCode},${place.locality},${place1.administrativeArea},${place.country}";
//       });
//
//       final pickedFile = await ImagePicker().pickImage(source: source, imageQuality: 35,);
//       // final pickedFile = await ImagePicker().pickImage(source: source, imageQuality: 35, preferredCameraDevice: CameraDevice.front );
//
//       if (pickedFile == null) return;
//
//       final imageTemporary = File(pickedFile.path);
//
//       setState(() {
//         this.startimage = imageTemporary;
//         _isVisible = true;
//       });
//       String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//       Reference storageReference = FirebaseStorage.instance.ref().child('images/$fileName');
//       UploadTask uploadTask = storageReference.putFile(imageTemporary);
//       TaskSnapshot taskSnapshot = await uploadTask;
//
//       // Get the image URL
//       String? imageUrl = await taskSnapshot.ref.getDownloadURL();
//       setState(() {
//         globalImageUrl = imageUrl;
//       });
//
// print("gloabal url");
//       print(globalImageUrl);
//
//     } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     }
//   }

  Future<void> showImageSourceOptions() async {
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
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
          leading: CircleAvatar(
            backgroundColor: StyleData.background,
            child: const Center(
              child: Icon(Icons.camera, color: Colors.black),
            ),
          ),
            title: const Text("Take Camera",
                style: TextStyle(color: Colors.white60)),
                onTap: () {
                  Navigator.pop(context);
                  getStartImage(ImageSource.camera); // Capture from camera
                },
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
                onTap: () {
                  Navigator.pop(context);
                  getStartImage(ImageSource.gallery); // Select from gallery
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> getStartImage(ImageSource source) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please enable Your Location Service');
      return;
    }

    // Check and request location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg: 'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      // Get the address based on latitude and longitude
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];
      Placemark place1 = placemarks[1];

      setState(() {
        currentposition = position;
        currentDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
        currentAddress =
        "${place1.name},${place.street},${place.subLocality},${place1.thoroughfare}, ${place.postalCode},${place.locality},${place1.administrativeArea},${place.country}";
      });

      // Pick an image from the camera or gallery
      final pickedFile = await ImagePicker().pickImage(source: source, imageQuality: 35);
      if (pickedFile == null) return;

      final imageTemporary = File(pickedFile.path);

      setState(() {
        this.startimage = imageTemporary;
        _isVisible = true;
      });

      // Upload the image to Firebase
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference = FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = storageReference.putFile(imageTemporary);
      TaskSnapshot taskSnapshot = await uploadTask;

      // Get the image URL
      String? imageUrl = await taskSnapshot.ref.getDownloadURL();
      setState(() {
        globalImageUrl = imageUrl;
      });

      print("Global URL: $globalImageUrl");
      print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");

    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }











  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final connectorProvider = Provider.of<ConnectorProvider>(context);
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
                  child:  Container(
                    child: Image.asset(
                      'assets/images/arrow.png',
                    ),
                  ),),
            ),
            title: Text("New Visit",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: StyleData.boldFont),),
            centerTitle: true,
        
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.03,
                          ),
                          SizedBox(
                            width: width * 0.95,
                            child: DropdownButtonFormField2<String>(
                              value: _selectedLeadSource,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedLeadSource = newValue;
                                  isLeadSourceSelected = true;
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Select Lead source';
                                }
                                return null;
                              },
                              items: _leadSourceList
                                  .map((item){
                                return DropdownMenuItem<String>(
                                  value: item['title'],
                                  child: Text(
                                    item['title'],
                                    style: const TextStyle(
                                      color: Color(0xFF393939),
                                      fontSize: 15,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                );
                              }).toList(),
                              //     .map((DropDownData item) {
                              //   return DropdownMenuItem(
                              //     value: item.title,
                              //     child: Text(
                              //       item.title.length > 25
                              //           ? item.title.substring(0, 26) + '.'
                              //           : item.title,
                              //       style: const TextStyle(
                              //         color: Color(0xFF393939),
                              //         fontSize: 15,
                              //         fontFamily: 'Poppins',
                              //         fontWeight: FontWeight.w400,
                              //       ),
                              //     ),
                              //   );
                              // }).toList(),
                              style: const TextStyle(
                                color: Color(0xFF393939),
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                              //   hint: const Text('Select an option'),
                              decoration: InputDecoration(
                                labelText: 'Lead Source *',
                                hintText: '',
                                //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                focusedBorder: focus,
                                enabledBorder: enb,
                                filled: true,
                                fillColor: StyleData.textFieldColor,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _selectedLeadSource == "DSA",
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                SizedBox(
                                  width: width * 0.95,
                                  child: DropdownButtonFormField2<String>(
                                    isExpanded: true,
                                    hint: const Text(
                                      'Select option',
                                      style: TextStyle(
                                        fontSize: 15, // Adjusted font size to match second dropdown
                                        color: Color(0xFF393939), // Changed text color to match second dropdown
                                      ),
                                    ),
                                    items: _leadDSAList.map((DropDownData item) {
                                      return DropdownMenuItem(
                                        value: item.title,
                                        child: Text(
                                          item.title.length > 25
                                              ? item.title.substring(0, 26) + '.'
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
                                    value: _selectedDSA,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedDSA = newValue;
                                        DropDownData selectedDSAData = _leadDSAList.firstWhere(
                                              (item) => item.title == newValue,
                                        );
                                        print('DSAID: ${selectedDSAData.id}');
                                        selectedDSACode = selectedDSAData.id.toString();
                                      });
                                      setState(() {
                                        selectedDSACode1 = selectedDSACode;
                                        selectedDSACodeController.text = selectedDSACode!;
                                      });
                                      print(selectedDSACode1);
                                    },
                                    validator: (newValue) {
                                      if (newValue!.isEmpty) {
                                        return 'Choose DSA Name';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Choose DSA *',
                                      hintText: '',
                                      //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                      focusedBorder: focus,
                                      enabledBorder: enb,
                                      filled: true,
                                      fillColor: StyleData.textFieldColor,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      maxHeight: 200,
                                    ),
                                    selectedItemBuilder: (BuildContext context) {
                                      return _leadDSAList.map<Widget>((DropDownData item) {
                                        return Text(
                                          item.title,
                                          style: const TextStyle(fontSize: 13, color: Colors.black),
                                        );
                                      }).toList();
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      padding: const EdgeInsets.only(left: 3),
                                      width: width * 0.9,
                                      // height: height * 0.07,
                                    ),
                                    style: const TextStyle(
                                      color: Color(0xFF393939),
                                      fontSize: 15,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                    ),
                                    dropdownSearchData: DropdownSearchData(
                                      searchController: textEditingController,
                                      searchInnerWidgetHeight: 60,
                                      searchInnerWidget: Container(
                                        height: 60,
                                        padding: const EdgeInsets.only(left: 8),
                                        child: TextFormField(
                                          expands: true,
                                          maxLines: null,
                                          controller: textEditingController,
                                          decoration: InputDecoration(
                                            labelText: 'Search',
                                            labelStyle: TextStyle(
                                              color: Color(0xFF393939),
                                              fontSize: 13,
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: Colors.black38),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: Colors.black38),
                                            ),
                                          ),
                                        ),
                                      ),
                                      searchMatchFn: (item, searchValue) {
                                        return item.value.toString().toLowerCase().contains(searchValue.toLowerCase());
                                      },
                                    ),
                                    onMenuStateChange: (isOpen) {
                                      if (!isOpen) {
                                        textEditingController.clear();
                                      }
                                    },
                                  ),
                                ),
                                //
                                // SizedBox(
                                //   width: width * 0.95,
                                //   child: DropdownButtonFormField2<String>(
                                //     value: _selectedDSA,
                                //     onChanged: (String? newValue) {
                                //       setState(() {
                                //         _selectedDSA = newValue;
                                //
                                //         DropDownData selectedDSAData = _leadDSAList.firstWhere(
                                //               (item) => item.title == newValue,
                                //         );
                                //         // Fetch and print the selected title's ID
                                //         print('DSAID: ${selectedDSAData.id}');
                                //         selectedDSACode = selectedDSAData.id.toString();
                                //
                                //       });
                                //       setState(() {
                                //         selectedDSACode1 = selectedDSACode;
                                //         selectedDSACodeController.text = selectedDSACode!;
                                //       });
                                //       print(selectedDSACode1);
                                //     },
                                //    // focusNode: _customerNameFocus,
                                //     validator: (value) {
                                //       if (value!.isEmpty) {
                                //         return 'Choose DSA Name';
                                //       }
                                //       return null;
                                //     },
                                //     dropdownStyleData:DropdownStyleData(
                                //       decoration: BoxDecoration(
                                //         //     color: StyleData.buttonColor,
                                //           borderRadius: BorderRadius.circular(10)
                                //
                                //       ),
                                //       maxHeight: 200,
                                //     ) ,
                                //     items: _leadDSAList
                                //         .map((DropDownData item){
                                //       return DropdownMenuItem(
                                //         value: item.title,
                                //         child: Text(
                                //           item.title.length > 25
                                //               ? item.title.substring(0, 26) + '.'  // adjust the length as needed
                                //               : item.title,
                                //           style: const TextStyle(
                                //             color: Color(0xFF393939),
                                //             fontSize: 15,
                                //             fontFamily: 'Poppins',
                                //             fontWeight: FontWeight.w400,
                                //           ),
                                //         ),
                                //       );
                                //     }).toList(),
                                //     style: const TextStyle(
                                //       color: Color(0xFF393939),
                                //       fontSize: 15,
                                //       fontFamily: 'Poppins',
                                //       fontWeight: FontWeight.w400,
                                //     ),
                                //     //   hint: const Text('Select an option'),
                                //     decoration: InputDecoration(
                                //       labelText: 'Choose DSA *',
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
                                  width: width * 0.95,
                                  child: TextFormField(
                                    controller: selectedDSACodeController,
                                  //  initialValue: selectedDSACode1,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      labelText: 'DSA Code',
                                      hintText: '',
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
                          Visibility(
                            visible: _selectedLeadSource == "Connector",
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                SizedBox(
                                  width: width * 0.95,
                                  child: DropdownButtonFormField2<String>(
                                    isExpanded: true,
                                    hint: const Text(
                                      'Select option',
                                      style: TextStyle(
                                        fontSize: 15, // Adjusted font size to match second dropdown
                                        color: Color(0xFF393939), // Changed text color to match second dropdown
                                      ),
                                    ),
                                    items: _leadConnectorList
                                        .map((DropDownData item){
                                      return DropdownMenuItem(
                                        value: item.title,
                                        child: Text(
                                          item.title.length > 30
                                              ? item.title.substring(0, 29) + '...'
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
                                    value: _selectedConnector,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedConnector = newValue;
                                        DropDownData selectedConnectorData = _leadConnectorList.firstWhere(
                                              (item) => item.title == newValue,
        
                                        );
                                        // Fetch and print the selected title's ID
                                        print('ConnectorID: ${selectedConnectorData.id}');
                                        ConnectorCode = selectedConnectorData.id.toString();
                                      });
                                      setState(() {
                                        ConnectorCode1 = ConnectorCode;
                                        ConnectorCodeController.text = ConnectorCode!;
                                      });
                                      print(ConnectorCode1);
                                    },
                                    //  focusNode: _customerNameFocus,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Select connector name';
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(
                                      color: Color(0xFF393939),
                                      fontSize: 15,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    //   hint: const Text('Select an option'),
                                    decoration: InputDecoration(
                                      labelText: 'Choose Connector *',
                                      hintText: '',
                                      //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                      focusedBorder: focus,
                                      enabledBorder: enb,
                                      filled: true,
                                      fillColor: StyleData.textFieldColor,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      maxHeight: 200,
                                    ),
                                    selectedItemBuilder: (BuildContext context) {
                                      return _leadConnectorList.map<Widget>((DropDownData item) {
                                        return Text(
                                          item.title,
                                          style: const TextStyle(fontSize: 14, color: Colors.black),
                                        );
                                      }).toList();
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      padding: const EdgeInsets.only(left: 3),
                                      width: width * 0.9,
                                      // height: height * 0.07,
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                    ),
                                    dropdownSearchData: DropdownSearchData(
                                      searchController: textEditingController,
                                      searchInnerWidgetHeight: 60,
                                      searchInnerWidget: Container(
                                        height: 60,
                                        padding: const EdgeInsets.only(left: 8),
                                        child: TextFormField(
                                          expands: true,
                                          maxLines: null,
                                          controller: textEditingController,
                                          decoration: InputDecoration(
                                            labelText: 'Search',
                                            labelStyle: TextStyle(
                                              color: Color(0xFF393939),
                                              fontSize: 13,
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: Colors.black38),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: Colors.black38),
                                            ),
                                          ),
                                        ),
                                      ),
                                      searchMatchFn: (item, searchValue) {
                                        return item.value.toString().toLowerCase().contains(searchValue.toLowerCase());
                                      },
                                    ),
                                    onMenuStateChange: (isOpen) {
                                      if (!isOpen) {
                                        textEditingController.clear();
                                      }
                                    },
                                  ),
                                ),
                                // SizedBox(
                                //   width: width * 0.95,
                                //   child: DropdownButtonFormField2<String>(
                                //     value: _selectedConnector,
                                //     onChanged: (String? newValue) {
                                //       setState(() {
                                //         _selectedConnector = newValue;
                                //         DropDownData selectedConnectorData = _leadConnectorList.firstWhere(
                                //               (item) => item.title == newValue,
                                //
                                //         );
                                //         // Fetch and print the selected title's ID
                                //         print('DSAID: ${selectedConnectorData.id}');
                                //         ConnectorCode = selectedConnectorData.id.toString();
                                //       });
                                //       setState(() {
                                //         ConnectorCode1 = ConnectorCode;
                                //         ConnectorCodeController.text = ConnectorCode!;
                                //       });
                                //       print(ConnectorCode1);
                                //     },
                                //   //  focusNode: _customerNameFocus,
                                //     validator: (value) {
                                //       if (value!.isEmpty) {
                                //         return 'Select connector name';
                                //       }
                                //       return null;
                                //     },
                                //     items: _leadConnectorList
                                //         .map((DropDownData item){
                                //       return DropdownMenuItem(
                                //         value: item.title,
                                //         child: Text(
                                //           item.title.length > 30
                                //               ? item.title.substring(0, 29) + '...'
                                //               : item.title,
                                //           style: const TextStyle(
                                //             color: Color(0xFF393939),
                                //             fontSize: 15,
                                //             fontFamily: 'Poppins',
                                //             fontWeight: FontWeight.w400,
                                //           ),
                                //         ),
                                //       );
                                //     }).toList(),
                                //     dropdownStyleData:DropdownStyleData(
                                //       decoration: BoxDecoration(
                                //         //     color: StyleData.buttonColor,
                                //           borderRadius: BorderRadius.circular(10)
                                //
                                //       ),
                                //       maxHeight: 200,
                                //     ) ,
                                //     style: const TextStyle(
                                //       color: Color(0xFF393939),
                                //       fontSize: 15,
                                //       fontFamily: 'Poppins',
                                //       fontWeight: FontWeight.w400,
                                //     ),
                                //     //   hint: const Text('Select an option'),
                                //     decoration: InputDecoration(
                                //     labelText: 'Choose Connector *',
                                //     hintText: '',
                                //     //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                //     focusedBorder: focus,
                                //     enabledBorder: enb,
                                //     filled: true,
                                //     fillColor: StyleData.textFieldColor,
                                //   ),
                                //   ),
                                // ),
                                SizedBox(
                                  width: width * 0.95,
                                  child: TextFormField(
                                    controller: ConnectorCodeController,
                                    //  initialValue: selectedDSACode1,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      labelText: 'Connector Code',
                                      hintText: '',
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
                          Visibility(
                            visible: _selectedLeadSource == "Marketing Campaign",
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                SizedBox(
                                  width: width * 0.95,
                                  child: DropdownButtonFormField2<String>(
                                    value: _selectedCampaign,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedCampaign = newValue;
                                      });
                                    },
                                   // focusNode: _customerNameFocus,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Select campaign name';
                                      }
                                      return null;
                                    },
                                    items: _leadCampaignList
                                        .map((DropDownData item){
                                      return DropdownMenuItem(
                                        value: item.title,
                                        child: Text(
                                          item.title.length > 33
                                              ? item.title.substring(0, 32) + '...'  // adjust the length as needed
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
                                    dropdownStyleData:DropdownStyleData(
                                      decoration: BoxDecoration(
                                        //     color: StyleData.buttonColor,
                                          borderRadius: BorderRadius.circular(10)
        
                                      ),
                                      maxHeight: 200,
                                    ) ,
                                    style: const TextStyle(
                                      color: Color(0xFF393939),
                                      fontSize: 15,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    //   hint: const Text('Select an option'),
                                    decoration: InputDecoration(
                                      labelText: 'Choose Marketing Campaign',
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
                          Visibility(
                            visible: _selectedLeadSource == "Customer Referral",
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                SizedBox(
                                  width: width * 0.95,
                                  child: TextFormField(
                                    controller: _customerName,
                                    // onChanged: (value) {
                                    //   setState(() {
                                    //     checkCustomerFieldsFilled();
                                    //   });
                                    // },
                                    //focusNode: _customerNameFocus,
                                    decoration: InputDecoration(
                                      labelText: 'Customer Name',
                                      hintText: '',
                                      //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                      focusedBorder: focus,
                                      enabledBorder: enb,
                                      filled: true,
                                      fillColor: StyleData.textFieldColor,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please customer name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.95,
                                  child: TextFormField(
                                    controller: _customerMobileNumber,
                                    // onChanged: (value) {
                                    //   setState(() {
                                    //     checkCustomerFieldsFilled();
                                    //   });
                                    // },
                                    //focusNode: _customerNameFocus,
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(10),
                                    ],
        
                                    decoration: InputDecoration(
                                      labelText: 'Mobile Number',
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
                                        return 'Please mobile number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: _selectedLeadSource == "Employee Referral",
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                SizedBox(
                                  width: width * 0.95,
                                  child: TextFormField(
                                    controller: _employeeName,
                                    // onChanged: (value) {
                                    //   setState(() {
                                    //     checkCustomerFieldsFilled();
                                    //   });
                                    // },
                                    //focusNode: _customerNameFocus,
                                    decoration: InputDecoration(
                                      labelText: 'Employee Name',
                                      hintText: '',
                                      //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                      focusedBorder: focus,
                                      enabledBorder: enb,
                                      filled: true,
                                      fillColor: StyleData.textFieldColor,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please employee name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.95,
                                  child: TextFormField(
                                    controller: _employeeCode,
                                    // onChanged: (value) {
                                    //   setState(() {
                                    //     checkCustomerFieldsFilled();
                                    //   });
                                    // },
                                    //focusNode: _customerNameFocus,
                                   //keyboardType: TextInputType.phone,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.singleLineFormatter,
                                      LengthLimitingTextInputFormatter(7),
                                    ],
        
                                    decoration: InputDecoration(
                                      labelText: 'Employee Code',
                                      hintText: '',
                                     // prefixText: '+91 ',
                                      //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                      focusedBorder: focus,
                                      enabledBorder: enb,
                                      filled: true,
                                      fillColor: StyleData.textFieldColor,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter employee code';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: _selectedLeadSource == "Builder",
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                SizedBox(
                                  width: width * 0.95,
                                  child: TextFormField(
                                    controller: _builderName,
                                    // onChanged: (value) {
                                    //   setState(() {
                                    //     checkCustomerFieldsFilled();
                                    //   });
                                    // },
                                    //focusNode: _customerNameFocus,
                                    decoration: InputDecoration(
                                      labelText: 'Builder Name',
                                      hintText: '',
                                      //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                      focusedBorder: focus,
                                      enabledBorder: enb,
                                      filled: true,
                                      fillColor: StyleData.textFieldColor,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter builder name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: _selectedLeadSource == "Cross-Sell",
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                SizedBox(
                                  width: width * 0.95,
                                  child: TextFormField(
                                    controller: _crmLeadId,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    // onChanged: (value) {
                                    //   setState(() {
                                    //     checkCustomerFieldsFilled();
                                    //   });
                                    // },
                                    //focusNode: _customerNameFocus,
                                    decoration: InputDecoration(
                                      labelText: 'CRM Lead ID',
                                      hintText: '',

                                      //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                      focusedBorder: focus,
                                      enabledBorder: enb,
                                      filled: true,
                                      fillColor: StyleData.textFieldColor,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter CRM Lead ID';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: isLeadSourceSelected == true,
                            child: Column(
                              children: [
                                SizedBox(height: height * 0.01),
                                Card(
                                  elevation: 3,
                                  child: GestureDetector(
                                    onTap: () {
                                        setState(() {
                                          isCustomerInfo = !isCustomerInfo;
                                          isVisitInfo = false;
                                        //  isAddressInfo = false;
                                          isOtherInfo = false;
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
                                                    areCustomerFieldsFilled
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
                                                  DropdownButtonFormField2<String>(
                                                    value: _selectedSalutation,
                                                    onChanged: (String? newValue) {
                                                      setState(() {
                                                        _selectedSalutation = newValue;
                                                        checkCustomerFieldsFilled();
                                                      });
                                                    },
                                                    validator: (value) {
                                                      if (value == null || value.isEmpty) {
                                                        return 'Please select salutation';
                                                      }
                                                      return null; // Return null if the value is valid
                                                    },
                                                    dropdownStyleData:DropdownStyleData(
                                                      decoration: BoxDecoration(
                                                        //     color: StyleData.buttonColor,
                                                          borderRadius: BorderRadius.circular(10)
        
                                                      ),
                                                      maxHeight: 200,
                                                    ) ,
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
                                                  TextFormField(
                                                    controller: firstName,
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
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                                                    ],
                                                    validator: (value) {
                                                      if (value == null || value.isEmpty) {
                                                        return 'Please enter your first name';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    controller: middleName,
                                                    // onChanged: (value) {
                                                    //   setState(() {
                                                    //     checkCustomerFieldsFilled();
                                                    //   });
                                                    // },
                                                    decoration: InputDecoration(
                                                      labelText: 'Middle Name',
                                                      hintText: 'Enter Middle Name',
                                                      //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                      focusedBorder: focus,
                                                      enabledBorder: enb,
                                                      filled: true,
                                                      fillColor: StyleData.textFieldColor,
                                                    ),
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                                                    ],
                                                    // validator: (value) {
                                                    //   if (value == null || value.isEmpty) {
                                                    //     return 'Please enter your first name';
                                                    //   }
                                                    //   return null;
                                                    // },
                                                  ),
                                                  TextFormField(
                                                    controller: lastName,
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
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                                                    ],
                                                    validator: (value) {
                                                      if (value == null || value.isEmpty) {
                                                        return 'Please enter your last name';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    controller: customerNumber,
                                                    keyboardType: TextInputType.phone,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter.digitsOnly,
                                                      LengthLimitingTextInputFormatter(10),
                                                    ],
                                                    onChanged: (value) {
                                                      setState(() {
                                                     //   fetchAllCustomerMobile(value);
                                                        checkCustomerFieldsFilled();
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                      labelText: 'Customer Phone *',
                                                      hintText: 'Enter Customer Phone',
                                                      prefixText: '+91 ', // Add the prefix here
                                                      // prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
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
        
                                                  SizedBox(height: height * 0.02),
                                                  Visibility(
                                                    visible: areCustomerFieldsFilled,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        if(areCustomerFieldsFilled)
                                                        {
                                                          setState(() {
                                                            isVisitInfo = !isVisitInfo;
                                                            isCustomerInfo = false;
                                                         //   isAddressInfo = false;
                                                            isOtherInfo = false;
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
                                      if(areCustomerFieldsFilled)
                                        {
                                      setState(() {
                                        isVisitInfo = !isVisitInfo;
                                        isCustomerInfo = false;
                                     //   isAddressInfo = false;
                                        isOtherInfo = false;
                                      });
                                    }},
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
                                                      'assets/images/vistInfo.png',
                                                      width: width * 0.08,
                                                      height: height * 0.04,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.05,
                                                    ),
                                                    Text("Visit Information",style: TextStyle(color: StyleData.appBarColor,fontWeight: FontWeight.bold,fontSize: 16),),
                                                    Spacer(),
                                                    areVisitFieldsFilled
                                                        ? Icon(Icons.check_circle_sharp, color: Colors.green, size: 22,)
                                                        : Icon(Icons.arrow_drop_down_circle_rounded, color: StyleData.buttonColor, size: 22,)
                                                  ],
                                                ),
                                              ),
                                              // SizedBox(height: height * 0.015),
                                              Visibility(
                                                  visible:  isVisitInfo == true,
                                                  child: Column(
                                                    children: [
                                                      TextFormField(
                                                    //    focusNode: _dateFocus,
                                                    controller: _dateController,
                                                        // onChanged: (value) {
                                                        //   setState(() {
                                                        //     checkVisitFieldsFilled();
                                                        //   });
                                                        // },
                                                  readOnly: true,
                                                    onTap: () => _selectDate(context),
                                                        decoration: InputDecoration(
                                                          labelText: 'Visit Date *',
                                                          suffixIcon: Icon(Icons.calendar_today),
                                                          focusedBorder: focus,
                                                          enabledBorder: enb,
                                                          filled: true,
                                                          fillColor: StyleData.textFieldColor,
                                                        ),
        
                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return 'Please Select visit date';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      TextFormField(
                                                        controller: _timeController,
                                                        readOnly: true,
                                                        onTap: () => _selectTime(context),
                                                        // onChanged: (value) {
                                                        //   setState(() {
                                                        //     checkVisitFieldsFilled();
                                                        //   });
                                                        // },
                                                        decoration: InputDecoration(
                                                          labelText: 'Visit Time *',
                                                          suffixIcon: Icon(Icons.access_time),
                                                          focusedBorder: focus,
                                                          enabledBorder: enb,
                                                          filled: true,
                                                          fillColor: StyleData.textFieldColor,
                                                        ),
                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return 'Please enter visit time';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      SizedBox(height: height * 0.02),
                                                      Visibility(
                                                        visible: areVisitFieldsFilled,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            if(areVisitFieldsFilled)
                                                            {
                                                              setState(() {
                                                                isOtherInfo = !isOtherInfo;
                                                                isVisitInfo = false;
                                                                isCustomerInfo = false;
                                                             //   isOtherInfo = false;
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
                                      if(areVisitFieldsFilled)
                                        {
                                      setState(() {
                                        isOtherInfo = !isOtherInfo;
                                        isVisitInfo = false;
                                        isCustomerInfo = false;
                                      //  isAddressInfo = false;
                                      });
                                    }},
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
                                                      'assets/images/other.png',
                                                      width: width * 0.08,
                                                      height: height * 0.01,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.05,
                                                    ),
                                                    Text("Other Information",style: TextStyle(color: StyleData.appBarColor,fontWeight: FontWeight.bold,fontSize: 16),),
                                                    Spacer(),
                                                    areOtherFieldsFilled
                                                        ? Icon(Icons.check_circle_sharp, color: Colors.green, size: 22,)
                                                        : Icon(Icons.arrow_drop_down_circle_rounded, color: StyleData.buttonColor, size: 22,)
                                                  ],
                                                ),
                                              ),
                                              // SizedBox(height: height * 0.015),
                                              Visibility(
                                                  visible:  isOtherInfo == true,
                                                  child: Column(
                                                    children: [
                                                      DropdownButtonFormField2<String>(
                                                        value: selectedPurpose,
                                                        onChanged: (String? newValue) {
                                                          setState(() {
                                                            selectedPurpose = newValue;
                                                            checkOtherFieldsFilled();
                                                          });
                                                        },
                                                        items: purposeVisit
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
                                                          labelText: 'Purpose Of Visit *',
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
                                                            return 'Please enter purpose of visit';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      DropdownButtonFormField2<String>(
                                                        value: selectedCustomerStatus,
                                                        onChanged: (String? newValue) {
                                                          setState(() {
                                                            selectedCustomerStatus = newValue;
                                                            checkOtherFieldsFilled();
                                                          });
                                                        },
                                                        items: customerStatus
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
                                                          labelText: 'Customer Status *',
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
                                                            return 'Please select Customer Status';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      Visibility(
                                                        visible: selectedCustomerStatus == "Not Interested",
                                                        child: TextFormField(
                                                          controller: _reasonNotInterested,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              //   fetchAllCustomerMobile(value);
                                                              checkOtherFieldsFilled();
                                                            });
                                                          },
                                                           decoration: InputDecoration(
                                                            labelText: 'Reason *',
                                                            focusedBorder: focus,
                                                            enabledBorder: enb,
                                                            filled: true,
                                                            fillColor: StyleData.textFieldColor,
                                                          ),
                                                          validator: (value) {
                                                            if (value == null || value.isEmpty) {
                                                              return 'Please enter Reason';
                                                            }
                                                            return null;
                                                          },
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
                                  elevation: 4.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Container(
                                    color: Colors.white,
                                    child: TextField(
                                      controller: locationController,
                                      enabled: false,
                                      maxLines: 2,
                                      decoration: InputDecoration(
                                        hintText: 'Location',
                                        prefixIcon: Icon(Icons.gps_fixed,color: StyleData.appBarColor2,),
                                        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                      ),
                                    ),
                                  ),
                                ),
        
                              ],
                            ),
                          ),
                          SizedBox(height:  height * 0.01),
                          Visibility(
                            visible: isLeadSourceSelected == true,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                   // getStartImage(ImageSource.camera);
                                    showImageSourceOptions();
                                  },
                                  child: ClipOval(
                                    child: Container(
                                      color: StyleData.appBarColor2,
                                      width: 70, // Adjust the width
                                      height: 70, // Adjust the height
                                      child: Center(
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 35, // Adjust the icon size
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height:  height * 0.01), // Space between icon and text
                                Text(
                                  'Capture Selfie',
                                  style: TextStyle(
                                    // color: Colors.black,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              //  _isVisible
                                _isVisible && startimage != null
                                    ? Stack(
                                  children: [
                                    Image.file(
                                      startimage!,
                                      width: MediaQuery.of(context).size.width * 0.8,
                                      height: MediaQuery.of(context).size.width * 0.8,
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      left: 10,
                                      child: Container(
                                        // color: Colors.white,
                                        child: Text(
                                          '${currentDateTime}\nLat: ${currentposition?.latitude}, Long: ${currentposition?.longitude}',
                                          style: TextStyle(
                                            color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                    : Container(),

                              ],
                            ),
                          ),
                          SizedBox(
                            height:  height * 0.36,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: StyleData.appBarColor2,
                  ),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            areCustomerFieldsFilled == true && areVisitFieldsFilled == true
                             && areOtherFieldsFilled == true) {
                          if(startimage != null) {
                            //  visitCreation();
                            if (customerNumber.text.length < 10) {
                              CustomSnackBar.errorSnackBarQ(
                                  "Please enter valid Mobile Number", context);
                            }
                            else {
                              fetchAllCustomerMobile(customerNumber.text);
                            }
                          }else{
                            CustomSnackBar.errorSnackBarQ("Please Capture Selfie", context);
                          }
        
                        }
                        else {
                          CustomSnackBar.errorSnackBarQ("Please enter all the mandatory fields", context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      child: Text(
                        'Save & Continue',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
                  Text('Visit created successfully', textAlign: TextAlign.center, style: TextStyle(color: Colors.black87,fontSize: 16,),),
                  //  SizedBox(height: 8),
                  Row(
                    children: [
                      Text('Visit ID - ', textAlign: TextAlign.center,style: TextStyle(color: Colors.black87)),
                      Text('$visitID', textAlign: TextAlign.center,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold)),
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
  String formatDate(String dateString) {
    try {
      // Assuming dateString is in the format 'yyyy-MM-dd HH:mm:ss.SSS'
      DateTime date = DateTime.parse(dateString);

      final formatter = DateFormat('yyyy-MM-dd');
      return formatter.format(date);
    } catch (e) {
      print("Error parsing date: $e");
      return " --";
    }
  }
}
