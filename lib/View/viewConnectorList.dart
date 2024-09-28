import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/StyleData.dart';
import 'dsaConnectorCreation.dart';

class ViewConnectorList extends StatefulWidget {
  String? employeeCode;
  ViewConnectorList({Key? key,
     this.employeeCode
  }) : super(key: key);

  @override
  State<ViewConnectorList> createState() => _ViewConnectorListState();
}




class _ViewConnectorListState extends State<ViewConnectorList> {
  List<Map<String, dynamic>> _dataList = [];
  TextEditingController searchKEY = TextEditingController();
  bool _isLoading = true;
  String _error = '';
  ScrollController _scrollController = ScrollController();
  int listCount = 0;

  List<DocumentSnapshot> searchListOfLeads = [];
  void _runFilter(String enteredKeyword) {
    var data = _dataList.where((row) => (row["connectorName"]
        .toString()
        .toUpperCase()
        .contains(enteredKeyword.toUpperCase())||
        row["connectorCode"]
            .toString()
            .toUpperCase()
            .contains(enteredKeyword.toUpperCase()))).toList();
    setState(() {
      searchListOfLeads = data.cast<DocumentSnapshot<Object?>>();
    });
  }
  
  
  Future<void> fetchAllDataForEmployeeCode() async {
    print("Employee code: ${widget.employeeCode}");
    CollectionReference newConnectors = FirebaseFirestore.instance.collection('newConnectors');

    try {
      var querySnapshot = await newConnectors
          .where("employeeCode", isEqualTo: widget.employeeCode)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> allData = [];

        for (var doc in querySnapshot.docs) {
          var data = doc.data() as Map<String, dynamic>;
          allData.add(data);

          // // Example: Print the data
          // print("Document ID: ${doc.id}");
          // print("Employee Code: ${data['employeeCode']}");
          // print("Employee Name: ${data['employeeName']}");
          // print("Branch Code: ${data['branchCode']}");
          // print("Region: ${data['Region']}");
        }

        setState(() {
          _dataList = allData;
          _isLoading = false;
          listCount = allData.length;
        });
      } else {
        setState(() {
          _error = "No data found for employeeCode: ${widget.employeeCode}";
          _isLoading = false;
          listCount = 0;
        });
      }
    } catch (error) {
      setState(() {
        _error = "Error fetching data: $error";
        _isLoading = false;
        listCount = 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAllDataForEmployeeCode();
  }




  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(child:
    Scaffold(
      appBar: AppBar(
        backgroundColor: StyleData.appBarColor2,
        leading: Padding(
          padding: const EdgeInsets.all(19.0),
          child: GestureDetector(
            onTap: (){
              // SimpleHiddenDrawerController.of(context).open();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                  DSAConnectorCreationPage(),
                ),
              );

            },
            child:  Container(
              child: Image.asset(
                'assets/images/arrow.png',
              ),
            ),),
        ),
        title: Text("Connector List",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: StyleData.boldFont),),
        centerTitle: true,
        actions: [

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Builder(
                builder: (context) {
                  String countText = searchKEY.text.isEmpty
                      ? _dataList.length.toString()
                      : searchListOfLeads.length.toString();
                  double textWidth =
                      countText.length *
                          8.0; // Adjust 8.0 based on your font size and preference
                  return Container(
                    width: textWidth + 20,
                    height: height * 0.036,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white24,
                    ),
                    child: Center(
                      child: Text(
                        '$listCount', // Display the count in trailing
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                }
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _error.isNotEmpty
          ? Center(child: Text(_error))
          : Scrollbar(
        thickness: 8.5,
        thumbVisibility: true,
        radius: const Radius.circular(8),
        controller: _scrollController,
            child: ListView.builder(
              controller: _scrollController,
                    itemCount: _dataList.length,
                    itemBuilder: (context, index) {
            var data = _dataList[index];
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: DottedBorder(
                color: Colors.grey.shade300,
                strokeWidth: 1,
                borderType: BorderType.RRect,
                radius: Radius.circular(10),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Connector Name: ${data['connectorName'] ?? 'No Name'}, ${data['connectorCode'] ?? 'N/A'}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      'Branch Code: ${data['branchCode'] ?? 'N/A'}, Region: ${data['regionName'] ?? 'N/A'}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            );
                    },
                  ),
          ),
    ),

    );
  }
}
