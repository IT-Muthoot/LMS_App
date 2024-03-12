import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:lead_management_system/View/HomePageView.dart';
import 'package:lead_management_system/View/dashbordPageView.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/Response/DropDownModel.dart';
import '../Utils/CustomeSnackBar.dart';
import '../Utils/StyleData.dart';
import 'VisitPageView.dart';



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


//Dropdowns
  getDropDownLeadData() {
    FirebaseFirestore.instance
        .collection("leadSource")
        .doc('leadSource')
        .get()
        .then((value) {
      for (var element in value.data()!['leadSource']) {
        setState(() {
          _leadSourceList
              .add(DropDownData(element['id'], element['title']));
        });
      }
    });
  }
  String? _selectedLeadSource;
  final List<DropDownData> _leadSourceList = [];

  getDropDownConnectorData() {
    FirebaseFirestore.instance
        .collection("connectorName")
        .doc('connectorName')
        .get()
        .then((value) {
      for (var element in value.data()!['connectorName']) {
        setState(() {
          _leadConnectorList
              .add(DropDownData(int.parse(element['id']), element['title']));
        });
      }
    });
  }
  String? _selectedConnector;
  int? _selectedConnectorID;
  int? _selectedDSAID;
  final List<DropDownData> _leadConnectorList = [];

  getDropDownDSAData() {
    FirebaseFirestore.instance
        .collection("dsaName")
        .doc('dsaName')
        .get()
        .then((value) {
      for (var element in value.data()!['dsaName']) {
        setState(() {
          _leadDSAList
              .add(DropDownData(int.parse(element['id']), element['title']));
        });
      }
    });
  }
  String? _selectedDSA;
  String? selectedDSACode;
  String? ConnectorCode;
  String? selectedDSACode1;
  String? ConnectorCode1;
  final List<DropDownData> _leadDSAList = [];

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

  final List<DropDownData> _salutationList = [];

  String? _selectedSalutation;
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

  final List<String> _stateselect = [];
  String? _selectedState;

  final List<String> purposeVisit = [
    'Document Pick up',
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
      'Authorization':  'Bearer ${prefs.getString('access_token') ?? ''}',
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
      "Latitude": latitude.toString(),
      "Longitude": longitude.toString(),
    });
    print(data);
    var dio = Dio();
    var response = await dio.request(
        'https://muthootltd--uat.sandbox.my.salesforce.com/services/apexrest/VisitApi/',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
      data: data,
    );

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
      // addDataToFirestore();
      addDataToFirestore();
     // _showAlertDialogSuccess(context);
    }
    else {
      Navigator.pop(context);
      print(response.statusMessage);
    }
  }




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
  TextEditingController _landMark = TextEditingController();
  TextEditingController _district = TextEditingController();
  TextEditingController _postOffice = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _pincode = TextEditingController();

  //Additional details
  TextEditingController _customerName = TextEditingController();
  TextEditingController _customerMobileNumber = TextEditingController();
  TextEditingController _employeeName = TextEditingController();
  TextEditingController _employeeCode = TextEditingController();


  List<dynamic> _PostcodeList = [];
  String? selectedPostCode;

