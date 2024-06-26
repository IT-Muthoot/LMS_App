import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SaveData extends StatefulWidget {
  const SaveData({Key? key}) : super(key: key);

  @override
  State<SaveData> createState() => _SaveDataState();
}

class _SaveDataState extends State<SaveData> {

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

  List<Map<String, dynamic>> employeeMapping = [
    {
      "EMP_CODE": "MD00001",
      "NAME": "Ramesh Chandra Regar",
      "DSGN_NAME": "Relationship Manager",
      "BRANCH CODE": "BHIL024",
      "BRANCH": "BHILWARA",
      "REGION CODE": "RO0006",
      "REGION": "RAJASTHAN",
      "ZONE CODE": "ZO0003",
      "ZONE": "NORTH",
      "Reporting Manager Code": "MO1567",
      "Reporting Manager Name": "NITISH GOSWAMI",
      "Reporting_DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MD00002",
      "NAME": "Akash Dubey",
      "DSGN_NAME": "Relationship Officer",
      "BRANCH CODE": "VIRA999",
      "BRANCH": "MUMBAI - VIRAR",
      "REGION CODE": "RO0003",
      "REGION": "ROM",
      "ZONE CODE": "ZO0002",
      "ZONE": "WEST",
      "Reporting Manager Code": "MO1528",
      "Reporting Manager Name": "Sunil Shipurkar",
      "Reporting_DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MD00003",
      "NAME": "Gunju Rajesh",
      "DSGN_NAME": "Relationship Officer",
      "BRANCH CODE": "VIJA050",
      "BRANCH": "VIJAYAWADA",
      "REGION CODE": "RO0007",
      "REGION": "TAP",
      "ZONE CODE": "ZO0001",
      "ZONE": "SOUTH",
      "Reporting Manager Code": "MO1616",
      "Reporting Manager Name": "DAVID NELATURI",
      "Reporting_DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MD00004",
      "NAME": "Avinash Brijnarayan Vishwakarma",
      "DSGN_NAME": "Relationship Manager",
      "BRANCH CODE": "THAN037",
      "BRANCH": "MUMBAI - THANE",
      "REGION CODE": "RO0003",
      "REGION": "ROM",
      "ZONE CODE": "ZO0002",
      "ZONE": "WEST",
      "Reporting Manager Code": "MO1449",
      "Reporting Manager Name": "Kanhai jee",
      "Reporting_DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MD00010",
      "NAME": "Arkanti Kiran",
      "DSGN_NAME": "Relationship Officer",
      "BRANCH CODE": "KURN116",
      "BRANCH": "KURNOOL",
      "REGION CODE": "RO0007",
      "REGION": "TAP",
      "ZONE CODE": "ZO0001",
      "ZONE": "SOUTH",
      "Reporting Manager Code": "MO1580",
      "Reporting Manager Name": "NALLAMALLA SIVUDU",
      "Reporting_DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MD00011",
      "NAME": "Mutyala Vikram",
      "DSGN_NAME": "Relationship Officer",
      "BRANCH CODE": "NELL069",
      "BRANCH": "NELLORE",
      "REGION CODE": "RO0007",
      "REGION": "TAP",
      "ZONE CODE": "ZO0001",
      "ZONE": "SOUTH",
      "Reporting Manager Code": "MO1398",
      "Reporting Manager Name": "IQBAL SHAIK",
      "Reporting_DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MD00013",
      "NAME": "Sanjay Patil",
      "DSGN_NAME": "Relationship Officer",
      "BRANCH CODE": "NASI016",
      "BRANCH": "NASIK",
      "REGION CODE": "RO0003",
      "REGION": "ROM",
      "ZONE CODE": "ZO0002",
      "ZONE": "WEST",
      "Reporting Manager Code": "MO1690",
      "Reporting Manager Name": "Mohammad Khan",
      "Reporting_DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MD00014",
      "NAME": "Vicky Thorat",
      "DSGN_NAME": "Relationship Officer",
      "BRANCH CODE": "PIMP092",
      "BRANCH": "PIMPRI",
      "REGION CODE": "RO0003",
      "REGION": "ROM",
      "ZONE CODE": "ZO0002",
      "ZONE": "WEST",
      "Reporting Manager Code": "MO1595",
      "Reporting Manager Name": "PRASHANT PAWAR",
      "Reporting_DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MD00015",
      "NAME": "Shoeb Bagwan",
      "DSGN_NAME": "Relationship Manager",
      "BRANCH CODE": "SOLA019",
      "BRANCH": "SOLAPUR",
      "REGION CODE": "RO0003",
      "REGION": "ROM",
      "ZONE CODE": "ZO0002",
      "ZONE": "WEST",
      "Reporting Manager Code": "MO1138",
      "Reporting Manager Name": "Fahim Shaikh",
      "Reporting_DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MD00016",
      "NAME": "Gali Vijay",
      "DSGN_NAME": "Relationship Officer",
      "BRANCH CODE": "VIJA050",
      "BRANCH": "VIJAYAWADA",
      "REGION CODE": "RO0007",
      "REGION": "TAP",
      "ZONE CODE": "ZO0001",
      "ZONE": "SOUTH",
      "Reporting Manager Code": "MO1616",
      "Reporting Manager Name": "DAVID NELATURI",
      "Reporting_DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MD00019",
      "NAME": "Jagdish Laxman Sathe",
      "DSGN_NAME": "Relationship Officer",
      "BRANCH CODE": "KALY037",
      "BRANCH": "MUMBAI - KALYAN",
      "REGION CODE": "RO0003",
      "REGION": "ROM",
      "ZONE CODE": "ZO0002",
      "ZONE": "WEST",
      "Reporting Manager Code": "MO1388",
      "Reporting Manager Name": "SANTOSH DESHMUKH",
      "Reporting_DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MD00020",
      "NAME": "Rakesh Joshi",
      "DSGN_NAME": "Relationship Officer",
      "BRANCH CODE": "JODH014",
      "BRANCH": "JODHPUR",
      "REGION CODE": "RO0006",
      "REGION": "RAJASTHAN",
      "ZONE CODE": "ZO0003",
      "ZONE": "NORTH",
      "Reporting Manager Code": "MO1649",
      "Reporting Manager Name": "Mukesh Suthar",
      "Reporting_DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MD00021",
      "NAME": "Anil Kumar",
      "DSGN_NAME": "Relationship Officer",
      "BRANCH CODE": "YAMU057",
      "BRANCH": "YAMUNANAGAR",
      "REGION CODE": "RO0008",
      "REGION": "PCH",
      "ZONE CODE": "ZO0003",
      "ZONE": "NORTH",
      "Reporting Manager Code": "MO1289",
      "Reporting Manager Name": "SANJEEV KUMAR",
      "Reporting_DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MD00022",
      "NAME": "Ravi Saini",
      "DSGN_NAME": "Relationship Manager",
      "BRANCH CODE": "KANP018",
      "BRANCH": "KANPUR",
      "REGION CODE": "RO0012",
      "REGION": "UTTAR PRADESH",
      "ZONE CODE": "ZO0003",
      "ZONE": "NORTH",
      "Reporting Manager Code": "MO1192",
      "Reporting Manager Name": "ANIL MISHRA",
      "Reporting_DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MD00023",
      "NAME": "Madhusudan",
      "DSGN_NAME": "Relationship Officer",
      "BRANCH CODE": "TUMK053",
      "BRANCH": "BANGALORE-TUMKUR",
      "REGION CODE": "RO0010",
      "REGION": "KARNATAKA",
      "ZONE CODE": "ZO0001",
      "ZONE": "SOUTH",
      "Reporting Manager Code": "MO1123",
      "Reporting Manager Name": "Arun a",
      "Reporting_DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MD00024",
      "NAME": "Gurwinder Singh",
      "DSGN_NAME": "Relationship Officer",
      "BRANCH CODE": "CHAN057",
      "BRANCH": "CHANDIGARH",
      "REGION CODE": "RO0008",
      "REGION": "PCH",
      "ZONE CODE": "ZO0003",
      "ZONE": "NORTH",
      "Reporting Manager Code": "MO1682",
      "Reporting Manager Name": "MANI SINGH",
      "Reporting_DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MD00025",
      "NAME": "Vishal Arwade",
      "DSGN_NAME": "Relationship Officer",
      "BRANCH CODE": "AHME008",
      "BRANCH": "AHMEDNAGAR",
      "REGION CODE": "RO0003",
      "REGION": "ROM",
      "ZONE CODE": "ZO0002",
      "ZONE": "WEST",
      "Reporting Manager Code": "MO1263",
      "Reporting Manager Name": "ROHIT JADHAV",
      "Reporting_DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MD00028",
      "NAME": "Aakash Devidas Jagtap",
      "DSGN_NAME": "Relationship Manager",
      "BRANCH CODE": "NASI016",
      "BRANCH": "NASIK",
      "REGION CODE": "RO0003",
      "REGION": "ROM",
      "ZONE CODE": "ZO0002",
      "ZONE": "WEST",
      "Reporting Manager Code": "MO1690",
      "Reporting Manager Name": "Mohammad Khan",
      "Reporting_DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MD00031",
      "NAME": "Pankaj Sharma",
      "DSGN_NAME": "Relationship Officer",
      "BRANCH CODE": "SIKA047",
      "BRANCH": "SIKAR",
      "REGION CODE": "RO0006",
      "REGION": "RAJASTHAN",
      "ZONE CODE": "ZO0003",
      "ZONE": "NORTH",
      "Reporting Manager Code": "MO1484",
      "Reporting Manager Name": "PRITAM SHEKHAWAT",
      "Reporting_DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MD00032",
      "NAME": "Sangram Singh Gurjar",
      "DSGN_NAME": "Relationship Officer",
      "BRANCH CODE": "GWAL026",
      "BRANCH": "GWALIOR",
      "REGION CODE": "RO0004",
      "REGION": "MADHYA PRADESH",
      "ZONE CODE": "ZO0002",
      "ZONE": "WEST",
      "Reporting Manager Code": "MO1669",
      "Reporting Manager Name": "Ashutosh Sharma",
      "Reporting_DESIGNATION": "SALES MANAGER"
    },
    {
      "EMP_CODE": "MD00033",
      "NAME": "Vetriventhan M",
      "DSGN_NAME": "Relationship Manager",
      "BRANCH CODE": "MADU086",
      "BRANCH": "MADURAI",
      "REGION CODE": "RO0011",
      "REGION": "TAMILNADU",
      "ZONE CODE": "ZO0001",
      "ZONE": "SOUTH",
      "Reporting Manager Code": "MO1563",
      "Reporting Manager Name": "DHANAPANDIAN K",
      "Reporting_DESIGNATION": "SALES MANAGER"
    }
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


  List<Map<String, dynamic>> technicalChecklist  = [
    {
      "DNCR": {
        "Home Loan": {
          "Purchase Directly From Builder/Authority": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Draft/Agreement to sale/Allotment letter"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved Plan and commencement certificate"},
                {"ID": 2, "Title": "NA order / Receipt"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Draft/Agreement to sale/Allotment letter"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Electricity Bill (PDD)"},
                {"ID": 2, "Title": "Layout copy/Brochure"},
                {"ID": 3, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Draft/Agreement to sale/Allotment letter"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Electricity Bill (PDD)"},
                {"ID": 2, "Title": "Layout copy/Brochure"},
                {"ID": 3, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Draft/Agreement to sale/Allotment letter"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Electricity Bill (PDD)"},
                {"ID": 2, "Title": "Layout copy/Brochure"},
                {"ID": 3, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            }
          },
          "Resale Purchase": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved Plan and commencement certificate"},
                {"ID": 2, "Title": "Latest House tax receipt (If property falls within MC limit)"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            }
          },
          "Balance Transfer": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved Plan and commencement certificate"},
                {"ID": 2, "Title": "NA order / Receipt"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            }
          },
          "Home Extension": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Architect Estimate"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Architect Estimate"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Architect Estimate"}
              ]
            }
          },
          "Home Improvement/Rennovation": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Architect Estimate"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Architect Estimate"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Architect Estimate"}
              ]
            }
          },
          "Self-Construction": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Architect Estimate"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Architect Estimate"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Architect Estimate"}
              ]
            }
          },
          "Plot Purchase+Construction": {
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Draft/Agreement to sale/Allotment letter"},
                {"ID": 2, "Title": "Architect Estimate"},
                {"ID": 3, "Title": "Layout copy/Brochure"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Draft/Agreement to sale/Allotment letter"},
                {"ID": 2, "Title": "Architect Estimate"},
                {"ID": 3, "Title": "Layout copy/Brochure"}
              ]
            }
          }
        },
        "Non-Home Loan": {
          "Loan Against Commercial Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved Plan and commencement certificate"},
                {"ID": 2, "Title": "NA order / Receipt"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            }
          },
          "Balance Transfer - Loan Against Residential Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved Plan and commencement certificate"},
                {"ID": 2, "Title": "NA order / Receipt"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            }
          },
          "LOAN AGAINST COMMERCIAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved Plan and commencement certificate"},
                {"ID": 2, "Title": "NA order / Receipt"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            }
          },
          "LOAN FOR COMMERICAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved Plan and commencement certificate"},
                {"ID": 2, "Title": "NA order / Receipt"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            }
          },
          "MICRO/MINI - LOAN AGAINST RESIDENTAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved Plan and commencement certificate"},
                {"ID": 2, "Title": "NA order / Receipt"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            }
          },
          "Normal - Loan Against Residential Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved Plan and commencement certificate"},
                {"ID": 2, "Title": "NA order / Receipt"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            }
          },
          "Refinance": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved Plan and commencement certificate"},
                {"ID": 2, "Title": "NA order / Receipt"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            }
          },
          "Clinic Loan": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved Plan and commencement certificate"},
                {"ID": 2, "Title": "NA order / Receipt"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout copy/Brochure"},
                {"ID": 2, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer."}
              ]
            }
          },
          "Top-Up": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Electricity Bill or Property Tax receipts"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Electricity Bill or Property Tax receipts"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Electricity Bill or Property Tax receipts"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Electricity Bill or Property Tax receipts"},
              ]
            }
          },
        }
      }
    },//DNCR
    {
      "Rajasthan": {
        "Home Loan": {
          "Purchase Directly From Builder/Authority": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Sale agreement"},
                {"ID": 3, "Title": "Floor Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed/Sale agreement"},
                {"ID": 2, "Title": "Proposed estimate for construction"},
                {"ID": 3, "Title": "Floor Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed/Sale agreement"},
                {"ID": 2, "Title": "Proposed estimate for construction"},
                {"ID": 3, "Title": "Floor Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed/Sale agreement"},
                {"ID": 2, "Title": "Proposed estimate for construction"},
                {"ID": 3, "Title": "Floor Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            }
          },
          "Resale Purchase": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Sale agreement"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Sale agreement"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Sale agreement"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Sale agreement"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            }
          },
          "Balance Transfer": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            }
          },
          "Home Extension": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Estimate for extension with proposed construction plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Estimate for extension with proposed construction plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Estimate for extension with proposed construction plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            }
          },
          "Home Improvement/Rennovation": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Estimate for extension with proposed construction plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Estimate for extension with proposed construction plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Estimate for extension with proposed construction plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            }
          },
          "Self-Construction": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Estimate for extension with proposed construction plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Estimate for extension with proposed construction plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Estimate for extension with proposed construction plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            }
          },
          "Plot Purchase+Construction": {
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Sale agreement"},
                {"ID": 3, "Title": "Proposed estimate for construction"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan of scheme"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Sale agreement"},
                {"ID": 3, "Title": "Proposed estimate for construction"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan of scheme"},
              ]
            }
          }
        },
        "Non-Home Loan": {
          "Loan Against Commercial Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            }
          },
          "Balance Transfer - Loan Against Residential Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            }
          },
          "LOAN AGAINST COMMERCIAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            }
          },
          "LOAN FOR COMMERICAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            }
          },
          "MICRO/MINI - LOAN AGAINST RESIDENTAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            }
          },
          "Normal - Loan Against Residential Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            }
          },
          "Refinance": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            }
          },
          "Clinic Loan": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Electricity Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"}
              ]
            }
          },
          "Top-Up": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ]
            }
          },
        }
      }
    },//Rajasthan
    {
      "KERALA": {
        "Home Loan": {
          "Purchase Directly From Builder/Authority": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Sale Agreement / signed or draft"},
                {"ID": 3, "Title": "Approved Building plan & Permit"},
                {"ID": 4, "Title": "Lay Out Plan"},
                {"ID": 5, "Title": "Location Sketch"},
                {"ID": 6, "Title": "Rera Registration (if applicable)"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"},
                {"ID": 2, "Title": "Sale Agreement / signed or draft"},
                {"ID": 3, "Title": "Approved Building plan & Permit"},
                {"ID": 4, "Title": "Lay Out Plan"},
                {"ID": 5, "Title": "Location Sketch"},
                {"ID": 6, "Title": "Rera Registration (if applicable)"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
                {"ID": 5, "Title": "Possession Certificate"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"},
                {"ID": 2, "Title": "Sale Agreement / signed or draft"},
                {"ID": 3, "Title": "Approved Building plan & Permit"},
                {"ID": 4, "Title": "Lay Out Plan"},
                {"ID": 5, "Title": "Location Sketch"},
                {"ID": 6, "Title": "Rera Registration (if applicable)"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
                {"ID": 5, "Title": "Possession Certificate"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"},
                {"ID": 2, "Title": "Sale Agreement / signed or draft"},
                {"ID": 3, "Title": "Approved Building plan & Permit"},
                {"ID": 4, "Title": "Lay Out Plan"},
                {"ID": 5, "Title": "Location Sketch"},
                {"ID": 6, "Title": "Rera Registration (if applicable)"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
                {"ID": 5, "Title": "Possession Certificate"},
              ]
            }
          },
          "Resale Purchase": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Location Sketch"},
                {"ID": 3, "Title": "Sale Agreement / signed or draft"},
                {"ID": 4, "Title": "Building Tax Receipt"},
                {"ID": 5, "Title": "Land Tax receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Location Sketch"},
                {"ID": 3, "Title": "Sale Agreement / signed or draft"},
                {"ID": 4, "Title": "Building Tax Receipt"},
                {"ID": 5, "Title": "Land Tax receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Location Sketch"},
                {"ID": 3, "Title": "Sale Agreement / signed or draft"},
                {"ID": 4, "Title": "Building Tax Receipt"},
                {"ID": 5, "Title": "Land Tax receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Location Sketch"},
                {"ID": 3, "Title": "Sale Agreement / signed or draft"},
                {"ID": 4, "Title": "Building Tax Receipt"},
                {"ID": 5, "Title": "Land Tax receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"}
              ]
            }
          },
          "Balance Transfer": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            }
          },
          "Home Extension": {
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Location Sketch"},
                {"ID": 2, "Title": "Approved Extension Plan & Permit"},
                {"ID": 3, "Title": "Estimate for Extension"},
                {"ID": 4, "Title": "Building Tax Receipt"},
                {"ID": 5, "Title": "Land Tax receipt"},
                {"ID": 6, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Thandaper account statement"},
                {"ID": 3, "Title": "E C"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Location Sketch"},
                {"ID": 2, "Title": "Approved Extension Plan & Permit"},
                {"ID": 3, "Title": "Estimate for Extension"},
                {"ID": 4, "Title": "Building Tax Receipt"},
                {"ID": 5, "Title": "Land Tax receipt"},
                {"ID": 6, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Thandaper account statement"},
                {"ID": 3, "Title": "E C"}
              ]
            }
          },
          "Home Improvement/Rennovation": {
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Location Sketch"},
                {"ID": 2, "Title": "Approved Extension Plan & Permit"},
                {"ID": 3, "Title": "Estimate for Extension"},
                {"ID": 4, "Title": "Building Tax Receipt"},
                {"ID": 5, "Title": "Land Tax receipt"},
                {"ID": 6, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Thandaper account statement"},
                {"ID": 3, "Title": "E C"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Location Sketch"},
                {"ID": 2, "Title": "Approved Extension Plan & Permit"},
                {"ID": 3, "Title": "Estimate for Extension"},
                {"ID": 4, "Title": "Building Tax Receipt"},
                {"ID": 5, "Title": "Land Tax receipt"},
                {"ID": 6, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Thandaper account statement"},
                {"ID": 3, "Title": "E C"}
              ]
            }
          },
          "Self-Construction": {
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Location Sketch"},
                {"ID": 2, "Title": "Approved Extension Plan & Permit"},
                {"ID": 3, "Title": "Estimate for Extension"},
                {"ID": 4, "Title": "Building Tax Receipt"},
                {"ID": 5, "Title": "Land Tax receipt"},
                {"ID": 6, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Thandaper account statement"},
                {"ID": 3, "Title": "E C"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Location Sketch"},
                {"ID": 2, "Title": "Approved Extension Plan & Permit"},
                {"ID": 3, "Title": "Estimate for Extension"},
                {"ID": 4, "Title": "Building Tax Receipt"},
                {"ID": 5, "Title": "Land Tax receipt"},
                {"ID": 6, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Thandaper account statement"},
                {"ID": 3, "Title": "E C"}
              ]
            }
          },
          "Plot Purchase+Construction": {
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Location Sketch"},
                {"ID": 3, "Title": "Sale Agreement / signed or draft"},
                {"ID": 4, "Title": "Proposed Building plan"},
                {"ID": 5, "Title": "Proposed Estimate for Construction"},
                {"ID": 6, "Title": "Land Tax receipt"},
                {"ID": 7, "Title": "Lay Out Plan (If Plot Purchase from Large Extent)"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Location Sketch"},
                {"ID": 3, "Title": "Sale Agreement / signed or draft"},
                {"ID": 4, "Title": "Proposed Building plan"},
                {"ID": 5, "Title": "Proposed Estimate for Construction"},
                {"ID": 6, "Title": "Land Tax receipt"},
                {"ID": 7, "Title": "Lay Out Plan (If Plot Purchase from Large Extent)"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"}
              ]
            }
          }
        },
        "Non-Home Loan": {
          "Loan Against Commercial Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            }
          },
          "Balance Transfer - Loan Against Residential Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            }
          },
          "LOAN AGAINST COMMERCIAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            }
          },
          "LOAN FOR COMMERICAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            }
          },
          "MICRO/MINI - LOAN AGAINST RESIDENTAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            }
          },
          "Normal - Loan Against Residential Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            }
          },
          "Refinance": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            }
          },
          "Clinic Loan": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Land Tax receipt"},
                {"ID": 3, "Title": "Location Sketch"},
                {"ID": 4, "Title": "Building Tax Receipt"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Possession Certificate"},
                {"ID": 2, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Thandaper account statement"},
                {"ID": 4, "Title": "E C"},
              ]
            }
          },
          "Top-Up": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ]
            }
          },
        }
      }
    },//Kerala
    {
      "TAMILNADU": {
        "Home Loan": {
          "Purchase Directly From Builder/Authority": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed in favour of seller"},
                {"ID": 2, "Title": "sale agreement"},
                {"ID": 3, "Title": "plan approval/ working plan"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
                {"ID": 4, "Title": "Construction agreement if flat"},
                {"ID": 5, "Title": "Rera Registration (if applicable)"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed in favour of seller"},
                {"ID": 2, "Title": "sale agreement"},
                {"ID": 3, "Title": "plan approval/ working plan"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed in favour of seller"},
                {"ID": 2, "Title": "sale agreement"},
                {"ID": 3, "Title": "plan approval/ working plan"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed in favour of seller"},
                {"ID": 2, "Title": "sale agreement"},
                {"ID": 3, "Title": "plan approval/ working plan"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            }
          },
          "Resale Purchase": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed in favour of seller"},
                {"ID": 2, "Title": "sale agreement"},
                {"ID": 3, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
                {"ID": 4, "Title": "Construction agreement if flat"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed in favour of seller"},
                {"ID": 2, "Title": "sale agreement"},
                {"ID": 3, "Title": "Property tax receipt / Utility Bill"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed in favour of seller"},
                {"ID": 2, "Title": "sale agreement"},
                {"ID": 3, "Title": "Property tax receipt / Utility Bill"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed in favour of seller"},
                {"ID": 2, "Title": "sale agreement"},
                {"ID": 3, "Title": "Property tax receipt / Utility Bill"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            }
          },
          "Balance Transfer": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
                {"ID": 4, "Title": "Construction agreement if flat"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            }
          },
          "Home Extension": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "plan approval/Actual plan"},
                {"ID": 3, "Title": "Estimate"},
                {"ID": 4, "Title": "Property tax receipt / Utility Bill"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "plan approval/Actual plan"},
                {"ID": 3, "Title": "Estimate"},
                {"ID": 4, "Title": "Property tax receipt / Utility Bill"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "plan approval/Actual plan"},
                {"ID": 3, "Title": "Estimate"},
                {"ID": 4, "Title": "Property tax receipt / Utility Bill"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"}
              ]
            }
          },
          "Home Improvement/Rennovation": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "plan approval/Actual plan"},
                {"ID": 3, "Title": "Estimate"},
                {"ID": 4, "Title": "Property tax receipt / Utility Bill"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "plan approval/Actual plan"},
                {"ID": 3, "Title": "Estimate"},
                {"ID": 4, "Title": "Property tax receipt / Utility Bill"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "plan approval/Actual plan"},
                {"ID": 3, "Title": "Estimate"},
                {"ID": 4, "Title": "Property tax receipt / Utility Bill"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"}
              ]
            }
          },
          "Self-Construction": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "plan approval/Actual plan"},
                {"ID": 3, "Title": "Estimate"},
                {"ID": 4, "Title": "Property tax receipt / Utility Bill"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "plan approval/Actual plan"},
                {"ID": 3, "Title": "Estimate"},
                {"ID": 4, "Title": "Property tax receipt / Utility Bill"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "plan approval/Actual plan"},
                {"ID": 3, "Title": "Estimate"},
                {"ID": 4, "Title": "Property tax receipt / Utility Bill"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"}
              ]
            }
          },
          "Plot Purchase+Construction": {
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed in favour of seller"},
                {"ID": 2, "Title": "sale agreement"},
                {"ID": 3, "Title": "Layout"},
                {"ID": 4, "Title": "Plan approval/Actual plan"},
                {"ID": 5, "Title": "Estimate"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "FMB or TSLR/Patta"},
                {"ID": 2, "Title": "Seller sale deed"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed in favour of seller"},
                {"ID": 2, "Title": "sale agreement"},
                {"ID": 3, "Title": "Layout"},
                {"ID": 4, "Title": "Plan approval/Actual plan"},
                {"ID": 5, "Title": "Estimate"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "FMB or TSLR/Patta"},
                {"ID": 2, "Title": "Seller sale deed"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            }
          }
        },
        "Non-Home Loan": {
          "Loan Against Commercial Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
                {"ID": 4, "Title": "Construction agreement if flat"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            }
          },
          "Balance Transfer - Loan Against Residential Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
                {"ID": 4, "Title": "Construction agreement if flat"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            }
          },
          "LOAN AGAINST COMMERCIAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
                {"ID": 4, "Title": "Construction agreement if flat"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            }
          },
          "LOAN FOR COMMERICAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
                {"ID": 4, "Title": "Construction agreement if flat"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            }
          },
          "MICRO/MINI - LOAN AGAINST RESIDENTAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
                {"ID": 4, "Title": "Construction agreement if flat"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            }
          },
          "Normal - Loan Against Residential Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
                {"ID": 4, "Title": "Construction agreement if flat"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            }
          },
          "Refinance": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
                {"ID": 4, "Title": "Construction agreement if flat"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            }
          },
          "Clinic Loan": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
                {"ID": 4, "Title": "Construction agreement if flat"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax receipt / Utility Bill"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "FMB or TSLR/Patta"},
                {"ID": 3, "Title": "survery sketch"},
              ]
            }
          },
          "Top-Up": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ]
            }
          },
        }
      }
    }, // Tamilnadu
    {
      "KARNATAKA": {
        "Home Loan": {
          "Purchase Directly From Builder/Authority": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale agreement"},
                {"ID": 2, "Title": "Title deed"},
                {"ID": 3, "Title": "Khatha"},
                {"ID": 4, "Title": "Approved plan"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "Construction permission"},
                {"ID": 3, "Title": "Electricity Bill"},
                {"ID": 4, "Title": "RERA certificate"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale agreement"},
                {"ID": 2, "Title": "Title deed"},
                {"ID": 3, "Title": "Khatha"},
                {"ID": 4, "Title": "Approved plan"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": "Construction permission"},
                {"ID": 3, "Title": "Electricity Bill"},
                {"ID": 4, "Title": "RERA certificate"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale agreement"},
                {"ID": 2, "Title": "Title deed"},
                {"ID": 3, "Title": "Khatha"},
                {"ID": 4, "Title": "Approved plan"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": "Construction permission"},
                {"ID": 3, "Title": "Electricity Bill"},
                {"ID": 4, "Title": "RERA certificate"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale agreement"},
                {"ID": 2, "Title": "Title deed"},
                {"ID": 3, "Title": "Khatha"},
                {"ID": 4, "Title": "Approved plan"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": "Construction permission"},
                {"ID": 3, "Title": "Electricity Bill"},
                {"ID": 4, "Title": "RERA certificate"},
              ]
            }
          },
          "Resale Purchase": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale agreement"},
                {"ID": 2, "Title": "Title deed"},
                {"ID": 3, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "Construction permission"},
                {"ID": 3, "Title": "Electricity Bill"},
                {"ID": 4, "Title": " tax receipt"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale agreement"},
                {"ID": 2, "Title": "Title deed"},
                {"ID": 3, "Title": "Khatha"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": " tax receipt"},
                {"ID": 3, "Title": "Electricity Bill"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale agreement"},
                {"ID": 2, "Title": "Title deed"},
                {"ID": 3, "Title": "Khatha"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": " tax receipt"},
                {"ID": 3, "Title": "Electricity Bill"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale agreement"},
                {"ID": 2, "Title": "Title deed"},
                {"ID": 3, "Title": "Khatha"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": " tax receipt"},
                {"ID": 3, "Title": "Electricity Bill"},
              ]
            }
          },
          "Balance Transfer": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Khatha"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            }
          },
          "Home Extension": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"},
                {"ID": 3, "Title": "Approved /working plan"},
                {"ID": 4, "Title": "Estimation"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": "Construction permission"},
                {"ID": 3, "Title": "survery sketch"},
                {"ID": 4, "Title": "Electricity Bill"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"},
                {"ID": 3, "Title": "Approved /working plan"},
                {"ID": 4, "Title": "Estimation"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": "Construction permission"},
                {"ID": 3, "Title": "Survey sketch"},
                {"ID": 4, "Title": "Electricity Bill"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"},
                {"ID": 3, "Title": "Approved /working plan"},
                {"ID": 4, "Title": "Estimation"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": "Construction permission"},
                {"ID": 3, "Title": "Survey sketch"},
                {"ID": 4, "Title": "Electricity Bill"}
              ]
            }
          },
          "Home Improvement/Rennovation": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"},
                {"ID": 3, "Title": "Approved /working plan"},
                {"ID": 4, "Title": "Estimation"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": "Construction permission"},
                {"ID": 3, "Title": "survery sketch"},
                {"ID": 4, "Title": "Electricity Bill"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"},
                {"ID": 3, "Title": "Approved /working plan"},
                {"ID": 4, "Title": "Estimation"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": "Construction permission"},
                {"ID": 3, "Title": "Survey sketch"},
                {"ID": 4, "Title": "Electricity Bill"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"},
                {"ID": 3, "Title": "Approved /working plan"},
                {"ID": 4, "Title": "Estimation"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": "Construction permission"},
                {"ID": 3, "Title": "Survey sketch"},
                {"ID": 4, "Title": "Electricity Bill"}
              ]
            }
          },
          "Self-Construction": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"},
                {"ID": 3, "Title": "Approved /working plan"},
                {"ID": 4, "Title": "Estimation"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": "Construction permission"},
                {"ID": 3, "Title": "survery sketch"},
                {"ID": 4, "Title": "Electricity Bill"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"},
                {"ID": 3, "Title": "Approved /working plan"},
                {"ID": 4, "Title": "Estimation"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": "Construction permission"},
                {"ID": 3, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Electricity Bill"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"},
                {"ID": 3, "Title": "Approved /working plan"},
                {"ID": 4, "Title": "Estimation"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout plan"},
                {"ID": 2, "Title": "Construction permission"},
                {"ID": 3, "Title": "Survey sketch"},
                {"ID": 3, "Title": "Electricity Bill"}
              ]
            }
          },
          "Plot Purchase+Construction": {
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale agreement"},
                {"ID": 2, "Title": "Title deed"},
                {"ID": 3, "Title": "Khatha"},
                {"ID": 4, "Title": "Layout plan"},
                {"ID": 5, "Title": "Estimate"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Survey sketch"},
                {"ID": 2, "Title": "Estimation"},
                {"ID": 3, "Title": "plan approval/Actual plan"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale agreement"},
                {"ID": 2, "Title": "Title deed"},
                {"ID": 3, "Title": "Khatha"},
                {"ID": 4, "Title": "Layout plan"},
                {"ID": 5, "Title": "Estimate"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Survey sketch"},
                {"ID": 2, "Title": "Estimation"},
                {"ID": 3, "Title": "plan approval/Actual plan"},
              ]
            }
          }
        },
        "Non-Home Loan": {
          "Loan Against Commercial Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Khatha"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            }
          },
          "Balance Transfer - Loan Against Residential Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Khatha"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            }
          },
          "LOAN AGAINST COMMERCIAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Khatha"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            }
          },
          "LOAN FOR COMMERICAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Khatha"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            }
          },
          "MICRO/MINI - LOAN AGAINST RESIDENTAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Khatha"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            }
          },
          "Normal - Loan Against Residential Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Khatha"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            }
          },
          "Refinance": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Khatha"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            }
          },
          "Clinic Loan": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Khatha"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            }
          },
          "Top-Up": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ]
            }
          },
        }
      }
    }, // Karnataka
    {
      "TAP": {
        "Home Loan": {
          "Purchase Directly From Builder/Authority": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Agreement of Sale"},
                {"ID": 2, "Title": "Link document"},
                {"ID": 3, "Title": "Plan approval / Architect plan"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "Survey map"},
                {"ID": 3, "Title": "Location Sketch"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Agreement of Sale"},
                {"ID": 2, "Title": "Link document"},
                {"ID": 3, "Title": "Plan approval / Architect plan"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "Survey map"},
                {"ID": 3, "Title": "Location Sketch"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Agreement of Sale"},
                {"ID": 2, "Title": "Link document"},
                {"ID": 3, "Title": "Plan approval / Architect plan"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "Survey map"},
                {"ID": 3, "Title": "Location Sketch"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Agreement of Sale"},
                {"ID": 2, "Title": "Link document"},
                {"ID": 3, "Title": "Plan approval / Architect plan"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Lay out"},
                {"ID": 2, "Title": "Survey map"},
                {"ID": 3, "Title": "Location Sketch"},
              ]
            }
          },
          "Resale Purchase": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Agreement of Sale"},
                {"ID": 2, "Title": "Link document"},
                {"ID": 3, "Title": "Property tax"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "plan approval"},
                {"ID": 2, "Title": "Location Sketch"},
                {"ID": 3, "Title": "Survey map"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Agreement of Sale"},
                {"ID": 2, "Title": "Link document"},
                {"ID": 3, "Title": "Property tax"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "plan approval"},
                {"ID": 2, "Title": "Location Sketch"},
                {"ID": 3, "Title": "Survey map"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Agreement of Sale"},
                {"ID": 2, "Title": "Link document"},
                {"ID": 3, "Title": "Property tax"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "plan approval"},
                {"ID": 2, "Title": "Location Sketch"},
                {"ID": 3, "Title": "Survey map"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Agreement of Sale"},
                {"ID": 2, "Title": "Link document"},
                {"ID": 3, "Title": "Property tax"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "plan approval"},
                {"ID": 2, "Title": "Location Sketch"},
                {"ID": 3, "Title": "Survey map"},
              ]
            }
          },
          "Balance Transfer": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout"},
                {"ID": 2, "Title": "Location Sketch"},
                {"ID": 3, "Title": "Survey map"},
                {"ID": 4, "Title": "plan approval"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout"},
                {"ID": 2, "Title": "Location Sketch"},
                {"ID": 3, "Title": "Survey map"},
                {"ID": 4, "Title": "plan approval"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout"},
                {"ID": 2, "Title": "Location Sketch"},
                {"ID": 3, "Title": "Survey map"},
                {"ID": 4, "Title": "plan approval"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Property tax"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout"},
                {"ID": 2, "Title": "Location Sketch"},
                {"ID": 3, "Title": "Survey map"},
                {"ID": 4, "Title": "plan approval"}
              ]
            }
          },
          "Home Extension": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Plan approval / Architect plan"},
                {"ID": 3, "Title": "Property tax"},
                {"ID": 4, "Title": "Estimation"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Location Sketch"},
                {"ID": 2, "Title": "Survey map"},
                {"ID": 3, "Title": "Link document"},
                {"ID": 4, "Title": "Estimation for Extension"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Plan approval / Architect plan"},
                {"ID": 3, "Title": "Property tax"},
                {"ID": 4, "Title": "Estimation"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Location Sketch"},
                {"ID": 2, "Title": "Survey map"},
                {"ID": 3, "Title": "Link document"},
                {"ID": 4, "Title": "Estimation for Extension"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Plan approval / Architect plan"},
                {"ID": 3, "Title": "Property tax"},
                {"ID": 4, "Title": "Estimation"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Location Sketch"},
                {"ID": 2, "Title": "Survey map"},
                {"ID": 3, "Title": "Link document"},
                {"ID": 4, "Title": "Estimation for Extension"}
              ]
            }
          },
          "Home Improvement/Rennovation": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Plan approval / Architect plan"},
                {"ID": 3, "Title": "Property tax"},
                {"ID": 4, "Title": "Estimation"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Location Sketch"},
                {"ID": 2, "Title": "Survey map"},
                {"ID": 3, "Title": "Link document"},
                {"ID": 4, "Title": "Estimation for Extension"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Plan approval / Architect plan"},
                {"ID": 3, "Title": "Property tax"},
                {"ID": 4, "Title": "Estimation"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Location Sketch"},
                {"ID": 2, "Title": "Survey map"},
                {"ID": 3, "Title": "Link document"},
                {"ID": 4, "Title": "Estimation for Extension"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Plan approval / Architect plan"},
                {"ID": 3, "Title": "Property tax"},
                {"ID": 4, "Title": "Estimation"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Location Sketch"},
                {"ID": 2, "Title": "Survey map"},
                {"ID": 3, "Title": "Link document"},
                {"ID": 4, "Title": "Estimation for Extension"}
              ]
            }
          },
          "Self-Construction": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Plan approval / Architect plan"},
                {"ID": 3, "Title": "Property tax"},
                {"ID": 4, "Title": "Estimation"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Location Sketch"},
                {"ID": 2, "Title": "Survey map"},
                {"ID": 3, "Title": "Link document"},
                {"ID": 4, "Title": "Estimation for Extension"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Plan approval / Architect plan"},
                {"ID": 3, "Title": "Property tax"},
                {"ID": 4, "Title": "Estimation"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Location Sketch"},
                {"ID": 2, "Title": "Survey map"},
                {"ID": 3, "Title": "Link document"},
                {"ID": 4, "Title": "Estimation for Extension"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Plan approval / Architect plan"},
                {"ID": 3, "Title": "Property tax"},
                {"ID": 4, "Title": "Estimation"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Location Sketch"},
                {"ID": 2, "Title": "Survey map"},
                {"ID": 3, "Title": "Link document"},
                {"ID": 4, "Title": "Estimation for Extension"}
              ]
            }
          },
          "Plot Purchase+Construction": {
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Agreement of Sale"},
                {"ID": 2, "Title": "Link document"},
                {"ID": 3, "Title": "Plan approval / Architect plan"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout"},
                {"ID": 2, "Title": "Location Sketch"},
                {"ID": 3, "Title": "Survey map"},
                {"ID": 3, "Title": "Estimation"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Agreement of Sale"},
                {"ID": 2, "Title": "Link document"},
                {"ID": 3, "Title": "Plan approval / Architect plan"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Layout"},
                {"ID": 2, "Title": "Location Sketch"},
                {"ID": 3, "Title": "Survey map"},
                {"ID": 3, "Title": "Estimation"}
              ]
            }
          }
        },
        "Non-Home Loan": {
          "Loan Against Commercial Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Khatha"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            }
          },
          "Balance Transfer - Loan Against Residential Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Khatha"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            }
          },
          "LOAN AGAINST COMMERCIAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Khatha"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            }
          },
          "LOAN FOR COMMERICAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Khatha"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            }
          },
          "MICRO/MINI - LOAN AGAINST RESIDENTAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Khatha"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            }
          },
          "Normal - Loan Against Residential Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Khatha"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            }
          },
          "Refinance": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Khatha"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            }
          },
          "Clinic Loan": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale deed"},
                {"ID": 2, "Title": "Khatha"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Khatha"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved plan & permission"},
                {"ID": 2, "Title": "Electricity Bill"},
              ]
            }
          },
          "Top-Up": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ]
            }
          },
        }
      }
    }, // TAP
    {
      "PCH": {
        "Home Loan": {
          "Purchase Directly From Builder/Authority": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Agreement to sell"},
                {"ID": 3, "Title": "MC/DA Approved map if MAP applicable or availability."}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Route Map/Key Plan"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Agreement to sell"},
                {"ID": 3, "Title": "MC/DA Approved map if MAP applicable or availability."},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Route Map/Key Plan"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Agreement to sell"},
                {"ID": 3, "Title": "MC/DA Approved map if MAP applicable or availability."},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Route Map/Key Plan"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Agreement to sell"},
                {"ID": 3, "Title": "MC/DA Approved map if MAP applicable or availability."},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Route Map/Key Plan"}
              ]
            }
          },
          "Resale Purchase": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"},
                {"ID": 2, "Title": "Agreement to sell"},
                {"ID": 3, "Title": "Property tax"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Route Map/Key Plan"},
                {"ID": 2, "Title": "Colony layout plan (Demanded Case To Case bases )"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"},
                {"ID": 2, "Title": "Agreement to sell"},
                {"ID": 3, "Title": "Property tax"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Route Map/Key Plan"},
                {"ID": 2, "Title": "Colony layout plan (Demanded Case To Case bases )"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"},
                {"ID": 2, "Title": "Agreement to sell"},
                {"ID": 3, "Title": "Property tax"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Route Map/Key Plan"},
                {"ID": 2, "Title": "Colony layout plan (Demanded Case To Case bases )"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"},
                {"ID": 2, "Title": "Agreement to sell"},
                {"ID": 3, "Title": "Property tax"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Route Map/Key Plan"},
                {"ID": 2, "Title": "Colony layout plan (Demanded Case To Case bases )"}
              ]
            }
          },
          "Balance Transfer": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            }
          },
          "Home Extension": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Customer declaration for Estimate & built-up area as per competition with proposed Covered area and COC as per standard."}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Route Map/Key Plan"},
                {"ID": 2, "Title": "Architect Estimate and Map with proposed area Details (before disbursal)"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Customer declaration for Estimate & built-up area as per competition with proposed Covered area and COC as per standard."}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Route Map/Key Plan"},
                {"ID": 2, "Title": "Architect Estimate and Map with proposed area Details (before disbursal)"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Customer declaration for Estimate & built-up area as per competition with proposed Covered area and COC as per standard."}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Route Map/Key Plan"},
                {"ID": 2, "Title": "Architect Estimate and Map with proposed area Details (before disbursal)"}
              ]
            }
          },
          "Home Improvement/Rennovation": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Customer declaration for Estimate & built-up area as per competition with proposed Covered area and COC as per standard."}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Route Map/Key Plan"},
                {"ID": 2, "Title": "Architect Estimate and Map with proposed area Details (before disbursal)"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Customer declaration for Estimate & built-up area as per competition with proposed Covered area and COC as per standard."}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Route Map/Key Plan"},
                {"ID": 2, "Title": "Architect Estimate and Map with proposed area Details (before disbursal)"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Customer declaration for Estimate & built-up area as per competition with proposed Covered area and COC as per standard."}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Route Map/Key Plan"},
                {"ID": 2, "Title": "Architect Estimate and Map with proposed area Details (before disbursal)"}
              ]
            }
          },
          "Self-Construction": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Customer declaration for Estimate & built-up area as per competition with proposed Covered area and COC as per standard."}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Route Map/Key Plan"},
                {"ID": 2, "Title": "Architect Estimate and Map with proposed area Details (before disbursal)"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Customer declaration for Estimate & built-up area as per competition with proposed Covered area and COC as per standard."}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Route Map/Key Plan"},
                {"ID": 2, "Title": "Architect Estimate and Map with proposed area Details (before disbursal)"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Customer declaration for Estimate & built-up area as per competition with proposed Covered area and COC as per standard."}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Route Map/Key Plan"},
                {"ID": 2, "Title": "Architect Estimate and Map with proposed area Details (before disbursal)"}
              ]
            }
          },
          "Plot Purchase+Construction": {
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Agreement to sell"},
                {"ID": 3, "Title": "Customer declaration for Estimate & built-up area as per competition with proposed Covered area and COC as per standard."},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Architect Estimate and Map with proposed area Details (before disbursal)"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title deed"},
                {"ID": 2, "Title": "Agreement to sell"},
                {"ID": 3, "Title": "Customer declaration for Estimate & built-up area as per competition with proposed Covered area and COC as per standard."},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Architect Estimate and Map with proposed area Details (before disbursal)"},
              ]
            }
          }
        },
        "Non-Home Loan": {
          "Loan Against Commercial Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            }
          },
          "Balance Transfer - Loan Against Residential Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            }
          },
          "LOAN AGAINST COMMERCIAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            }
          },
          "LOAN FOR COMMERICAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            }
          },
          "MICRO/MINI - LOAN AGAINST RESIDENTAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            }
          },
          "Normal - Loan Against Residential Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            }
          },
          "Refinance": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            }
          },
          "Clinic Loan": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "House Tax Receipt, Magistrate Affidavit ,PMR ( Required case to case)"}
              ]
            }
          },
          "Top-Up": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Route Map/Key Plan"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Route Map/Key Plan"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Route Map/Key Plan"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Route Map/Key Plan"}
              ]
            }
          },
        }
      }
    }, // PCH
    {
      "UTTAR PRADESH": {
        "Home Loan": {
          "Purchase Directly From Builder/Authority": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sanction building plan/floor plan by approved architect"},
                {"ID": 2, "Title": "Agreement to sale/Draft Agreement/Seller Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "T&CP Layout/Builder Layout if applicable"},
                {"ID": 2, "Title": "RERA Registration copy if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sanction building plan/floor plan by approved architect"},
                {"ID": 2, "Title": "Agreement to sale/Draft Agreement/Seller Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "T&CP Layout/Builder Layout if applicable"},
                {"ID": 2, "Title": "RERA Registration copy if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sanction building plan/floor plan by approved architect"},
                {"ID": 2, "Title": "Agreement to sale/Draft Agreement/Seller Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "T&CP Layout/Builder Layout if applicable"},
                {"ID": 2, "Title": "RERA Registration copy if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sanction building plan/floor plan by approved architect"},
                {"ID": 2, "Title": "Agreement to sale/Draft Agreement/Seller Deed"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "T&CP Layout/Builder Layout if applicable"},
                {"ID": 2, "Title": "RERA Registration copy if applicable"}
              ]
            }
          },
          "Resale Purchase": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Sanction building plan by approved architect"},
                {"ID": 2, "Title": "Agreement to sale/Draft Agreement/Seller Deed"},
                {"ID": 3, "Title": "E-bill/Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Identification issue-Patwari Nazri Naksa Report/Location Plan."},
                {"ID": 2, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 3, "Title": "T&CP Layout/Builder Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sanction building plan by approved architect"},
                {"ID": 2, "Title": "Agreement to sale/Draft Agreement/Seller Deed"},
                {"ID": 3, "Title": "E-bill/Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Identification issue-Patwari Nazri Naksa Report/Location Plan."},
                {"ID": 2, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 3, "Title": "T&CP Layout/Builder Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sanction building plan by approved architect"},
                {"ID": 2, "Title": "Agreement to sale/Draft Agreement/Seller Deed"},
                {"ID": 3, "Title": "E-bill/Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Identification issue-Patwari Nazri Naksa Report/Location Plan."},
                {"ID": 2, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 3, "Title": "T&CP Layout/Builder Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Sanction building plan by approved architect"},
                {"ID": 2, "Title": "Agreement to sale/Draft Agreement/Seller Deed"},
                {"ID": 3, "Title": "E-bill/Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Identification issue-Patwari Nazri Naksa Report/Location Plan."},
                {"ID": 2, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 3, "Title": "T&CP Layout/Builder Layout if applicable"}
              ]
            }
          },
          "Balance Transfer": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            }
          },
          "Home Extension": {
            "Apartment": {
                "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "Detailed Estimate/Architect Plan"}
                ],
                "Non Mandatory": [
                {"ID": 1, "Title": "Patwari Nazri Naksha Report/Location Plan."},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paidreceipt"},
                {"ID": 3, "Title": "T&CP Layout/Builder Layout if applicable"}
                ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "Detailed Estimate/Architect Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Patwari Nazri Naksha Report/Location Plan."},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paidreceipt"},
                {"ID": 3, "Title": "T&CP Layout/Builder Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "Detailed Estimate/Architect Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Patwari Nazri Naksha Report/Location Plan."},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paidreceipt"},
                {"ID": 3, "Title": "T&CP Layout/Builder Layout if applicable"}
              ]
            }
          },
          "Home Improvement/Rennovation": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "Detailed Estimate/Architect Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Patwari Nazri Naksha Report/Location Plan."},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paidreceipt"},
                {"ID": 3, "Title": "T&CP Layout/Builder Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "Detailed Estimate/Architect Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Patwari Nazri Naksha Report/Location Plan."},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paidreceipt"},
                {"ID": 3, "Title": "T&CP Layout/Builder Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "Detailed Estimate/Architect Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Patwari Nazri Naksha Report/Location Plan."},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paidreceipt"},
                {"ID": 3, "Title": "T&CP Layout/Builder Layout if applicable"}
              ]
            }
          },
          "Self-Construction": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "Detailed Estimate/Architect Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Patwari Nazri Naksha Report/Location Plan."},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paidreceipt"},
                {"ID": 3, "Title": "T&CP Layout/Builder Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "Detailed Estimate/Architect Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Patwari Nazri Naksha Report/Location Plan."},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paidreceipt"},
                {"ID": 3, "Title": "T&CP Layout/Builder Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "Detailed Estimate/Architect Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Patwari Nazri Naksha Report/Location Plan."},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paidreceipt"},
                {"ID": 3, "Title": "T&CP Layout/Builder Layout if applicable"}
              ]
            }
          },
          "Plot Purchase+Construction": {
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Agreement to Sale"},
                {"ID": 3, "Title": "Architect drawn Map & Estimate"},
                {"ID": 4, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by seller & buyer"},
                {"ID": 5, "Title": "Mauka patwari/pointer plan required case to case basis"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Architect Estimate and Map with proposed area Details (before disbursal)"},
                {"ID": 2, "Title": "Society layout plan(Incase where numbering of Plots is seen in sale deed)"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Sale Deed"},
                {"ID": 2, "Title": "Agreement to Sale"},
                {"ID": 3, "Title": "Architect drawn Map & Estimate"},
                {"ID": 4, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by seller & buyer"},
                {"ID": 5, "Title": "Mauka patwari/pointer plan required case to case basis"},
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Architect Estimate and Map with proposed area Details (before disbursal)"},
                {"ID": 2, "Title": "Society layout plan(Incase where numbering of Plots is seen in sale deed)"}
              ]
            }
          }
        },
        "Non-Home Loan": {
          "Loan Against Commercial Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            }
          },
          "Balance Transfer - Loan Against Residential Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            }
          },
          "LOAN AGAINST COMMERCIAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            }
          },
          "LOAN FOR COMMERICAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            }
          },
          "MICRO/MINI - LOAN AGAINST RESIDENTAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            }
          },
          "Normal - Loan Against Residential Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            }
          },
          "Refinance": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            }
          },
          "Clinic Loan": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Applicant’s sale deed"},
                {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
                {"ID": 3, "Title": "Latest Property Tax paid receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "If Property age is More than 30Year so we have require Structure Stability Report."},
                {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"}
              ]
            }
          },
          "Top-Up": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Old technical report/Electricity Bill /Property Tax receipts"},
              ]
            }
          },
        }
      }
    }, // Uttar Pradesh
    {
      "ROM": {
        "Home Loan": {
          "Purchase Directly From Builder/Authority": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Building plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "CC / OC, Rera Certificate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Building plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "CC / OC, Rera Certificate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Building plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "CC / OC, Rera Certificate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Building plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "CC / OC, Rera Certificate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            }
          },
          "Resale Purchase": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Balance Transfer": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Home Extension": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            }
          },
          "Home Improvement/Rennovation": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            }
          },
          "Self-Construction": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            }
          },
          "Plot Purchase+Construction": {
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            }
          }
        },
        "Non-Home Loan": {
          "Loan Against Commercial Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Balance Transfer - Loan Against Residential Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "LOAN AGAINST COMMERCIAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "LOAN FOR COMMERICAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "MICRO/MINI - LOAN AGAINST RESIDENTAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Normal - Loan Against Residential Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Refinance": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Clinic Loan": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Top-Up": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"},
              ]
            }
          },
        }
      }
    }, // ROM
    {
      "MP": {
        "Home Loan": {
          "Purchase Directly From Builder/Authority": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Building plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "CC / OC, Rera Certificate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Building plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "CC / OC, Rera Certificate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Building plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "CC / OC, Rera Certificate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Building plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "CC / OC, Rera Certificate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            }
          },
          "Resale Purchase": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Balance Transfer": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Home Extension": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            }
          },
          "Home Improvement/Rennovation": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            }
          },
          "Self-Construction": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            }
          },
          "Plot Purchase+Construction": {
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            }
          }
        },
        "Non-Home Loan": {
          "Loan Against Commercial Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Balance Transfer - Loan Against Residential Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "LOAN AGAINST COMMERCIAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "LOAN FOR COMMERICAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "MICRO/MINI - LOAN AGAINST RESIDENTAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Normal - Loan Against Residential Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Refinance": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Clinic Loan": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Top-Up": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"},
              ]
            }
          },
        }
      }
    }, // MP
    {
      "Gujarat": {
        "Home Loan": {
          "Purchase Directly From Builder/Authority": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Building plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "CC / OC, Rera Certificate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Building plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "CC / OC, Rera Certificate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Building plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "CC / OC, Rera Certificate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Building plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "CC / OC, Rera Certificate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            }
          },
          "Resale Purchase": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Balance Transfer": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Home Extension": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            }
          },
          "Home Improvement/Rennovation": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            }
          },
          "Self-Construction": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            }
          },
          "Plot Purchase+Construction": {
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            }
          }
        },
        "Non-Home Loan": {
          "Loan Against Commercial Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Balance Transfer - Loan Against Residential Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "LOAN AGAINST COMMERCIAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "LOAN FOR COMMERICAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "MICRO/MINI - LOAN AGAINST RESIDENTAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Normal - Loan Against Residential Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Refinance": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Clinic Loan": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Top-Up": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"},
              ]
            }
          },
        }
      }
    }, // Gujarat
    {
      "Mumbai": {
        "Home Loan": {
          "Purchase Directly From Builder/Authority": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Building plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "CC / OC, Rera Certificate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Building plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "CC / OC, Rera Certificate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Building plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "CC / OC, Rera Certificate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Building plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "CC / OC, Rera Certificate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            }
          },
          "Resale Purchase": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Balance Transfer": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Home Extension": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            }
          },
          "Home Improvement/Rennovation": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            }
          },
          "Self-Construction": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Titile document"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            }
          },
          "Plot Purchase+Construction": {
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Plan"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Estimate"},
                {"ID": 3, "Title": "Layout if applicable"}
              ]
            }
          }
        },
        "Non-Home Loan": {
          "Loan Against Commercial Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Balance Transfer - Loan Against Residential Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "LOAN AGAINST COMMERCIAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "LOAN FOR COMMERICAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "MICRO/MINI - LOAN AGAINST RESIDENTAL PROPERTY": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Normal - Loan Against Residential Property": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Refinance": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Clinic Loan": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "ATS / Draft copy"},
                {"ID": 2, "Title": "Seller Title document if applicable"},
                {"ID": 3, "Title": "Sanction plan / CC / OC"},
                {"ID": 4, "Title": "Title document"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Land diversion order ( NA Order/ Zone certificate / Gaothan certificate /  Land use certificate etc )"},
                {"ID": 2, "Title": "Ebill / PTR"},
                {"ID": 3, "Title": "CC / OC if applicable"},
                {"ID": 4, "Title": "Layout if applicable"}
              ]
            }
          },
          "Top-Up": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"},
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"},
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"},
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title document"},
              ]
            }
          },
        }
      }
    }, // Mumbai
  ];




  List<Map<String, dynamic>> documentChecklist = [
    {
      "TAMILNADU": {
        "Home Loan": {
          "Self-Construction": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Plan approval/Actual plan"},
              {"ID": 3, "Title": "Estimate"}
            ],
            "Non Mandatory": [
              {"ID": 1, "Title": "Lay out"},
              {"ID": 2, "Title": "FMB or TSLR/Patta"},
              {"ID": 3, "Title": "survery sketch"}
            ]
          },
          "Purchase Directly From Builder/Authority": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed in favour of seller"},
              {"ID": 2, "Title": "Sale agreement"},
              {"ID": 3, "Title": "Plan approval"}
            ],
            "Non Mandatory": [
              {"ID": 1, "Title": "Lay out"},
              {"ID": 2, "Title": "FMB or TSLR/Patta"},
              {"ID": 3, "Title": "survery sketch"},
              {"ID": 4, "Title": "Construction agreement if flat"},
            ]
          },
          "Resale Purchase": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed in favour of seller"},
              {"ID": 2, "Title": "Sale agreement"},
              {"ID": 3, "Title": "Property tax receipt"}
            ],
            "Non Mandatory": [
              {"ID": 1, "Title": "Lay out"},
              {"ID": 2, "Title": "FMB or TSLR/Patta"},
              {"ID": 3, "Title": "survery sketch"},
              {"ID": 4, "Title": "Construction agreement if flat"},
            ]
          },
          "Plot Purchase+Construction": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale agreement"},
              {"ID": 2, "Title": "Layout approval"},
              {"ID": 3, "Title": "Plan approval/Actual plan"},
              {"ID": 4, "Title": "Estimate"}
            ],
            "Non Mandatory": [
              {"ID": 1, "Title": "FMB or TSLR/Patta"},
              {"ID": 2, "Title": "Seller sale deed"},
              {"ID": 3, "Title": "survery sketch"},
            ]
          },
          "Home Improvement/Rennovation": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Plan approval/Actual plan"},
              {"ID": 3, "Title": "Estimate"}
            ],
            "Non Mandatory": [
              {"ID": 1, "Title": "Lay out"},
              {"ID": 2, "Title": "FMB or TSLR/Patta"},
              {"ID": 3, "Title": "survery sketch"}
            ]
          },
          "Home Extension": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Plan approval/Actual plan"},
              {"ID": 3, "Title": "Estimate"}
            ],
            "Non Mandatory": [
              {"ID": 1, "Title": "Lay out"},
              {"ID": 2, "Title": "FMB or TSLR/Patta"},
              {"ID": 3, "Title": "survery sketch"}
            ]
          },
          "Balance Transfer": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Property tax receipt"}
            ],
            "Non Mandatory": [
              {"ID": 1, "Title": "Lay out"},
              {"ID": 2, "Title": "FMB or TSLR/Patta"},
              {"ID": 3, "Title": "survery sketch"},
              {"ID": 4, "Title": "Construction agreement if flat"},
            ]
          }
        },
        "Non-Home Loan": {
          "Normal - Loan Against Residential Property": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Property tax receipt"}
            ],
            "Non Mandatory": [
              {"ID": 1, "Title": "Lay out"},
              {"ID": 2, "Title": "FMB or TSLR/Patta"},
              {"ID": 3, "Title": "survery sketch"},
              {"ID": 4, "Title": "Construction agreement if flat"},
            ]
          },
          "Balance Transfer - Loan Against Residential Property": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Property tax receipt"}
            ],
            "Non Mandatory": [
              {"ID": 1, "Title": "Lay out"},
              {"ID": 2, "Title": "FMB or TSLR/Patta"},
              {"ID": 3, "Title": "survery sketch"},
              {"ID": 4, "Title": "Construction agreement if flat"},
            ]
          },
          "Refinance": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Plan approval/Actual plan"}
            ],
            "Non Mandatory": [
              {"ID": 1, "Title": "Lay out"},
              {"ID": 2, "Title": "FMB or TSLR/Patta"},
              {"ID": 3, "Title": "survery sketch"},
              {"ID": 4, "Title": "Property tax/EB"},
            ]
          }
        }
      }
    },
    {
      "KARNATAKA": {
        "Home Loan": {
          "Self-Construction": {
            "Mandatory": [
              {"ID": 1, "Title": "Title deed"},
              {"ID": 2, "Title": "Khatha"},
              {"ID": 3, "Title": "Approved / Working plan"},
              {"ID": 4, "Title": "Estimation"}
            ]
          },
          "Purchase Directly From Builder/Authority": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale agreement"},
              {"ID": 2, "Title": "Title deed"},
              {"ID": 3, "Title": "Khatha"},
              {"ID": 4, "Title": "Approved plan"}
            ]
          },
          "Resale Purchase": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale agreement"},
              {"ID": 2, "Title": "Title deed"},
              {"ID": 3, "Title": "Khatha"}
            ]
          },
          "Plot Purchase+Construction": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale agreement"},
              {"ID": 2, "Title": "Title deed"},
              {"ID": 3, "Title": "Khatha"},
              {"ID": 4, "Title": "Layout plan"}
            ]
          },
          "Balance Transfer": {
            "Mandatory": [
              {"ID": 1, "Title": "Title deed"},
              {"ID": 2, "Title": "Khatha"}
            ]
          },
          "Home Extension": {
            "Mandatory": [
              {"ID": 1, "Title": "Title deed"},
              {"ID": 2, "Title": "Khatha"},
              {"ID": 3, "Title": "Approved / Working plan"},
              {"ID": 4, "Title": "Estimation"}
            ]
          },
          "Home Improvement/Rennovation": {
            "Mandatory": [
              {"ID": 1, "Title": "Title deed"},
              {"ID": 2, "Title": "Khatha"},
              {"ID": 3, "Title": "Approved / Working plan"},
              {"ID": 4, "Title": "Estimation"}
            ]
          }
        },
        "Non-Home Loan": {
          "Refinance": {
            "Mandatory": [
              {"ID": 1, "Title": "Title deed"},
              {"ID": 2, "Title": "Khatha"}
            ]
          }
        }
      }
    },
    {
      "TAP": {
        "Home Loan": {
          "Self-Construction": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Plan approval / Architect plan"},
              {"ID": 3, "Title": "Estimation"}
            ]
          },
          "Purchase Directly From Builder/Authority": {
            "Mandatory": [
              {"ID": 1, "Title": "Agreement of Sale"},
              {"ID": 2, "Title": "Link document"},
              {"ID": 3, "Title": "Plan approval / Architect plan"}
            ]
          },
          "Resale Purchase": {
            "Mandatory": [
              {"ID": 1, "Title": "Agreement of Sale"},
              {"ID": 2, "Title": "Link document"},
              {"ID": 3, "Title": "Property tax"}
            ]
          },
          "Plot Purchase+Construction": {
            "Mandatory": [
              {"ID": 1, "Title": "Agreement of Sale"},
              {"ID": 2, "Title": "Link document"},
              {"ID": 3, "Title": "Estimation"},
              {"ID": 4, "Title": "Plan approval / Architect plan"}
            ]
          },
          "Home Improvement/Rennovation": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Link document"},
              {"ID": 3, "Title": "Estimation"},
              {"ID": 4, "Title": "Property tax"}
            ]
          },
          "Home Extension": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Link document"},
              {"ID": 3, "Title": "Estimation for Extension"},
              {"ID": 4, "Title": "Plan approval / Architect plan"},
              {"ID": 5, "Title": "Property tax"}
            ]
          },
          "Balance Transfer": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Property tax"}
            ]
          }
        },
        "Non-Home Loan": {
          "Normal - Loan Against Residential Property": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Property tax"}
            ]
          },
          "Balance Transfer - Loan Against Residential Property": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Property tax"}
            ]
          },
          "Refinance": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Property tax"}
            ]
          }
        }
      }
    },
    {
      "GUJARAT": {
        "Home Loan": {
          "Purchase Directly From Builder/Authority": {
            "Mandatory": [
              {"ID": 1, "Title": "Agreement for sale/Allotment letter"},
              {"ID": 2, "Title": "Construction Permission"},
              {"ID": 3, "Title": "Approved lay out/Building plan"}
            ]
          },
          "Resale Purchase": {
            "Mandatory": [
              {"ID": 1, "Title": "Agreement for sale"},
              {"ID": 2, "Title": "Tax bill"},
              {"ID": 3, "Title": "Electricity bill"}
            ]
          },
          "Plot Purchase+Construction": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Approved lay out/Building plan/Draft plan"},
              {"ID": 3, "Title": "Estimate"}
            ]
          },
          "Balance Transfer": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Tax bill"},
              {"ID": 3, "Title": "Electricity bill"}
            ]
          },
          "Home Improvement/Rennovation": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Construction Permission"},
              {"ID": 3, "Title": "Approved lay out/Building plan"},
              {"ID": 4, "Title": "Estimate"}
            ]
          }
        },
        "Non-Home Loan": {
          "Refinance": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Construction Permission"},
              {"ID": 3, "Title": "Approved lay out/Building plan"},
              {"ID": 4, "Title": "Estimate"}
            ]
          }
        }
      }
    },
    {
      "MADHYA PRADESH": {
        "Home Loan": {
          "Home Improvement/Rennovation": {
            "Mandatory": [
              {"ID": 1, "Title": "Sanction building plan by Municipal / DA"},
              {"ID": 2, "Title": "Construction permission by Municipal / DA"},
              {"ID": 3, "Title": "Applicant’s sale deed"},
              {"ID": 4, "Title": "Diversion Order"},
              {"ID": 5, "Title": "T&CP Layout/ Builder Layout if applicable"},
              {"ID": 6, "Title": "Detailed Estimate/ Architect Plan"},
              {"ID": 7, "Title": "Latest Property Tax paid receipt"}
            ]
          },
          "Purchase Directly From Builder/Authority": {
            "Mandatory": [
              {"ID": 1, "Title": "Sanction building plan by Municipal / DA"},
              {"ID": 2, "Title": "Construction permission / Regularization order by Municipal / DA"},
              {"ID": 3, "Title": "Agreement to sale / Draft Agreement/ Seller Deed"},
              {"ID": 4, "Title": "Diversion Order"},
              {"ID": 5, "Title": "T&CP Layout/ Builder Layout if applicable"},
              {"ID": 6, "Title": "RERA Registration copy if applicable"}
            ]
          },
          "Resale Purchase": {
            "Mandatory": [
              {"ID": 1, "Title": "Sanction building plan by Municipal / DA"},
              {"ID": 2, "Title": "Construction permission / Regularization order by Municipal / DA"},
              {"ID": 3, "Title": "Agreement to sale / Draft Agreement/ Seller Deed"},
              {"ID": 4, "Title": "Diversion Order"},
              {"ID": 5, "Title": "T&CP Layout/ Builder Layout if applicable"},
              {"ID": 6, "Title": "Latest Property Tax paid receipt"}
            ]
          },
          "Balance Transfer": {
            "Mandatory": [
              {"ID": 1, "Title": "Sanction building plan by Municipal / DA"},
              {"ID": 2, "Title": "Construction permission"},
              {"ID": 3, "Title": "Applicant’s sale deed"},
              {"ID": 4, "Title": "Diversion order"},
              {"ID": 5, "Title": "Latest Property Tax paid receipt"},
              {"ID": 6, "Title": "T&CP Layout/ Builder Layout if applicable"}
            ]
          }
        },
        "Non-Home Loan": {
          "Refinance": {
            "Mandatory": [
              {"ID": 1, "Title": "Sanction building plan by Municipal / DA"},
              {"ID": 2, "Title": "Construction permission"},
              {"ID": 3, "Title": "Applicant’s sale deed"},
              {"ID": 4, "Title": "Diversion Order"},
              {"ID": 5, "Title": "Layout plan if applicable"},
              {"ID": 6, "Title": "Detailed Estimate"},
              {"ID": 7, "Title": "Latest Property Tax paid receipt"}
            ]
          },
          "Normal - Loan Against Residential Property": {
            "Mandatory": [
              {"ID": 1, "Title": "Sanction building plan by Municipal/ Arcitect Plan"},
              {"ID": 2, "Title": "Construction permission"},
              {"ID": 3, "Title": "Agreement to sale / Draft Agreement/ Sale Deed"},
              {"ID": 4, "Title": "Diversion Order"},
              {"ID": 5, "Title": "T&CP Layout/ Builder Layout if applicable"},
              {"ID": 6, "Title": "Latest Property Tax Paid Receipt/ E-bill"}
            ]
          }
        }
      }
    },
    {
      "RAJASTHAN": {
        "Home Loan": {
          "Self-Construction": {
            "Mandatory": [
              {"ID": 1, "Title": "Title deed"},
              {"ID": 2, "Title": "Estimate for construction with proposed construction plan"},
              {"ID": 3, "Title": "Layout plan"}
            ]
          },
          "Home Improvement/Rennovation": {
            "Mandatory": [
              {"ID": 1, "Title": "Title deed"},
              {"ID": 2, "Title": "Estimate for extension with proposed construction plan"},
              {"ID": 3, "Title": "Layout plan"}
            ]
          },
          "Resale Purchase": {
            "Mandatory": [
              {"ID": 1, "Title": "Title deed"},
              {"ID": 2, "Title": "Sale agreement"},
              {"ID": 3, "Title": "Layout plan"}
            ]
          },
          "Purchase Directly From Builder/Authority": {
            "Mandatory": [
              {"ID": 1, "Title": "Title deed"},
              {"ID": 2, "Title": "Sale agreement"},
              {"ID": 3, "Title": "Layout plan"},
              {"ID": 4, "Title": "Floor Plan"}
            ]
          },
          "Plot Purchase+Construction": {
            "Mandatory": [
              {"ID": 1, "Title": "Title deed"},
              {"ID": 2, "Title": "Sale agreement"},
              {"ID": 3, "Title": "Proposed estimate for construction"},
              {"ID": 4, "Title": "Layout plan of scheme"}
            ]
          },
          "Balance Transfer": {
            "Mandatory": [
              {"ID": 1, "Title": "Title deed"},
              {"ID": 2, "Title": "Layout plan"}
            ]
          }
        }
      }
    },
    {
      "UTTAR PRADESH": {
        "Home Loan": {
          "Self-Construction/ Improvement/Extension": {
            "Mandatory": [
              {"ID": 1, "Title": "Applicant’s sale deed"},
              {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"},
              {"ID": 3, "Title": "Detailed Estimate/ Architect Plan"},
              {"ID": 4, "Title": "E-bill/Latest Property Tax paid receipt"}
            ]
          },
          "Purchase Directly From Builder/Authority": {
            "Mandatory": [
              {"ID": 1, "Title": "Sanction building plan/floor plan by approved architect"},
              {"ID": 2, "Title": "Agreement to sale / Draft Agreement/ Seller Deed"},
              {"ID": 3, "Title": "T&CP Layout/ Builder Layout if applicable"},
              {"ID": 4, "Title": "RERA Registration copy if applicable"}
            ]
          },
          "Resale Purchase": {
            "Mandatory": [
              {"ID": 1, "Title": "Sanction building plan by approved architect"},
              {"ID": 2, "Title": "Agreement to sale / Draft Agreement/ Seller Deed"},
              {"ID": 3, "Title": "T&CP Layout/ Builder Layout if applicable"},
              {"ID": 4, "Title": "E-bill/Latest Property Tax paid receipt"}
            ]
          },
          "Balance Transfer": {
            "Mandatory": [
              {"ID": 1, "Title": "Applicant’s sale deed"},
              {"ID": 2, "Title": "E-bill/Latest Property Tax paid receipt"},
              {"ID": 3, "Title": "T&CP Layout/ Builder Layout if applicable"},
              {"ID": 4, "Title": "Layout plan if applicable"},
              {"ID": 5, "Title": "Detailed Estimate &map"}
            ]
          },
          "Plot Purchase+Construction": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale Deed"},
              {"ID": 2, "Title": "Agreement to Sale"},
              {"ID": 3, "Title": "Society layout plan (In case where numbering of Plots is seen in sale deed)"},
              {"ID": 4, "Title": "Architect drawn Map & Estimate"},
              {"ID": 5, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by seller & buyer"},
              {"ID": 6, "Title": "Mauka patwari/pointer plan required case to case basis"}
            ]
          }
        },
        "Non-Home Loan": {
          "Normal - Loan Against Residential Property": {
            "Mandatory": [
              {"ID": 1, "Title": "Agreement to sale / Draft Agreement/ Sale Deed"},
              {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"},
              {"ID": 3, "Title": "Latest Property Tax Paid Receipt/ E-bill"}
            ]
          },
          "Refinance": {
            "Mandatory": [
              {"ID": 1, "Title": "Applicant’s sale deed"},
              {"ID": 2, "Title": "T&CP Layout/ Builder Layout if applicable"},
              {"ID": 3, "Title": "Latest Property Tax paid receipt"}
            ]
          }
        }
      }
    },
    {
      "ROM": {
        "Home Loan": {
          "Purchase Directly From Builder/Authority": {
            "Mandatory": [
              {"ID": 1, "Title": "Sanction building plan by Municipal / DA"},
              {"ID": 2, "Title": "Construction permission / Regularization order by Municipal / DA"},
              {"ID": 3, "Title": "Agreement to sale / Draft Agreement"},
              {"ID": 4, "Title": "N.A. Order / Property Card / Zone Certificate"},
              {"ID": 5, "Title": "Layout plan if applicable"},
              {"ID": 6, "Title": "RERA Registration copy if applicable"}
            ]
          },
          "Resale Purchase": {
            "Mandatory": [
              {"ID": 1, "Title": "Sanction building plan by Municipal / DA if applicable"},
              {"ID": 2, "Title": "Construction permission / Regularization order by Municipal / DA if applicable"},
              {"ID": 3, "Title": "Copy of seller sale deed"},
              {"ID": 4, "Title": "Agreement to sale / Draft Agreement"},
              {"ID": 5, "Title": "N.A. Order / Property Card /Zone Certificate"},
              {"ID": 6, "Title": "Layout plan if applicable"},
              {"ID": 7, "Title": "Latest Tax paid receipt"}
            ]
          },
          "Self-Construction": {
            "Mandatory": [
              {"ID": 1, "Title": "Sanction building plan by Municipal / DA / Architect plan"},
              {"ID": 2, "Title": "Construction permission by Municipal / DA if applicable"},
              {"ID": 3, "Title": "Applicant’s sale deed"},
              {"ID": 4, "Title": "N.A. Order / Property Card / Zone Certificate"},
              {"ID": 5, "Title": "Layout plan if applicable"},
              {"ID": 6, "Title": "Detailed Estimate"}
            ]
          },
          "Balance Transfer": {
            "Mandatory": [
              {"ID": 1, "Title": "Sanction building plan by Municipal / DA if applicable"},
              {"ID": 2, "Title": "Construction permission / Regularization order by Municipal / DA if applicable"},
              {"ID": 3, "Title": "Applicant’s sale deed"},
              {"ID": 4, "Title": "N.A. Order / Property Card / Zone Certificate"},
              {"ID": 5, "Title": "Layout plan if applicable"}
            ]
          },
          "Home Improvement/Rennovation": {
            "Mandatory": [
              {"ID": 1, "Title": "Sanction building plan by Municipal / DA / Architect plan for proposed area"},
              {"ID": 2, "Title": "Construction permission by Municipal / DA if applicable"},
              {"ID": 3, "Title": "Applicant’s sale deed"},
              {"ID": 4, "Title": "N.A. Order / Property Card / Zone Certificate"},
              {"ID": 5, "Title": "Layout plan if applicable"},
              {"ID": 6, "Title": "Detailed Estimate for proposed area"}
            ]
          }
        },
        "Non-Home Loan": {
          "Refinance": {
            "Mandatory": [
              {"ID": 1, "Title": "Sanction building plan by Municipal / DA / Architect plan"},
              {"ID": 2, "Title": "Construction permission / Regularization order by Municipal / DA if applicable"},
              {"ID": 3, "Title": "Applicant’s sale deed"},
              {"ID": 4, "Title": "N.A. Order / Property Card / Zone Certificate"},
              {"ID": 5, "Title": "Layout plan if applicable"},
              {"ID": 6, "Title": "Detailed Estimate"}
            ]
          },
          "Normal - Loan Against Residential Property": {
            "Mandatory": [
              {"ID": 1, "Title": "Sanction building plan by Municipal / DA if applicable"},
              {"ID": 2, "Title": "Construction permission / Regularization order by Municipal / DA if applicable"},
              {"ID": 3, "Title": "Applicant’s sale deed"},
              {"ID": 4, "Title": "N.A. Order / Property Card / Zone Certificate"},
              {"ID": 5, "Title": "Layout plan if applicable"},
              {"ID": 6, "Title": "Latest Tax paid receipt"}
            ]
          }
        }
      }
    },
    {
      "DNCR": {
        "Home Loan": {
          "Plot Purchase+Construction": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale Deed"},
              {"ID": 2, "Title": "Agreement to Sale"},
              {"ID": 3, "Title": "Colony layout plan (In case where numbering of Plots is seen in sale deed, )"},
              {"ID": 4, "Title": "Architect building plan & construction Estimate)"},
              {"ID": 5, "Title": "Architect/Hand made route sketch of the property from the nearest landmark duly signed by seller & buyer"},
              {"ID": 6, "Title": "Mauka patwari/pointer plan required case to case basis"}
            ]
          },
          "Self-Construction": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Architect building plan & construction Estimate"},
              {"ID": 3, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by seller & buyer"},
              {"ID": 4, "Title": "Mauka patwari/pointer plan required case to case basis."}
            ]
          },
          "Normal - Loan Against Residential Property": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale Deed"},
              {"ID": 2, "Title": "Electrcity Bill or Latest utility bill"},
              {"ID": 3, "Title": "Architect/Hand made route sketch of the property from the nearest landmark duly signed by applicant"}
            ]
          },
          "Balance Transfer": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale Deed"},
              {"ID": 2, "Title": "Electrcity Bill or Latest utility bill"},
              {"ID": 3, "Title": "Architect/Hand made route sketch of the property from the nearest landmark duly signed by applicant"}
            ]
          },
          "Purchase Directly From Builder/Authority": {
            "Mandatory": [
              {"ID": 1, "Title": "Draft/Agreement to sale/Allotment letter"},
              {"ID": 2, "Title": "Approved Plan and commencement certificate"},
              {"ID": 3, "Title": "NA order"}
            ]
          }
        },
        "Non-Home Loan": {
          "Top-Up": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale Deed"},
              {"ID": 2, "Title": "Electrcity Bill or Latest utility bill"},
              {"ID": 3, "Title": "Architect/Hand made route sketch of the property from the nearest landmark duly signed by applicant"}
            ]
          }
        }
      }
    },
    {
      "PCH": {
        "Home Loan": {
          "Plot Purchase+Construction": {
            "Mandatory": [
              {"ID": 1, "Title": "Title Document"},
              {"ID": 2, "Title": "ATS"},
              {"ID": 3, "Title": "Estimate and Map Req. during initiation"}
            ]
          },
          "Purchase Directly From Builder/Authority": {
            "Mandatory": [
              {"ID": 1, "Title": "Title Document"},
              {"ID": 2, "Title": "ATS"},
              {"ID": 3, "Title": "HTA if Applicable"}
            ]
          },
          "Self-Construction": {
            "Mandatory": [
              {"ID": 1, "Title": "Title Document"},
              {"ID": 2, "Title": "Estimate and Map Req. during initiation"}
            ]
          },
          "Home Improvement/Rennovation": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale Deed"},
              {"ID": 2, "Title": "Construction Map and Renovation Estimate"}
            ]
          },
          "Balance Transfer": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale Deed"},
              {"ID": 2, "Title": "Electricity Bill"}
            ]
          }
        },
        "Non-Home Loan": {
          "Normal - Loan Against Residential Property": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale Deed"},
              {"ID": 2, "Title": "Electricity Bill"}
            ]
          }
        }
      }
    },
    {
      "MUMBAI": {
        "Home Loan": {
          "Purchase Directly From Builder/Authority": {
            "Mandatory": [
              {"ID": 1, "Title": "Draft/Agreement to sale/Allotment letter"},
              {"ID": 2, "Title": "Approved Plan and commencement certificate"},
              {"ID": 3, "Title": "NA order"},
              {"ID": 4, "Title": "Namuna 8A"},
              {"ID": 5, "Title": "Fore Boundary Certificate"},
              {"ID": 6, "Title": "Gaothan Certificate"}
            ]
          },
          "Resale Purchase": {
            "Mandatory": [
              {"ID": 1, "Title": "Agreement to sale/Draft Agreement/Allotment Letter"},
              {"ID": 2, "Title": "Approved Plan and Commencement certificate"},
              {"ID": 3, "Title": "NA order"},
              {"ID": 4, "Title": "Namuna 8A"},
              {"ID": 5, "Title": "Fore Boundary Certificate"},
              {"ID": 6, "Title": "Gaothan Certificate"}
            ]
          },
          "Plot Purchase+Construction": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Registered Architect Plan Copy"},
              {"ID": 3, "Title": "NA order and Layout plan"},
              {"ID": 4, "Title": "Registered Architect Estimate"},
              {"ID": 5, "Title": "Namuna 8A"},
              {"ID": 6, "Title": "Fore Boundary Certificate"},
              {"ID": 7, "Title": "Gaothan Certificate"}
            ]
          },
          "Balance Transfer": {
            "Mandatory": [
              {"ID": 1, "Title": "Agreement to sale/Allotment Letter"},
              {"ID": 2, "Title": "Approved Plan and Commencement certificate or Tax Receipt"},
              {"ID": 3, "Title": "NA order"},
              {"ID": 4, "Title": "Namuna 8A"},
              {"ID": 5, "Title": "Fore Boundary Certificate"},
              {"ID": 6, "Title": "Gaothan Certificate"}
            ]
          }
        },
        "Non-Home Loan": {
          "Normal - Loan Against Residential Property": {
            "Mandatory": [
              {"ID": 1, "Title": "Agreement to sale/Allotment Letter"},
              {"ID": 2, "Title": "Approved Plan and Commencement certificate or Tax Receipt"},
              {"ID": 3, "Title": "NA order"},
              {"ID": 4, "Title": "Namuna 8A"},
              {"ID": 5, "Title": "Fore Boundary Certificate"},
              {"ID": 6, "Title": "Gaothan Certificate"}
            ]
          },
          "Top-Up": {
            "Mandatory": [
              {"ID": 1, "Title": "Agreement to Sale/Allotment Letter"},
              {"ID": 2, "Title": "Ebill"}
            ]
          }
        }
      }
    }
  ];

  // void pushData() async {
  //   FirebaseFirestore.instance
  //       .collection("technicalChecklist")
  //       .doc("technicalChecklist")
  //       .update({"technicalChecklist": FieldValue.arrayUnion(technicalChecklist)});
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
