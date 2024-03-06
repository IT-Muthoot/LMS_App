import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SaveData extends StatefulWidget {
  const SaveData({Key? key}) : super(key: key);

  @override
  State<SaveData> createState() => _SaveDataState();
}

class _SaveDataState extends State<SaveData> {
  List<Map<String, dynamic>> leadSource = [
    {"title": "Business Partner", "id": 1},
    {"title": "DSA", "id": 2},
    {"title": "Connector", "id": 3},
    {"title": "Marketing Campaign", "id": 4},
    {"title": "Employee Referral", "id": 5},
    {"title": "Builder", "id": 6},
    {"title": "Customer Referral", "id": 7},
    {"title": "Cross Sales", "id": 8},
  ];
  List<Map<String, dynamic>> salutation = [
    {"title": " Mr.", "id": 1},
    {"title": "Mrs.", "id": 2},
    {"title": "Miss.", "id": 3},
    {"title": "Ms.", "id": 4},
    {"title": "Dr.", "id": 5},
    {"title": "Adv.", "id": 6},
    {"title": "Sri.", "id": 7},
    {"title": "Smt.", "id": 8},
    {"title": "Fr.Kumari.", "id": 9},
    {"title": "Kumari.", "id": 10},
    {"title": "Sr.", "id": 11},
  ];
  // {
  //   "employment_types": [
  //     {
  //       "id": 1,
  //       "title": "Formal Salaried",
  //       "subtypes": [
  //         { "id": 1, "title": "Partnership" },
  //         { "id": 2, "title": "Proprietorship(Informal)" },
  //         { "id": 3, "title": "Private Limited(Formal)" },
  //         { "id": 4, "title": "Central Govt./State Govt./PSU" },
  //         { "id": 5, "title": "Others" }
  //       ]
  //     },
  //     {
  //       "id": 2,
  //       "title": "Informal Salaried",
  //       "subtypes": [
  //         { "id": 6, "title": "Partnership" },
  //         { "id": 7, "title": "Proprietorship(Informal)" },
  //         { "id": 8, "title": "Others" }
  //       ]
  //     },
  //     {
  //       "id": 3,
  //       "title": "Formal SEP",
  //       "subtypes": [
  //         { "id": 9, "title": "LLP" }
  //       ]
  //     },
  //     {
  //       "id": 4,
  //       "title": "Informal SEP",
  //       "subtypes": [
  //         { "id": 10, "title": "HUF" }
  //       ]
  //     },
  //     {
  //       "id": 5,
  //       "title": "Formal SENP",
  //       "subtypes": [
  //         { "id": 11, "title": "Others" }
  //       ]
  //     },
  //     {
  //       "id": 6,
  //       "title": "Informal SENP",
  //       "subtypes": [
  //         { "id": 12, "title": "Others" }
  //       ]
  //     },
  //     {
  //       "id": 7,
  //       "title": "Not Working(NA)",
  //       "subtypes": [
  //         { "id": 13, "title": "Not Working(NA)" }
  //       ]
  //     }
  //   ]
  // }
  List<Map<String, dynamic>> customerProfile = [
    {"title": "Formal Salaried", "id": 1},
    {"title": "Informal Salaried", "id": 2},
    {"title": "Formal SEP", "id": 3},
    {"title": "Informal SEP", "id": 4},
    {"title": "Formal SENP", "id": 5},
    {"title": "Informal SENP", "id": 6},
    {"title": "Not Working(NA)", "id": 7},
  ];


  List<Map<String, dynamic>> stateList = [
    {"id": 1, "title": "ANDHRA PRADESH"},
    {"id": 2, "title": "ASSAM"},
    {"id": 3, "title": "BIHAR"},
    {"id": 4, "title": "CHANDIGARH"},
    {"id": 5, "title": "CHHATTISGARH"},
    {"id": 6, "title": "DELHI"},
    {"id": 7, "title": "GOA"},
    {"id": 8, "title": "GUJARAT"},
    {"id": 9, "title": "HARYANA"},
    {"id": 10, "title": "HIMACHAL PRADESH"},
    {"id": 11, "title": "JAMMU AND KASHMIR"},
    {"id": 12, "title": "JHARKHAND"},
    {"id": 13, "title": "KARNATAKA"},
    {"id": 14, "title": "KERALA"},
    {"id": 15, "title": "LADAKH"},
    {"id": 16, "title": "MADHYA PRADESH"},
    {"id": 17, "title": "MAHARASHTRA"},
    {"id": 18, "title": "ODISHA"},
    {"id": 19, "title": "PUDUCHERRY"},
    {"id": 20, "title": "PUNJAB"},
    {"id": 21, "title": "RAJASTHAN"},
    {"id": 22, "title": "TAMIL NADU"},
    {"id": 23, "title": "TELANGANA"},
    {"id": 24, "title": "THE DADRA AND NAGAR HAVELI AND DAMAN AND DIU"},
    {"id": 25, "title": "UTTAR PRADESH"},
    {"id": 26, "title": "UTTARAKHAND"}
  ];














  // void pushData() async {
  //   FirebaseFirestore.instance
  //       .collection("customerProfile")
  //       .doc("customerProfile")
  //       .update({"customerProfile": FieldValue.arrayUnion(customerProfile)});
  //   print("hi");
  // }
  void pushData() async {
    FirebaseFirestore.instance
        .collection("stateList")
        .doc("stateList")
        .update({"stateList": FieldValue.arrayUnion(stateList)});
    print("hi");
  }

  @override
  Widget build(BuildContext context) {
   pushData();

    return Container();
  }


}