//Functions
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
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
                primary: Color(0xff973232),
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

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xff973232), // Your custom yellow color
            hintColor: Colors.blueGrey.shade200,
            colorScheme: ColorScheme.light(primary: Color(0xff973232)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Color(0xff973232),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        _timeController.text = pickedTime.format(context);
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
  // void checkVisitFieldsFilled() {
  //   if (_dateController.text.isNotEmpty &&
  //       _timeController.text.isNotEmpty) {
  //     setState(() {
  //       areVisitFieldsFilled = true;
  //     });
  //   } else {
  //     setState(() {
  //       areVisitFieldsFilled = false;
  //     });
  //   }
  // }

  void checkAddressFieldsFilled() {
    if (_addressLine1.text.isNotEmpty &&
        _addressLine2.text.isNotEmpty  && _addressLine3.text.isNotEmpty &&
    _city.text.isNotEmpty  && _pincode.text.isNotEmpty) {
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

  List<DocumentSnapshot> ListOfLeads = [];
  List outputList1 = [];
  var userType;
  String? fetchMobileNumber;

  void fetchLeads() async {
    CollectionReference users = FirebaseFirestore.instance.collection('LeadCreation');

    users.get().then((value) {
      setState(() {
        ListOfLeads = value.docs;
      });
      for (var i = 0; value.docs.length > i; i++) {
        print(value.docs[i].data());
      }
    });
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

    // Check if mobileNumber exists in allCustomerMobiles
    bool isMobileExists = allCustomerMobiles.contains(mobileNumber);

    // Now allCustomerMobiles contains the CustomerMobile values
    print("All Customer Mobiles: $allCustomerMobiles");

    // Use isMobileExists as needed in your code
    print("Mobile Number $mobileNumber exists: $isMobileExists");

    if (isMobileExists) {
      // If mobile number exists, call visitCreation()
      CustomSnackBar.errorSnackBarQ("Mobile number already Exists", context);

    } else {
      // If mobile number doesn't exist, show custom message
      visitCreation();
    }

    // Optionally, you can use setState here if needed
    // setState(() {
    //   // Set state or perform other actions based on isMobileExists
    // });
  }




  CollectionReference leadsCreation = FirebaseFirestore.instance.collection("LeadCreation");
  Future<void> addDataToFirestore() async {
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
      // 'addressLine1': _addressLine1.text,
      // 'addressLine2': _addressLine2.text,
      // 'addressLine3': _addressLine3.text,
      // 'city': _city.text,
      // 'landmark':_landMark.text,
      // 'state':_state.text,
      // 'district':_district.text,
      // 'postOffice':selectedPostCode,
      // 'pincode':_pincode.text,
      'customerName':_customerName.text,
      'CustomerMobile':_customerMobileNumber.text,
      'leadSource': _selectedLeadSource,
      'dsaName': _selectedDSA,
      'connectorName': _selectedConnector,
      'compaignName': _selectedCampaign,
      'purposeVisit' : selectedPurpose,
      'customerStatus' : selectedCustomerStatus,
      'DSAConnectorCode' : _selectedLeadSource == 'DSA' ? selectedDSACode1 : ConnectorCode1,
      'latitude' : latitude,
      'longitude' : longitude,
      'address': locationController.text,
      'LeadID' : "-",
      'userId': userId,
      'createdDateTime':Timestamp.fromDate(now),
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

  UnderlineInputBorder enb =  UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:   const BorderSide(color:  Colors.black38)
  );
  UnderlineInputBorder focus =  UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:  const BorderSide(color: Color(0xff298b28))
  );

  TextEditingController locationController = TextEditingController();
  String latitude = '';
  String longitude = '';
  void getLocation() async {
    print("Getting location");
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);

      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark firstPlacemark = placemarks.first;
        String address = "${firstPlacemark.subThoroughfare} ${firstPlacemark.thoroughfare}, "
            "${firstPlacemark.subLocality}, ${firstPlacemark.locality}, "
            "${firstPlacemark.administrativeArea} ${firstPlacemark.postalCode}, "
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
    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      getLocation();
    } else {
      print("Location permission denied");
    }
  }
  List<String> stateValues = [];
  List<String> districts  = [];
  List<String> postOffice  = [];

  // void getCity() async {
  //   try {
  //     final String jsonContent = await rootBundle.loadString('assets/jsons/citylist.json');
  //     print(jsonContent);
  //
  //     // Explicitly cast the decoded JSON to List<Map<String, dynamic>>
  //     List<Map<String, dynamic>> jsonDataList = (jsonDecode(jsonContent) as List)
  //         .map((item) => item as Map<String, dynamic>)
  //         .toList();
  //
  //     stateValues = jsonDataList.map((item) => item["S"].toString()).toSet().toList();
  //     print("StateList");
  //     print(stateValues);
  //     setState(() {
  //       // Set initial value or perform other actions after loading data
  //       _selectedState = stateValues.isNotEmpty ? stateValues[0] : '';
  //       print(_selectedState);
  //     });
  //   } catch (e) {
  //     // Handle errors, e.g., log the error or throw it again
  //     print('Error fetching city data: $e');
  //
  //     // You can set a default value or show an error message to the user
  //     setState(() {
  //       _selectedState = 'Default State'; // Set a default value
  //     });
  //   }
  // }
  //
  // String? _selectedDistrict;
  // String? _selectedPostOffice;
  // List<Map<String, dynamic>> jsonDataList = [];
  // List<Map<String, dynamic>> filterDataByState(String selectedState) {
  //   return jsonDataList.where((item) => item['S'] == selectedState).toList();
  // }
  //
  //
  // void updateDistrictsAndPlaces(String selectedState) {
  //   try {
  //     List<Map<String, dynamic>> filteredData = filterDataByState(selectedState);
  //
  //     print(filteredData); // Print filtered data for debugging
  //
  //     districts = filteredData.map((item) => item['D'].toString()).toSet().toList();
  //     postOffice = filteredData.map((item) => item['PO'].toString()).toSet().toList();
  //
  //     print(districts);
  //     print("Districts");
  //
  //     // Update your dropdowns or do anything else with the districts and places
  //     // For example, you can update the districts and places dropdowns:
  //     setState(() {
  //       _selectedDistrict = districts.isNotEmpty ? districts[0] : '';
  //       _selectedPostOffice = postOffice.isNotEmpty ? postOffice[0] : '';
  //     });
  //   } catch (e) {
  //     // Handle errors, e.g., log the error or throw it again
  //     print('Error updating districts and places: $e');
  //
  //     // You can set default values or show an error message to the user
  //     setState(() {
  //       _selectedDistrict = 'Default District'; // Set a default value for district
  //       _selectedPostOffice = 'Default Post Office'; // Set a default value for post office
  //     });
  //   }
  // }

