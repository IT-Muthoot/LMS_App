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

  List<Map<String, dynamic>> campaignName = [
    {"id": "001", "title": "Auto Announcement Activity"},
    {"id": "002", "title": "Builders Meet"},
    {"id": "003", "title": "Canopy Activity"},
    {"id": "004", "title": "CSR Tie Up With Hospitals, Police Stations Etc , Doing BTL Activities"},
    {"id": "005", "title": "Doctor Campaign"},
    {"id": "006", "title": "Exhibitions Participations Activity"},
    {"id": "007", "title": "Festival Related Or Special Offer / Product Campaign ( 360 Deg )"},
    {"id": "008", "title": "Leaflet Distribution"},
    {"id": "009", "title": "Loan Mela"},
    {"id": "010", "title": "Local Market Day Activity"},
    {"id": "011", "title": "Market Day Activity"},
    {"id": "012", "title": "News Paper Activity"},
    {"id": "013", "title": "Promotional EDM"},
    {"id": "014", "title": "Road Show/ Canter/ Van Activity"},
    {"id": "015", "title": "Sandwich Board Activity"},
    {"id": "016", "title": "Society Activities"},
    {"id": "017", "title": "Spot Sanction Day"},
    {"id": "018", "title": "Stall Activity At Builder End"},
    {"id": "019", "title": "Wall Painting"},
    {"id": "020", "title": "Pre-Approved_Top-Up"},
    {"id": "021", "title": "Blaze Campaign Lead"},
    {"id": "022", "title": "Blaze OBD Campaign"}
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
        .collection("campaignName")
        .doc("campaignName")
        .update({"campaignName": FieldValue.arrayUnion(campaignName)});
    print("hi");
  }

  @override
  Widget build(BuildContext context) {
   pushData();

    return Container();
  }


}
