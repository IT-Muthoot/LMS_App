import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lead_management_system/View/HomePageView.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../Model/Response/DropDownModel.dart';
import '../Utils/CustomeSnackBar.dart';
import '../Utils/StyleData.dart';
import 'ApplicantDetailsView.dart';
import 'VisitPageView.dart';

class NewLeadPageView extends StatefulWidget {
  final bool isNewActivity;
  final bool isUpdateActivity;
  final String docId;
 // String? accessToken;

   NewLeadPageView({Key? key,
    required this.isNewActivity,
    required this.isUpdateActivity,
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


  final List<String> _residentialType= [
    'Self owned',
    'Parent owned',
    'Rented',
  ];
  String? _selectedResidentialType;
  final List<String> _residentialStatus= [
    'Resident',
    'Non-Resident',
  ];
  String? _selectedResidentialStatus;

  final List<DropDownData> _customerProfileList = [];

  getDropDownCustProfileData() {
    FirebaseFirestore.instance
        .collection("customerProfile")
        .doc('customerProfile')
        .get()
        .then((value) {
      for (var element in value.data()!['customerProfile']) {
        setState(() {
          _customerProfileList
              .add(DropDownData(element['id'], element['title']));
        });
      }
    });
  }
  String? _selectedCustomerProfile;

  final List<DropDownData> _employeeCategoryList = [];

  getDropDownEmpCategoryData() {
    FirebaseFirestore.instance
        .collection("employeeCategory")
        .doc('employeeCategory')
        .get()
        .then((value) {
      for (var element in value.data()!['employeeCategory']) {
        setState(() {
          _employeeCategoryList
              .add(DropDownData(element['id'], element['title']));
        });
      }
    });
  }
  String? _selectedEmployeeCategory;

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
    'Transgender',
  ];
  String? _selectedGender;

  final List<String> _stateselect = [
    'Kerala',
    'Karnataka',
    'Andhra Pradesh',
  ];
  String? _selectedState;

  final List<String> purposeVisit = [
    'Document Pick up',
    'Lead Capture',
  ];
  String? selectedPurpose;

  String? selectedProductValue;
  final List<DropDownProductData> _productsList = [];
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

  bool consentCRIF = false;
  bool consentKYC = false;

  TextEditingController monthlyIncomeOfApplicant = TextEditingController();
  TextEditingController aadharCardNumber = TextEditingController();
  TextEditingController panCardNumber = TextEditingController();


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
        _dateOfBirth.text = formatDate(pickedDate.toLocal().toString());
      });
    }
  }


  bool isCustomerInfo = false;
  bool isAddressInfo = false;
  bool isLeadInfo = false;
  bool isProfileInfo = false;
  bool areCustomerFieldsFilled = false;
  bool areAddressFieldsFilled = false;
  bool areLeadsFieldsFilled = false;
  bool areProfileFieldsFilled = false;

  bool areFieldsFilled = false;
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
  TextEditingController _postOffice = TextEditingController();
  TextEditingController _pincode = TextEditingController();
  TextEditingController _leadSource = TextEditingController();
  TextEditingController _homeFinBranchCode = TextEditingController(text: 'KALY037');
  TextEditingController _leadAmount = TextEditingController();

  //Additional details

  UnderlineInputBorder enb =  UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:   const BorderSide(color:  Colors.black38)
  );
  UnderlineInputBorder focus =  UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:  const BorderSide(color: Color(0xff778287))
  );

  void checkCustomerFieldsFilled() {
    if (_selectedSalutation != null &&
        firstName.text.isNotEmpty &&
        lastName.text.isNotEmpty &&
        customerNumber.text.isNotEmpty &&  _email.text.isNotEmpty &&
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
        _city.text.isNotEmpty && _selectedState != null && _district.text.isNotEmpty && _postOffice.text.isNotEmpty && _pincode.text.isNotEmpty) {
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
    if ( _leadAmount.text.isNotEmpty && selectedProductValue != null && selectedProdut != null) {
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

  var userType;
  List<DocumentSnapshot> ListOfLeads = [];
  List<Map<dynamic, dynamic>> ListOfDSANames = [];
  var docData;
  bool isFetching = true;
  String? leadSource;

  String? DSAConnectorName;
  String? DSAConnectorCode;
  String? DSAConnectorCode1;


  getdata() {
    if (!widget.isNewActivity) {
      CollectionReference users =
      FirebaseFirestore.instance.collection('LeadCreation');
      users.doc(widget.docId).get().then((value) {
        setState(() {
          docData = value.data();
        });
        _selectedSalutation = docData["salutation"] ?? "";
        firstName.text  = docData["firstName"] ?? "";
        middleName.text  = docData["middleName"] ?? "";
        lastName.text = docData["lastName"] ?? "";
        customerNumber.text = docData["customerNumber"] ?? "";
        _addressLine1.text = docData["addressLine1"] ?? "";
        _addressLine2.text = docData["addressLine2"] ?? "";
        _addressLine3.text = docData["addressLine3"] ?? "";
        _landMark.text = docData["_landMark"] ?? "";
        _city.text = docData["city"] ?? "";
        _selectedState= docData["state"] ?? "";
        _district.text= docData["district"] ?? "";
        _postOffice.text= docData["postOffice"] ?? "";
        _pincode.text= docData["pincode"] ?? "";
        _leadSource.text= docData["leadSource"] ?? "";
        customerStatus= docData["customerStatus"] ?? "";
        DSAConnectorName = docData["leadSource"] == "DSA"
            ? docData["dsaName"] ?? ""
            : docData["connectorName"] ?? "";
        print("Lead Source value");
      //  print(_leadSource.text);
        print(DSAConnectorName);

        setState(() {

           leadSource = _leadSource.text;
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

  String? LeadID;

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
  //  print(widget.accessToken);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('access_token');
    var headers = {
   'Authorization':  'Bearer ${prefs.getString('access_token') ?? ''}',
    //  'Authorization':  'Bearer ${widget.accessToken ?? ''}',
      'Content-Type': 'application/json',
      'Cookie': 'BrowserId=qnhrXMyBEe6lOh9ncfvoTw; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
   // print(widget.accessToken);
    print(customerStatus);
    print(selectedProductValue);
    var data = json.encode({
      "LastName": lastName.text,
      "FirstName": firstName.text,
      "MiddleName":middleName.text,
      "Salutation": _selectedSalutation ?? "",
      "Email": _email.text,
      "Phone": customerNumber.text,
      "HfinBranchcode": "KALY037",
      "Product": selectedProductValue,
      "Purpose": selectedProdut ?? "",
      "DSAorConnectorName": DSAConnectorName,
      "DSAorConnectorCode":"626",
      "Interest": customerStatus,
      "Amount": _leadAmount.text,
      "DateOfBirth": _dateOfBirth.text,
      "Gender": _selectedGender ?? "",
      "ResidentStatus": _selectedResidentialStatus ?? "",
      "ResidentType": _selectedResidentialType ?? "",
      "Nationality": _nationality.text,
      "CustomerProfile": _selectedCustomerProfile ?? "",
      "MonthlyIncome": monthlyIncomeOfApplicant.text,
      "EmployerCategory": _selectedEmployeeCategory ?? "",
      "Pan": panCardNumber.text,
      "Aadhaar": aadharCardNumber.text,
      "Address1": _addressLine1.text,
      "Address2": _addressLine2.text,
      "Address3": _addressLine3.text,
      "Pincode": _pincode.text
    });

   print(data);
    var dio = Dio();
    var response = await dio.request(
      'https://muthootltd--uat.sandbox.my.salesforce.com/services/apexrest/LeadCreationTest/',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    try {
      if (response.statusCode == 200) {
        print(json.encode(response.data));

        var responseMap = response.data;
        // print(json.encode(responseMap));
        String sfLeadId = responseMap['SFleadId'];
        // saveLead(sfLeadId);
        setState(() {
          LeadID = sfLeadId;
        });

        Navigator.pop(context);
   updateDataToFirestore();
        _showAlertDialogSuccess(context);
      }
    } catch (e) {
      _showAlertDialogSuccess1(context);
      print("Error: $e");
    }
    //
    // else {
    //   Navigator.pop(context);
    //   print(response.statusMessage);
    // }
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
      convertedLeads.where('customerNumber', isEqualTo: customerNumber.text).get().then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          print(querySnapshot.docs.isNotEmpty);
          convertedLeads.doc(querySnapshot.docs.first.id).update(params).then((value) {
            print("Data updated to Visits successfully");
            Navigator.pop(context);
          }).catchError((error) {
            print("Failed to update data: $error");
          });
        } else {
            Navigator.pop(context);
        }
      }).catchError((error) {
        print("Failed to check if customerNumber exists: $error");
      });

    }catch(e){
      print(e);
    };


  }

  Future<void> updateDataToFirestore() async {
    CollectionReference convertedLeads = FirebaseFirestore.instance.collection("convertedLeads");
    SharedPreferences pref =
    await SharedPreferences.getInstance();
    var userId = pref.getString("token");
    DateTime now = DateTime.now();
    print("Hello");
    try{
      Map<String, dynamic> params = {
        'salutation': _selectedSalutation ?? "",
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
        'landmark':_landMark.text,
        'state':_selectedState,
        'district':_district.text,
        'postOffice':_postOffice.text,
        'pincode':_pincode.text,
        'residentialType':_selectedResidentialType ?? "",
        'residentialStatus':_selectedResidentialStatus ?? "",
        'homeFinBranchCode':_homeFinBranchCode.text,
        'leadAmount':_leadAmount.text,
        'leadSource': _leadSource.text,
        'productCategory': selectedProductValue ?? "",
        'products': selectedProdut ?? "",
        'CustomerProfile': _selectedCustomerProfile ?? "",
        'EmployeeCategory': _selectedEmployeeCategory ?? "",
        'monthlyIncome' : monthlyIncomeOfApplicant.text,
        'aadharNumber' : aadharCardNumber.text,
        'panCardNumber' : panCardNumber.text,
        'LeadID' : LeadID ?? "",
        'userId': userId,
        'createdDateTime':Timestamp.fromDate(now),
      };
      // convertedLeads.where('customerNumber', isEqualTo: customerNumber.text).get().then((querySnapshot) {
      //   if (querySnapshot.docs.isNotEmpty) {
      //     // If customerNumber exists, update the document
      //     print(querySnapshot.docs.isNotEmpty);
      //     convertedLeads.doc(querySnapshot.docs.first.id).update(params).then((value) {
      //       print("Data updated successfully");
      //       Navigator.pop(context);
      //       updateDataToVisitFirestore();
      //       _showAlertDialogSuccess(context);
      //     }).catchError((error) {
      //       print("Failed to update data: $error");
      //     });
      //   } else {
          convertedLeads.add(params).then((value) {
            print("Data added successfully");
            Navigator.pop(context);
            updateDataToVisitFirestore();
            _showAlertDialogSuccess(context);
          }).catchError((error) {
            print("Failed to add data: $error");
          });
      //   }
      // }).catchError((error) {
      //   print("Failed to check if customerNumber exists: $error");
      // });

    }catch(e){
      print(e);
    };


  }

  Future<void> getDropdownDSAData() async {
    var collectionReference = FirebaseFirestore.instance.collection('dsaName').doc('dsaName');
    try {
      collectionReference.get().then((ListOfDSANames1) {

        var listData = ListOfDSANames1.data() as Map<String,dynamic> ;
        var id = listData['dsaName'].where((dsa) {
          // var dsa = dsa1.data()["id"];

          print(dsa["title"]);
          print("title");
          print(DSAConnectorName);
          if(dsa["title"].toString().toLowerCase() == DSAConnectorName.toString().toLowerCase()){
            setState(() {
              DSAConnectorCode = dsa["id"];
              print(DSAConnectorCode);
            });
          }
          return dsa["title"].toString().toLowerCase() == DSAConnectorName.toString().toLowerCase();
        }).toList();
      });
    } catch (error) {
      print('Error fetching data: $error');
    }
  }
  Future<void> getDropdownConnectorData() async {
    var collectionReference = FirebaseFirestore.instance.collection('connectorName').doc('connectorName');
    try {
      collectionReference.get().then((ListOfDSANames1) {

        var listData = ListOfDSANames1.data() as Map<String,dynamic> ;
        var id = listData['connectorName'].where((dsa) {
          // var dsa = dsa1.data()["id"];

          print(dsa["title"]);
          print("title");
          print(DSAConnectorName);
          if(dsa["title"].toString().toLowerCase() == DSAConnectorName.toString().toLowerCase()){
            setState(() {

              print("selectedData");
              print(dsa);
              DSAConnectorCode1 = dsa["id"];
              print(DSAConnectorCode1);
            });
          }
          return dsa["title"].toString().toLowerCase() == DSAConnectorName.toString().toLowerCase();
        }).toList();
      });
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

   initState() {
    // TODO: implement initState
    super.initState();
  //  print(widget.accessToken);
    getDropDownProductsData();
    getDropDownSalutationData();
    getdata();
    getDropdownDSAData();
    getDropdownConnectorData();
    getDropDownEmpCategoryData();
    getDropDownCustProfileData();
  }

  @override
  Widget build(BuildContext context) {

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
              child: Image.asset(
                'assets/images/arrow.png',
              ),),
        ),
        title: Text("New Lead",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: StyleData.boldFont),),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          SizedBox(height: height * 0.01),
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
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'Please enter your middle name';
                                                    }
                                                    return null;
                                                  },
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

                                                  // onChanged: (value) {
                                                  //   setState(() {
                                                  //     checkCustomerFieldsFilled();
                                                  //   });
                                                  // },
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Enter email';
                                                    }
                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                    labelText: 'Email *',
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
                                                  decoration: InputDecoration(
                                                    labelText: 'Additional Phone Number',
                                                    hintText: 'Enter Phone Number',
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
                                                SizedBox(height: height * 0.02),
                                                Visibility(
                                                  visible: areCustomerFieldsFilled,
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
                                if(areCustomerFieldsFilled)
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
                                              Text("Address Information",style: TextStyle(color: StyleData.appBarColor,fontWeight: FontWeight.bold,fontSize: 16),),
                                              Spacer(),
                                              areAddressFieldsFilled
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
                                                    hintText: 'Enter Adress Line 1',
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
                                                    return null;
                                                  },
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
                                                    return null;
                                                  },
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
                                                    return null;
                                                  },
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
                                                ),
                                                TextFormField(
                                                  controller: _landMark,
                                                  decoration: InputDecoration(
                                                    labelText: 'Landmark',
                                                    hintText: 'Enter Landmark',
                                                    //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                    //   border: InputBorder.none,
                                                    focusedBorder: focus,
                                                    enabledBorder: enb,
                                                    filled: true,
                                                    fillColor: StyleData.textFieldColor,
                                                  ),
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'Please enter your landmark';
                                                    }
                                                    return null;
                                                  },
                                                ),
        
                                                DropdownButtonFormField2<String>(
                                                  value:_selectedState,
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      _selectedState = newValue;
                                                      checkAddressFieldsFilled();
                                                    });
                                                  },
                                                  items: _stateselect
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
                                                    labelText: 'State *',
                                                    hintText: 'Select an option',
                                                    //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                    // border: InputBorder.none,
                                                    focusedBorder: focus,
                                                    enabledBorder: enb,
                                                    filled: true,
                                                    fillColor: StyleData.textFieldColor,
                                                  ),
                                                ),
                                                TextFormField(
                                                  controller: _district,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      checkAddressFieldsFilled();
                                                    });
                                                  },
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
                                                  controller: _postOffice,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      checkAddressFieldsFilled();
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    labelText: 'Post Office *',
                                                    hintText: 'Enter post office',
                                                    //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                    //   border: InputBorder.none,
                                                    focusedBorder: focus,
                                                    enabledBorder: enb,
                                                    filled: true,
                                                    fillColor: StyleData.textFieldColor,
                                                  ),
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'Please enter your post office';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                TextFormField(
                                                  controller: _pincode,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      checkAddressFieldsFilled();
                                                    });
                                                  },
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
                                              ],
                                            )),
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
                                    ),
                                  )),
                            ),
                          ),
                          Card(
                            elevation: 3,
                            child: GestureDetector(
                              onTap: () {
                                if(areAddressFieldsFilled)
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
                                              Text("Lead Details",style: TextStyle(color: StyleData.appBarColor,fontWeight: FontWeight.bold,fontSize: 16),),
                                              Spacer(),
                                              areLeadsFieldsFilled
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
                                                  controller: _homeFinBranchCode,
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                    labelText: 'Home Fin Branch Code',
                                                    hintText: 'KALY037',
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
                                                      style: TextStyle(fontSize: 16,color: Colors.grey.shade700),
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
                                                          value: 'Non Home Loan',
                                                          groupValue: selectedProductValue,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              selectedProductValue = 'Non Home Loan';
                                                              checkLeadsFieldsFilled();
                                                            });
                                                          },
                                                          activeColor: StyleData.appBarColor,
                                                        ),
                                                        Text(
                                                          'Non Home Loan',
                                                          style: TextStyle(fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),

                                                selectedProductValue == 'Home Loan' ?
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
                                                      items: _productsList.where((item) => item.type == 1)
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
                                                        labelText: 'Product *',
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
                                                        labelText: 'Product *',
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
                                                SizedBox(height: height * 0.02),
                                                Visibility(
                                                  visible: areLeadsFieldsFilled,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      if(areLeadsFieldsFilled)
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
                                if(areLeadsFieldsFilled)
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
                                              Text("Profiling Stage",style: TextStyle(color: StyleData.appBarColor,fontWeight: FontWeight.bold,fontSize: 16),),
                                              Spacer(),
                                              areProfileFieldsFilled
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
                                                              checkProfileFieldsFilled();
                                                            });
                                                          },
                                                          items: _customerProfileList
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
                                                          items: _employeeCategoryList
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
                                                            labelText: 'Employee Category *',
                                                            hintText: 'Select an option',
                                                            //  prefixIcon: Icon(Icons.person, color: HexColor("#7c8880"),),
                                                            focusedBorder: focus,
                                                            enabledBorder: enb,
                                                            filled: true,
                                                            fillColor: StyleData.textFieldColor,
                                                          ),
                                                        ),
                                                        SizedBox(height: height * 0.01,),
                                                        TextFormField(
                                                          controller: monthlyIncomeOfApplicant,
                                                          onChanged: (String? newValue) {
                                                            setState(() {
                                                              checkProfileFieldsFilled();
                                                            });
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
                                                            FilteringTextInputFormatter.singleLineFormatter,
                                                            LengthLimitingTextInputFormatter(10),
                                                          ],
                                                          validator: (value) {
                                                            if (value == null || value.isEmpty) {
                                                              return 'Pan Card Number is required';
                                                            } else if (!isValidPanCard(value)) {
                                                              return 'Invalid Pan Card Number';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                        SizedBox(height: height * 0.01,),
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
                                                        )
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height:  height * 0.46,
            ),
            Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                color: StyleData.appBarColor,
              ),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {

                 if (_formKey.currentState!.validate() &&
                     areCustomerFieldsFilled == true && areLeadsFieldsFilled == true
                     && areAddressFieldsFilled == true && areProfileFieldsFilled == true) {
                   leadCreation();
                 }
                 else {
                   CustomSnackBar.errorSnackBarQ("Please enter mandatory fields", context);
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
              ),
            )
        
          ],
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
                Text('Lead created successfully', textAlign: TextAlign.center,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold)),
                //  SizedBox(height: 8),
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
                          builder: (context) =>
                              ApplicantDetailsView(),
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

  bool isValidPanCard(String panNumber) {
    RegExp panRegExp = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
    return panRegExp.hasMatch(panNumber);
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
