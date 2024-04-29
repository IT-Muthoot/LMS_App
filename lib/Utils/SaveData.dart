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
  List<Map<String, dynamic>> employeeMapping = [
    {
      "EMP_CODE": "MA03937",
      "NAME": "ASHISH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH CODE": "ROHT094",
      "BRANCH": "ROHTAK",
      "REGION CODE": "RO0008",
      "REGION": "PCH",
      "ZONE CODE": "ZO0003",
      "ZONE": "NORTH",
      "Reporting Manager Code": "MO1471",
      "Reporting Manager Name": "MAHESH .",
      "DSGN_NAME_2": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA03932",
      "NAME": "VIKAS KUMAR SHARMA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH CODE": "ALWA012",
      "BRANCH": "ALWAR",
      "REGION CODE": "RO0006",
      "REGION": "RAJASTHAN",
      "ZONE CODE": "ZO0003",
      "ZONE": "NORTH",
      "Reporting Manager Code": "MO1128",
      "Reporting Manager Name": "Bhanu Pareek",
      "DSGN_NAME_2": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA03924",
      "NAME": "AGRAVAT DHAVAL RASHMIKANT",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH CODE": "AHME007",
      "BRANCH": "AHMEDABAD",
      "REGION CODE": "RO0005",
      "REGION": "GUJARAT",
      "ZONE CODE": "ZO0002",
      "ZONE": "WEST",
      "Reporting Manager Code": "MO1194",
      "Reporting Manager Name": "SHAIKH MUKHTYAR",
      "DSGN_NAME_2": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA03934",
      "NAME": "VIJAYPAL SINGH RAJPUT",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH CODE": "BHOP013",
      "BRANCH": "BHOPAL",
      "REGION CODE": "RO0004",
      "REGION": "MADHYA PRADESH",
      "ZONE CODE": "ZO0002",
      "ZONE": "WEST",
      "Reporting Manager Code": "MO1625",
      "Reporting Manager Name": "Mohd Khan",
      "DSGN_NAME_2": "SALES MANAGER"
    },
    {
      "EMP_CODE": "FA03929",
      "NAME": "SHIVANI KUSHWAHA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH CODE": "BHOP013",
      "BRANCH": "BHOPAL",
      "REGION CODE": "RO0004",
      "REGION": "MADHYA PRADESH",
      "ZONE CODE": "ZO0002",
      "ZONE": "WEST",
      "Reporting Manager Code": "MO1625",
      "Reporting Manager Name": "Mohd Khan",
      "DSGN_NAME_2": "SALES MANAGER"
    },
    {
      "EMP_CODE": "FA03930",
      "NAME": "CHANDA RAMASHARY YADAV",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH CODE": "THAN037",
      "BRANCH": "MUMBAI - THANE",
      "REGION CODE": "RO0002",
      "REGION": "MUMBAI",
      "ZONE CODE": "ZO0002",
      "ZONE": "WEST",
      "Reporting Manager Code": "MO1444",
      "Reporting Manager Name": "SANDEEP SAR",
      "DSGN_NAME_2": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA03936",
      "NAME": "IRFAAN ANISH SHEIKH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH CODE": "NAGP010",
      "BRANCH": "NAGPUR",
      "REGION CODE": "RO0003",
      "REGION": "ROM",
      "ZONE CODE": "ZO0002",
      "ZONE": "WEST",
      "Reporting Manager Code": "MO1610",
      "Reporting Manager Name": "SHAIKH ISMAIL",
      "DSGN_NAME_2": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA03935",
      "NAME": "KIRAN LAXMAN SHINGARE",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH CODE": "KOLH009",
      "BRANCH": "KOLHAPUR",
      "REGION CODE": "RO0003",
      "REGION": "ROM",
      "ZONE CODE": "ZO0002",
      "ZONE": "WEST",
      "Reporting Manager Code": "MO1464",
      "Reporting Manager Name": "AMIT PITAKE",
      "DSGN_NAME_2": "SALES MANAGER"
    }
  ];


  List<Map<String, dynamic>> dsaName = [
    {"id": "1014", "title": "WEALTHVALLEY INSURANCE MARKETING PRIVATE LIMITED"},
    {"id": "1015", "title": "AURA I SOLUTION"},
    {"id": "1016", "title": "DK ASSOCIATES"},
    {"id": "1017", "title": "Kashvi Sales and Distribution Pvt Ltd."},
    {"id": "1020", "title": "NEERACHI TECHNOLOGIES Pvt. Ltd"},
    {"id": "1021", "title": "Y S S DIRECT CREDIT  Pvt. Ltd"},
    {"id": "1022", "title": "SIDDHI IMAGINE FINTECH CONSULTANCY PRIVATE LIMITED"},
    {"id": "1023", "title": "S M ENTERPRISES"},
    {"id": "1024", "title": "SHREE FINANCE"},
    {"id": "1025", "title": "ACE EQUITY SOLUTIONS Pvt. Ltd."}
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
        .collection("employeeMapping")
        .doc("employeeMapping")
        .set({
      "employeeMapping": FieldValue.arrayUnion(employeeMapping)
    }, SetOptions(merge: true));
    print("hi");
  }

  @override
  Widget build(BuildContext context) {
   pushData();

    return Container();
  }


}
