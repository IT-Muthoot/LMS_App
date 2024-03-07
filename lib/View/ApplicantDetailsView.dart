import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lead_management_system/View/HomePageView.dart';
import 'package:lead_management_system/View/dashbordPageView.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/StyleData.dart';
import 'NewLeadPageView.dart';
import 'documentsPageView.dart';

class ApplicantDetailsView extends StatefulWidget {
  const ApplicantDetailsView({super.key});

  @override
  State<ApplicantDetailsView> createState() => _ApplicantDetailsViewState();
}

class _ApplicantDetailsViewState extends State<ApplicantDetailsView> {

  bool consentCRIF = true;
  bool consentKYC = true;

  var userType;
  List<DocumentSnapshot> ListOfLeads = [];
  TextEditingController searchKEY = TextEditingController();

  void fetchdata() async {
    CollectionReference users = FirebaseFirestore.instance.collection('convertedLeads');
    SharedPreferences pref = await SharedPreferences.getInstance();
   // var userId = pref.getString("token");
    var userId = pref.getString("userID");
    setState(() {
      userType = pref.getString("logintype");
    });
    print(userType);
    if (userType == "user") {
      users.where("userId", isEqualTo: userId).get().then((value) {
        setState(() {
          ListOfLeads = value.docs;
        });
        for (var i = 0; value.docs.length > i; i++) {
          print(value.docs[i].data());
        }
      });
    } else {
      users.get().then((value) {
        setState(() {
          ListOfLeads = value.docs;
        });
        for (var i = 0; value.docs.length > i; i++) {
          print(value.docs[i].data());
        }
      });
    }
  }
  List<DocumentSnapshot> searchListOfLeads = [];
  void _runFilter(String enteredKeyword) {
    var data = ListOfLeads.where((row) => (row["firstName"]
        .toString()
        .toUpperCase()
        .contains(enteredKeyword.toUpperCase())||
        row["LeadID"]
            .toString()
            .toUpperCase()
            .contains(enteredKeyword.toUpperCase()) || row["productCategory"]
        .toString()
        .toUpperCase()
        .contains(enteredKeyword.toUpperCase()))).toList();
    setState(() {
      searchListOfLeads = data;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: StyleData.appBarColor2,
        leading: Padding(
          padding: const EdgeInsets.all(19.0),
          child: GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomePageView(),
                  ),
                );
              },
              child:  Container(
                child: Image.asset(
                  'assets/images/arrow.png',
                ),
              ),),
        ),
        title: Text("Lead Details",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: StyleData.boldFont),),
        centerTitle: true,
actions: [
  Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        SizedBox(
          width: width * 0.05,
        ),
        Container(
          width: width * 0.08,
          height: height * 0.036,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white24,
          ),
          child: Center(
            child: Text(ListOfLeads.length.toString(),
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
      ],
    ),
  ),

],
      ),
       body:    Column(
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
                   suffixIcon: IconButton(
                     icon:    SizedBox(
                       //  height: 60,
                       child: Image.asset(
                           'assets/images/filter.png',
                           width: width * 0.06,
                           height: height * 0.02,
                           color: Colors.black87
                       ),
                     ),
                     onPressed: () {
                    //   _scaffoldKey.currentState!.openDrawer();
                     },
                   ),
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
             height: height * 0.03,
           ),
           SizedBox(
             height: height * 0.65,
             width: MediaQuery.of(context).size.width,
             child:ListOfLeads.isNotEmpty ?
             ListView.builder(
               itemCount: searchKEY.text.isEmpty
                   ? ListOfLeads.length
                   : searchListOfLeads.length,
               itemBuilder: (context, index) {
                 ListOfLeads.sort((a, b) =>
                     (b['createdDateTime'] as Timestamp).compareTo(a['createdDateTime'] as Timestamp));
                 return InkWell(
                   onTap: () {
                     // Navigator.push(
                     //     context,
                     //     MaterialPageRoute(
                     //         builder: (context) => NewLeadPageView(
                     //           isNewActivity: false,
                     //           isUpdateActivity: true,
                     //           docId: ListOfLeads[index].id,
                     //         )));
                   },
                   child: Container(
                     margin: EdgeInsets.only(bottom: 8.0),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(8.0),
                       color: Colors.white,
                       boxShadow: [
                         BoxShadow(
                           color: Colors.grey.withOpacity(0.5),
                           spreadRadius: 2,
                           blurRadius: 5,
                           offset: Offset(0, 3),
                         ),
                       ],
                     ),
                     child: Padding(
                       padding: EdgeInsets.all(8.0),
                       child: GestureDetector(
                         onTap: () {
                           Navigator.push(
                               context,
                               MaterialPageRoute(
                                   builder: (context) => DocumentPageView(
                                   )));
                         },
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Icon(
                                   Icons.star,
                                   color: Colors.yellow.shade800
                                 ),
                                 Text(
                                   "Lead ID",
                                   style: TextStyle(
                                     color: StyleData.appBarColor2,
                                     fontSize: 18.0,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                                 Icon(
                                   Icons.visibility,
                                     color: Colors.red.shade300
                                 ),
                               ],
                             ),
                             Center(

                               child: Text(
                                 searchKEY.text.isEmpty
                                     ? ListOfLeads[index]["LeadID"]
                                     : searchListOfLeads[index]["LeadID"],
                                 style: TextStyle(
                                   color: Colors.black54,
                                   fontSize: 14.0,
                                   fontFamily: 'Poppins',
                                 ),
                               ),
                             ),
                             Divider(
                               color: StyleData.appBarColor2,
                               thickness: 0.3,
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [
                                 Column(
                                   children: [
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text(
                                           "Applicant Name",
                                           style: TextStyle(
                                             color: Colors.red.shade300,
                                             fontSize: 16.0,
                                             fontWeight: FontWeight.bold,
                                             fontFamily: 'Poppins',
                                           ),
                                         ),
                                       ],
                                     ),
                                     Text(
                                       searchKEY.text.isEmpty
                                           ? ListOfLeads[index]["firstName"] + " " + ListOfLeads[index]["lastName"]
                                           : searchListOfLeads[index]["firstName"] + " " + ListOfLeads[index]["lastName"],
                                       style: TextStyle(
                                         color: Colors.black54,
                                         fontSize: 14.0,
                                       ),
                                     ),
                                   ],
                                 ),
                                 Column(
                                   children: [
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text(
                                           "Product Category",
                                           style: TextStyle(
                                             color: Colors.red.shade300,
                                             fontSize: 16.0,
                                             fontWeight: FontWeight.bold,
                                             fontFamily: 'Poppins',
                                           ),
                                         ),
                                       ],
                                     ),
                                     Text(
                                       searchKEY.text.isEmpty
                                           ? ListOfLeads[index]["productCategory"]
                                           : searchListOfLeads[index]["productCategory"],
                                       style: TextStyle(
                                         color: Colors.black54,
                                         fontSize: 14.0,
                                       ),
                                     ),
                                   ],
                                 )
                               ],
                             )
                           ],
                         ),
                       ),
                     ),
                   ),

                 );
               },
             )
                 : Center(
                   child: const Text(
                              'No Data found',
                              style: TextStyle(fontSize: 24),
                            ),
                 ),
           ),
         ],
       ),

    );
  }
}
