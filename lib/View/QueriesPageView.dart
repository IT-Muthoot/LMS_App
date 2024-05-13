import 'package:cloud_firestore/cloud_firestore.dart';
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

    if (userType == "user") {
      QuerySnapshot querySnapshot = await users.where("userId", isEqualTo: userId).get();
      userLeads = querySnapshot.docs;
      print(userLeads);
      setState(() {
        ListOfLeads = userLeads.where((lead) =>
        lead["LeadID"].length > 1 &&
            lead["VerificationStatus"] == "Pending" &&
            lead.data() is Map<String, dynamic> && // Check if data is a Map
            (lead.data() as Map<String, dynamic>).containsKey("Query") && // Cast and check for 'Query' key
            lead["Query"] != null
        ).toList();
      });
    } else {
      QuerySnapshot querySnapshot = await users.where("VerificationStatus", isEqualTo: "Pending").get();
      setState(() {
        ListOfLeads = querySnapshot.docs.where((lead) =>
        lead["LeadID"].length > 1 &&
            lead.data() is Map<String, dynamic> && // Check if data is a Map
            (lead.data() as Map<String, dynamic>).containsKey("Query") && // Cast and check for 'Query' key
            lead["Query"] != null
        ).toList();


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
              "Queries",
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
                  height:  MediaQuery.of(context).size.height,
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
                                                : searchListOfLeads[index]["firstName"] +" "+ searchListOfLeads[index]["lastName"]?? "",),
                                          ),
                                          Card(
                                            child: Container(
                                              color: Colors.white,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  ListOfLeads[index]['VerificationStatus'],
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
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: width * 0.6,
                                            child: Text(
                                              searchKEY.text.isEmpty
                                                  ? ListOfLeads[index]['LeadID'] ?? ""
                                                  : searchListOfLeads[index]["LeadID"] ?? "",
                                              style: TextStyle(color: StyleData.appBarColor2),
                                            ),
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
                                          Text( searchKEY.text.isEmpty
                                              ? ListOfLeads[index]['Query'] ?? ""
                                              : searchListOfLeads[index]["Query"] ?? "",style: TextStyle(color:Colors.black,fontSize: 15)),
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
