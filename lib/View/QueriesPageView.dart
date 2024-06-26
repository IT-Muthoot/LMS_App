import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lead_management_system/View/ProfilePageView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../Utils/StyleData.dart';
import 'documentsPageView.dart';

class QueryPageView extends StatefulWidget {
  const QueryPageView({super.key});

  @override
  State<QueryPageView> createState() => _QueryPageViewState();
}

class _QueryPageViewState extends State<QueryPageView> {


  var userType;
  List<DocumentSnapshot> ListOfLeads = [];
  TextEditingController searchKEY = TextEditingController();
  List<DocumentSnapshot> userLeads = [];
  var lead;
  ScrollController _scrollController = ScrollController();
  String? LeadID;
  String? VisitID;
  String? DocIS;
  bool _isLoading = true;


  List<DocumentSnapshot> searchListOfLeads = [];
  void _runFilter(String enteredKeyword) {
    var data = ListOfLeads.where((row) => (row["firstName"]
        .toString()
        .toUpperCase()
        .contains(enteredKeyword.toUpperCase())||
        row["LeadID"]
            .toString()
            .toUpperCase()
            .contains(enteredKeyword.toUpperCase()))).toList();
    setState(() {
      searchListOfLeads = data;
    });
  }


  void fetchLeadsdata() async {
    CollectionReference users = FirebaseFirestore.instance.collection('convertedLeads');
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userId = pref.getString("userID");
    setState(() {
      userType = pref.getString("logintype");
    });

    try {
      QuerySnapshot querySnapshot;

      // Fetching leads based on userId and VerificationStatus "Push Back"
      querySnapshot = await users
          .where("userId", isEqualTo: userId)
          .where("VerificationStatus", isEqualTo: "Push Back")
          .get();

      userLeads = querySnapshot.docs;

      List<DocumentSnapshot> filteredLeads = userLeads.where((lead) {
        Map<String, dynamic> data = lead.data() as Map<String, dynamic>;
        List<dynamic> documents = data["VerifiedBy"] == "Pending with CM" ? data["Documents1"] : data["Documents"];
        return data["LeadID"].length > 1 &&
            documents.any((doc) => doc["query"] != null && doc["query"].toString().isNotEmpty);
      }).toList();

      for (var lead in filteredLeads) {
        Map<String, dynamic> data = lead.data() as Map<String, dynamic>;
        List<dynamic> documents = data["VerifiedBy"] == "Pending with CM" ? data["Documents1"] : data["Documents"];
        for (var doc in documents) {
          print('Document Key: ${doc['key']}');
          print('Is Checked: ${doc['isChecked']}');
          print('Query: ${doc['query']}');
        }
      }

      setState(() {
        ListOfLeads = filteredLeads;
      });

    } catch (e) {
      print('Error fetching leads data: $e');
    }
  }




  List<String> _getAllKeyNameAndQueriesFromLead(DocumentSnapshot lead) {
    Map<String, dynamic>? leadData = lead.data() as Map<String, dynamic>?;

    if (leadData == null) {
      return [];
    }

    List<dynamic> documents;
    if (leadData.containsKey("VerifiedBy") && leadData["VerifiedBy"] == "Pending with CM") {
      documents = leadData.containsKey("Documents1") ? leadData["Documents1"] : [];
    } else {
      documents = leadData.containsKey("Documents") ? leadData["Documents"] : [];
    }

    List<String> keyNameAndQueries = [];
    for (var doc in documents) {
      if (doc.containsKey("query") && doc["query"] != null && doc["query"].toString().isNotEmpty) {
        String keyName = doc["key"];
        String query = doc["query"].toString();
        keyNameAndQueries.add("$keyName: $query");
      }
    }
    return keyNameAndQueries;
  }

