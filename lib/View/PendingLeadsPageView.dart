import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lead_management_system/View/ProfilePageView.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/StyleData.dart';

class PendingLeadsPageView extends StatefulWidget {
  const PendingLeadsPageView({super.key});

  @override
  State<PendingLeadsPageView> createState() => _PendingLeadsPageViewState();
}

class _PendingLeadsPageViewState extends State<PendingLeadsPageView> {


  var userType;
  List<DocumentSnapshot> ListOfLeads = [];
  TextEditingController searchKEY = TextEditingController();
  List<DocumentSnapshot> userLeads = [];
  var lead;
  ScrollController _scrollController = ScrollController();

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
        ListOfLeads = userLeads.where((lead) => lead["LeadID"].length > 1 && lead["VerificationStatus"] == "Pending").toList();
      });

    } else {
      QuerySnapshot querySnapshot = await users.where("VerificationStatus", isEqualTo: "Pending").get();
      setState(() {
        ListOfLeads = querySnapshot.docs.where((lead) => lead["LeadID"].length > 1).toList();
      });
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    fetchLeadsdata();
    super.initState();
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
              "Pending Leads",
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
                        return Column(
                            children:[
                              Card(
                                child: Container(
                                  color: Colors.white,
                                  child: ListTile(
                                    title: Row(
                                      children: [
                                        SizedBox(
                                          width: width * 0.67,
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
                                    subtitle: Text(
                                      searchKEY.text.isEmpty
                                          ? ListOfLeads[index]['LeadID'] ?? ""
                                          : searchListOfLeads[index]["LeadID"] ?? "",
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
