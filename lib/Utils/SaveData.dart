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
        "EMP_CODE": "MD00048",
        "NAME": "Manju Varghese",
        "DSGN_NAME": "Relationship Manager",
        "BRANCH CODE": "KOCH001",
        "BRANCH": "KOCHI",
        "REGION CODE": "RO0001",
        "REGION": "KERALA",
        "ZONE CODE": "ZO0001",
        "Zone": "SOUTH",
        "Reporting Manager Code": "MO1309",
        "Reporting Manager Name": "SAFDER G"
      },
      {
        "EMP_CODE": "MD00051",
        "NAME": "Rupesh Metkar",
        "DSGN_NAME": "Relationship Manager",
        "BRANCH CODE": "NAGP010",
        "BRANCH": "Nagpur",
        "REGION CODE": "ZO0002",
        "REGION": "ROM",
        "ZONE CODE": "ZO0002",
        "Zone": "WEST",
        "Reporting Manager Code": "MO1756",
        "Reporting Manager Name": "Kiran Ambade"
      },
      {
        "EMP_CODE": "MD00055",
        "NAME": "Raghu Rathnagiri",
        "DSGN_NAME": "Relationship Manager",
        "BRANCH CODE": "BANG053",
        "BRANCH": "Bangalore",
        "REGION CODE": "RO0010",
        "REGION": "KARNATAKA",
        "ZONE CODE": "ZO0001",
        "Zone": "SOUTH",
        "Reporting Manager Code": "MO1101",
        "Reporting Manager Name": "Rahul R"
      },
      {
        "EMP_CODE": "MD00056",
        "NAME": "Amit Tiwari",
        "DSGN_NAME": "Relationship Officer",
        "BRANCH CODE": "BHOP013",
        "BRANCH": "Bhopal",
        "REGION CODE": "ZO0002",
        "REGION": "MADHYA PRADESH",
        "ZONE CODE": "ZO0002",
        "Zone": "WEST",
        "Reporting Manager Code": "MO1696",
        "Reporting Manager Name": "Ramanand Lohiya"
      },
      {
        "EMP_CODE": "MD00059",
        "NAME": "Sanjeev Kumar",
        "DSGN_NAME": "Relationship Officer",
        "BRANCH CODE": "YAMU057",
        "BRANCH": "Yamunanagar",
        "REGION CODE": "RO0003",
        "REGION": "PCH",
        "ZONE CODE": "ZO0003",
        "Zone": "NORTH",
        "Reporting Manager Code": "MO1289",
        "Reporting Manager Name": "Sanjeev Kumar"
      },
      {
        "EMP_CODE": "MD00061",
        "NAME": "Arun Malik",
        "DSGN_NAME": "Relationship Officer",
        "BRANCH CODE": "KARN064",
        "BRANCH": "Karnal",
        "REGION CODE": "RO0001",
        "REGION": "PCH",
        "ZONE CODE": "ZO0003",
        "Zone": "NORTH",
        "Reporting Manager Code": "MO1590",
        "Reporting Manager Name": "Paramjeet Singh"
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

  //
  // List<Map<String, dynamic>> technicalChecklist = [
  //   {
  //     "KERALA": {
  //       "Home Loan": {
  //         "Home Extension": {
  //           "APARTMENT": {
  //             "Mandatory": [
  //               {"ID": 1, "Title": "Title Deed"},
  //               {"ID": 2, "Title": "Location Sketch"},
  //               {"ID": 3, "Title": "Approved Building plan & Permit"},
  //               {"ID": 4, "Title": "Construction Estimate"},
  //               {"ID": 5, "Title": "Land Tax receipt"}
  //             ],
  //             "Non Mandatory": [
  //               {"ID": 1, "Title": "Possession Certificate"},
  //               {"ID": 2, "Title": "Survey sketch"},
  //               {"ID": 3, "Title": "Thandaper account statement"},
  //               {"ID": 4, "Title": "E C"}
  //             ]
  //           },
  //         },
  //         "Home Improvement/Rennovation": {
  //           "APARTMENT": {
  //             "Mandatory": [
  //               {"ID": 1, "Title": "Title Deed"},
  //               {"ID": 2, "Title": "Location Sketch"},
  //               {"ID": 3, "Title": "Approved Building plan & Permit"},
  //               {"ID": 4, "Title": "Construction Estimate"},
  //               {"ID": 5, "Title": "Land Tax receipt"}
  //             ],
  //             "Non Mandatory": [
  //               {"ID": 1, "Title": "Possession Certificate"},
  //               {"ID": 2, "Title": "Survey sketch"},
  //               {"ID": 3, "Title": "Thandaper account statement"},
  //               {"ID": 4, "Title": "E C"}
  //             ]
  //           }
  //         },
  //         "Self-Construction": {
  //           "APARTMENT": {
  //             "Mandatory": [
  //               {"ID": 1, "Title": "Title Deed"},
  //               {"ID": 2, "Title": "Location Sketch"},
  //               {"ID": 3, "Title": "Approved Building plan & Permit"},
  //               {"ID": 4, "Title": "Construction Estimate"},
  //               {"ID": 5, "Title": "Land Tax receipt"}
  //             ],
  //             "Non Mandatory": [
  //               {"ID": 1, "Title": "Possession Certificate"},
  //               {"ID": 2, "Title": "Survey sketch"},
  //               {"ID": 3, "Title": "Thandaper account statement"},
  //               {"ID": 4, "Title": "E C"}
  //             ]
  //           }
  //         }
  //       },
  //     }
  //   },//Kerala
  // ];

  List<Map<String, dynamic>> technicalChecklist  = [
    {
      "DNCR": {
        "Home Loan": {
          "Purchase Directly From Builder/Authority": {
            "Apartment": {
              "Mandatory": [
                {"ID": 1, "Title": "Draft/Agreement to sale/Allotment letter"},
                {"ID": 2, "Title": "NA order / Receipt"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Approved Plan and commencement certificate"},
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
                {"ID": 1, "Title": "Draft/Agreement to sale/Allotment letter"},
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
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Draft/Agreement to sale/Allotment letter"},
                {"ID": 2, "Title": "Architect Estimate"},
                {"ID": 3, "Title": "Layout copy/Brochure"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Architect drawn/Hand made route sketch of the property from the nearest landmark duly signed by buyer"}
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
            "APARTMENT": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"},
                {"ID": 2, "Title": "Location Sketch"},
                {"ID": 3, "Title": "Approved Building plan & Permit"},
                {"ID": 4, "Title": "Construction Estimate"},
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
            "APARTMENT": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"},
                {"ID": 2, "Title": "Location Sketch"},
                {"ID": 3, "Title": "Approved Building plan & Permit"},
                {"ID": 4, "Title": "Construction Estimate"},
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
            "APARTMENT": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"},
                {"ID": 2, "Title": "Location Sketch"},
                {"ID": 3, "Title": "Approved Building plan & Permit"},
                {"ID": 4, "Title": "Construction Estimate"},
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
                {"ID": 1, "Title": "Title deed"},
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
                {"ID": 3, "Title": "Property tax"}
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
                {"ID": 3, "Title": "Property tax"}
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
                {"ID": 3, "Title": "Property tax"}
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
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Route Map/Key Plan"},
                {"ID": 2, "Title": "Colony layout plan (Demanded Case To Case bases )"}
              ]
            },
            "Villa": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"},
                {"ID": 2, "Title": "Agreement to sell"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Route Map/Key Plan"},
                {"ID": 2, "Title": "Colony layout plan (Demanded Case To Case bases )"}
              ]
            },
            "House": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"},
                {"ID": 2, "Title": "Agreement to sell"}
              ],
              "Non Mandatory": [
                {"ID": 1, "Title": "Route Map/Key Plan"},
                {"ID": 2, "Title": "Colony layout plan (Demanded Case To Case bases )"}
              ]
            },
            "Plot": {
              "Mandatory": [
                {"ID": 1, "Title": "Title Deed"},
                {"ID": 2, "Title": "Agreement to sell"}
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
                {"ID": 1, "Title": "Land conversion letter"},
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
                {"ID": 1, "Title": "Land conversion letter"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
                {"ID": 1, "Title": "Land diversion order ( NA Order/ ZONE CODE certificate / Gaothan certificate /  Land use certificate etc )"},
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