  RichText buildRichTextFromLead(DocumentSnapshot lead) {
    List<String> keyNameAndQueries = _getAllKeyNameAndQueriesFromLead(lead);

    List<TextSpan> technicalDocumentSpans = [];
    List<TextSpan> loanApplicationDocumentSpans = [];

    for (int i = 0; i < keyNameAndQueries.length; i++) {
      List<String> parts = keyNameAndQueries[i].split(': ');
      String keyName = parts[0];
      String query = parts[1];

      TextSpan entry = TextSpan(
        children: [
          TextSpan(
            text: "${i + 1}. $keyName: ",
            style: TextStyle(color: Colors.grey),
          ),
          TextSpan(
            text: "$query\n",
            style: TextStyle(color: Colors.red),
          ),
        ],
      );

      if (keyName.endsWith('-checklist')) {
        technicalDocumentSpans.add(entry);
      } else {
        loanApplicationDocumentSpans.add(entry);
      }
    }

    List<TextSpan> children = [];

    if (technicalDocumentSpans.isNotEmpty) {
      children.add(TextSpan(
        text: "Technical Document\n",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
      ));
      children.addAll(technicalDocumentSpans);
    }

    if (loanApplicationDocumentSpans.isNotEmpty) {
      children.add(TextSpan(
        text: "Loan Application Document\n",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
      ));
      children.addAll(loanApplicationDocumentSpans);
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 15),
        children: children,
      ),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    fetchLeadsdata();
    Future.delayed(Duration(seconds: 2), () {
      loadData();
    });
    super.initState();
  }
  void loadData() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        // Navigate to ApplicantDetailsView when back button is pressed
        Navigator.pop(context);
        // Prevent the default back navigation
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: StyleData.appBarColor2,
            leading: Padding(
              padding: const EdgeInsets.all(19.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(
              "Queried",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: StyleData.boldFont,
              ),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.05,
                    ),
                    Builder(
                      builder: (context) {
                        String countText = searchKEY.text.isEmpty
                            ? ListOfLeads.length.toString()
                            : searchListOfLeads.length.toString();
                        double textWidth =
                            countText.length * 8.0; // Adjust 8.0 based on your font size and preference
                        return Container(
                          width: textWidth + 20,
                          height: height * 0.036,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white24,
                          ),
                          child: Center(
                            child: Text(
                              countText,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.01,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: searchKEY,
                      style: const TextStyle(fontSize: 14,color: Colors.black54),
                      cursorColor: Colors.black87,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        labelStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black54
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color:Colors.black54)),
                        contentPadding: const EdgeInsets.only(left: 1,),
                        hintStyle: const TextStyle(fontSize: 14,color: Colors.black54),
                        prefixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {},
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: new BorderSide(color: Colors.grey)),
                      ),
                      onChanged: (value) {
                        _runFilter(value);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                _isLoading ?
                Column(
                  children: List.generate(5, (index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.black12,
                      highlightColor: Colors.white70,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 20,
                                    color: Colors.white70,
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: double.infinity,
                                    height: 20,
                                    color: Colors.white70,
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: 100,
                                    height: 20,
                                    color: Colors.white70,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ) :
                SizedBox(
                  height:height * 0.73,
                  width: MediaQuery.of(context).size.width,
                  child:ListOfLeads.isNotEmpty
                      ?
                  Scrollbar(
                    thickness: 8.5,
                    thumbVisibility: true,
                    radius: const Radius.circular(8),
                    controller: _scrollController,
                    child: ListView.builder(
                      itemCount: searchKEY.text.isEmpty
                          ? ListOfLeads.length
                          : searchListOfLeads.length,
                      itemBuilder: (BuildContext context, int index) {
                        ListOfLeads.sort((a, b) =>
                            (b['createdDateTime'] as Timestamp).compareTo(a['createdDateTime'] as Timestamp));
                        return Card(
                          elevation: 6,
                          child: DottedBorder(
                            strokeWidth : 0.3,
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: width * 0.6,
                                              child:
                                              Text( searchKEY.text.isEmpty
                                                  ? ListOfLeads[index]['firstName'] +" "+ ListOfLeads[index]['lastName'] ?? ""
                                                  : searchListOfLeads[index]["firstName"] +" "+ searchListOfLeads[index]["lastName"]?? "",
                                                style: TextStyle(color: StyleData.appBarColor2,fontSize: 18),
                                              ),
                                            ),
                                            Card(
                                              child: Container(
                                                color: Colors.white,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    searchKEY.text.isEmpty
                                                        ?   ListOfLeads[index]['VerificationStatus'] : searchListOfLeads[index]['VerificationStatus'],
                                                    style: TextStyle(color: Colors.orange),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Row(
                                        //   children: [
                                        //     // SizedBox(
                                        //     //   width: width * 0.6,
                                        //     //   child: Text(
                                        //     //     searchKEY.text.isEmpty
                                        //     //         ? ListOfLeads[index]['LeadID'] ?? ""
                                        //     //         : searchListOfLeads[index]["LeadID"] ?? "",
                                        //     //     style: TextStyle(color: StyleData.appBarColor2),
                                        //     //   ),
                                        //     // ),
                                        //
                                        //   ],
                                        // ),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Text("Query : ",style: TextStyle(color:StyleData.appBarColor2,fontSize: 15),),
                                                Text(
                                                  searchKEY.text.isEmpty
                                                      ? ListOfLeads[index]['QueryBy'] ?? ""
                                                      : searchListOfLeads[index]["QueryBy"] ?? "",
                                                  style: TextStyle(color:Colors.black,fontSize: 15)
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: width * 0.27,
                                            ),
                                            Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.0),
                                                side: BorderSide(color: Colors.grey, width: 2.0),
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => DocumentPageView(
                                                          visitID: searchKEY.text.isEmpty
                                                              ? ListOfLeads[index]['VisitID'] ?? ""
                                                              : searchListOfLeads[index]["VisitID"] ?? "",
                                                          docId: ListOfLeads[index].id,
                                                          isNewActivity: false,
                                                          isTechChecklist: true,
                                                          leadID: searchKEY.text.isEmpty
                                                              ? ListOfLeads[index]['LeadID'] ?? ""
                                                              : searchListOfLeads[index]["LeadID"] ?? "",
                                                          isPartiallyVerifiedLeads : false
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  color: Colors.white,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      'Update',
                                                      style: TextStyle(color: StyleData.appBarColor2),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Text(
                                        //   searchKEY.text.isEmpty
                                        //       ? _getAllKeyNameAndQueriesFromLead(ListOfLeads[index]).join('\n') ?? ""
                                        //       : _getAllKeyNameAndQueriesFromLead(searchListOfLeads[index]).join('\n') ?? "",
                                        //   style: TextStyle(color:Colors.black, fontSize: 15),
                                        // ),

                                        searchKEY.text.isEmpty
                                            ? buildRichTextFromLead(ListOfLeads[index])
                                            : buildRichTextFromLead(searchListOfLeads[index]),
                                    
                                      ],
                                    ),
                                  ),
                                  // Column(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: [
                                  //     Text("Query",style: TextStyle(color:StyleData.appBarColor2,fontSize: 15),),
                                  //     // Text( searchKEY.text.isEmpty
                                  //     //     ? ListOfLeads[index]['Query'] ?? ""
                                  //     //     : searchListOfLeads[index]["Query"] ?? "",),
                                  //   ],
                                  // )
                                    
                                ],
                              ),
                                    
                            ),
                          ),
                        );
                      },
                    ),
                  ) :
                  Center(
                    child: const Text(
                      'No Data found',
                      style: TextStyle(fontSize: 24),
                    ),
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
