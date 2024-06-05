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
      "EMP_CODE": "MA04039",
      "NAME": "GAJENDRA NATH TRIPATHI",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH CODE": "LUCK078",
      "BRANCH": "LUCKNOW",
      "REGION CODE": "RO0012",
      "REGION": "UTTAR PRADESH",
      "ZONE CODE": "ZO0003",
      "ZONE": "NORTH",
      "Reporting Manager Code": "MO1324",
      "Reporting DESIGNATION": "SALES MANAGER",
      "Reporting Manager Name": "AJAY PRAKASH"
    },
    {
      "EMP_CODE": "MA04044",
      "NAME": "SUKHPREET SINGH",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH CODE": "BATH089",
      "BRANCH": "BATHINDA",
      "REGION CODE": "RO0008",
      "REGION": "PCH",
      "ZONE CODE": "ZO0003",
      "ZONE": "NORTH",
      "Reporting Manager Code": "MO1316",
      "Reporting DESIGNATION": "SALES MANAGER",
      "Reporting Manager Name": "SATKARJEET SINGH"
    },
    {
      "EMP_CODE": "MA04034",
      "NAME": "BOOBALAN SELVARAJ",
      "DSGN_NAME": "RELATIONSHIP MANAGER",
      "BRANCH CODE": "COIM086",
      "BRANCH": "COIMBATORE",
      "REGION CODE": "RO0011",
      "REGION": "TAMILNADU",
      "ZONE CODE": "ZO0001",
      "ZONE": "SOUTH",
      "Reporting Manager Code": "MO1340",
      "Reporting DESIGNATION": "SALES MANAGER",
      "Reporting Manager Name": "MARIYAPPAN M"
    },
    {
      "EMP_CODE": "MA04033",
      "NAME": "UTTAM ARUN JAGTAP",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH CODE": "NASI016",
      "BRANCH": "NASIK",
      "REGION CODE": "RO0003",
      "REGION": "ROM",
      "ZONE CODE": "ZO0002",
      "ZONE": "WEST",
      "Reporting Manager Code": "MO1168",
      "Reporting DESIGNATION": "SALES MANAGER",
      "Reporting Manager Name": "SHAMRAO KHATAL"
    },
    {
      "EMP_CODE": "MA04032",
      "NAME": "AMIT SUBHASH PATIL",
      "DSGN_NAME": "RELATIONSHIP OFFICER",
      "BRANCH CODE": "JALG018",
      "BRANCH": "JALGAON",
      "REGION CODE": "RO0003",
      "REGION": "ROM",
      "ZONE CODE": "ZO0002",
      "ZONE": "WEST",
      "Reporting Manager Code": "MO1244",
      "Reporting DESIGNATION": "SALES MANAGER",
      "Reporting Manager Name": "MILAN SAKHALA"
    }
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
            ]
          },
          "Purchase Directly From Builder/Authority": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed in favour of seller"},
              {"ID": 2, "Title": "Sale agreement"},
              {"ID": 3, "Title": "Plan approval"}
            ]
          },
          "Resale Purchase": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed in favour of seller"},
              {"ID": 2, "Title": "Sale agreement"},
              {"ID": 3, "Title": "Property tax receipt"}
            ]
          },
          "Plot Purchase+Construction": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale agreement"},
              {"ID": 2, "Title": "Layout approval"},
              {"ID": 3, "Title": "Plan approval/Actual plan"},
              {"ID": 4, "Title": "Estimate"}
            ]
          },
          "Home Improvement/Rennovation": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Plan approval/Actual plan"},
              {"ID": 3, "Title": "Estimate"}
            ]
          },
          "Home Extension": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Plan approval/Actual plan"},
              {"ID": 3, "Title": "Estimate"}
            ]
          },
          "Balance Transfer": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Property tax receipt"}
            ]
          }
        },
        "Non-Home Loan": {
          "Normal - Loan Against Residential Property": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Property tax receipt"}
            ]
          },
          "Balance Transfer - Loan Against Residential Property": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Property tax receipt"}
            ]
          },
          "Refinance": {
            "Mandatory": [
              {"ID": 1, "Title": "Sale deed"},
              {"ID": 2, "Title": "Plan approval/Actual plan"}
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
              {"ID": 3, "Title": "Society layout plan (In case where numbering of plots is seen in sale deed)"},
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
              {"ID": 3, "Title": "Colony layout plan (In case where numbering of plots is seen in sale deed, )"},
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
          "TOP-UP": {
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
  //       .collection("documentChecklist")
  //       .doc("documentChecklist")
  //       .update({"documentChecklist": FieldValue.arrayUnion(documentChecklist)});
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
