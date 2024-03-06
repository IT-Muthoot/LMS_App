import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/StyleData.dart';

class DocumentPageView extends StatefulWidget {
  const DocumentPageView({super.key});

  @override
  State<DocumentPageView> createState() => _DocumentPageViewState();
}

class _DocumentPageViewState extends State<DocumentPageView> {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar:  AppBar(
        backgroundColor: StyleData.appBarColor2,
        title: Text("Applicant Detail",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: StyleData.boldFont),),
        centerTitle: true,

      ),
      body: Row(
        children: [
          Expanded(
            child: buildCheckboxColumn('Mandatory', checkboxValues),
          ),
          Expanded(
            child: buildCheckboxColumn('Optional', optionalCheckboxes),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //
      //   },
      //   child: Icon(Icons.save),
      // ),
    )
    );
  }

  Widget buildCheckboxColumn(String title, Map<String, bool> checkboxes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        ...checkboxes.keys.map((String key) {
          return Row(
            children: [
              Checkbox(
                value: checkboxes[key],
                activeColor: StyleData.appBarColor,
                onChanged: (value) {
                  setState(() {
                    checkboxes[key] = value!;
                  });
                },
              ),
              Text(
                key,
                style: TextStyle(fontSize: 18),
              ),
            ],
          );
        }).toList(),
      ],
    );
  }
}