Future<void> getToken()
async {
  var headers = {
    'X-PrettyPrint': '1',
    'Content-Type': 'application/x-www-form-urlencoded',
    'Cookie': 'BrowserId=qnhrXMyBEe6lOh9ncfvoTw; CookieConsentPolicy=0:0; LSKey-c\$CookieConsentPolicy=0:0'
  };
  var data = {
    'grant_type': 'password',
    'client_id': '3MVG9u0ll7_j5qFxuFGIYQ4WguPM0jYjSJXprZRrAAOaI8q0BVKqxCt1dzjQ0tti3JDqnTeGjj1Dk7v9.QwnQ',
    'client_secret': 'ED297E5AD800E43B413260D0C4C7CFA7F49D11CE440F2EBC88220064B32D51CD',
    'username': 'itkrishnaprasad@muthootgroup.com',
    'password': 'Karthikrishna@12y7630AbZERemUschpI8nDyy4d'
  };
  var dio = Dio();
  var response = await dio.request(
    'https://test.salesforce.com/services/oauth2/token',
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



  void initState() {
    // TODO: implement initState
    getToken();
    fetchLeads();
    getDropDownSalutationData();
    getDropDownLeadData();
    getDropDownConnectorData();
    getDropDownDSAData();
    getDropDownCampaignData();
    super.initState();
    requestLocationPermission();
   // getAccessToken();
  }


  //FocusNode _customerNameFocus = FocusNode();


  @override
  Widget build(BuildContext context) {
    // _customerNameFocus.addListener(() {
    //   if (_customerNameFocus.hasFocus) {
    //     setState(() {
    //       isCustomerInfo = true;
    //     });
    //   }
    // });
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                     HomePageView(),
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
                                value: _selectedDSA,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedDSA = newValue;

                                    DropDownData selectedDSAData = _leadDSAList.firstWhere(
                                          (item) => item.title == newValue,
                                    );
                                    // Fetch and print the selected title's ID
                                    print('DSAID: ${selectedDSAData.id}');
                                    selectedDSACode = selectedDSAData.id.toString();

                                  });
                                  setState(() {
                                    selectedDSACode1 = selectedDSACode;
                                  });
                                  print(selectedDSACode1);
                                },
                               // focusNode: _customerNameFocus,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Choose DSA Name';
                                  }
                                  return null;
                                },
                                dropdownStyleData:DropdownStyleData(
                                  decoration: BoxDecoration(
                                    //     color: StyleData.buttonColor,
                                      borderRadius: BorderRadius.circular(10)
              
                                  ),
                                  maxHeight: 200,
                                ) ,
                                items: _leadDSAList
                                    .map((DropDownData item){
                                  return DropdownMenuItem(
                                    value: item.title,
                                    child: Text(
                                      item.title.length > 25
                                          ? item.title.substring(0, 26) + '.'  // adjust the length as needed
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
                                  labelText: 'Choose DSA *',
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
                        visible: _selectedLeadSource == "Connector",
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.01,
                            ),
                            SizedBox(
                              width: width * 0.95,
                              child: DropdownButtonFormField2<String>(
                                value: _selectedConnector,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedConnector = newValue;
                                    DropDownData selectedConnectorData = _leadConnectorList.firstWhere(
                                          (item) => item.title == newValue,

                                    );
                                    // Fetch and print the selected title's ID
                                    print('DSAID: ${selectedConnectorData.id}');
                                    ConnectorCode = selectedConnectorData.id.toString();
                                  });
                                  setState(() {
                                    ConnectorCode1 = ConnectorCode;
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
                                  labelText: 'Choose Connector *',
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
                            // Card(
                            //   elevation: 3,
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       if(areVisitFieldsFilled)
                            //         {
                            //       setState(() {
                            //         isAddressInfo = !isAddressInfo;
                            //         isVisitInfo = false;
                            //         isCustomerInfo = false;
                            //         isOtherInfo = false;
                            //       });
                            //     }},
                            //     child: Container(
                            //         color: Colors.white,
                            //         child: Padding(
                            //           padding: const EdgeInsets.all(8.0),
                            //           child: Column(
                            //             children: [
                            //               SizedBox(
                            //                 height: height * 0.05,
                            //                 width: width * 1,
                            //                 child: Row(
                            //                   children: [
                            //                     Image.asset(
                            //                       'assets/images/address.png',
                            //                       width: width * 0.08,
                            //                       height: height * 0.04,
                            //                       fit: BoxFit.cover,
                            //                     ),
                            //                     SizedBox(
                            //                       width: width * 0.05,
                            //                     ),
                            //                     Text("Address Information",style: TextStyle(color: StyleData.appBarColor,fontWeight: FontWeight.bold,fontSize: 16),),
                            //                    Spacer(),
                            //                     areAddressFieldsFilled
                            //                         ? Icon(Icons.check_circle_sharp, color: Colors.green, size: 22,)
                            //                         : Icon(Icons.arrow_drop_down_circle_rounded, color: StyleData.buttonColor, size: 22,)
                            //                   ],
                            //                 ),
                            //               ),
                            //               // SizedBox(height: height * 0.015),
                            //               Visibility(
                            //                   visible:  isAddressInfo == true,
                            //                   child: Column(
                            //                     children: [
                            //                       TextFormField(
                            //                         controller: _addressLine1,
                            //                         onChanged: (value) {
                            //                           setState(() {
                            //                             checkAddressFieldsFilled();
                            //                           });
                            //                         },
                            //                         decoration: InputDecoration(
                            //                           labelText: 'Address Line 1 *',
                            //                           hintText: 'Enter Adress Line 1',
                            //                           //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                            //                           //   border: InputBorder.none,
                            //                           focusedBorder: focus,
                            //                           enabledBorder: enb,
                            //                           filled: true,
                            //                           fillColor: StyleData.textFieldColor,
                            //                         ),
                            //                         validator: (value) {
                            //                           if (value == null || value.isEmpty) {
                            //                             return 'Please enter Address Line 1';
                            //                           }
                            //                           return null;
                            //                         },
                            //                       ),
                            //                       TextFormField(
                            //                         controller: _addressLine2,
                            //                         onChanged: (value) {
                            //                           setState(() {
                            //                             checkAddressFieldsFilled();
                            //                           });
                            //                         },
                            //                         decoration: InputDecoration(
                            //                           labelText: 'Address Line 2 *',
                            //                           hintText: 'Enter Address Line 2',
                            //                           //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                            //                           //   border: InputBorder.none,
                            //                           focusedBorder: focus,
                            //                           enabledBorder: enb,
                            //                           filled: true,
                            //                           fillColor: StyleData.textFieldColor,
                            //                         ),
                            //                         validator: (value) {
                            //                           if (value == null || value.isEmpty) {
                            //                             return 'Please enter address line 2';
                            //                           }
                            //                           return null;
                            //                         },
                            //                       ),
                            //                       TextFormField(
                            //                         controller: _addressLine3,
                            //                         onChanged: (value) {
                            //                           setState(() {
                            //                             checkAddressFieldsFilled();
                            //                           });
                            //                         },
                            //                         decoration: InputDecoration(
                            //                           labelText: 'Address Line 3 *',
                            //                           hintText: 'Enter Address Line 3',
                            //                           //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                            //                           //   border: InputBorder.none,
                            //                           focusedBorder: focus,
                            //                           enabledBorder: enb,
                            //                           filled: true,
                            //                           fillColor: StyleData.textFieldColor,
                            //                         ),
                            //                         validator: (value) {
                            //                           if (value == null || value.isEmpty) {
                            //                             return 'Please enter address line 3';
                            //                           }
                            //                           return null;
                            //                         },
                            //                       ),
                            //                       TextFormField(
                            //                         controller: _city,
                            //                         onChanged: (value) {
                            //                           setState(() {
                            //                             checkAddressFieldsFilled();
                            //                           });
                            //                         },
                            //                         decoration: InputDecoration(
                            //                           labelText: 'City/Town/Village *',
                            //                           hintText: 'Enter City/Town/Village',
                            //                           //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                            //                           //   border: InputBorder.none,
                            //                           focusedBorder: focus,
                            //                           enabledBorder: enb,
                            //                           filled: true,
                            //                           fillColor: StyleData.textFieldColor,
                            //                         ),
                            //                         validator: (value) {
                            //                           if (value == null || value.isEmpty) {
                            //                             return 'Please enter your City/Town/Village';
                            //                           }
                            //                           return null;
                            //                         },
                            //                       ),
                            //                       TextFormField(
                            //                         controller: _landMark,
                            //                         onChanged: (value) {
                            //                           // setState(() {
                            //                           //   checkAddressFieldsFilled();
                            //                           // });
                            //                         },
                            //                         decoration: InputDecoration(
                            //                           labelText: 'Landmark',
                            //                           hintText: 'Enter Landmark',
                            //                           //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                            //                           //   border: InputBorder.none,
                            //                           focusedBorder: focus,
                            //                           enabledBorder: enb,
                            //                           filled: true,
                            //                           fillColor: StyleData.textFieldColor,
                            //                         ),
                            //                       ),
                            //                       TextFormField(
                            //                         controller: _pincode,
                            //                         onChanged: (value) async {
                            //                           setState(() {
                            //                             checkAddressFieldsFilled();
                            //                           });
                            //                           if (value.length == 6) {
                            //                             final String jsonContent = await rootBundle
                            //                                 .loadString('assets/jsons/citylist.json');
                            //
                            //                             final List<dynamic> jsonData =
                            //                             json.decode(jsonContent);
                            //
                            //                             var listSearchData = jsonData
                            //                                 .where((item) => item['PC'].toString().toLowerCase().contains(value.toLowerCase()))
                            //                                 .toList();
                            //
                            //                             print("Helloooooooooo");
                            //                             print(listSearchData);
                            //                             if (listSearchData.isNotEmpty) {
                            //                               selectedPostCode = null;
                            //                               setState(() {
                            //                                 _PostcodeList =
                            //                                     listSearchData.map((e) => e).toList();
                            //                               });
                            //
                            //                               print("List Drop Data");
                            //                               var districtNames = listSearchData
                            //                                   .map((e) => e["D"].toString())
                            //                                   .toSet() // Convert to a set to remove duplicates
                            //                                   .first;  // Take the first element
                            //
                            //                               print(districtNames);
                            //
                            //                               var stateName = listSearchData
                            //                                   .map((e) => e["S"].toString())
                            //                                   .toSet() // Convert to a set to remove duplicates
                            //                                   .first;  // Take the first element
                            //
                            //                               print(stateName);
                            //                               setState(() {
                            //                                 _district.text = districtNames;
                            //                                 _state.text = stateName;
                            //                               });
                            //
                            //                             } else {
                            //                               _PostcodeList.clear();
                            //                               //  showToastMessage('Enter correct pincode');
                            //                             }
                            //                           }
                            //                         },
                            //                         keyboardType: TextInputType.phone,
                            //                         inputFormatters: [
                            //                           FilteringTextInputFormatter.singleLineFormatter,
                            //                           LengthLimitingTextInputFormatter(6),
                            //                         ],
                            //                         decoration: InputDecoration(
                            //                           labelText: 'Pincode *',
                            //                           hintText: 'Enter Pincode',
                            //                           //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                            //                           //  border: InputBorder.none,
                            //                           focusedBorder: focus,
                            //                           enabledBorder: enb,
                            //                           filled: true,
                            //                           fillColor: StyleData.textFieldColor,
                            //                         ),
                            //                         validator: (value) {
                            //                           if (value == null || value.isEmpty) {
                            //                             return 'Please enter pincode';
                            //                           }
                            //                           return null;
                            //                         },
                            //                       ),
                            //                       DropdownButtonFormField2(
                            //                         dropdownStyleData:DropdownStyleData(
                            //                           decoration: BoxDecoration(
                            //                             //     color: StyleData.buttonColor,
                            //                               borderRadius: BorderRadius.circular(10)
                            //
                            //                           ),
                            //                           maxHeight: 200,
                            //                         ) ,
                            //                         // isExpanded: true,
                            //                         // isDense: true,
                            //                         decoration: InputDecoration(
                            //                           labelText: 'Post Office *',
                            //                           hintText: 'Select an option',
                            //                           //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                            //                           focusedBorder: focus,
                            //                           enabledBorder: enb,
                            //                           filled: true,
                            //                           fillColor: StyleData.textFieldColor,
                            //                         ),
                            //                         validator: (value) {
                            //                           if (selectedPostCode == null) {
                            //                             return "Select Post Office";
                            //                           }
                            //                           return null;
                            //                         },
                            //                         value: selectedPostCode,
                            //                         onChanged: (value) {
                            //                          // checkAddressFieldsFilled();
                            //                           setState(() {
                            //                             selectedPostCode = value as String?;
                            //                           });
                            //                         },
                            //
                            //                         items: _PostcodeList.map((dynamic item) {
                            //                           return DropdownMenuItem(
                            //                             value: item["PO"],
                            //                             child: Text(
                            //                               item["PO"],
                            //                                style: const TextStyle(
                            //                                 color: Color(0xFF393939),
                            //                             fontSize: 15,
                            //                             fontFamily: 'Poppins',
                            //                             fontWeight: FontWeight.w400,
                            //                           ),
                            //                             ),
                            //                           );
                            //                         }).toList(),
                            //                         style: const TextStyle(
                            //                           color: Color(0xFF393939),
                            //                           fontSize: 15,
                            //                           fontFamily: 'Poppins',
                            //                           fontWeight: FontWeight.w400,
                            //                         ),
                            //
                            //                         // items:
                            //                         //     _PostcodeList.map((dynamic item) {
                            //                         //   return DropdownMenuItem<dynamic>(
                            //                         //     value: item,
                            //                         //     child: Text(
                            //                         //       item,
                            //                         //       style: const TextStyle(color: Colors.white),
                            //                         //     ),
                            //                         //   );
                            //                         // }).toList(),
                            //                       ),
                            //                       TextFormField(
                            //                         controller: _district,
                            //                         readOnly: true,
                            //                         // onChanged: (value) {
                            //                         //   setState(() {
                            //                         //     checkAddressFieldsFilled();
                            //                         //   });
                            //                         // },
                            //                         decoration: InputDecoration(
                            //                           labelText: 'District *',
                            //                           hintText: 'Enter District',
                            //                           //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                            //                           //   border: InputBorder.none,
                            //                           focusedBorder: focus,
                            //                           enabledBorder: enb,
                            //                           filled: true,
                            //                           fillColor: StyleData.textFieldColor,
                            //                         ),
                            //                         validator: (value) {
                            //                           if (value == null || value.isEmpty) {
                            //                             return 'Please enter your district';
                            //                           }
                            //                           return null;
                            //                         },
                            //                       ),
                            //                       TextFormField(
                            //                         controller: _state,
                            //                         readOnly: true,
                            //                         // onChanged: (value) {
                            //                         //   setState(() {
                            //                         //     checkAddressFieldsFilled();
                            //                         //   });
                            //                         // },
                            //                         decoration: InputDecoration(
                            //                           labelText: 'State *',
                            //                           hintText: '',
                            //                           //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                            //                           //   border: InputBorder.none,
                            //                           focusedBorder: focus,
                            //                           enabledBorder: enb,
                            //                           filled: true,
                            //                           fillColor: StyleData.textFieldColor,
                            //                         ),
                            //                         validator: (value) {
                            //                           if (value == null || value.isEmpty) {
                            //                             return 'Please enter your State';
                            //                           }
                            //                           return null;
                            //                         },
                            //                       ),
                            //
                            //
                            //
                            //                       SizedBox(height: height * 0.02),
                            //                       Visibility(
                            //                         visible: areAddressFieldsFilled,
                            //                         child: GestureDetector(
                            //                           onTap: () {
                            //                             if(areAddressFieldsFilled)
                            //                             {
                            //                               setState(() {
                            //                                 isOtherInfo = !isOtherInfo;
                            //                                 isVisitInfo = false;
                            //                                 isCustomerInfo = false;
                            //                                 isAddressInfo = false;
                            //                               });
                            //                             }},
                            //                           child: Align(
                            //                             alignment: Alignment.bottomRight,
                            //                             child: Icon(
                            //                               Icons.arrow_circle_down,
                            //                               color: Colors.yellow.shade800, // Set your desired arrow color
                            //                               size: 22,
                            //                             ),
                            //                           ),
                            //                         ),
                            //                       ),
                            //                     ],
                            //                   )),
                            //             ],
                            //           ),
                            //         )),
                            //   ),
                            // ),
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
                                                      labelText: 'Purpose Of Visit',
                                                      hintText: 'Select an option',
                                                      //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                    //  border: InputBorder.none,
                                                      focusedBorder: focus,
                                                      enabledBorder: enb,
                                                      filled: true,
                                                      fillColor:StyleData.textFieldColor,
                                                    ),
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
                                                      labelText: 'Customer Status',
                                                      hintText: 'Select an option',
                                                      //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                      //  border: InputBorder.none,
                                                      focusedBorder: focus,
                                                      enabledBorder: enb,
                                                      filled: true,
                                                      fillColor:StyleData.textFieldColor,
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
                       // visitCreation();
                      fetchAllCustomerMobile(customerNumber.text);
                    }
                    else {
                      CustomSnackBar.errorSnackBarQ("Please enter mandatory fields", context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
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
    );
  }


  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //     builder: (BuildContext context, Widget? child) {
  //       return Theme(
  //         data: ThemeData.light().copyWith(
  //           primaryColor: Colors.yellow, // Your custom yellow color
  //           hintColor: Colors.yellow,
  //           colorScheme: ColorScheme.light(primary: Colors.yellow),
  //           buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
  //           textButtonTheme: TextButtonThemeData(
  //             style: TextButton.styleFrom(
  //               primary: Colors.yellow,
  //             ),
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );
  //
  //   if (picked != null && picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked;
  //     });
  //   }
  // }
  void _showAlertDialogSuccess(BuildContext context) {
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
            width: 190,
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
                          builder: (context) => HomePageView(),
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
