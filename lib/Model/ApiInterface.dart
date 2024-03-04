

import 'dart:convert';

import 'ApiClient.dart';
import 'Repository/Repo.dart';
// import 'Response/NewData.dart';
import 'Response/BaseData.dart';
import 'ServerURL.dart';

class ApiInterface implements Repo {

  final ApiClient _apiService = ApiClient();

  // @override
  // Future<List<ListData>?> getDummy(Map<String, dynamic> params) async {
  //   // TODO: implement getDummy
  //     try {
  //       // dynamic response = await _apiService.fetchGetData(ServerURL.getUrl(RequestType.base),params);
  //       dynamic response = await _apiService.fetchGetData("https://jsonplaceholder.typicode.com/posts",params);
  //       
  //       final dataObjects = DummyData.fromJson(response).listData;
  //       print("success");
  //       print(dataObjects);
  //       return dataObjects;
  //     } catch (e) {
  //       print("Error $e");
  //       print("fali387 ");
  //       rethrow;
  //     }
  // }

  @override
  Future<DummyData?> otpVerification(Map<String, dynamic> params) async {
    // TODO: implement otpVerification
    try {
      // dynamic response = await _apiService.fetchGetData(ServerURL.getUrl(RequestType.base),params);
      dynamic response = await _apiService.fetchData(ServerURL.getUrl(RequestType.SendOTP),params);
      
      final dataObjects = DummyData.fromJson(response);
      print("success");
      print(dataObjects);
      return dataObjects;
    } catch (e) {
      print("Error $e");
      print("fali387 ");
      rethrow;
    }
  }

  @override
  Future<DummyData?> validateEmp(Map<String, dynamic> params) {
    // TODO: implement validateEmp
    throw UnimplementedError();
  }




}