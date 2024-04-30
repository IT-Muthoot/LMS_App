import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/StyleData.dart';

class DocumentChecklistPageView extends StatefulWidget {
  final bool isNewActivity;
  final bool isUpdateActivity;
  final String leadId;
  final String docId;
  const DocumentChecklistPageView({super.key, required this.isNewActivity, required this.isUpdateActivity, required this.leadId, required this.docId});

  @override
  State<DocumentChecklistPageView> createState() => _DocumentChecklistPageViewState();
}

class _DocumentChecklistPageViewState extends State<DocumentChecklistPageView> {

  var userType;

  List<DocumentSnapshot> leadDetails = [];
  String? productCategory;
  String? purposeOfLoan;
  String? region;

  void fetchLeadDetails() async {
    CollectionReference leadsCollection =
    FirebaseFirestore.instance.collection('convertedLeads');

    QuerySnapshot leadSnapshot = await leadsCollection
        .where('LeadID', isEqualTo: widget.leadId)
        .limit(1)
        .get();

    if (leadSnapshot.docs.isNotEmpty) {
      setState(() {
        leadDetails = leadSnapshot.docs;
        productCategory = leadDetails[0]['productCategory'];
        purposeOfLoan = leadDetails[0]['products'];
        region = leadDetails[0]['Region'];
      });
    } else {

    }
  }

  Future<void> _fetchDataFromFirestore() async {
    try {
      // Access the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Access the "documentChecklist" collection
      CollectionReference checklistCollection = firestore.collection('documentChecklist');

      // Get the documents in the collection
      QuerySnapshot querySnapshot = await checklistCollection.get();

      // Iterate through the documents and log the data
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        log(documentSnapshot.data().toString());

      }
    } catch (e) {
      log('Error fetching data: $e');
    }
  }





  @override
  void initState() {
    // TODO: implement initState
    fetchLeadDetails();
    _fetchDataFromFirestore();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:  AppBar(
          backgroundColor: StyleData.appBarColor2,
          title: Text("Document Checklist",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: StyleData.boldFont),),
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lead ID: ${widget.leadId}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  'Product: $productCategory',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  'Purpose Of Loan: $purposeOfLoan',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
