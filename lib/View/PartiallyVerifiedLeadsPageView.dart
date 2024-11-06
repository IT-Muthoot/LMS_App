import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lead_management_system/View/ProfilePageView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../Utils/StyleData.dart';
import 'ReviewPage.dart';
import 'documentsPageView.dart';

class PartiallyVerifiedLeadPageView extends StatefulWidget {
  const PartiallyVerifiedLeadPageView({super.key});

  @override
  State<PartiallyVerifiedLeadPageView> createState() => _PartiallyVerifiedLeadPageViewState();
}

class _PartiallyVerifiedLeadPageViewState extends State<PartiallyVerifiedLeadPageView> {


  var userType;
  List<DocumentSnapshot> ListOfLeads = [];
  TextEditingController searchKEY = TextEditingController();
  List<DocumentSnapshot> userLeads = [];
  var lead;
  bool _isLoading = true;
  ScrollController _scrollController = ScrollController();
  bool isPartiallyVarifiedLeads = false;

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

    if (userType == "user") {
      QuerySnapshot querySnapshot = await users.where("userId", isEqualTo: userId).get();
      userLeads = querySnapshot.docs;
      //  print(userLeads);
      setState(() {
        ListOfLeads = userLeads.where((lead) => ((lead["VerificationStatus"] == "Sent for Verification" || lead["VerificationStatus"] == "Verified") && (lead["VerifiedBy"] == "Pending with CM" || lead["VerifiedBy"] == "Verified") &&  (lead['technicalStatus'] == "Technical Pending" || lead['technicalStatus'] == "Partially Uploaded") && lead['technicalChecklistCount'] > 0 )).toList();
      });

    } else {
      QuerySnapshot querySnapshot = await users.where("VerificationStatus", isEqualTo: "Verified").get();
      setState(() {
        ListOfLeads = querySnapshot.docs;
      });
    }
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
              "Partially Verified Leads",
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
                  height: height * 0.73,
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
                        return Column(
                            children:[
                              GestureDetector(
                                onTap : () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReviewPage(LeadID:  searchKEY.text.isEmpty
                                          ? ListOfLeads[index]['LeadID'] ?? ""
                                          : searchListOfLeads[index]["LeadID"] ?? ""),
                                    ),
                                  );
                                },
                                child: Card(
                                  child: Container(
                                    color: Colors.white,
                                    child: ListTile(
                                      title: Row(
                                        children: [
                                          SizedBox(
                                            width: width * 0.65,
                                            child:
                                            Text( searchKEY.text.isEmpty
                                                ? ListOfLeads[index]['firstName'] +" "+ ListOfLeads[index]['lastName'] ?? ""
                                                : searchListOfLeads[index]["firstName"] +" "+ searchListOfLeads[index]["lastName"]?? "",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: StyleData.appBarColor2
                                              ),
                                            ),

                                          ),
                                          Column(
                                            children: [
                                              Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  side: BorderSide(color: Colors.grey, width: 2.0),
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      // MaterialPageRoute(
                                                      //   builder: (context) => DocumentPageView(
                                                      //     visitID: searchKEY.text.isEmpty
                                                      //         ? ListOfLeads[index]['VisitID'] ?? ""
                                                      //         : searchListOfLeads[index]["VisitID"] ?? "",
                                                      //     docId: ListOfLeads[index].id,
                                                      //       consentHandle: ListOfLeads[index]["consentHandle"] ?? "",
                                                      //     isNewActivity: false,
                                                      //     isTechChecklist: true,
                                                      //     leadID: searchKEY.text.isEmpty
                                                      //         ? ListOfLeads[index]['LeadID'] ?? ""
                                                      //         : searchListOfLeads[index]["LeadID"] ?? "",
                                                      //     isPartiallyVerifiedLeads : true
                                                      //
                                                      //   ),
                                                      // ),
                                                      MaterialPageRoute(
                                                        builder: (context) => DocumentPageView(
                                                          visitID: searchKEY.text.isEmpty
                                                              ? ListOfLeads[index]['VisitID'] ?? ""
                                                              : searchListOfLeads[index]["VisitID"] ?? "",
                                                          docId: ListOfLeads[index].id,
                                                          consentHandle: (ListOfLeads[index].data() as Map<String, dynamic>?)?.containsKey("consentHandle") == true
                                                              ? ListOfLeads[index]["consentHandle"]
                                                              : "",
                                                          isNewActivity: false,
                                                          isTechChecklist: true,
                                                          leadID: searchKEY.text.isEmpty
                                                              ? ListOfLeads[index]['LeadID'] ?? ""
                                                              : searchListOfLeads[index]["LeadID"] ?? "",
                                                          isPartiallyVerifiedLeads: true,
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
                                          // SizedBox(
                                          //   width: width * 0.01,
                                          // ),
                                          //     Card(
                                          //       child: Container(
                                          //         color: Colors.white,
                                          //         child: Padding(
                                          //           padding: const EdgeInsets.all(8.0),
                                          //           child: Text(
                                          //             searchKEY.text.isEmpty
                                          //                 ?  ListOfLeads[index]['VerificationStatus'] : searchListOfLeads[index]['VerificationStatus'] ,
                                          //             style: TextStyle(color: Colors.green),
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     ),
                                        ],
                                      ),
                                      // subtitle: Text(
                                      //   searchKEY.text.isEmpty
                                      //       ? ListOfLeads[index]['LeadID'] ?? ""
                                      //       : searchListOfLeads[index]["LeadID"] ?? "",
                                      //   style: TextStyle(
                                      //     fontSize: 13,
                                      //   ),
                                      // ),
                                    ),

                                  ),
                                ),
                              ),
                            ]
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
