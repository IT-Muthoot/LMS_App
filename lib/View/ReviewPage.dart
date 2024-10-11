import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lead_management_system/Utils/StyleData.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/apiurls.dart';

class ReviewPage extends StatefulWidget {
  final String LeadID;

  ReviewPage({required this.LeadID});

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  Map<String, dynamic>? docData;
  String? LeadStatus;
  String? LeadCreatedDateTime;
  String? LeadID;

  @override
  void initState() {
    super.initState();
    getLeadDetails();
    getToken();
  }

  Future<void> getLeadDetails() async {
    CollectionReference users = FirebaseFirestore.instance.collection('convertedLeads');

    if (widget.LeadID.isNotEmpty) {
      try {
        QuerySnapshot querySnapshot = await users.where('LeadID', isEqualTo: widget.LeadID).get();
        if (querySnapshot.docs.isNotEmpty) {
          var value = querySnapshot.docs.first.data() as Map<String, dynamic>;
          getLeadStatus();
          setState(() {
            docData = value;
            LeadID = value['LeadID'];
          });
        } else {
          setState(() {
            docData = null;
          });
        }
      } catch (error) {
        print("Error fetching lead details: $error");
        setState(() {
          docData = null;
        });
      }
    }
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
      'https://muthootltd--muthootdo.sandbox.my.salesforce.com/services/apexrest/getLeadStatus/${widget.LeadID}',
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

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: StyleData.appBarColor2,
            leading: Padding(
              padding: const EdgeInsets.all(19.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(
              "Applicant Detail",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: StyleData.boldFont,
              ),
            ),
            centerTitle: true,
          ),
          body: docData == null
              ? Center(child: CircularProgressIndicator(color: StyleData.appBarColor2,))
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Card(
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${docData!['salutation']} ${docData!['firstName']} ${docData!['lastName']}',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          buildDetailRow('Lead ID', docData!['LeadID']),
                          buildDetailRow('Lead Status', LeadStatus ?? ""),
                          buildDetailRow('Email', docData!['email'] ?? 'No Email'),
                          buildDetailRow('Phone', docData!['customerNumber'] ?? 'No Phone'),
                          buildDetailRow('Gender', docData!['gender'] ?? 'No Details'),
                          SizedBox(height: 8),
                          Divider(),
                          Text(
                            'Address Details:',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: StyleData.appBarColor2),
                          ),
                          buildDetailRow('Address 1', docData!['addressLine1'] ?? 'No Details'),
                          buildDetailRow('Address 2', docData!['addressLine2'] ?? 'No Details'),
                          buildDetailRow('Address 3', docData!['addressLine3'] ?? 'No Details'),
                          buildDetailRow('City', docData!['city'] ?? 'No Details'),
                          buildDetailRow('District', docData!['district'] ?? 'No Details'),
                          buildDetailRow('State', docData!['state'] ?? 'No Details'),
                          buildDetailRow('Post Office', docData!['postOffice'] ?? 'No Details'),
                          buildDetailRow('Residential Type', docData!['residentialType'] ?? 'No Details'),
                          buildDetailRow('Residential Status', docData!['residentialStatus'] ?? 'No Details'),
                          SizedBox(height: 8),
                          Divider(),
                          Text(
                            'Lead Details:',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: StyleData.appBarColor2),
                          ),
                          buildDetailRow('Lead Amount', docData!['leadAmount'] ?? 'No Details'),
                          buildDetailRow('Monthly Income', docData!['monthlyIncome'] ?? 'No Details'),
                          buildDetailRow('Product', docData!['productCategory'] ?? 'No Details'),
                          buildDetailRow('Purpose Of Loan', docData!['products'] ?? 'No Details'),
                          SizedBox(height: 8),
                          Divider(),
                          Text(
                            'Profiling Details:',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: StyleData.appBarColor2),
                          ),
                          buildDetailRow('Customer Profile', docData!['CustomerProfile'] ?? 'No Details'),
                          buildDetailRow('Employee Category', docData!['EmployeeCategory'] ?? 'No Details'),
                          buildDetailRow('PAN Number', docData!['panCardNumber'] ?? 'No Details'),
                          buildDetailRow('Aadhar Number', docData!['aadharNumber'] ?? 'No Details'),
                          Divider(),
                        ],
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
}
