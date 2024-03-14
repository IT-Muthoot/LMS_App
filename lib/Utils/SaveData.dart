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
  List<Map<String, dynamic>> employeeList = [
    {
      "EMP_CODE": "MA02521",
      "NAME": "DHANANJAY PAL",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "ALLAHABAD",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "ALLA054"
    },
    {
      "EMP_CODE": "MA02444",
      "NAME": "ANURAG SHUKLA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "ALLAHABAD",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "ALLA054"
    },
    {
      "EMP_CODE": "MA03097",
      "NAME": "YATHARTH GAUTAM",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "LUCKNOW",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "LUCK078"
    },
    {
      "EMP_CODE": "MA03098",
      "NAME": "ARUN KUMAR SINGH",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "LUCKNOW",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "LUCK078"
    },
    {
      "EMP_CODE": "FA03606",
      "NAME": "MANSI OMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KANPUR",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "KANP018"
    },
    {
      "EMP_CODE": "MA03183",
      "NAME": "ABHISHEK MISHRA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "LUCKNOW",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "LUCK078"
    },
    {
      "EMP_CODE": "MA03277",
      "NAME": "DEEPAK PANDEY",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "ALLAHABAD",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "ALLA054"
    },
    {
      "EMP_CODE": "MA03325",
      "NAME": "RAJAT MISHRA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "LUCKNOW",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "LUCK078"
    },
    {
      "EMP_CODE": "MA03243",
      "NAME": "SAURABH MISHRA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "ALLAHABAD",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "ALLA054"
    },
    {
      "EMP_CODE": "MA03418",
      "NAME": "SHIVAM SINGH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KANPUR",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "KANP018"
    },
    {
      "EMP_CODE": "MA03530",
      "NAME": "NARENDRA SINGH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KANPUR",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "KANP018"
    },
    {
      "EMP_CODE": "MA03399",
      "NAME": "ADITYA KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KANPUR",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "KANP018"
    },
    {
      "EMP_CODE": "MA03012",
      "NAME": "SUDHAKAR AWASTHI",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "KANPUR",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "KANP018"
    },
    {
      "EMP_CODE": "MA03741",
      "NAME": "ROHIT VISHWAKARMA",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "ALLAHABAD",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "ALLA054"
    },
    {
      "EMP_CODE": "MA03466",
      "NAME": "RANJEET KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KANPUR",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "KANP018"
    },
    {
      "EMP_CODE": "MA03487",
      "NAME": "VIJAY UPADHYAY",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KANPUR",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "KANP018"
    },
    {
      "EMP_CODE": "MA03761",
      "NAME": "AMBRISH KUMAR TRIPATHI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "ALLAHABAD",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "ALLA054"
    },
    {
      "EMP_CODE": "MA03632",
      "NAME": "ATUL KUMAR TIWARI",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "KANPUR",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "KANP018"
    },
    {
      "EMP_CODE": "MA02845",
      "NAME": "AWDHESH PRATAP SINGH",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "ALLAHABAD",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "ALLA054"
    },
    {
      "EMP_CODE": "MA03332",
      "NAME": "INDER PAL SINGH",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "LUCKNOW",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "LUCK078"
    },
    {
      "EMP_CODE": "MA03707",
      "NAME": "TARAN CHANDRA SINGH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "ALLAHABAD",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "ALLA054"
    },
    {
      "EMP_CODE": "MA03703",
      "NAME": "ARPAN KUMAR MISHRA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "VARANASI",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "VARA052"
    },
    {
      "EMP_CODE": "MA03797",
      "NAME": "SHIVAM PANDAY",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "LUCKNOW",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "LUCK078"
    },
    {
      "EMP_CODE": "MA03534",
      "NAME": "UTKARSH SHARMA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KANPUR",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "KANP018"
    },
    {
      "EMP_CODE": "MA03214",
      "NAME": "ANSHU SINGH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "LUCKNOW",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "LUCK078"
    },
    {
      "EMP_CODE": "MA03117",
      "NAME": "AKASH TIWARI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "LUCKNOW",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "LUCK078"
    },
    {
      "EMP_CODE": "MA03446",
      "NAME": "DIVYA SINGH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "VARANASI",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "VARA052"
    },
    {
      "EMP_CODE": "MA03545",
      "NAME": "BALJEET KASHYAP",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "LUCKNOW",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "LUCK078"
    },
    {
      "EMP_CODE": "MA03734",
      "NAME": "BRAHMA PRAKASH SRIVASTAVA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KANPUR",
      "REGION": "UTTAR PRADESH",
      "BRANCH CODE": "KANP018"
    },
    {
      "EMP_CODE": "MA03147",
      "NAME": "PARMINDER SINGH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "BATHINDA",
      "REGION": "PCH",
      "BRANCH CODE": "BATH089"
    },
    {
      "EMP_CODE": "MA03104",
      "NAME": "BALJEET SINGH",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "BATHINDA",
      "REGION": "PCH",
      "BRANCH CODE": "BATH089"
    },
    {
      "EMP_CODE": "MA02494",
      "NAME": "MUKESH KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "HISAR",
      "REGION": "PCH",
      "BRANCH CODE": "HISA062"
    },
    {
      "EMP_CODE": "MA03319",
      "NAME": "INDER JEET",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "SIRSA",
      "REGION": "PCH",
      "BRANCH CODE": "SIRS090"
    },
    {
      "EMP_CODE": "MA03478",
      "NAME": "ANKUSH GUPTA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KAITHAL",
      "REGION": "PCH",
      "BRANCH CODE": "KAIT091"
    },
    {
      "EMP_CODE": "MA03393",
      "NAME": "UTSAV MADAAN",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "LUDHIANA",
      "REGION": "PCH",
      "BRANCH CODE": "LUDH074"
    },
    {
      "EMP_CODE": "MA03633",
      "NAME": "RAHUL .",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "ROHTAK",
      "REGION": "PCH",
      "BRANCH CODE": "ROHT094"
    },
    {
      "EMP_CODE": "MA03234",
      "NAME": "SONU .",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "YAMUNANAGAR",
      "REGION": "PCH",
      "BRANCH CODE": "YAMU057"
    },
    {
      "EMP_CODE": "MA03524",
      "NAME": "KULDEEP SINGH",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "SIRSA",
      "REGION": "PCH",
      "BRANCH CODE": "SIRS090"
    },
    {
      "EMP_CODE": "MA03464",
      "NAME": "GAURAV SHARMA",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "KAITHAL",
      "REGION": "PCH",
      "BRANCH CODE": "KAIT091"
    },
    {
      "EMP_CODE": "MA02915",
      "NAME": "VINIT KUMAR",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "YAMUNANAGAR",
      "REGION": "PCH",
      "BRANCH CODE": "YAMU057"
    },
    {
      "EMP_CODE": "MA03180",
      "NAME": "SUNIL KUMAR",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "HISAR",
      "REGION": "PCH",
      "BRANCH CODE": "HISA062"
    },
    {
      "EMP_CODE": "MA03140",
      "NAME": "SANDEEP KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "LUDHIANA",
      "REGION": "PCH",
      "BRANCH CODE": "LUDH074"
    },
    {
      "EMP_CODE": "MA03281",
      "NAME": "PARVEEN .",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "HISAR",
      "REGION": "PCH",
      "BRANCH CODE": "HISA062"
    },
    {
      "EMP_CODE": "MA03202",
      "NAME": "RAJAT MIDHA",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "SIRSA",
      "REGION": "PCH",
      "BRANCH CODE": "SIRS090"
    },
    {
      "EMP_CODE": "MA03182",
      "NAME": "MOHIT MITAL",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "SIRSA",
      "REGION": "PCH",
      "BRANCH CODE": "SIRS090"
    },
    {
      "EMP_CODE": "MA03184",
      "NAME": "SOHAN LAL",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "YAMUNANAGAR",
      "REGION": "PCH",
      "BRANCH CODE": "YAMU057"
    },
    {
      "EMP_CODE": "MA03121",
      "NAME": "SUNDER .",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "HISAR",
      "REGION": "PCH",
      "BRANCH CODE": "HISA062"
    },
    {
      "EMP_CODE": "MA03169",
      "NAME": "MOHAN LAL",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "SIRSA",
      "REGION": "PCH",
      "BRANCH CODE": "SIRS090"
    },
    {
      "EMP_CODE": "MA03352",
      "NAME": "HARINDER SINGH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "CHANDIGARH",
      "REGION": "PCH",
      "BRANCH CODE": "CHAN057"
    },
    {
      "EMP_CODE": "MA03372",
      "NAME": "GAGANDEEP SINGH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "CHANDIGARH",
      "REGION": "PCH",
      "BRANCH CODE": "CHAN057"
    },
    {
      "EMP_CODE": "MA03350",
      "NAME": "RAMAN KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "SIRSA",
      "REGION": "PCH",
      "BRANCH CODE": "SIRS090"
    },
    {
      "EMP_CODE": "MA02995",
      "NAME": "VEER SINGH",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "CHANDIGARH",
      "REGION": "PCH",
      "BRANCH CODE": "CHAN057"
    },
    {
      "EMP_CODE": "MA03330",
      "NAME": "AMIT KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "HISAR",
      "REGION": "PCH",
      "BRANCH CODE": "HISA062"
    },
    {
      "EMP_CODE": "MA03519",
      "NAME": "SATINDER DHALIWAL",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "PATIALA",
      "REGION": "PCH",
      "BRANCH CODE": "PATI077"
    },
    {
      "EMP_CODE": "MA03733",
      "NAME": "SANDEEP KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "CHANDIGARH",
      "REGION": "PCH",
      "BRANCH CODE": "CHAN057"
    },
    {
      "EMP_CODE": "MA03764",
      "NAME": "ANIL KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "ROHTAK",
      "REGION": "PCH",
      "BRANCH CODE": "ROHT094"
    },
    {
      "EMP_CODE": "MA03691",
      "NAME": "RAJ KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "BATHINDA",
      "REGION": "PCH",
      "BRANCH CODE": "BATH089"
    },
    {
      "EMP_CODE": "MA03732",
      "NAME": "MUKESH KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KARNAL",
      "REGION": "PCH",
      "BRANCH CODE": "KARN064"
    },
    {
      "EMP_CODE": "MA03681",
      "NAME": "BHARAT .",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "HISAR",
      "REGION": "PCH",
      "BRANCH CODE": "HISA062"
    },
    {
      "EMP_CODE": "MA03705",
      "NAME": "ABHISHEK KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "GURUGRAM",
      "REGION": "DNCR",
      "BRANCH CODE": "GURU081"
    },
    {
      "EMP_CODE": "MA03772",
      "NAME": "PRASHANT TAILOR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "GURUGRAM",
      "REGION": "DNCR",
      "BRANCH CODE": "GURU081"
    },
    {
      "EMP_CODE": "MA03193",
      "NAME": "VINAY KUMAR",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "CHANDIGARH",
      "REGION": "PCH",
      "BRANCH CODE": "CHAN057"
    },
    {
      "EMP_CODE": "MA02498",
      "NAME": "SAHIL .",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "LUDHIANA",
      "REGION": "PCH",
      "BRANCH CODE": "LUDH074"
    },
    {
      "EMP_CODE": "MA03434",
      "NAME": "RAJU .",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "HISAR",
      "REGION": "PCH",
      "BRANCH CODE": "HISA062"
    },
    {
      "EMP_CODE": "MA03449",
      "NAME": "SURINDER KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "CHANDIGARH",
      "REGION": "PCH",
      "BRANCH CODE": "CHAN057"
    },
    {
      "EMP_CODE": "MA03556",
      "NAME": "SANDEEP KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KAITHAL",
      "REGION": "PCH",
      "BRANCH CODE": "KAIT091"
    },
    {
      "EMP_CODE": "MA03628",
      "NAME": "SATVIR SINGH",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "LUDHIANA",
      "REGION": "PCH",
      "BRANCH CODE": "LUDH074"
    },
    {
      "EMP_CODE": "MA03629",
      "NAME": "BHOOP SINGH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "HISAR",
      "REGION": "PCH",
      "BRANCH CODE": "HISA062"
    },
    {
      "EMP_CODE": "MA03213",
      "NAME": "ANIL .",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KAITHAL",
      "REGION": "PCH",
      "BRANCH CODE": "KAIT091"
    },
    {
      "EMP_CODE": "MA02738",
      "NAME": "KAWALJIT SINGH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "PATIALA",
      "REGION": "PCH",
      "BRANCH CODE": "PATI077"
    },
    {
      "EMP_CODE": "MA03495",
      "NAME": "TARUN BHATIA",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "PATIALA",
      "REGION": "PCH",
      "BRANCH CODE": "PATI077"
    },
    {
      "EMP_CODE": "MA03543",
      "NAME": "MANISH .",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "GURUGRAM",
      "REGION": "DNCR",
      "BRANCH CODE": "GURU081"
    },
    {
      "EMP_CODE": "MA03665",
      "NAME": "PARMOD KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KAITHAL",
      "REGION": "PCH",
      "BRANCH CODE": "KAIT091"
    },
    {
      "EMP_CODE": "MA03258",
      "NAME": "DEEPAK GUPTA",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "BATHINDA",
      "REGION": "PCH",
      "BRANCH CODE": "BATH089"
    },
    {
      "EMP_CODE": "MA03270",
      "NAME": "VINOD KUMAR BHAT",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "AJMER",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "AJME022"
    },
    {
      "EMP_CODE": "MA03442",
      "NAME": "GYANENDRA SINGH",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "JAIPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "JAIP006"
    },
    {
      "EMP_CODE": "MA02525",
      "NAME": "PANKAJ SAINI",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "SIKAR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "SIKA047"
    },
    {
      "EMP_CODE": "MA02620",
      "NAME": "MAHENDRA BALAI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "BHILWARA",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "BHIL024"
    },
    {
      "EMP_CODE": "MA03506",
      "NAME": "NARESH KUMAR SAINI",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "SIKAR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "SIKA047"
    },
    {
      "EMP_CODE": "MA03037",
      "NAME": "SUBHASH CHANDRA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "AJMER",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "AJME022"
    },
    {
      "EMP_CODE": "MA03778",
      "NAME": "RAHUL KUMAR SHARMA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "JAIPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "JAIP006"
    },
    {
      "EMP_CODE": "MA03656",
      "NAME": "KULDEEP SINGH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "JODHPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "JODH014"
    },
    {
      "EMP_CODE": "MA03742",
      "NAME": "RAJVEER JAT",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "ALWAR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "ALWA012"
    },
    {
      "EMP_CODE": "MA03070",
      "NAME": "RAHUL JOSHI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "AJMER",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "AJME022"
    },
    {
      "EMP_CODE": "MA03390",
      "NAME": "YASHWANT DABKIYA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "BHILWARA",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "BHIL024"
    },
    {
      "EMP_CODE": "FA03413",
      "NAME": "SANJU RANI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "JAIPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "JAIP006"
    },
    {
      "EMP_CODE": "FA03392",
      "NAME": "AMREEN IQBAL",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "JAIPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "JAIP006"
    },
    {
      "EMP_CODE": "MA03394",
      "NAME": "MAHENDRA SUNDA",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "JAIPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "JAIP006"
    },
    {
      "EMP_CODE": "MA03198",
      "NAME": "ANIL PAREEK",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "JAIPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "JAIP006"
    },
    {
      "EMP_CODE": "MA03497",
      "NAME": "BHUPENDRA SEN",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "BHILWARA",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "BHIL024"
    },
    {
      "EMP_CODE": "MA03507",
      "NAME": "NEERAJ KUMAR YADAV",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "JAIPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "JAIP006"
    },
    {
      "EMP_CODE": "MA03141",
      "NAME": "RAJESH KUMAR MEENA",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "JAIPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "JAIP006"
    },
    {
      "EMP_CODE": "MA02854",
      "NAME": "ASHOK KUMAWAT",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "JAIPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "JAIP006"
    },
    {
      "EMP_CODE": "MA02921",
      "NAME": "VIKAS KUMAR SAINI",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "JAIPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "JAIP006"
    },
    {
      "EMP_CODE": "MA02887",
      "NAME": "DEEPAK YADAV",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "JAIPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "JAIP006"
    },
    {
      "EMP_CODE": "MA02904",
      "NAME": "BAHADUR CHOUHAN",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KOTA",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "KOTA015"
    },
    {
      "EMP_CODE": "MA03561",
      "NAME": "JAIRAJ SINGH SHAKTAWAT",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "UDAIPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "UDAI025"
    },
    {
      "EMP_CODE": "MA03549",
      "NAME": "ABHISHEK SEN",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "JODHPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "JODH014"
    },
    {
      "EMP_CODE": "MA03650",
      "NAME": "DINESH KUMAR",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "KOTA",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "KOTA015"
    },
    {
      "EMP_CODE": "MA03640",
      "NAME": "HARSH SHRIMALI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "UDAIPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "UDAI025"
    },
    {
      "EMP_CODE": "MA03695",
      "NAME": "AJRUDEEN KATHAT",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "AJMER",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "AJME022"
    },
    {
      "EMP_CODE": "MA03706",
      "NAME": "SATYA PRAKASH SUMAN",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KOTA",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "KOTA015"
    },
    {
      "EMP_CODE": "MA03639",
      "NAME": "DAMODAR PAREEK",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "JODHPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "JODH014"
    },
    {
      "EMP_CODE": "MA03368",
      "NAME": "ANURAG BIKHIWAL",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "SIKAR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "SIKA047"
    },
    {
      "EMP_CODE": "MA02835",
      "NAME": "ABHINANDAN SONI",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "JAIPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "JAIP006"
    },
    {
      "EMP_CODE": "MA03436",
      "NAME": "GAJRAJ SINGH RAJPUT",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "BHILWARA",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "BHIL024"
    },
    {
      "EMP_CODE": "MA03746",
      "NAME": "PRIYAVRAT SINGH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "JAIPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "JAIP006"
    },
    {
      "EMP_CODE": "MA02676",
      "NAME": "YOGESH KUMAR SWALKYA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "ALWAR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "ALWA012"
    },
    {
      "EMP_CODE": "MA02317",
      "NAME": "DIVAKAR SHARMA",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "ALWAR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "ALWA012"
    },
    {
      "EMP_CODE": "MA03142",
      "NAME": "NAVEEN TUNDWAL",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "AJMER",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "AJME022"
    },
    {
      "EMP_CODE": "MA03502",
      "NAME": "SETHA RAM DEORA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "JODHPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "JODH014"
    },
    {
      "EMP_CODE": "MA02806",
      "NAME": "RAMAVATAR TAMOLI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "JAIPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "JAIP006"
    },
    {
      "EMP_CODE": "MA03457",
      "NAME": "SURESH CHAND MEENA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "ALWAR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "ALWA012"
    },
    {
      "EMP_CODE": "MA03388",
      "NAME": "KASHISH MALIK",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "ALWAR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "ALWA012"
    },
    {
      "EMP_CODE": "MA03756",
      "NAME": "MAYANK GURJAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "JODHPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "JODH014"
    },
    {
      "EMP_CODE": "MA03637",
      "NAME": "PUNIT DAVE",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "JODHPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "JODH014"
    },
    {
      "EMP_CODE": "MA03257",
      "NAME": "RAJ KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "BHILWARA",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "BHIL024"
    },
    {
      "EMP_CODE": "MA03722",
      "NAME": "SAURABH CHOPRA",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "JAIPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "JAIP006"
    },
    {
      "EMP_CODE": "MA03777",
      "NAME": "AJAY MENARIA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "UDAIPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "UDAI025"
    },
    {
      "EMP_CODE": "MA03616",
      "NAME": "DEEPAK .",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KOTA",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "KOTA015"
    },
    {
      "EMP_CODE": "MA03389",
      "NAME": "PRABHU LAL JAT",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "BHILWARA",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "BHIL024"
    },
    {
      "EMP_CODE": "MA02662",
      "NAME": "RAM LAL JAT",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "BHILWARA",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "BHIL024"
    },
    {
      "EMP_CODE": "MA03723",
      "NAME": "HARSHIT ACHARYA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "BHILWARA",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "BHIL024"
    },
    {
      "EMP_CODE": "MA03803",
      "NAME": "VIKRAM SINGH RAJPUT",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "ALWAR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "ALWA012"
    },
    {
      "EMP_CODE": "MA03801",
      "NAME": "VINIT SHUKLA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "JAIPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "JAIP006"
    },
    {
      "EMP_CODE": "MA03822",
      "NAME": "JITENDRA ROJ",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "JAIPUR",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "JAIP006"
    },
    {
      "EMP_CODE": "MA03802",
      "NAME": "VIKAS TEJI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KOTA",
      "REGION": "RAJASTHAN",
      "BRANCH CODE": "KOTA015"
    },
    {
      "EMP_CODE": "MA02957",
      "NAME": "MANEESH KUMAR BHARDWAJ",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "Delhi",
      "REGION": "DNCR",
      "BRANCH CODE": "DELH083"
    },
    {
      "EMP_CODE": "MA03138",
      "NAME": "INDRA NARAYAN SHUKLA",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "NOIDA",
      "REGION": "DNCR",
      "BRANCH CODE": "NOID058"
    },
    {
      "EMP_CODE": "MA03357",
      "NAME": "VISHAL SHARMA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NOIDA",
      "REGION": "DNCR",
      "BRANCH CODE": "NOID058"
    },
    {
      "EMP_CODE": "MA03600",
      "NAME": "MANOJ KUMAR",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "GHAZIABAD",
      "REGION": "DNCR",
      "BRANCH CODE": "GHAZ056"
    },
    {
      "EMP_CODE": "MA03591",
      "NAME": "ROHIT KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "FARIDABAD",
      "REGION": "DNCR",
      "BRANCH CODE": "FARI055"
    },
    {
      "EMP_CODE": "MA03317",
      "NAME": "SAURAV KUMAR",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "FARIDABAD",
      "REGION": "DNCR",
      "BRANCH CODE": "FARI055"
    },
    {
      "EMP_CODE": "MA03404",
      "NAME": "ANURUDH KUMAR RAWAT",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "NOIDA",
      "REGION": "DNCR",
      "BRANCH CODE": "NOID058"
    },
    {
      "EMP_CODE": "MA03162",
      "NAME": "ANKIT RANA",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "NOIDA",
      "REGION": "DNCR",
      "BRANCH CODE": "NOID058"
    },
    {
      "EMP_CODE": "MA03108",
      "NAME": "SANJEEV KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NOIDA",
      "REGION": "DNCR",
      "BRANCH CODE": "NOID058"
    },
    {
      "EMP_CODE": "MA03592",
      "NAME": "KAILASH .",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "FARIDABAD",
      "REGION": "DNCR",
      "BRANCH CODE": "FARI055"
    },
    {
      "EMP_CODE": "MA03757",
      "NAME": "GAURAV .",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "GHAZIABAD",
      "REGION": "DNCR",
      "BRANCH CODE": "GHAZ056"
    },
    {
      "EMP_CODE": "MA03767",
      "NAME": "MAHENDRA PRATAP KUSHWAHA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "Delhi",
      "REGION": "DNCR",
      "BRANCH CODE": "DELH083"
    },
    {
      "EMP_CODE": "MA03660",
      "NAME": "ISHANT TYAGI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NOIDA",
      "REGION": "DNCR",
      "BRANCH CODE": "NOID058"
    },
    {
      "EMP_CODE": "MA03264",
      "NAME": "SANDEEP GIRI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "Delhi",
      "REGION": "DNCR",
      "BRANCH CODE": "DELH083"
    },
    {
      "EMP_CODE": "MA03127",
      "NAME": "ABHILASH KUMAR MISHRA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "Delhi",
      "REGION": "DNCR",
      "BRANCH CODE": "DELH083"
    },
    {
      "EMP_CODE": "MA03452",
      "NAME": "JEETU .",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "NOIDA",
      "REGION": "DNCR",
      "BRANCH CODE": "NOID058"
    },
    {
      "EMP_CODE": "MA03174",
      "NAME": "VIKAS KUMAR",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "NOIDA",
      "REGION": "DNCR",
      "BRANCH CODE": "NOID058"
    },
    {
      "EMP_CODE": "MA03314",
      "NAME": "AMRENDRA KUMAR JHA",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "NOIDA",
      "REGION": "DNCR",
      "BRANCH CODE": "NOID058"
    },
    {
      "EMP_CODE": "MA03594",
      "NAME": "DHIRENDER KUMAR JHA",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "Delhi",
      "REGION": "DNCR",
      "BRANCH CODE": "DELH083"
    },
    {
      "EMP_CODE": "MA03476",
      "NAME": "NAGENDRA KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NOIDA",
      "REGION": "DNCR",
      "BRANCH CODE": "NOID058"
    },
    {
      "EMP_CODE": "MA03643",
      "NAME": "MURSHID SHAMIM",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "Delhi",
      "REGION": "DNCR",
      "BRANCH CODE": "DELH083"
    },
    {
      "EMP_CODE": "MA03796",
      "NAME": "PRADEEP KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "GHAZIABAD",
      "REGION": "DNCR",
      "BRANCH CODE": "GHAZ056"
    },
    {
      "EMP_CODE": "MA03740",
      "NAME": "SACHIN .",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NOIDA",
      "REGION": "DNCR",
      "BRANCH CODE": "NOID058"
    },
    {
      "EMP_CODE": "MA03396",
      "NAME": "NAND KISHOR",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "NOIDA",
      "REGION": "DNCR",
      "BRANCH CODE": "NOID058"
    },
    {
      "EMP_CODE": "MA03200",
      "NAME": "MUKESH KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NOIDA",
      "REGION": "DNCR",
      "BRANCH CODE": "NOID058"
    },
    {
      "EMP_CODE": "MA02210",
      "NAME": "SUDHIR KUMAR SHARMA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "Delhi",
      "REGION": "DNCR",
      "BRANCH CODE": "DELH083"
    },
    {
      "EMP_CODE": "MA03795",
      "NAME": "ATUL SHARMA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NOIDA",
      "REGION": "DNCR",
      "BRANCH CODE": "NOID058"
    },
    {
      "EMP_CODE": "MA02931",
      "NAME": "CHAITANYA WALVEKAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "HUBLI",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "HUBL068"
    },
    {
      "EMP_CODE": "MA03430",
      "NAME": "ANIL KUMAR N R",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MYSORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "MYSO054"
    },
    {
      "EMP_CODE": "MA02566",
      "NAME": "MANJUNATH .",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "BANGALORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "BANG053"
    },
    {
      "EMP_CODE": "MA03480",
      "NAME": "UMESH K",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "HOSUR",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "HOSU053"
    },
    {
      "EMP_CODE": "MA03568",
      "NAME": "MANJUNATHA .",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "RAMNAGARA",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "RAMN093"
    },
    {
      "EMP_CODE": "MA03718",
      "NAME": "NARENDRA GOWDA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "BANGALORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "BANG053"
    },
    {
      "EMP_CODE": "MA03521",
      "NAME": "VUPPALAPATI SUDHEER KUMAR",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "BANGALORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "BANG053"
    },
    {
      "EMP_CODE": "MA03671",
      "NAME": "MANJUNATHA M",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "DAVANAGERE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "DAVA053"
    },
    {
      "EMP_CODE": "MA03690",
      "NAME": "SANTOSH BALAKRISHNA RAMAGIRI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "BELGAUM",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "BELG052"
    },
    {
      "EMP_CODE": "MA03328",
      "NAME": "H R AJAYA KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MYSORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "MYSO054"
    },
    {
      "EMP_CODE": "MA02979",
      "NAME": "SHIVARAJU S H",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "BANGALORE-TUMKUR",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "TUMK053"
    },
    {
      "EMP_CODE": "MA02986",
      "NAME": "K N DEVARAJU",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "BANGALORE-TUMKUR",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "TUMK053"
    },
    {
      "EMP_CODE": "MA03237",
      "NAME": "SHRIDHAR T",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "MYSORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "MYSO054"
    },
    {
      "EMP_CODE": "MA03223",
      "NAME": "MOHAMMED YUSUF DAMBAL",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "HUBLI",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "HUBL068"
    },
    {
      "EMP_CODE": "MA03335",
      "NAME": "RAVIKIRAN .",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "HOSUR",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "HOSU053"
    },
    {
      "EMP_CODE": "MA03245",
      "NAME": "MAHESH NAGARAJ",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "HOSUR",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "HOSU053"
    },
    {
      "EMP_CODE": "MA03360",
      "NAME": "SHIVA SHANKAR REDDY",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "BANGALORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "BANG053"
    },
    {
      "EMP_CODE": "MA03438",
      "NAME": "SHABARISH P",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "BANGALORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "BANG053"
    },
    {
      "EMP_CODE": "MA02857",
      "NAME": "DILEEP .",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "BANGALORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "BANG053"
    },
    {
      "EMP_CODE": "MA03570",
      "NAME": "MAHESH S P",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "BANGALORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "BANG053"
    },
    {
      "EMP_CODE": "MA03505",
      "NAME": "S SOMASHEKHAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "BANGALORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "BANG053"
    },
    {
      "EMP_CODE": "MA03608",
      "NAME": "ASIF NADAF",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "HUBLI",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "HUBL068"
    },
    {
      "EMP_CODE": "MA03511",
      "NAME": "JAYANTH B N",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "BANGALORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "BANG053"
    },
    {
      "EMP_CODE": "MA03353",
      "NAME": "MANOJ DESAI",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "BELGAUM",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "BELG052"
    },
    {
      "EMP_CODE": "MA03604",
      "NAME": "VITHAL SOMAPPA LAMANI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "HUBLI",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "HUBL068"
    },
    {
      "EMP_CODE": "MA03654",
      "NAME": "RAJESH S",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "BANGALORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "BANG053"
    },
    {
      "EMP_CODE": "MA03735",
      "NAME": "SHREEDHARA B",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "DAVANAGERE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "DAVA053"
    },
    {
      "EMP_CODE": "MA03768",
      "NAME": "RAJANIKANTHA K M",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MYSORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "MYSO054"
    },
    {
      "EMP_CODE": "MA03400",
      "NAME": "VARUN D M",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "RAMNAGARA",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "RAMN093"
    },
    {
      "EMP_CODE": "MA03143",
      "NAME": "NAVEENA K B",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "DAVANAGERE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "DAVA053"
    },
    {
      "EMP_CODE": "MA03666",
      "NAME": "MANU K R",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "DAVANAGERE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "DAVA053"
    },
    {
      "EMP_CODE": "MA02899",
      "NAME": "H DAYANANDA",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "BANGALORE-TUMKUR",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "TUMK053"
    },
    {
      "EMP_CODE": "MA03634",
      "NAME": "HEMANTH KUMAR S N",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MYSORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "MYSO054"
    },
    {
      "EMP_CODE": "MA03798",
      "NAME": "GOPINATH NANDHALAPPA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "HOSUR",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "HOSU053"
    },
    {
      "EMP_CODE": "MA03038",
      "NAME": "VINAYAKA E",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "DAVANAGERE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "DAVA053"
    },
    {
      "EMP_CODE": "MA03715",
      "NAME": "M N REDDY",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "BANGALORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "BANG053"
    },
    {
      "EMP_CODE": "MA03738",
      "NAME": "DARSHAN GOWDA H",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "BANGALORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "BANG053"
    },
    {
      "EMP_CODE": "MA03154",
      "NAME": "ANILKUMAR V DALAVI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "HUBLI",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "HUBL068"
    },
    {
      "EMP_CODE": "MA03345",
      "NAME": "LAKSHMAN T",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "BANGALORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "BANG053"
    },
    {
      "EMP_CODE": "MA03426",
      "NAME": "DAYANANDA G N",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "BANGALORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "BANG053"
    },
    {
      "EMP_CODE": "MA02826",
      "NAME": "SATHISH U",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "BANGALORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "BANG053"
    },
    {
      "EMP_CODE": "MA03554",
      "NAME": "MANJUNATH GEJAPATI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "BELGAUM",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "BELG052"
    },
    {
      "EMP_CODE": "MA02749",
      "NAME": "PRAKASHA B M",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MYSORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "MYSO054"
    },
    {
      "EMP_CODE": "MA03040",
      "NAME": "MAHADEVA SWAMY D M",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "BANGALORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "BANG053"
    },
    {
      "EMP_CODE": "MA03472",
      "NAME": "SAGAR K P",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "MYSORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "MYSO054"
    },
    {
      "EMP_CODE": "MA03560",
      "NAME": "KUMAR .",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "RAMNAGARA",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "RAMN093"
    },
    {
      "EMP_CODE": "MA03082",
      "NAME": "MUTTURAJ N",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "BANGALORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "BANG053"
    },
    {
      "EMP_CODE": "MA03306",
      "NAME": "SHIVU M",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "BANGALORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "BANG053"
    },
    {
      "EMP_CODE": "MA03787",
      "NAME": "NAGAVIVEK Y",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "BANGALORE",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "BANG053"
    },
    {
      "EMP_CODE": "MA03820",
      "NAME": "VINAY IRAYYA HIREMATH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "BELGAUM",
      "REGION": "KARNATAKA",
      "BRANCH CODE": "BELG052"
    },
    {
      "EMP_CODE": "MA03207",
      "NAME": "RAMARAJAN R",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "PONDICHERRY",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "POND086"
    },
    {
      "EMP_CODE": "MA03254",
      "NAME": "RAJESHKUMAR ARJUNAN",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "SALEM",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "SALE086"
    },
    {
      "EMP_CODE": "MA02736",
      "NAME": "MURUGADAS PARANDAMAN",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "VELLORE",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "VELL086"
    },
    {
      "EMP_CODE": "MA03748",
      "NAME": "ANANTHA RAJAN GOVINTHA RAJAN",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NAGERCOIL",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "NAGE119"
    },
    {
      "EMP_CODE": "MA03529",
      "NAME": "MOHANA KARTHICK M",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "CHENNAI",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "CHEN086"
    },
    {
      "EMP_CODE": "MA03651",
      "NAME": "PERUMAL K",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "CHENNAI",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "CHEN086"
    },
    {
      "EMP_CODE": "MA03709",
      "NAME": "AJITH SWAMYDHAS",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NAGERCOIL",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "NAGE119"
    },
    {
      "EMP_CODE": "MA02659",
      "NAME": "AKILAN PARAMASIVAM",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "TIRUCHIRAPALLI",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "TIRU086"
    },
    {
      "EMP_CODE": "MA03093",
      "NAME": "SAKTHI NARAYANAN S",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "SALEM",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "SALE086"
    },
    {
      "EMP_CODE": "MA03125",
      "NAME": "D MANIKANDAN",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "PONDICHERRY",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "POND086"
    },
    {
      "EMP_CODE": "MA03236",
      "NAME": "ESAKKIDURAI M",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "TIRUNELVELI",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "TIRN086"
    },
    {
      "EMP_CODE": "MA03090",
      "NAME": "MANIKANDAN LAKSHMANAN",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "SALEM",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "SALE086"
    },
    {
      "EMP_CODE": "MA03333",
      "NAME": "VETRIVEL K",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "PONDICHERRY",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "POND086"
    },
    {
      "EMP_CODE": "MA03252",
      "NAME": "S NARESHKUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "PONDICHERRY",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "POND086"
    },
    {
      "EMP_CODE": "MA03132",
      "NAME": "GANESH THIRUPATHI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "COIMBATORE",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "COIM086"
    },
    {
      "EMP_CODE": "MA02841",
      "NAME": "SUTHAGARAN R",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "CHENNAI",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "CHEN086"
    },
    {
      "EMP_CODE": "MA03320",
      "NAME": "V PRADEEP",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "CHENNAI",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "CHEN086"
    },
    {
      "EMP_CODE": "MA03186",
      "NAME": "VENKATESH M",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "CHENNAI",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "CHEN086"
    },
    {
      "EMP_CODE": "MA03309",
      "NAME": "SURESH DELVANAYAGAM",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "CHENNAI",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "CHEN086"
    },
    {
      "EMP_CODE": "MA03300",
      "NAME": "S PRIYADHARSHAN",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "CHENNAI",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "CHEN086"
    },
    {
      "EMP_CODE": "MA02856",
      "NAME": "SATHISHKUMAR K R",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "CHENNAI",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "CHEN086"
    },
    {
      "EMP_CODE": "MA03483",
      "NAME": "THIRUMALAI R",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "COIMBATORE",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "COIM086"
    },
    {
      "EMP_CODE": "MA03489",
      "NAME": "PRATHAP R",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "SALEM",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "SALE086"
    },
    {
      "EMP_CODE": "MA03429",
      "NAME": "GOKUL .",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "COIMBATORE",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "COIM086"
    },
    {
      "EMP_CODE": "MA03544",
      "NAME": "RAMESH M",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "TIRUNELVELI",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "TIRN086"
    },
    {
      "EMP_CODE": "MA03574",
      "NAME": "KARTHIKEYAN D",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "TIRUCHIRAPALLI",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "TIRU086"
    },
    {
      "EMP_CODE": "MA03563",
      "NAME": "M VENUGOPAL",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "COIMBATORE",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "COIM086"
    },
    {
      "EMP_CODE": "MA03347",
      "NAME": "M SARANRAJ",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "PONDICHERRY",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "POND086"
    },
    {
      "EMP_CODE": "MA03164",
      "NAME": "BALA VINAYAGAM L",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "CHENNAI",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "CHEN086"
    },
    {
      "EMP_CODE": "MA03609",
      "NAME": "ARAVINDHAN .",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "PONDICHERRY",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "POND086"
    },
    {
      "EMP_CODE": "MA03774",
      "NAME": "S NELSON DEVA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "TIRUCHIRAPALLI",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "TIRU086"
    },
    {
      "EMP_CODE": "MA03697",
      "NAME": "JOHN ANDREW",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "CHENNAI",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "CHEN086"
    },
    {
      "EMP_CODE": "MA03527",
      "NAME": "RUBESH P K",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "CHENNAI",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "CHEN086"
    },
    {
      "EMP_CODE": "MA03528",
      "NAME": "S VISHNU",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "CHENNAI",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "CHEN086"
    },
    {
      "EMP_CODE": "MA03662",
      "NAME": "YOGANATHAN K",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "SALEM",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "SALE086"
    },
    {
      "EMP_CODE": "MA03694",
      "NAME": "MANIKANDAN S",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "PONDICHERRY",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "POND086"
    },
    {
      "EMP_CODE": "MA03728",
      "NAME": "PRADEEP S",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MADURAI",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "MADU086"
    },
    {
      "EMP_CODE": "MA03714",
      "NAME": "SAKTHIVEL RAJENDRAN",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "CHENNAI",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "CHEN086"
    },
    {
      "EMP_CODE": "MA03039",
      "NAME": "D ARUN KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "SALEM",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "SALE086"
    },
    {
      "EMP_CODE": "MA02702",
      "NAME": "POOVARASAN S",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "VELLORE",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "VELL086"
    },
    {
      "EMP_CODE": "MA03191",
      "NAME": "VENKATESAN A",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "CHENNAI",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "CHEN086"
    },
    {
      "EMP_CODE": "MA02824",
      "NAME": "RAJKUMAR K",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "CHENNAI",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "CHEN086"
    },
    {
      "EMP_CODE": "MA03565",
      "NAME": "VASANTHAKUMR MURUGAN",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "COIMBATORE",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "COIM086"
    },
    {
      "EMP_CODE": "MA03754",
      "NAME": "DAVID PAULSAM",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "TIRUNELVELI",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "TIRN086"
    },
    {
      "EMP_CODE": "MA03077",
      "NAME": "SANTHANAM A",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "COIMBATORE",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "COIM086"
    },
    {
      "EMP_CODE": "MA03815",
      "NAME": "AKASH M",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MADURAI",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "MADU086"
    },
    {
      "EMP_CODE": "MA03800",
      "NAME": "SURESH M",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "SALEM",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "SALE086"
    },
    {
      "EMP_CODE": "MA03812",
      "NAME": "BALASUBRAMANI M",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "MADURAI",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "MADU086"
    },
    {
      "EMP_CODE": "MA03823",
      "NAME": "MURUGAN S",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "TIRUNELVELI",
      "REGION": "TAMILNADU",
      "BRANCH CODE": "TIRN086"
    },
    {
      "EMP_CODE": "MA02270",
      "NAME": "MANU MOHANAN",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KOTTAYAM",
      "REGION": "KERALA",
      "BRANCH CODE": "KOTT028"
    },
    {
      "EMP_CODE": "MA02605",
      "NAME": "SHINU S R",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "TRIVANDRUM",
      "REGION": "KERALA",
      "BRANCH CODE": "TRIV029"
    },
    {
      "EMP_CODE": "FA02783",
      "NAME": "NEETHU G SHARMA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "ALAPPUZHA",
      "REGION": "KERALA",
      "BRANCH CODE": "ALAP033"
    },
    {
      "EMP_CODE": "FA02794",
      "NAME": "I ARCHANA",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "TRIVANDRUM",
      "REGION": "KERALA",
      "BRANCH CODE": "TRIV029"
    },
    {
      "EMP_CODE": "MA02884",
      "NAME": "RAHUL KRISHNAN U S",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "TRIVANDRUM",
      "REGION": "KERALA",
      "BRANCH CODE": "TRIV029"
    },
    {
      "EMP_CODE": "MA03190",
      "NAME": "RONY ALBERT",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "TRIVANDRUM",
      "REGION": "KERALA",
      "BRANCH CODE": "TRIV029"
    },
    {
      "EMP_CODE": "MA03473",
      "NAME": "JIJO ANTONY",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "TRIVANDRUM",
      "REGION": "KERALA",
      "BRANCH CODE": "TRIV029"
    },
    {
      "EMP_CODE": "MA03284",
      "NAME": "BAIJU A M",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "KOCHI",
      "REGION": "KERALA",
      "BRANCH CODE": "KOCH001"
    },
    {
      "EMP_CODE": "MA03212",
      "NAME": "JOSEPH BIXON FIGARADO",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KOCHI",
      "REGION": "KERALA",
      "BRANCH CODE": "KOCH001"
    },
    {
      "EMP_CODE": "MA03342",
      "NAME": "NIDHEESH V R",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "TRIVANDRUM",
      "REGION": "KERALA",
      "BRANCH CODE": "TRIV029"
    },
    {
      "EMP_CODE": "FA03447",
      "NAME": "SUCHITHRA S",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "TRIVANDRUM",
      "REGION": "KERALA",
      "BRANCH CODE": "TRIV029"
    },
    {
      "EMP_CODE": "MA03370",
      "NAME": "JIJU R",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "TRIVANDRUM",
      "REGION": "KERALA",
      "BRANCH CODE": "TRIV029"
    },
    {
      "EMP_CODE": "MA03381",
      "NAME": "GOPAN GA",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "TRIVANDRUM",
      "REGION": "KERALA",
      "BRANCH CODE": "TRIV029"
    },
    {
      "EMP_CODE": "MA03491",
      "NAME": "ARJUN N T",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KOZHIKODE",
      "REGION": "KERALA",
      "BRANCH CODE": "KOZH030"
    },
    {
      "EMP_CODE": "MA03739",
      "NAME": "GODSON K B",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "KOZHIKODE",
      "REGION": "KERALA",
      "BRANCH CODE": "KOZH030"
    },
    {
      "EMP_CODE": "MA03324",
      "NAME": "PRASANTH C M",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "KOCHI",
      "REGION": "KERALA",
      "BRANCH CODE": "KOCH001"
    },
    {
      "EMP_CODE": "MA03494",
      "NAME": "VISHNU BABU V",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KOZHIKODE",
      "REGION": "KERALA",
      "BRANCH CODE": "KOZH030"
    },
    {
      "EMP_CODE": "MA03201",
      "NAME": "AKHIL M S",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "KOTTAYAM",
      "REGION": "KERALA",
      "BRANCH CODE": "KOTT028"
    },
    {
      "EMP_CODE": "MA03676",
      "NAME": "ABHIJITH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "THRISSUR",
      "REGION": "KERALA",
      "BRANCH CODE": "THRI034"
    },
    {
      "EMP_CODE": "FA03668",
      "NAME": "STEFFY K S",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "KOCHI",
      "REGION": "KERALA",
      "BRANCH CODE": "KOCH001"
    },
    {
      "EMP_CODE": "MA03375",
      "NAME": "AYYAPPADAS P S",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KOCHI",
      "REGION": "KERALA",
      "BRANCH CODE": "KOCH001"
    },
    {
      "EMP_CODE": "MA03687",
      "NAME": "RONY K JOHN",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KOCHI",
      "REGION": "KERALA",
      "BRANCH CODE": "KOCH001"
    },
    {
      "EMP_CODE": "MA03721",
      "NAME": "RIJO THOMAS",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "KOCHI",
      "REGION": "KERALA",
      "BRANCH CODE": "KOCH001"
    },
    {
      "EMP_CODE": "MA03780",
      "NAME": "SHEHIN MAJEED",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "THRISSUR",
      "REGION": "KERALA",
      "BRANCH CODE": "THRI034"
    },
    {
      "EMP_CODE": "MA03725",
      "NAME": "KIRAN KUMAR M R",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "TRIVANDRUM",
      "REGION": "KERALA",
      "BRANCH CODE": "TRIV029"
    },
    {
      "EMP_CODE": "MA03152",
      "NAME": "JITHURAJ M",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "KOTTAYAM",
      "REGION": "KERALA",
      "BRANCH CODE": "KOTT028"
    },
    {
      "EMP_CODE": "MA03627",
      "NAME": "LIBIN JOSEPH C T",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "KOCHI",
      "REGION": "KERALA",
      "BRANCH CODE": "KOCH001"
    },
    {
      "EMP_CODE": "MA03010",
      "NAME": "RENITH K M",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "KOZHIKODE",
      "REGION": "KERALA",
      "BRANCH CODE": "KOZH030"
    },
    {
      "EMP_CODE": "MA03610",
      "NAME": "RAJESH M T",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "THRISSUR",
      "REGION": "KERALA",
      "BRANCH CODE": "THRI034"
    },
    {
      "EMP_CODE": "MA03369",
      "NAME": "NIKHIL F N",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "TRIVANDRUM",
      "REGION": "KERALA",
      "BRANCH CODE": "TRIV029"
    },
    {
      "EMP_CODE": "MA02641",
      "NAME": "VISHNU S",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KOTTAYAM",
      "REGION": "KERALA",
      "BRANCH CODE": "KOTT028"
    },
    {
      "EMP_CODE": "MA03523",
      "NAME": "SHAAN M C",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "KOZHIKODE",
      "REGION": "KERALA",
      "BRANCH CODE": "KOZH030"
    },
    {
      "EMP_CODE": "MA03816",
      "NAME": "RAJESH T R",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KOTTAYAM",
      "REGION": "KERALA",
      "BRANCH CODE": "KOTT028"
    },
    {
      "EMP_CODE": "MA03617",
      "NAME": "SUDHEESH T SUBRAMANIAN",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "KOCHI",
      "REGION": "KERALA",
      "BRANCH CODE": "KOCH001"
    },
    {
      "EMP_CODE": "FA03789",
      "NAME": "ALFANA MANAF",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "ALAPPUZHA",
      "REGION": "KERALA",
      "BRANCH CODE": "ALAP033"
    },
    {
      "EMP_CODE": "MA02353",
      "NAME": "AMARA MADHAVARAO",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "VISAKHAPATNAM",
      "REGION": "TAP",
      "BRANCH CODE": "VISA048"
    },
    {
      "EMP_CODE": "MA02298",
      "NAME": "GEDDAM SAI KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "VISAKHAPATNAM",
      "REGION": "TAP",
      "BRANCH CODE": "VISA048"
    },
    {
      "EMP_CODE": "MA02343",
      "NAME": "YENDLURI JOHN",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "ONGOLE",
      "REGION": "TAP",
      "BRANCH CODE": "ONGO072"
    },
    {
      "EMP_CODE": "MA02351",
      "NAME": "DEVA KARUN VALLABHAPURAM",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "ONGOLE",
      "REGION": "TAP",
      "BRANCH CODE": "ONGO072"
    },
    {
      "EMP_CODE": "MA02693",
      "NAME": "SHAIK ABU SALEHA",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "ANANTAPUR",
      "REGION": "TAP",
      "BRANCH CODE": "ANAN071"
    },
    {
      "EMP_CODE": "MA03018",
      "NAME": "MODUMPALLI SATHISH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KARIMNAGAR",
      "REGION": "TAP",
      "BRANCH CODE": "KARM051"
    },
    {
      "EMP_CODE": "MA02627",
      "NAME": "KALEPU RAVIKANTH",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "KAKINADA",
      "REGION": "TAP",
      "BRANCH CODE": "KAKI039"
    },
    {
      "EMP_CODE": "MA03373",
      "NAME": "INDLA GOPI KRISHNA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "VIJAYAWADA",
      "REGION": "TAP",
      "BRANCH CODE": "VIJA050"
    },
    {
      "EMP_CODE": "MA02440",
      "NAME": "ARDHALA H V N GOWTHAM",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "RAJAHMUNDRY",
      "REGION": "TAP",
      "BRANCH CODE": "RAJA049"
    },
    {
      "EMP_CODE": "MA02448",
      "NAME": "VARA BHARATH BABU",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "RAJAHMUNDRY",
      "REGION": "TAP",
      "BRANCH CODE": "RAJA049"
    },
    {
      "EMP_CODE": "MA03731",
      "NAME": "KANDHA VIKAS",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "HYDERABAD",
      "REGION": "TAP",
      "BRANCH CODE": "HYDE051"
    },
    {
      "EMP_CODE": "MA03280",
      "NAME": "MEDISETTI SIVAPRASAD",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "KAKINADA",
      "REGION": "TAP",
      "BRANCH CODE": "KAKI039"
    },
    {
      "EMP_CODE": "MA02690",
      "NAME": "RELANGI UDAY KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "VISAKHAPATNAM",
      "REGION": "TAP",
      "BRANCH CODE": "VISA048"
    },
    {
      "EMP_CODE": "MA03539",
      "NAME": "PUCHALAPALLI LAKSHMAN",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NELLORE",
      "REGION": "TAP",
      "BRANCH CODE": "NELL069"
    },
    {
      "EMP_CODE": "MA02499",
      "NAME": "SYED YASIN",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KARIMNAGAR",
      "REGION": "TAP",
      "BRANCH CODE": "KARM051"
    },
    {
      "EMP_CODE": "MA02658",
      "NAME": "ANKE RAJESH",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "ANANTAPUR",
      "REGION": "TAP",
      "BRANCH CODE": "ANAN071"
    },
    {
      "EMP_CODE": "MA02838",
      "NAME": "VATADI PRAVEEN KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "RAJAHMUNDRY",
      "REGION": "TAP",
      "BRANCH CODE": "RAJA049"
    },
    {
      "EMP_CODE": "MA02876",
      "NAME": "KAMPA RAJU",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "KARIMNAGAR",
      "REGION": "TAP",
      "BRANCH CODE": "KARM051"
    },
    {
      "EMP_CODE": "MA02988",
      "NAME": "PENDLI NAVEEN",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "WARANGAL",
      "REGION": "TAP",
      "BRANCH CODE": "WARA051"
    },
    {
      "EMP_CODE": "MA03088",
      "NAME": "UPPALAPATI PRASHANTH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "WARANGAL",
      "REGION": "TAP",
      "BRANCH CODE": "WARA051"
    },
    {
      "EMP_CODE": "MA03049",
      "NAME": "PAMBALA ANIL",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "KARIMNAGAR",
      "REGION": "TAP",
      "BRANCH CODE": "KARM051"
    },
    {
      "EMP_CODE": "MA03238",
      "NAME": "KASANI RAJKUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "WARANGAL",
      "REGION": "TAP",
      "BRANCH CODE": "WARA051"
    },
    {
      "EMP_CODE": "MA03273",
      "NAME": "THANNERI SANTHI KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "TIRUPATI",
      "REGION": "TAP",
      "BRANCH CODE": "TIRU021"
    },
    {
      "EMP_CODE": "MA03474",
      "NAME": "GUMMADAM GOVARDHANA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "ANANTAPUR",
      "REGION": "TAP",
      "BRANCH CODE": "ANAN071"
    },
    {
      "EMP_CODE": "MA03403",
      "NAME": "MENATI SULAMAIAH",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "NELLORE",
      "REGION": "TAP",
      "BRANCH CODE": "NELL069"
    },
    {
      "EMP_CODE": "MA03558",
      "NAME": "VINAKOTI VEERANJANEYULU",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "RAJAHMUNDRY",
      "REGION": "TAP",
      "BRANCH CODE": "RAJA049"
    },
    {
      "EMP_CODE": "MA02654",
      "NAME": "KOTHUR RAKESH KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "HYDERABAD",
      "REGION": "TAP",
      "BRANCH CODE": "HYDE051"
    },
    {
      "EMP_CODE": "MA03557",
      "NAME": "SURAPUREDDY NAGA MANIKANTA",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "RAJAHMUNDRY",
      "REGION": "TAP",
      "BRANCH CODE": "RAJA049"
    },
    {
      "EMP_CODE": "MA03582",
      "NAME": "JAKKANA DEMUDU BABU",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "KAKINADA",
      "REGION": "TAP",
      "BRANCH CODE": "KAKI039"
    },
    {
      "EMP_CODE": "MA03456",
      "NAME": "JUTHUKA DURGA PRASAD",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "RAJAHMUNDRY",
      "REGION": "TAP",
      "BRANCH CODE": "RAJA049"
    },
    {
      "EMP_CODE": "MA03517",
      "NAME": "BONAGIRI PRASHANTH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KARIMNAGAR",
      "REGION": "TAP",
      "BRANCH CODE": "KARM051"
    },
    {
      "EMP_CODE": "MA03569",
      "NAME": "GANDHAM SATISH KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "RAJAHMUNDRY",
      "REGION": "TAP",
      "BRANCH CODE": "RAJA049"
    },
    {
      "EMP_CODE": "MA03374",
      "NAME": "ULLI NAGARJUNA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "ONGOLE",
      "REGION": "TAP",
      "BRANCH CODE": "ONGO072"
    },
    {
      "EMP_CODE": "MA03683",
      "NAME": "AMBATI NARASIMHA MURTHY",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "RAJAHMUNDRY",
      "REGION": "TAP",
      "BRANCH CODE": "RAJA049"
    },
    {
      "EMP_CODE": "MA03614",
      "NAME": "MADISETTI ANAND KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "KARIMNAGAR",
      "REGION": "TAP",
      "BRANCH CODE": "KARM051"
    },
    {
      "EMP_CODE": "MA03769",
      "NAME": "PONDURI MANGARAJU",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "VISAKHAPATNAM",
      "REGION": "TAP",
      "BRANCH CODE": "VISA048"
    },
    {
      "EMP_CODE": "MA03638",
      "NAME": "GHORI MOHAMMED SHAKEEL",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NELLORE",
      "REGION": "TAP",
      "BRANCH CODE": "NELL069"
    },
    {
      "EMP_CODE": "MA03699",
      "NAME": "GANDHAM SHALEMU RAJU",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "RAJAHMUNDRY",
      "REGION": "TAP",
      "BRANCH CODE": "RAJA049"
    },
    {
      "EMP_CODE": "MA03667",
      "NAME": "KARROTHU APPALA RAJU",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "VISAKHAPATNAM",
      "REGION": "TAP",
      "BRANCH CODE": "VISA048"
    },
    {
      "EMP_CODE": "MA02780",
      "NAME": "YAMARTHI VIDYA VIKAS",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "RAJAHMUNDRY",
      "REGION": "TAP",
      "BRANCH CODE": "RAJA049"
    },
    {
      "EMP_CODE": "MA03255",
      "NAME": "POTNURU BHASKARA RAO",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "VISAKHAPATNAM",
      "REGION": "TAP",
      "BRANCH CODE": "VISA048"
    },
    {
      "EMP_CODE": "MA03499",
      "NAME": "Y NEELAKANTAM",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "TIRUPATI",
      "REGION": "TAP",
      "BRANCH CODE": "TIRU021"
    },
    {
      "EMP_CODE": "MA03116",
      "NAME": "AVUNURU NAGARAJU",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "HYDERABAD",
      "REGION": "TAP",
      "BRANCH CODE": "HYDE051"
    },
    {
      "EMP_CODE": "MA03253",
      "NAME": "BETHAM HANUMANTHA RAO",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "VIJAYAWADA",
      "REGION": "TAP",
      "BRANCH CODE": "VIJA050"
    },
    {
      "EMP_CODE": "MA03178",
      "NAME": "YENNU V MAHENDER",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "HYDERABAD",
      "REGION": "TAP",
      "BRANCH CODE": "HYDE051"
    },
    {
      "EMP_CODE": "MA01983",
      "NAME": "PENUBALA YOUGENDER CHAKRAVARTHY",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "HYDERABAD",
      "REGION": "TAP",
      "BRANCH CODE": "HYDE051"
    },
    {
      "EMP_CODE": "MA03398",
      "NAME": "MACHA SRINIVAS",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KARIMNAGAR",
      "REGION": "TAP",
      "BRANCH CODE": "KARM051"
    },
    {
      "EMP_CODE": "MA03684",
      "NAME": "YAMALA AKHIL",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "NELLORE",
      "REGION": "TAP",
      "BRANCH CODE": "NELL069"
    },
    {
      "EMP_CODE": "MA03692",
      "NAME": "MENDE RAVINDER",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "HYDERABAD",
      "REGION": "TAP",
      "BRANCH CODE": "HYDE051"
    },
    {
      "EMP_CODE": "MA02101",
      "NAME": "CHINNAM PRASADA RAO",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "VIJAYAWADA",
      "REGION": "TAP",
      "BRANCH CODE": "VIJA050"
    },
    {
      "EMP_CODE": "MA02938",
      "NAME": "NANDADI MAHESH BABU",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "HYDERABAD",
      "REGION": "TAP",
      "BRANCH CODE": "HYDE051"
    },
    {
      "EMP_CODE": "MA03067",
      "NAME": "MOHAMMED ABDUL AZEEM",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "KARIMNAGAR",
      "REGION": "TAP",
      "BRANCH CODE": "KARM051"
    },
    {
      "EMP_CODE": "MA03587",
      "NAME": "PATIL SRINIVASULU REDDY",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "ANANTAPUR",
      "REGION": "TAP",
      "BRANCH CODE": "ANAN071"
    },
    {
      "EMP_CODE": "MA02604",
      "NAME": "GYAJANGI SAI KIRAN",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KARIMNAGAR",
      "REGION": "TAP",
      "BRANCH CODE": "KARM051"
    },
    {
      "EMP_CODE": "MA03224",
      "NAME": "YEDDULA PRASAD REDDY",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "ANANTAPUR",
      "REGION": "TAP",
      "BRANCH CODE": "ANAN071"
    },
    {
      "EMP_CODE": "MA03454",
      "NAME": "CHELIMILLA LOHIT KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "HYDERABAD",
      "REGION": "TAP",
      "BRANCH CODE": "HYDE051"
    },
    {
      "EMP_CODE": "MA02217",
      "NAME": "GUNTI PRAMOD KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "HYDERABAD",
      "REGION": "TAP",
      "BRANCH CODE": "HYDE051"
    },
    {
      "EMP_CODE": "MA03564",
      "NAME": "RESHAMALLA ESHWAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "WARANGAL",
      "REGION": "TAP",
      "BRANCH CODE": "WARA051"
    },
    {
      "EMP_CODE": "MA03750",
      "NAME": "JALA SATISH YADAV",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KURNOOL",
      "REGION": "TAP",
      "BRANCH CODE": "KURN116"
    },
    {
      "EMP_CODE": "MA03635",
      "NAME": "MEKA NARESH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KAKINADA",
      "REGION": "TAP",
      "BRANCH CODE": "KAKI039"
    },
    {
      "EMP_CODE": "MA03724",
      "NAME": "KOTAMSETTY SUDHEER KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "ONGOLE",
      "REGION": "TAP",
      "BRANCH CODE": "ONGO072"
    },
    {
      "EMP_CODE": "MA03196",
      "NAME": "POCHIRAJU RAMA KRISHNA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "VISAKHAPATNAM",
      "REGION": "TAP",
      "BRANCH CODE": "VISA048"
    },
    {
      "EMP_CODE": "MA03318",
      "NAME": "MADIRI SRIKANTH",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "VIJAYAWADA",
      "REGION": "TAP",
      "BRANCH CODE": "VIJA050"
    },
    {
      "EMP_CODE": "MA02634",
      "NAME": "PARVEJ ALI RAJPUT",
      "DSGN_NAME": "RELATIONSHIP OFFICER - CROSS SELL",
      "BRANCH": "HYDERABAD",
      "REGION": "TAP",
      "BRANCH CODE": "HYDE051"
    },
    {
      "EMP_CODE": "FA03510",
      "NAME": "BATADA SALONI RAFIKALI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "SURENDRANAGAR",
      "REGION": "GUJARAT",
      "BRANCH CODE": "SURE066"
    },
    {
      "EMP_CODE": "MA03607",
      "NAME": "PARIKH JAY",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "VADODARA",
      "REGION": "GUJARAT",
      "BRANCH CODE": "VADO021"
    },
    {
      "EMP_CODE": "MA03401",
      "NAME": "VATSALKUMAR HASMUKHBHAI RATHOD",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "SURAT",
      "REGION": "GUJARAT",
      "BRANCH CODE": "SURA004"
    },
    {
      "EMP_CODE": "MA03751",
      "NAME": "KATHERIYA KRUNALSINGH RANVIRSINGH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "VADODARA",
      "REGION": "GUJARAT",
      "BRANCH CODE": "VADO021"
    },
    {
      "EMP_CODE": "MA03461",
      "NAME": "PANDEY AVANEESH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "SURAT",
      "REGION": "GUJARAT",
      "BRANCH CODE": "SURA004"
    },
    {
      "EMP_CODE": "MA02997",
      "NAME": "MYANGER PARTH RAKESHKUMAR",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "VADODARA",
      "REGION": "GUJARAT",
      "BRANCH CODE": "VADO021"
    },
    {
      "EMP_CODE": "MA03072",
      "NAME": "JITENDRAKUMAR CHAVDA",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "VADODARA",
      "REGION": "GUJARAT",
      "BRANCH CODE": "VADO021"
    },
    {
      "EMP_CODE": "MA03163",
      "NAME": "PARMAR BHAVINKUMAR ISHVARBHAI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "VADODARA",
      "REGION": "GUJARAT",
      "BRANCH CODE": "VADO021"
    },
    {
      "EMP_CODE": "MA03298",
      "NAME": "NIRAV ASHOKKUMAR JANI",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "SURENDRANAGAR",
      "REGION": "GUJARAT",
      "BRANCH CODE": "SURE066"
    },
    {
      "EMP_CODE": "MA03250",
      "NAME": "SHINGALA SARTHAK HARESHBHAI",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "AHMEDABAD",
      "REGION": "GUJARAT",
      "BRANCH CODE": "AHME007"
    },
    {
      "EMP_CODE": "MA03106",
      "NAME": "SOLANKI VIKASKUMAR KANAIYALAL",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "AHMEDABAD",
      "REGION": "GUJARAT",
      "BRANCH CODE": "AHME007"
    },
    {
      "EMP_CODE": "MA03279",
      "NAME": "TIWARI PRAVENDRA SURENDRA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "AHMEDABAD",
      "REGION": "GUJARAT",
      "BRANCH CODE": "AHME007"
    },
    {
      "EMP_CODE": "MA02869",
      "NAME": "PAVAN RAJNIKUMAR NAI",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "AHMEDABAD",
      "REGION": "GUJARAT",
      "BRANCH CODE": "AHME007"
    },
    {
      "EMP_CODE": "MA02934",
      "NAME": "VASANI ALPESH HARESHBHAI",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "AHMEDABAD",
      "REGION": "GUJARAT",
      "BRANCH CODE": "AHME007"
    },
    {
      "EMP_CODE": "MA03197",
      "NAME": "PARMAR BHARAT CHANABHAI",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "RAJKOT",
      "REGION": "GUJARAT",
      "BRANCH CODE": "RAJK005"
    },
    {
      "EMP_CODE": "MA03550",
      "NAME": "JADHAV HARSHIL SUNIL",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "VADODARA",
      "REGION": "GUJARAT",
      "BRANCH CODE": "VADO021"
    },
    {
      "EMP_CODE": "MA03752",
      "NAME": "KEYURKUMAR JAYANTBHAI BAROT",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "VADODARA",
      "REGION": "GUJARAT",
      "BRANCH CODE": "VADO021"
    },
    {
      "EMP_CODE": "MA03745",
      "NAME": "PARMAR MITHUN",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "AHMEDABAD",
      "REGION": "GUJARAT",
      "BRANCH CODE": "AHME007"
    },
    {
      "EMP_CODE": "MA03762",
      "NAME": "NAMSA BRIJESH VALJIBHAI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "VADODARA",
      "REGION": "GUJARAT",
      "BRANCH CODE": "VADO021"
    },
    {
      "EMP_CODE": "MA03791",
      "NAME": "PARMAR SHYAM",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "JAMNAGAR",
      "REGION": "GUJARAT",
      "BRANCH CODE": "JAMN067"
    },
    {
      "EMP_CODE": "MA03009",
      "NAME": "VAGHELA HITESH DHANSUKHBHAI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "JUNAGADH",
      "REGION": "GUJARAT",
      "BRANCH CODE": "JUNA042"
    },
    {
      "EMP_CODE": "MA02313",
      "NAME": "NIDHESH BABULAL SOLANKI",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "AHMEDABAD",
      "REGION": "GUJARAT",
      "BRANCH CODE": "AHME007"
    },
    {
      "EMP_CODE": "MA02699",
      "NAME": "CHAUHAN JAYRAJSINH CHAMPAKSINH",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "RAJKOT",
      "REGION": "GUJARAT",
      "BRANCH CODE": "RAJK005"
    },
    {
      "EMP_CODE": "MA03231",
      "NAME": "MARU BIPINBHAI RAMESHBHAI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "SURAT",
      "REGION": "GUJARAT",
      "BRANCH CODE": "SURA004"
    },
    {
      "EMP_CODE": "MA03759",
      "NAME": "BODALA KRISH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "VADODARA",
      "REGION": "GUJARAT",
      "BRANCH CODE": "VADO021"
    },
    {
      "EMP_CODE": "MA03793",
      "NAME": "PRASHANT YADAV",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "AHMEDABAD",
      "REGION": "GUJARAT",
      "BRANCH CODE": "AHME007"
    },
    {
      "EMP_CODE": "MA03792",
      "NAME": "SHUKALA RITESHBHAI VINODBHAI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "AHMEDABAD",
      "REGION": "GUJARAT",
      "BRANCH CODE": "AHME007"
    },
    {
      "EMP_CODE": "MA03448",
      "NAME": "RADHESHYAM BAGANIYA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "INDORE",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "INDO011"
    },
    {
      "EMP_CODE": "MA03355",
      "NAME": "ASHISH CHOUHAN",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "INDORE",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "INDO011"
    },
    {
      "EMP_CODE": "MA02488",
      "NAME": "SUDEER SING",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "INDORE",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "INDO011"
    },
    {
      "EMP_CODE": "MA02390",
      "NAME": "DEEPAK LOVEWANSHI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "INDORE",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "INDO011"
    },
    {
      "EMP_CODE": "MA03548",
      "NAME": "PRIYESH PATIL",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "INDORE",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "INDO011"
    },
    {
      "EMP_CODE": "MA03595",
      "NAME": "ROHIT SAHU",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "BHOPAL",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "BHOP013"
    },
    {
      "EMP_CODE": "MA03599",
      "NAME": "LALIT RANA",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "GWALIOR",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "GWAL026"
    },
    {
      "EMP_CODE": "MA03652",
      "NAME": "VIJAY SINGH BHADORIA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "GWALIOR",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "GWAL026"
    },
    {
      "EMP_CODE": "MA02471",
      "NAME": "AKASH RATHORE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "UJJAIN",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "UJJA072"
    },
    {
      "EMP_CODE": "MA02732",
      "NAME": "AKHILESH MALVIYA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "BHOPAL",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "BHOP013"
    },
    {
      "EMP_CODE": "MA02909",
      "NAME": "ANIRUDH JAIN",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "UJJAIN",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "UJJA072"
    },
    {
      "EMP_CODE": "MA03058",
      "NAME": "SANJAY BAIRAGI",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "UJJAIN",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "UJJA072"
    },
    {
      "EMP_CODE": "MA03110",
      "NAME": "RAHUL BHATIA",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "UJJAIN",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "UJJA072"
    },
    {
      "EMP_CODE": "MA02514",
      "NAME": "DEEPAK OJHA",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "GWALIOR",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "GWAL026"
    },
    {
      "EMP_CODE": "MA03102",
      "NAME": "BHUPENDRA SHARMA",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "GUNA",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "GUNA073"
    },
    {
      "EMP_CODE": "MA03338",
      "NAME": "SANJAY SINGH CHAUHAN",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "GWALIOR",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "GWAL026"
    },
    {
      "EMP_CODE": "MA03423",
      "NAME": "PAVAN KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "INDORE",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "INDO011"
    },
    {
      "EMP_CODE": "MA03387",
      "NAME": "RAKESH GOYAL",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "INDORE",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "INDO011"
    },
    {
      "EMP_CODE": "MA03435",
      "NAME": "RAJKUMAR KUSHWAH",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "GWALIOR - SHIVPURI",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "SHIV026"
    },
    {
      "EMP_CODE": "MA03407",
      "NAME": "NANDKISHORE GOME",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "RATLAM",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "RATL041"
    },
    {
      "EMP_CODE": "MA03227",
      "NAME": "KRISHNAPAL .",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "INDORE",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "INDO011"
    },
    {
      "EMP_CODE": "MA03075",
      "NAME": "AMIT NAMDEV",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "INDORE",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "INDO011"
    },
    {
      "EMP_CODE": "MA03074",
      "NAME": "LOVE SHUBHANSHU KIRTI VARDHAN MISHRA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "INDORE",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "INDO011"
    },
    {
      "EMP_CODE": "MA02962",
      "NAME": "SUMIT PRAJAPATI",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "INDORE",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "INDO011"
    },
    {
      "EMP_CODE": "MA03541",
      "NAME": "HOKAM SINGH PANWAR",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "RATLAM",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "RATL041"
    },
    {
      "EMP_CODE": "MA03440",
      "NAME": "ASHOK MALVIY",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "RATLAM",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "RATL041"
    },
    {
      "EMP_CODE": "MA03477",
      "NAME": "SHIVNARAYAN .",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "UJJAIN",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "UJJA072"
    },
    {
      "EMP_CODE": "MA03275",
      "NAME": "SHELENDRA SINGH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "RATLAM",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "RATL041"
    },
    {
      "EMP_CODE": "MA03542",
      "NAME": "DHARMENDRA MALVIYA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "UJJAIN",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "UJJA072"
    },
    {
      "EMP_CODE": "MA03421",
      "NAME": "CHANCHAL DHANAK",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "RATLAM",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "RATL041"
    },
    {
      "EMP_CODE": "MA03805",
      "NAME": "VINAY KUMAR JOSHI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "GWALIOR",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "GWAL026"
    },
    {
      "EMP_CODE": "MA03620",
      "NAME": "BRAJESH SEN",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "GWALIOR - SHIVPURI",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "SHIV026"
    },
    {
      "EMP_CODE": "MA03185",
      "NAME": "AMIT SHARMA",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "INDORE",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "INDO011"
    },
    {
      "EMP_CODE": "MA03621",
      "NAME": "SURESH MALVIYA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "INDORE",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "INDO011"
    },
    {
      "EMP_CODE": "MA03730",
      "NAME": "LALIT YADAV",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "GWALIOR",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "GWAL026"
    },
    {
      "EMP_CODE": "MA03441",
      "NAME": "TANISH SHARMA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "INDORE",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "INDO011"
    },
    {
      "EMP_CODE": "MA03470",
      "NAME": "SANTKUMAR YADAV",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "GUNA",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "GUNA073"
    },
    {
      "EMP_CODE": "MA03626",
      "NAME": "PIYUSH CHOUDHARY",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "INDORE",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "INDO011"
    },
    {
      "EMP_CODE": "MA03433",
      "NAME": "VISHAL SWAMY",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "INDORE",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "INDO011"
    },
    {
      "EMP_CODE": "MA02383",
      "NAME": "JASWANT AKODIYA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "RATLAM",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "RATL041"
    },
    {
      "EMP_CODE": "MA03123",
      "NAME": "SAURABH SHARMA",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "GWALIOR",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "GWAL026"
    },
    {
      "EMP_CODE": "MA02898",
      "NAME": "ANUJ SHARMA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "GUNA",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "GUNA073"
    },
    {
      "EMP_CODE": "MA03619",
      "NAME": "NARENDRA SAHU",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "GWALIOR",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "GWAL026"
    },
    {
      "EMP_CODE": "MA03672",
      "NAME": "PINTOO RAGHUWANSHI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "GUNA",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "GUNA073"
    },
    {
      "EMP_CODE": "MA03673",
      "NAME": "ROHIT SELAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "GUNA",
      "REGION": "MADHYA PRADESH",
      "BRANCH CODE": "GUNA073"
    },
    {
      "EMP_CODE": "MA03158",
      "NAME": "BHIMRAV BABURAV MANOHARE",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "MUMBAI - VIRAR",
      "REGION": "MUMBAI",
      "BRANCH CODE": "VIRA999"
    },
    {
      "EMP_CODE": "MA02894",
      "NAME": "AJAY BABU PAWAR",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "MUMBAI - VIRAR",
      "REGION": "MUMBAI",
      "BRANCH CODE": "VIRA999"
    },
    {
      "EMP_CODE": "MA03068",
      "NAME": "MOHD UMAR ABDUL ALLAM SHAIKH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NAVI MUMBAI - PANVEL",
      "REGION": "MUMBAI",
      "BRANCH CODE": "PANV038"
    },
    {
      "EMP_CODE": "MA03422",
      "NAME": "SHRIKANT OJHA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NAVI MUMBAI - PANVEL",
      "REGION": "MUMBAI",
      "BRANCH CODE": "PANV038"
    },
    {
      "EMP_CODE": "MA03679",
      "NAME": "PANKAJ KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NAVI MUMBAI - PANVEL",
      "REGION": "MUMBAI",
      "BRANCH CODE": "PANV038"
    },
    {
      "EMP_CODE": "MA03776",
      "NAME": "NISHANT SHANTARAM JADHAV",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NAVI MUMBAI - PANVEL",
      "REGION": "MUMBAI",
      "BRANCH CODE": "PANV038"
    },
    {
      "EMP_CODE": "MA03624",
      "NAME": "LAVKUSH RAMBADAL UPADHYAY",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - VIRAR",
      "REGION": "MUMBAI",
      "BRANCH CODE": "VIRA999"
    },
    {
      "EMP_CODE": "MA03678",
      "NAME": "PRAVIN VIDHYADHAR JADHAV",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - VIRAR",
      "REGION": "MUMBAI",
      "BRANCH CODE": "VIRA999"
    },
    {
      "EMP_CODE": "MA03531",
      "NAME": "RAHUL ANNASO GADADE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NAVI MUMBAI - PANVEL",
      "REGION": "MUMBAI",
      "BRANCH CODE": "PANV038"
    },
    {
      "EMP_CODE": "MA03689",
      "NAME": "RAJKUMAR F SHARMA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - VIRAR",
      "REGION": "MUMBAI",
      "BRANCH CODE": "VIRA999"
    },
    {
      "EMP_CODE": "MA03710",
      "NAME": "SACHIN VISNUH MANE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - VIRAR",
      "REGION": "MUMBAI",
      "BRANCH CODE": "VIRA999"
    },
    {
      "EMP_CODE": "MA03726",
      "NAME": "VINOD JAYRAM NAMUGADE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - VIRAR",
      "REGION": "MUMBAI",
      "BRANCH CODE": "VIRA999"
    },
    {
      "EMP_CODE": "MA03775",
      "NAME": "ABHISHEK VIJAYSHANKAR PANDEY",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "MUMBAI - KALYAN",
      "REGION": "MUMBAI",
      "BRANCH CODE": "KALY037"
    },
    {
      "EMP_CODE": "MA03677",
      "NAME": "RUPESH MADHUKAR PANJARI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - VIRAR",
      "REGION": "MUMBAI",
      "BRANCH CODE": "VIRA999"
    },
    {
      "EMP_CODE": "FA03696",
      "NAME": "CHHAYA MAHENDRA BHOMBDE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - VIRAR",
      "REGION": "MUMBAI",
      "BRANCH CODE": "VIRA999"
    },
    {
      "EMP_CODE": "MA03701",
      "NAME": "RUSHIKESH DNYANESHWAR PATIL",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - VIRAR",
      "REGION": "MUMBAI",
      "BRANCH CODE": "VIRA999"
    },
    {
      "EMP_CODE": "MA03205",
      "NAME": "RATHOD KARAN VISHWANATH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - VIRAR",
      "REGION": "MUMBAI",
      "BRANCH CODE": "VIRA999"
    },
    {
      "EMP_CODE": "MA01875",
      "NAME": "RATAN LAL S GUPTA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - KALYAN",
      "REGION": "MUMBAI",
      "BRANCH CODE": "KALY037"
    },
    {
      "EMP_CODE": "MA01866",
      "NAME": "AMAR NATH SHARMA",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "MUMBAI - KALYAN",
      "REGION": "MUMBAI",
      "BRANCH CODE": "KALY037"
    },
    {
      "EMP_CODE": "MA03005",
      "NAME": "DURGESH PYARELAL YADAV",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "MUMBAI - KALYAN",
      "REGION": "MUMBAI",
      "BRANCH CODE": "KALY037"
    },
    {
      "EMP_CODE": "MA02996",
      "NAME": "YOGESH PANDURANG THATE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - KALYAN",
      "REGION": "MUMBAI",
      "BRANCH CODE": "KALY037"
    },
    {
      "EMP_CODE": "MA02827",
      "NAME": "CHETAN KANTARAM MOTE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - KALYAN",
      "REGION": "MUMBAI",
      "BRANCH CODE": "KALY037"
    },
    {
      "EMP_CODE": "MA02987",
      "NAME": "SATISH KUMAR JHAKAREE PRASAD PRAJAPATI",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "MUMBAI - KALYAN",
      "REGION": "MUMBAI",
      "BRANCH CODE": "KALY037"
    },
    {
      "EMP_CODE": "MA02852",
      "NAME": "AMBESH KUMAR RAJESH KUMAR MISHRA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - VIRAR",
      "REGION": "MUMBAI",
      "BRANCH CODE": "VIRA999"
    },
    {
      "EMP_CODE": "MA02891",
      "NAME": "AKSHAY PURUSHOTTAM POTDUKHE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - KALYAN",
      "REGION": "MUMBAI",
      "BRANCH CODE": "KALY037"
    },
    {
      "EMP_CODE": "MA02926",
      "NAME": "KISHOR JANARDAN DATKHILE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - KALYAN",
      "REGION": "MUMBAI",
      "BRANCH CODE": "KALY037"
    },
    {
      "EMP_CODE": "MA03326",
      "NAME": "DARBARSING GOKUL PATIL",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "MUMBAI - KALYAN",
      "REGION": "MUMBAI",
      "BRANCH CODE": "KALY037"
    },
    {
      "EMP_CODE": "MA02879",
      "NAME": "SAGAR SHIRISH GAIKWAD",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - KALYAN",
      "REGION": "MUMBAI",
      "BRANCH CODE": "KALY037"
    },
    {
      "EMP_CODE": "MA03316",
      "NAME": "GULSHAN SHARAD KUMAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - VIRAR",
      "REGION": "MUMBAI",
      "BRANCH CODE": "VIRA999"
    },
    {
      "EMP_CODE": "MA03327",
      "NAME": "DHARMENDRA KUMAR UPADHYAY",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "MUMBAI - KALYAN",
      "REGION": "MUMBAI",
      "BRANCH CODE": "KALY037"
    },
    {
      "EMP_CODE": "MA02346",
      "NAME": "MANISH LALBHARI RAM",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NAVI MUMBAI - PANVEL",
      "REGION": "MUMBAI",
      "BRANCH CODE": "PANV038"
    },
    {
      "EMP_CODE": "MA03518",
      "NAME": "HARSHAL RAMAKANT RAUT",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - VIRAR",
      "REGION": "MUMBAI",
      "BRANCH CODE": "VIRA999"
    },
    {
      "EMP_CODE": "MA03590",
      "NAME": "SANTOSH SHOBHNATH MISHRA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - VIRAR",
      "REGION": "MUMBAI",
      "BRANCH CODE": "VIRA999"
    },
    {
      "EMP_CODE": "MA03348",
      "NAME": "SACHIN KAMLESH PRAJAPATI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - THANE",
      "REGION": "MUMBAI",
      "BRANCH CODE": "THAN037"
    },
    {
      "EMP_CODE": "FA03625",
      "NAME": "PUSHPITA KUMARI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - VIRAR",
      "REGION": "MUMBAI",
      "BRANCH CODE": "VIRA999"
    },
    {
      "EMP_CODE": "FA03790",
      "NAME": "CHAITALI DASHARATH ALE",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "MUMBAI - KALYAN",
      "REGION": "MUMBAI",
      "BRANCH CODE": "KALY037"
    },
    {
      "EMP_CODE": "MA03533",
      "NAME": "KIRAN PANDURANG LENGARE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NAVI MUMBAI - PANVEL",
      "REGION": "MUMBAI",
      "BRANCH CODE": "PANV038"
    },
    {
      "EMP_CODE": "MA03736",
      "NAME": "DHIRAJ PRAMOD PATHAK",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NAVI MUMBAI - PANVEL",
      "REGION": "MUMBAI",
      "BRANCH CODE": "PANV038"
    },
    {
      "EMP_CODE": "MA03680",
      "NAME": "SWAPNIL BHASKAR WANKHADE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NAVI MUMBAI - PANVEL",
      "REGION": "MUMBAI",
      "BRANCH CODE": "PANV038"
    },
    {
      "EMP_CODE": "MA03312",
      "NAME": "RAVINDRAKUMAR INDRASAN SHUKLA",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "MUMBAI - KALYAN",
      "REGION": "MUMBAI",
      "BRANCH CODE": "KALY037"
    },
    {
      "EMP_CODE": "MA02457",
      "NAME": "BUDHIRAM GUPTA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - VIRAR",
      "REGION": "MUMBAI",
      "BRANCH CODE": "VIRA999"
    },
    {
      "EMP_CODE": "MA03566",
      "NAME": "AKSHAY MADHAV ALANE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NAVI MUMBAI - PANVEL",
      "REGION": "MUMBAI",
      "BRANCH CODE": "PANV038"
    },
    {
      "EMP_CODE": "MA03177",
      "NAME": "JAGDISH SURESH PATIL",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "NAVI MUMBAI - PANVEL",
      "REGION": "MUMBAI",
      "BRANCH CODE": "PANV038"
    },
    {
      "EMP_CODE": "MA03601",
      "NAME": "ABID RAZA SAYED",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "MUMBAI - VIRAR",
      "REGION": "MUMBAI",
      "BRANCH CODE": "VIRA999"
    },
    {
      "EMP_CODE": "MA02429",
      "NAME": "RAKESH DNYANESHWAR PAWAR",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "MUMBAI - VIRAR",
      "REGION": "MUMBAI",
      "BRANCH CODE": "VIRA999"
    },
    {
      "EMP_CODE": "MA02196",
      "NAME": "NITESH RAMVILASH CHAURASIYA",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "MUMBAI - VIRAR",
      "REGION": "MUMBAI",
      "BRANCH CODE": "VIRA999"
    },
    {
      "EMP_CODE": "MA02829",
      "NAME": "RAHUL DILIP MALVE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - KALYAN",
      "REGION": "MUMBAI",
      "BRANCH CODE": "KALY037"
    },
    {
      "EMP_CODE": "MA03359",
      "NAME": "SUSHANT DIVAKAR JADHAV",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - KALYAN",
      "REGION": "MUMBAI",
      "BRANCH CODE": "KALY037"
    },
    {
      "EMP_CODE": "MA03427",
      "NAME": "SACHIN RADHEMOHAN SHRIVASTAV",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NAVI MUMBAI - PANVEL",
      "REGION": "MUMBAI",
      "BRANCH CODE": "PANV038"
    },
    {
      "EMP_CODE": "MA03481",
      "NAME": "SANTOSH KUMAR SUMAN",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "NAVI MUMBAI - PANVEL",
      "REGION": "MUMBAI",
      "BRANCH CODE": "PANV038"
    },
    {
      "EMP_CODE": "FA03571",
      "NAME": "ALKA .",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - VIRAR",
      "REGION": "MUMBAI",
      "BRANCH CODE": "VIRA999"
    },
    {
      "EMP_CODE": "MA03605",
      "NAME": "VINAYAK GIRIDHAR GHADASHI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - KALYAN",
      "REGION": "MUMBAI",
      "BRANCH CODE": "KALY037"
    },
    {
      "EMP_CODE": "MA03810",
      "NAME": "SIDDHARTH KHANDU PAWAR",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "MUMBAI - KALYAN",
      "REGION": "MUMBAI",
      "BRANCH CODE": "KALY037"
    },
    {
      "EMP_CODE": "MA03766",
      "NAME": "RAVI ASHOKKUMAR CHAUHAN",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "MUMBAI - KALYAN",
      "REGION": "MUMBAI",
      "BRANCH CODE": "KALY037"
    },
    {
      "EMP_CODE": "MA02452",
      "NAME": "MAYUR ANIL WALKE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "AHMEDNAGAR",
      "REGION": "ROM",
      "BRANCH CODE": "AHME008"
    },
    {
      "EMP_CODE": "MA02670",
      "NAME": "AVINASH SAHEBRAO INGALE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NASIK",
      "REGION": "ROM",
      "BRANCH CODE": "NASI016"
    },
    {
      "EMP_CODE": "MA02657",
      "NAME": "SAGAR BALASAHEB WAGHCHAURE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NASIK",
      "REGION": "ROM",
      "BRANCH CODE": "NASI016"
    },
    {
      "EMP_CODE": "MA02797",
      "NAME": "AANANDA SANTOSH PATEKAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NASIK",
      "REGION": "ROM",
      "BRANCH CODE": "NASI016"
    },
    {
      "EMP_CODE": "MA02843",
      "NAME": "SAIPAN RAJAK NADAF",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "SOLAPUR",
      "REGION": "ROM",
      "BRANCH CODE": "SOLA019"
    },
    {
      "EMP_CODE": "MA02846",
      "NAME": "GHANASHYAM GULABRAO PATIL",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "JALGAON",
      "REGION": "ROM",
      "BRANCH CODE": "JALG018"
    },
    {
      "EMP_CODE": "MA03043",
      "NAME": "MANGESH DEVIDAS AMBRIT",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "AHMEDNAGAR",
      "REGION": "ROM",
      "BRANCH CODE": "AHME008"
    },
    {
      "EMP_CODE": "MA02628",
      "NAME": "SUNIL ATMARAM LONARE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "PUNE",
      "REGION": "ROM",
      "BRANCH CODE": "PUNE003"
    },
    {
      "EMP_CODE": "MA03475",
      "NAME": "SALMAN SHAKIL MULLA",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KOLHAPUR",
      "REGION": "ROM",
      "BRANCH CODE": "KOLH009"
    },
    {
      "EMP_CODE": "MA03419",
      "NAME": "NATRAJ AMBAYYA MERGU",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "SOLAPUR",
      "REGION": "ROM",
      "BRANCH CODE": "SOLA019"
    },
    {
      "EMP_CODE": "MA02516",
      "NAME": "PRADIP D JAVHERI",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "PIMPRI",
      "REGION": "ROM",
      "BRANCH CODE": "PIMP092"
    },
    {
      "EMP_CODE": "MA02849",
      "NAME": "SHASHIKANT HARIDAS KUMBHAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "PIMPRI",
      "REGION": "ROM",
      "BRANCH CODE": "PIMP092"
    },
    {
      "EMP_CODE": "MA03602",
      "NAME": "SURAJ VIJAY CHOUGULE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KOLHAPUR",
      "REGION": "ROM",
      "BRANCH CODE": "KOLH009"
    },
    {
      "EMP_CODE": "FA03500",
      "NAME": "PRIYA MAKARDHWAJ DHURVE",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "PIMPRI",
      "REGION": "ROM",
      "BRANCH CODE": "PIMP092"
    },
    {
      "EMP_CODE": "MA02238",
      "NAME": "JIVANDAS MADANDAS BAIRAGI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "AURANGABAD",
      "REGION": "ROM",
      "BRANCH CODE": "AURA017"
    },
    {
      "EMP_CODE": "MA03615",
      "NAME": "DIPAK SAMPAT LANDGE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NASIK",
      "REGION": "ROM",
      "BRANCH CODE": "NASI016"
    },
    {
      "EMP_CODE": "MA02557",
      "NAME": "SATISH SANJAY SHIRSATH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "PUNE",
      "REGION": "ROM",
      "BRANCH CODE": "PUNE003"
    },
    {
      "EMP_CODE": "MA03321",
      "NAME": "AJIT KUMBHAR",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "SOLAPUR",
      "REGION": "ROM",
      "BRANCH CODE": "SOLA019"
    },
    {
      "EMP_CODE": "MA03458",
      "NAME": "MAYUR RAJESH KHADE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "PIMPRI",
      "REGION": "ROM",
      "BRANCH CODE": "PIMP092"
    },
    {
      "EMP_CODE": "MA03060",
      "NAME": "AMOL DILIP SANAP",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "PUNE",
      "REGION": "ROM",
      "BRANCH CODE": "PUNE003"
    },
    {
      "EMP_CODE": "MA03669",
      "NAME": "SUMIT KISHOR KAMBLE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "PIMPRI",
      "REGION": "ROM",
      "BRANCH CODE": "PIMP092"
    },
    {
      "EMP_CODE": "MA03743",
      "NAME": "NAYYUM BASHIR PATHAN",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "PIMPRI",
      "REGION": "ROM",
      "BRANCH CODE": "PIMP092"
    },
    {
      "EMP_CODE": "MA02888",
      "NAME": "SUDARSHAN NIVRUTTI PALASKAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "AURANGABAD",
      "REGION": "ROM",
      "BRANCH CODE": "AURA017"
    },
    {
      "EMP_CODE": "MA03032",
      "NAME": "AKSHAY RAMESH SAWANT",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "AHMEDNAGAR",
      "REGION": "ROM",
      "BRANCH CODE": "AHME008"
    },
    {
      "EMP_CODE": "MA02875",
      "NAME": "ULHAS VIJAY PATIL",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "JALGAON",
      "REGION": "ROM",
      "BRANCH CODE": "JALG018"
    },
    {
      "EMP_CODE": "FA02864",
      "NAME": "PRANALI DEVENDRA DESHMUKH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "JALGAON",
      "REGION": "ROM",
      "BRANCH CODE": "JALG018"
    },
    {
      "EMP_CODE": "MA02840",
      "NAME": "TUSHAR YUVRAJ PATIL",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "JALGAON",
      "REGION": "ROM",
      "BRANCH CODE": "JALG018"
    },
    {
      "EMP_CODE": "MA02539",
      "NAME": "SIDDESH SADANAND PATIL",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KOLHAPUR",
      "REGION": "ROM",
      "BRANCH CODE": "KOLH009"
    },
    {
      "EMP_CODE": "MA02993",
      "NAME": "VINAYAK BHIKAJI KUMBHAR",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "KOLHAPUR",
      "REGION": "ROM",
      "BRANCH CODE": "KOLH009"
    },
    {
      "EMP_CODE": "MA02844",
      "NAME": "RAJRATNA SHIVAJI KHARAT",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "NASIK",
      "REGION": "ROM",
      "BRANCH CODE": "NASI016"
    },
    {
      "EMP_CODE": "MA03219",
      "NAME": "DNYANESHWAR JIJABHAU SHINDE",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "AURANGABAD",
      "REGION": "ROM",
      "BRANCH CODE": "AURA017"
    },
    {
      "EMP_CODE": "MA03160",
      "NAME": "SUKESH HANJAGE",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "SOLAPUR",
      "REGION": "ROM",
      "BRANCH CODE": "SOLA019"
    },
    {
      "EMP_CODE": "MA02882",
      "NAME": "RANVEERKAR BALAJI ASHOK",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "AURANGABAD",
      "REGION": "ROM",
      "BRANCH CODE": "AURA017"
    },
    {
      "EMP_CODE": "MA02945",
      "NAME": "PAWANKUMAR GOPICHAND KHARADE",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "AURANGABAD",
      "REGION": "ROM",
      "BRANCH CODE": "AURA017"
    },
    {
      "EMP_CODE": "MA03402",
      "NAME": "CHETAN SURESH DABHAT",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "AHMEDNAGAR",
      "REGION": "ROM",
      "BRANCH CODE": "AHME008"
    },
    {
      "EMP_CODE": "MA03514",
      "NAME": "VIKRAM BABURAO GHUNAKE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KOLHAPUR",
      "REGION": "ROM",
      "BRANCH CODE": "KOLH009"
    },
    {
      "EMP_CODE": "MA03334",
      "NAME": "NILESH DHONDIRAM JADHAV",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "PUNE",
      "REGION": "ROM",
      "BRANCH CODE": "PUNE003"
    },
    {
      "EMP_CODE": "MA03354",
      "NAME": "RATNAKAR DASHRATH KHANDALE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "PUNE",
      "REGION": "ROM",
      "BRANCH CODE": "PUNE003"
    },
    {
      "EMP_CODE": "MA03366",
      "NAME": "HARSHAD RAJU GAIKWAD",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "PIMPRI",
      "REGION": "ROM",
      "BRANCH CODE": "PIMP092"
    },
    {
      "EMP_CODE": "MA03580",
      "NAME": "HARISH SHIVSHARAN JAKAPURE",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "SOLAPUR",
      "REGION": "ROM",
      "BRANCH CODE": "SOLA019"
    },
    {
      "EMP_CODE": "FA03361",
      "NAME": "PRATIKSHA PRAVIN DUSANE",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "NASIK",
      "REGION": "ROM",
      "BRANCH CODE": "NASI016"
    },
    {
      "EMP_CODE": "MA03562",
      "NAME": "GOUTAM BAJIRAO BHAGWAT",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KOLHAPUR",
      "REGION": "ROM",
      "BRANCH CODE": "KOLH009"
    },
    {
      "EMP_CODE": "MA03512",
      "NAME": "JAHIR ABBAS ABDUL RASHID SHAIKH",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "PUNE",
      "REGION": "ROM",
      "BRANCH CODE": "PUNE003"
    },
    {
      "EMP_CODE": "MA03513",
      "NAME": "BALKRISHNA SADASHIV JAKKA",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "PUNE",
      "REGION": "ROM",
      "BRANCH CODE": "PUNE003"
    },
    {
      "EMP_CODE": "MA03618",
      "NAME": "KHANDU RAOSAHEB SAWANT",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "AHMEDNAGAR",
      "REGION": "ROM",
      "BRANCH CODE": "AHME008"
    },
    {
      "EMP_CODE": "MA02885",
      "NAME": "PRASAD GANESH PURI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "AURANGABAD",
      "REGION": "ROM",
      "BRANCH CODE": "AURA017"
    },
    {
      "EMP_CODE": "MA03575",
      "NAME": "PRAKASH DNYANESHWAR RAUT",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "PUNE",
      "REGION": "ROM",
      "BRANCH CODE": "PUNE003"
    },
    {
      "EMP_CODE": "MA02078",
      "NAME": "KISHOR KAUTIKRAO CHAURE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "AURANGABAD",
      "REGION": "ROM",
      "BRANCH CODE": "AURA017"
    },
    {
      "EMP_CODE": "MA03737",
      "NAME": "KRISHNA VASUDEO CHAVAN",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "AURANGABAD",
      "REGION": "ROM",
      "BRANCH CODE": "AURA017"
    },
    {
      "EMP_CODE": "MA03770",
      "NAME": "SHIVAJI AMBADAS BHAWAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "AURANGABAD",
      "REGION": "ROM",
      "BRANCH CODE": "AURA017"
    },
    {
      "EMP_CODE": "MA03782",
      "NAME": "ATUL SUDAMRAO KSHIRSAGAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "PIMPRI",
      "REGION": "ROM",
      "BRANCH CODE": "PIMP092"
    },
    {
      "EMP_CODE": "MA03771",
      "NAME": "AMOL KISHOR BOTHE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "PIMPRI",
      "REGION": "ROM",
      "BRANCH CODE": "PIMP092"
    },
    {
      "EMP_CODE": "MA02892",
      "NAME": "GAURAV MADAN LAKHOTE",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "NASIK",
      "REGION": "ROM",
      "BRANCH CODE": "NASI016"
    },
    {
      "EMP_CODE": "MA02768",
      "NAME": "MANISH RAJENDRA PAWAR",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "JALGAON",
      "REGION": "ROM",
      "BRANCH CODE": "JALG018"
    },
    {
      "EMP_CODE": "FA03322",
      "NAME": "NIKITA PRAKASH PATIL",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "JALGAON",
      "REGION": "ROM",
      "BRANCH CODE": "JALG018"
    },
    {
      "EMP_CODE": "MA03383",
      "NAME": "GANESH VISHWANATH VISPUTE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "JALGAON",
      "REGION": "ROM",
      "BRANCH CODE": "JALG018"
    },
    {
      "EMP_CODE": "MA03526",
      "NAME": "MAYURESH SATISH KHARAT",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "PUNE",
      "REGION": "ROM",
      "BRANCH CODE": "PUNE003"
    },
    {
      "EMP_CODE": "MA03522",
      "NAME": "SHRIKANT MARUTI SHINDE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KOLHAPUR",
      "REGION": "ROM",
      "BRANCH CODE": "KOLH009"
    },
    {
      "EMP_CODE": "MA03576",
      "NAME": "AAKESH KAILASH BORGE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "PIMPRI",
      "REGION": "ROM",
      "BRANCH CODE": "PIMP092"
    },
    {
      "EMP_CODE": "MA03636",
      "NAME": "AJAY ANKUSH KADAM",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "PUNE",
      "REGION": "ROM",
      "BRANCH CODE": "PUNE003"
    },
    {
      "EMP_CODE": "MA02656",
      "NAME": "SURAJ RAMESH MUNDHE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "NASIK",
      "REGION": "ROM",
      "BRANCH CODE": "NASI016"
    },
    {
      "EMP_CODE": "MA02497",
      "NAME": "SAGAR NANAJI WAGH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "PUNE",
      "REGION": "ROM",
      "BRANCH CODE": "PUNE003"
    },
    {
      "EMP_CODE": "MA03555",
      "NAME": "SUJIT GOVIND MOHITE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "PUNE",
      "REGION": "ROM",
      "BRANCH CODE": "PUNE003"
    },
    {
      "EMP_CODE": "MA03493",
      "NAME": "SWAPNIL DNYANESHWAR INGLE",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "AURANGABAD",
      "REGION": "ROM",
      "BRANCH CODE": "AURA017"
    },
    {
      "EMP_CODE": "MA03022",
      "NAME": "YOGESHWAR BHAUSAHEB CHAVAN",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "AURANGABAD",
      "REGION": "ROM",
      "BRANCH CODE": "AURA017"
    },
    {
      "EMP_CODE": "MA03209",
      "NAME": "PRASHANT RAVINDRA THOMBARE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "AHMEDNAGAR",
      "REGION": "ROM",
      "BRANCH CODE": "AHME008"
    },
    {
      "EMP_CODE": "MA03226",
      "NAME": "AJINKYA SANJAY SURYWANSHI",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "PIMPRI",
      "REGION": "ROM",
      "BRANCH CODE": "PIMP092"
    },
    {
      "EMP_CODE": "MA02703",
      "NAME": "SHUBHAM DILIP KAKDE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "AURANGABAD",
      "REGION": "ROM",
      "BRANCH CODE": "AURA017"
    },
    {
      "EMP_CODE": "MA02023",
      "NAME": "BABASAHEB DATTATRAY BHALERAO",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "PUNE",
      "REGION": "ROM",
      "BRANCH CODE": "PUNE003"
    },
    {
      "EMP_CODE": "MA02823",
      "NAME": "SAGAR BALU DHANWADE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "PUNE",
      "REGION": "ROM",
      "BRANCH CODE": "PUNE003"
    },
    {
      "EMP_CODE": "MA03675",
      "NAME": "VIJAY MOHANRAO JADHAO",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "PIMPRI",
      "REGION": "ROM",
      "BRANCH CODE": "PIMP092"
    },
    {
      "EMP_CODE": "MA03239",
      "NAME": "GAUTAM BHIMRAV GAWLI",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "PIMPRI",
      "REGION": "ROM",
      "BRANCH CODE": "PIMP092"
    },
    {
      "EMP_CODE": "MA03331",
      "NAME": "VIVEK VIJAY JANGALE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KOLHAPUR",
      "REGION": "ROM",
      "BRANCH CODE": "KOLH009"
    },
    {
      "EMP_CODE": "MA03819",
      "NAME": "SACHIN GAIKWAD",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "AHMEDNAGAR",
      "REGION": "ROM",
      "BRANCH CODE": "AHME008"
    },
    {
      "EMP_CODE": "MA03799",
      "NAME": "MUKESH PRAKASH RAJPUT",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "PUNE",
      "REGION": "ROM",
      "BRANCH CODE": "PUNE003"
    },
    {
      "EMP_CODE": "MA03813",
      "NAME": "VIJAY JEEVAN SALVE",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH": "PIMPRI",
      "REGION": "ROM",
      "BRANCH CODE": "PIMP092"
    },
    {
      "EMP_CODE": "MA03814",
      "NAME": "HARI BHUPAL LOHAR",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KOLHAPUR",
      "REGION": "ROM",
      "BRANCH CODE": "KOLH009"
    },
    {
      "EMP_CODE": "MA03758",
      "NAME": "SAWROOP JAGADISH KOLI",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KOLHAPUR - SANGLI",
      "REGION": "ROM",
      "BRANCH CODE": "KOLH009"
    },
    {
      "EMP_CODE": "MA03727",
      "NAME": "AVINASH RAJARAM KAMBLE",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH": "KOLHAPUR - SANGLI",
      "REGION": "ROM",
      "BRANCH CODE": "KOLH009"
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
        .collection("documentList")
        .doc("documentList")
        .update({"documentList": FieldValue.arrayUnion(documentList)});
    print("hi");
  }

  @override
  Widget build(BuildContext context) {
   pushData();

    return Container();
  }


}
