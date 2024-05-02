import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/StyleData.dart';

class DocumentChecklistPageView extends StatefulWidget {
  final bool isNewActivity;
  final bool isUpdateActivity;
  final String leadId;
  final String docId;
  const DocumentChecklistPageView({super.key, required this.isNewActivity, required this.isUpdateActivity, required this.leadId, required this.docId});

  @override
  State<DocumentChecklistPageView> createState() => _DocumentChecklistPageViewState();
}

class _DocumentChecklistPageViewState extends State<DocumentChecklistPageView> {

  List<dynamic> mandatoryDocuments = [];
  String? SelectedMandatoryDoc;
  var userType;
  bool documentCheck = false;
  Map<String, bool> documentCheckboxStates = {};

  List<DocumentSnapshot> leadDetails = [];
  String? productCategory;
  String? purposeOfLoan;
  String? region;

  void fetchLeadDetails() async {
    CollectionReference leadsCollection =
    FirebaseFirestore.instance.collection('convertedLeads');

    QuerySnapshot leadSnapshot = await leadsCollection
        .where('LeadID', isEqualTo: widget.leadId)
        .limit(1)
        .get();

    if (leadSnapshot.docs.isNotEmpty) {
      setState(() {
        leadDetails = leadSnapshot.docs;
        productCategory = leadDetails[0]['productCategory']; // important
        purposeOfLoan = leadDetails[0]['products']; // important
        region = leadDetails[0]['Region']; // important
      });
      _fetchDataFromFirestore();
    } else {

    }
  }
  UnderlineInputBorder enb =  UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:   const BorderSide(color:  Colors.black38)
  );
  UnderlineInputBorder focus =  UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:  const BorderSide(color: Color(0xff778287))
  );

  Future<void> _fetchDataFromFirestore() async {
    try {
      // Access the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Access the "documentChecklist" collection
      CollectionReference checklistCollection = firestore.collection('documentChecklist');
      QuerySnapshot querySnapshot = await checklistCollection.get();
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        for(int i = 0; i < documentSnapshot['documentChecklist'].length; i++){
          String? uppercaseRegion = region?.toUpperCase();
          // print('Value at index $i: ${documentSnapshot['documentChecklist'][0]} \n');
          documentSnapshot['documentChecklist'][i].forEach((key, value) {
            // print('Key: $key');
            if(key == uppercaseRegion) {
              mandatoryDocuments = value[productCategory][purposeOfLoan]['Mandatory'];
              log(mandatoryDocuments.toString());
              // print(mandatoryDocuments.map((document) => document['Title']));
              // for(int i = 0; i < mandatoryDocuments.length; i++) {
              //   print(mandatoryDocuments[i]['Title']);
              // }
            }
          });
        }
      }
    } catch (e) {
      log('Error fetching data: $e');
    }
  }


  var pickedFile;
  FilePickerResult? pickedFiles;

  @override
  void initState() {
    // TODO: implement initState
    fetchLeadDetails();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar:  AppBar(
          backgroundColor: StyleData.appBarColor2,
          title: Text("Document Checklist",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: StyleData.boldFont),),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(19.0),
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         ApplicantDetailsView(),
                //   ),
                // );
              },
              child:  Container(
                child: Image.asset(
                  'assets/images/arrow.png',
                ),
              ),),
          ),

        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lead ID: ${widget.leadId}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  'Product: $productCategory',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  'Purpose Of Loan: $purposeOfLoan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  'Region: $region',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: documentCheck,
                      activeColor: StyleData.appBarColor,
                      onChanged: (value) {
                        setState(() {
                          documentCheck = value!;
                        });
                      },
                    ),
                    Text(
                      'Document Checklist',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),

                Visibility(
                  visible: documentCheck,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: mandatoryDocuments.length,
                    itemBuilder: (context, index) {
                      final document = mandatoryDocuments[index];
                      final documentId = document['ID'].toString();

                      documentCheckboxStates.putIfAbsent(documentId, () => false);

                      return CheckboxListTile(
                        title: Text(mandatoryDocuments[index]['Title']),
                        value: documentCheckboxStates[documentId], // Set initial value of checkbox, you can change it if the document is mandatory.
                        activeColor: StyleData.appBarColor,
                        onChanged: (bool? newValue) {
                          print(newValue);
                          setState(() {
                            documentCheckboxStates[documentId] = newValue ?? false;
                          });
                        },
                        // secondary: InkWell(
                        //   onTap: () {
                        //     selectSource(height, width);
                        //   },
                        //   child: DottedBorder(
                        //     color: Colors.black87,
                        //     borderType: BorderType.RRect,
                        //     radius: const Radius.circular(12),
                        //     padding: const EdgeInsets.all(6),
                        //     child: ClipRRect(
                        //       borderRadius:
                        //       const BorderRadius.all(Radius.circular(12)),
                        //       child: Container(
                        //         height: height * 0.07,
                        //         width: width * 0.9,
                        //         color: Colors.grey[200],
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             const Row(
                        //               mainAxisAlignment: MainAxisAlignment.center,
                        //               children: [
                        //                 Icon(
                        //                   Icons.camera_alt,
                        //                   color: Colors.black54,
                        //                   size: 26,
                        //                 ),
                        //                 Text(
                        //                   "/",
                        //                   style: TextStyle(  color: Colors.black54,),
                        //                 ),
                        //                 Icon(Icons.arrow_circle_up_rounded,
                        //                     color: Colors.black54, size: 26),
                        //               ],
                        //             ),
                        //             SizedBox(height: height * 0.01),
                        //             Text(
                        //                 SelectedMandatoryDoc ?? ""
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      );
                    }
                  )
                )




                // Visibility(
                //   visible: documentCheck,
                //   child: Column(
                //     children: [
                //       SizedBox(
                //         width: width * 1,
                //         child: DropdownButtonFormField2<String>(
                //           value: SelectedMandatoryDoc,
                //           onChanged: (String? newValue) {
                //             setState(() {
                //               SelectedMandatoryDoc = newValue;
                //             });
                //           },
                //           validator: (value) {
                //             if (value == null || value.isEmpty) {
                //               return 'Please select Document';
                //             }
                //             return null;
                //           },
                //           items: mandatoryDocuments.map((document){
                //             return DropdownMenuItem<String>(
                //               value: document['Title'],
                //               child: Text(
                //                 document['Title'],
                //                   overflow: TextOverflow.ellipsis,
                //                 style: const TextStyle(
                //                   color: Color(0xFF393939),
                //                   fontSize: 15,
                //                   fontFamily: 'Poppins',
                //                   fontWeight: FontWeight.w400,
                //                 ),
                //               ),
                //             );
                //           }).toList(),
                //           style: const TextStyle(
                //             color: Color(0xFF393939),
                //             fontSize: 15,
                //             fontFamily: 'Poppins',
                //             fontWeight: FontWeight.w400,
                //           ),
                //           //   hint: const Text('Select an option'),
                //           decoration: InputDecoration(
                //             labelText: 'Select the document*',
                //             hintText: 'Select an option',
                //             focusedBorder: focus,
                //             enabledBorder: enb,
                //             filled: true,
                //             fillColor:StyleData.textFieldColor,
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         height: height * 0.02,
                //       ),
                //       InkWell(
                //         onTap: () {
                //           selectSource(height, width);
                //         },
                //         child: DottedBorder(
                //           color: Colors.black87,
                //           borderType: BorderType.RRect,
                //           radius: const Radius.circular(12),
                //           padding: const EdgeInsets.all(6),
                //           child: ClipRRect(
                //             borderRadius:
                //             const BorderRadius.all(Radius.circular(12)),
                //             child: Container(
                //               height: height * 0.07,
                //               width: width * 0.9,
                //               color: Colors.grey[200],
                //               child: Column(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: [
                //                   const Row(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     children: [
                //                       Icon(
                //                         Icons.camera_alt,
                //                         color: Colors.black54,
                //                         size: 26,
                //                       ),
                //                       Text(
                //                         "/",
                //                         style: TextStyle(  color: Colors.black54,),
                //                       ),
                //                       Icon(Icons.arrow_circle_up_rounded,
                //                           color: Colors.black54, size: 26),
                //                     ],
                //                   ),
                //                   SizedBox(height: height * 0.01),
                //                   Text(
                //                       SelectedMandatoryDoc ?? ""
                //                     ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // )


              ],
            ),
          ),
        ),
      ),
    );
  }

  selectSource(height, width) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        barrierColor: Colors.blueGrey.withOpacity(0.7),
        backgroundColor: Colors.black,
        builder: (BuildContext context) {
          return SizedBox(
            height: height * 0.2,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: height * 0.015),
                child: ListView(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: StyleData.background,
                        child: const Center(
                          child: Icon(Icons.camera, color: Colors.black),
                        ),
                      ),
                      title: const Text("Take Camera",
                          style: TextStyle(color: Colors.white60)),
                      onTap: () async {
                        Navigator.pop(context);
                        pickedFile = await ImagePicker().pickImage(
                            source: ImageSource.camera,
                            maxHeight: 640,
                            maxWidth: 820,
                            imageQuality: 60);
                        print(pickedFile!.name);
                      //  uploadOnDMS(pickedFile,pickedFile!.name);
                      },
                      trailing: Icon(
                        Icons.arrow_circle_right_rounded,
                        color: StyleData.background,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: SizedBox(
                          width: width * 0.7,
                          child: const Divider(
                            color: Colors.black26,
                            thickness: 0.4,
                          )),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: StyleData.background,
                        child: const Center(
                          child: Icon(
                            Icons.image,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      title: const Text(
                        "Select From Gallery",
                        style: TextStyle(color: Colors.white60),
                      ),
                      onTap: () async {
                        Navigator.pop(context);
                        pickedFiles =
                        await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
                          allowCompression: true,
                          allowMultiple: false,
                        );
                        //  pickedFiles?.files.first
                        print(pickedFiles!.files.first.name);
                      //  uploadOnDMS(pickedFiles,pickedFiles!.names);
                      },
                      trailing: Icon(
                        Icons.arrow_circle_right_rounded,
                        color: StyleData.background,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  // void uploadOnDMS(var pickedFile, String title) async {
  //   //New Implementation for saving application PDF
  //   print("bhjkjhlknl");
  //   Dialogs.materialDialog(
  //       msg: 'Are you sure you want to upload this document?',
  //       title: "Alert",
  //       msgStyle:
  //       TextStyle(color: Colors.grey, fontFamily: StyleData.boldFont),
  //       titleStyle: const TextStyle(color: Colors.white),
  //       color: StyleData.appBarColor2,
  //       context: context,
  //       titleAlign: TextAlign.center,
  //       msgAlign: TextAlign.center,
  //       barrierDismissible: false,
  //       dialogWidth: kIsWeb ? 0.3 : null,
  //       onClose: (value) {},
  //       actions: [
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 30),
  //           child: InkWell(
  //             onTap: () async {
  //               Navigator.pop(context);
  //               SmartDialog.showLoading(msg: "Uploading Document");
  //               var dio = Dio();
  //               try {
  //                 FormData formData = FormData.fromMap({
  //                   "File": await MultipartFile.fromFile(
  //                     pickedFile!.path,
  //                     filename: pickedFile.name,
  //                     //    contentType: MediaType("pdf", "jpg"), //add this
  //                     contentType:  _getContentType(pickedFile.name), //add this
  //                   ),
  //                   "Title": widget.visitID,
  //                   "Description": "Document Verification",
  //                   "Tags": "HomeFin",
  //                   "IsPasswordProtected": "0",
  //                   "Password": "0",
  //                   "LUSR": "HomeFin",
  //                 });
  //                 print(formData);
  //                 formData.files.addAll([
  //                   MapEntry(
  //                       "File",
  //                       await MultipartFile.fromFile(pickedFile!.path,
  //                           filename: pickedFile.name,
  //                           contentType: MediaType('application', 'pdf')))
  //                 ]);
  //                 (dio.httpClientAdapter as DefaultHttpClientAdapter)
  //                     .onHttpClientCreate = (client) {
  //                   client.badCertificateCallback =
  //                       (X509Certificate cert, String host, int port) => true;
  //                 };
  //                 dio.options.headers['Content-Type'] = 'multipart/form-data';
  //                 // dio.options.headers['Host'] = '6cpduvi80d.execute-api.ap-south-1.amazonaws.com';
  //
  //                 var response = await dio.post(
  //                   ApiUrls().uploadDoc,
  //                   data: formData,
  //                   onSendProgress: (int sent, int total) {
  //                     debugPrint("sent${sent.toString()}" +
  //                         " total${total.toString()}");
  //                   },
  //                 ).whenComplete(() {
  //                   debugPrint("complete:");
  //                 }).catchError((onError) {
  //                   debugPrint("complete1");
  //                   SmartDialog.dismiss();
  //                 });
  //                 print(response);
  //                 var data = json.decode(response.toString());
  //                 print(data);
  //                 FirebaseFirestore.instance
  //                     .collection("convertedLeads")
  //                     .where("VisitID", isEqualTo: widget.visitID) // Check if visitID matches
  //                     .get()
  //                     .then((QuerySnapshot snapshot) {
  //                   if (snapshot.docs.isNotEmpty) {
  //                     // If there's a matching document, set the value
  //                     FirebaseFirestore.instance
  //                         .collection("convertedLeads")
  //                         .doc(snapshot.docs[0].id) // Use the ID of the first matching document
  //                         .set({
  //                       title: data["docId"].toString(),
  //                     },
  //                         SetOptions(merge: true));
  //                   } else {
  //                     // Handle case where no matching document is found
  //                     // Perhaps show an error message or take appropriate action
  //                   }
  //                 })
  //                     .catchError((error) {
  //                   // Handle errors
  //                   print("Error: $error");
  //                 });
  //                 // FirebaseFirestore.instance
  //                 //     .collection("convertedLeads")
  //                 //     .doc(widget.docId)
  //                 //     .set({
  //                 //   title: data["docId"].toString(),
  //                 // },
  //                 //     SetOptions(merge: true));
  //                 SmartDialog.dismiss();
  //                 if(data["docId"].toString().isNotEmpty)
  //                 {
  //                   if (applicationFormClicked) {
  //                     print(ApplicationDocID);
  //                     setState(() {
  //                       applicationForm ="Uploaded";
  //                     });
  //
  //                   } else if (bankPassbookClicked) {
  //                     setState(() {
  //                       bankPassbook = "Uploaded";
  //                     });
  //
  //                   }
  //                   else if (dateOfBirthClicked) {
  //                     setState(() {
  //                       dateOfBirthProof = "Uploaded";
  //                     });
  //                     // SharedPreferences prefs = await SharedPreferences.getInstance();
  //                     // await prefs.setString("dateOfBirthProof", "Uploaded");
  //                   } else if (loginFeeChequeClicked) {
  //                     setState(() {
  //                       loginFeeCheque = "Uploaded";
  //                     });
  //                   } else if (passportSizePhotoClicked) {
  //                     setState(() {
  //                       passportSizePhoto = "Uploaded";
  //                     });
  //                   } else if (photoIdProofClicked) {
  //                     setState(() {
  //                       photoIdProof = "Uploaded";
  //                     });
  //                   } else if (residenceProofClicked) {
  //                     setState(() {
  //                       residenceProof = "Uploaded";
  //                     });
  //                   } else if (salarySlipClicked) {
  //                     setState(() {
  //                       salarySlip = "Uploaded";
  //                     });
  //
  //                   } else if (signatureProofClicked) {
  //                     setState(() {
  //                       signatureProof = "Uploaded";
  //                     });
  //
  //                   } else if (copyOfPropertyClicked) {
  //                     setState(() {
  //                       copyOfProperty = "Uploaded";
  //                     });
  //
  //                   }else if (totalWorkExpClicked) {
  //                     setState(() {
  //                       totalWorkExp = "Uploaded";
  //                     });
  //                   }else if (qualificationProofClicked) {
  //                     setState(() {
  //                       qualificationProof = "Uploaded";
  //                     });
  //                   }
  //                 }
  //                 else
  //                 {
  //                   CustomSnackBar.errorSnackBarQ("Something went wrong,Please Try Again", context);
  //                 }
  //               } catch (e) {
  //                 SmartDialog.dismiss();
  //                 CustomSnackBar.errorSnackBarQ("Something went wrong,Please Try Again", context);
  //                 debugPrint(e.toString());
  //               }
  //             },
  //             child: Container(
  //               height: 40,
  //               width: 50,
  //               decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(5)),
  //               child: Center(
  //                   child: Text('Yes',
  //                       style: TextStyle(
  //                           color: Colors.black,
  //                           fontFamily: StyleData.boldFont,
  //                           fontSize: 12))),
  //             ),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 30),
  //           child: InkWell(
  //             onTap: () {
  //               Navigator.pop(context);
  //             },
  //             child: Container(
  //               height: 40,
  //               width: 50,
  //               decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(5)),
  //               child: Center(
  //                   child: Text('Cancel',
  //                       style: TextStyle(
  //                           color: Colors.black,
  //                           fontFamily: StyleData.boldFont,
  //                           fontSize: 12))),
  //             ),
  //           ),
  //         )
  //       ]);
  // }
}
