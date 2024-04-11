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
      "EMP_CODE": "FA03510",
      "NAME": "BATADA SALONI RAFIKALI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH CODE": "SURE066",
      "BRANCH": "SURENDRANAGAR",
      "REGION CODE": "RO0005",
      "REGION": "GUJARAT",
      "Reporting Manager Code": "MO1408",
      "Reporting Manager Name": "SHAILESH VANARA",
      "Reporting DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA03846",
      "NAME": "HARSHIT SARATHE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH CODE": "BHOP013",
      "BRANCH": "BHOPAL",
      "REGION CODE": "RO0004",
      "REGION": "MADHYA PRADESH",
      "Reporting Manager Code": "MO1625",
      "Reporting Manager Name": "Mohd Khan",
      "Reporting DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA03060",
      "NAME": "AMOL DILIP SANAP",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH CODE": "PUNE003",
      "BRANCH": "PUNE",
      "REGION CODE": "RO0003",
      "REGION": "ROM",
      "Reporting Manager Code": "MO1435",
      "Reporting Manager Name": "RAVINDRA INGAWALE",
      "Reporting DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA03298",
      "NAME": "NIRAV ASHOKKUMAR JANI",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH CODE": "SURE066",
      "BRANCH": "SURENDRANAGAR",
      "REGION CODE": "RO0005",
      "REGION": "GUJARAT",
      "Reporting Manager Code": "MO1408",
      "Reporting Manager Name": "SHAILESH VANARA",
      "Reporting DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA02904",
      "NAME": "BAHADUR CHOUHAN",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH CODE": "KOTA015",
      "BRANCH": "KOTA",
      "REGION CODE": "RO0006",
      "REGION": "RAJASTHAN",
      "Reporting Manager Code": "MO1557",
      "Reporting Manager Name": "UMMED SINGH",
      "Reporting DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA03791",
      "NAME": "PARMAR SHYAM",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH CODE": "JAMN067",
      "BRANCH": "JAMNAGAR",
      "REGION CODE": "RO0005",
      "REGION": "GUJARAT",
      "Reporting Manager Code": "MO1408",
      "Reporting Manager Name": "SHAILESH VANARA",
      "Reporting DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA03836",
      "NAME": "KULDEEP SEN",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH CODE": "SHIV026",
      "BRANCH": "GWALIOR - SHIVPURI",
      "REGION CODE": "RO0004",
      "REGION": "MADHYA PRADESH",
      "Reporting Manager Code": "MO1197",
      "Reporting Manager Name": "CHAYAN KUMAR",
      "Reporting DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA03837",
      "NAME": "JADAV SANJAYBHAI BATUKBHAI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH CODE": "SURE066",
      "BRANCH": "SURENDRANAGAR",
      "REGION CODE": "RO0005",
      "REGION": "GUJARAT",
      "Reporting Manager Code": "MO1408",
      "Reporting Manager Name": "SHAILESH VANARA",
      "Reporting DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA03009",
      "NAME": "VAGHELA HITESH DHANSUKHBHAI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH CODE": "JUNA042",
      "BRANCH": "JUNAGADH",
      "REGION CODE": "RO0005",
      "REGION": "GUJARAT",
      "Reporting Manager Code": "MO1408",
      "Reporting Manager Name": "SHAILESH VANARA",
      "Reporting DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA03727",
      "NAME": "AVINASH RAJARAM KAMBLE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH CODE": "SANG095",
      "BRANCH": "SANGLI",
      "REGION CODE": "RO0003",
      "REGION": "ROM",
      "Reporting Manager Code": "MO1600",
      "Reporting Manager Name": "JITENDRA VARALE",
      "Reporting DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA03620",
      "NAME": "BRAJESH SEN",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH CODE": "SHIV026",
      "BRANCH": "GWALIOR - SHIVPURI",
      "REGION CODE": "RO0004",
      "REGION": "MADHYA PRADESH",
      "Reporting Manager Code": "MO1197",
      "Reporting Manager Name": "CHAYAN KUMAR",
      "Reporting DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA03628",
      "NAME": "SATVIR SINGH",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH CODE": "LUDH074",
      "BRANCH": "LUDHIANA",
      "REGION CODE": "RO0008",
      "REGION": "PCH",
      "Reporting Manager Code": "MO1320",
      "Reporting Manager Name": "Pawan Kumar",
      "Reporting DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA03797",
      "NAME": "SHIVAM PANDAY",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH CODE": "LUCK078",
      "BRANCH": "LUCKNOW",
      "REGION CODE": "RO0012",
      "REGION": "UTTAR PRADESH",
      "Reporting Manager Code": "MO1633",
      "Reporting Manager Name": "RAMESH P",
      "Reporting DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA02497",
      "NAME": "SAGAR NANAJI WAGH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH CODE": "PUNE003",
      "BRANCH": "PUNE",
      "REGION CODE": "RO0003",
      "REGION": "ROM",
      "Reporting Manager Code": "MO0922",
      "Reporting Manager Name": "Chandrakant Mhase",
      "Reporting DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA03734",
      "NAME": "BRAHMA PRAKASH SRIVASTAVA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH CODE": "KANP018",
      "BRANCH": "KANPUR",
      "REGION CODE": "RO0012",
      "REGION": "UTTAR PRADESH",
      "Reporting Manager Code": "MO1633",
      "Reporting Manager Name": "RAMESH P",
      "Reporting DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA02023",
      "NAME": "BABASAHEB DATTATRAY BHALERAO",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH CODE": "PUNE003",
      "BRANCH": "PUNE",
      "REGION CODE": "RO0003",
      "REGION": "ROM",
      "Reporting Manager Code": "MO0922",
      "Reporting Manager Name": "Chandrakant Mhase",
      "Reporting DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA03897",
      "NAME": "PRASAD SURESH PALKAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH CODE": "PANV038",
      "BRANCH": "NAVI MUMBAI - PANVEL",
      "REGION CODE": "RO0002",
      "REGION": "MUMBAI",
      "Reporting Manager Code": "MO1577",
      "Reporting Manager Name": "RADHESHYAM DUBEY",
      "Reporting DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA03903",
      "NAME": "ANEESH K M",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH CODE": "THRI034",
      "BRANCH": "THRISSUR",
      "REGION CODE": "RO0001",
      "REGION": "KERALA",
      "Reporting Manager Code": "MO1548",
      "Reporting Manager Name": "SIBI R",
      "Reporting DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA03904",
      "NAME": "DINKAR SHANKAR GADUGALE",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH CODE": "PANV038",
      "BRANCH": "NAVI MUMBAI - PANVEL",
      "REGION CODE": "RO0002",
      "REGION": "MUMBAI",
      "Reporting Manager Code": "MO1577",
      "Reporting Manager Name": "RADHESHYAM DUBEY",
      "Reporting DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA03898",
      "NAME": "AGRAVAT YAGNIK ASHWINBHAI",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH CODE": "JUNA042",
      "BRANCH": "JUNAGADH",
      "REGION CODE": "RO0005",
      "REGION": "GUJARAT",
      "Reporting Manager Code": "MO1408",
      "Reporting Manager Name": "SHAILESH VANARA",
      "Reporting DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA03901",
      "NAME": "VIRENDRA PRATAP SINGH",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH CODE": "VARA052",
      "BRANCH": "VARANASI",
      "REGION CODE": "RO0012",
      "REGION": "UTTAR PRADESH",
      "Reporting Manager Code": "MO1460",
      "Reporting Manager Name": "TRISHANT MISHRA",
      "Reporting DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA03906",
      "NAME": "VINOD SHRIVASTAV",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH CODE": "BHOP013",
      "BRANCH": "BHOPAL",
      "REGION CODE": "RO0004",
      "REGION": "MADHYA PRADESH",
      "Reporting Manager Code": "MO1625",
      "Reporting Manager Name": "Mohd Khan",
      "Reporting DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MA03900",
      "NAME": "SHIVAKUMAR S",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH CODE": "RAMN093",
      "BRANCH": "RAMNAGARA",
      "REGION CODE": "RO0010",
      "REGION": "KARNATAKA",
      "Reporting Manager Code": "MO1594",
      "Reporting Manager Name": "DHARMA HG",
      "Reporting DESIGNATION": "SALES MANAGER"
    }
  ];

  List<Map<String, dynamic>> documentList = [
    {"id": 1, "title": "Application Form"},
    {"id": 2, "title": "Bank Passbook(Latest 6 months)"},
    {"id": 3, "title": "Date of Birth Proof"},
    {"id": 4, "title": "Login Fee Cheque"},
    {"id": 5, "title": "Passport Size Color Photograph"},
    {"id": 6, "title": "Photo ID Proof"},
    {"id": 7, "title": "Residence Proof"},
    {"id": 8, "title": "Salary Slip 3 Month"},
    {"id": 9, "title": "Signature Proof"},
    {"id": 10, "title": "Copy of Property"},
    {"id": 11, "title": "Qualification proof"},
    {"id": 12, "title": "Sector Employee From 16 for Pvt"},
    {"id": 13, "title": "Total Work Experience Proof(Min 3 years)"},
    {"id": 14, "title": "Work Experience Proof(1 years)"},
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
