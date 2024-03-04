import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import 'ApiException.dart';
import 'ServerURL.dart';

class ApiClient {
  final Dio dio = Dio();

  Future<dynamic> fetchData(String url, Map<String, dynamic> params) async {
    print(params);
    print(url);

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };
    var body = json.encode(params);
    print('\x1B[33m$body\x1B[0m');
    try {

      var response = await dio.post(url, data: params);
      print(response.statusCode);
      print('\x1B[32m${response.data.toString()}\x1B[0m');

      return returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }
  Future<dynamic> fetchGetData2(String url, Map<String, dynamic> params) async {
    print(params);
    print(url);

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };
    var body = json.encode(params);
    print('\x1B[33m$body\x1B[0m');
    try {

      var response = await dio.get(url, data: params);
      print(response.statusCode);
      print('\x1B[32m${response.data.toString()}\x1B[0m');

      return returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }



  Future<dynamic> fetchFormData(String url, Map<String, dynamic> params) async {
    print(params);
    print(url);

    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (client) {
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };
    // };
    var body = json.encode(params);
    print('\x1B[33m$body\x1B[0m');
    try {
      FormData data = FormData.fromMap(params);
      dio.options.headers['key'] = 'AsKsAsSsHTrrZOLsIsNsK';
      dio.options.headers['Content-Type'] = 'multipart/form-data';
      dio.options.headers['Host'] = ServerURL.hostKey;
      var response = await dio.post(url, data: data);
      print(response.statusCode);
      print('\x1B[32m${response.data.toString()}\x1B[0m');

      return returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> fetchGetData(String url, Map<String, dynamic> params) async {
    var urlData = Uri.parse(url);
    print(url);
    print(params);
    var body = json.encode(params);
    print('\x1B[33m$body\x1B[0m');
    try {
      var response = await dio.get(
        url,
      );
      print('\x1B[32m${response.data}\x1B[0m');

      return returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = response.data;
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.data.toString());
      case 404:
        throw UnauthorisedException(response.data.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communication with server with status code : ${response.statusCode}');
    }
  }
}
