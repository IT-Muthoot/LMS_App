import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Model/Response/DropDownModel.dart';

class ConnectorProvider with ChangeNotifier {
  List<DropDownData> _leadConnectorList = [];

  List<DropDownData> get leadConnectorList => _leadConnectorList;

  // List<DropDownData> _leadDSAList = [];
  //
  // List<DropDownData> get leadDSAList => _leadConnectorList;

  void getDropDownConnectorData() {
    FirebaseFirestore.instance
        .collection("connectorName")
        .doc('connectorName')
        .get()
        .then((value) {
      for (var element in value.data()!['connectorName']) {
        _leadConnectorList
            .add(DropDownData(int.parse(element['id']), element['title']));
      }
      notifyListeners();
    });
  }
  //
  // void getDropDownDSAData() {
  //   FirebaseFirestore.instance
  //       .collection("dsaName")
  //       .doc('dsaName')
  //       .get()
  //       .then((value) {
  //     for (var element in value.data()!['dsaName']) {
  //       _leadDSAList
  //           .add(DropDownData(int.parse(element['id']), element['title']));
  //     }
  //     notifyListeners();
  //   });
  // }


}
