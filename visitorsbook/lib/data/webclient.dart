// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:visitorsbook/helper/prefmanager.dart';

class WebClient {
  // static const baseUrl = "http://192.168.48.164:8088";
  static const baseUrl = "http://visit.leopardtechlabs.in";
  //static const baseUrl = "http://192.168.51.176:3000";
  //static const wpimageUrl = "http://brazil.indiansnakes.org/wp/";
  //static const imageUrl = "http://brazil.indiansnakes.org/u/";
  //static const wpimageUrl = "http://api.indiansnakes.org/wp/";

  static Future<dynamic> post(url, data) async {
    var token = await PrefManager.getToken();

    Map? sendData = {};
    if (data?.isNotEmpty ?? false) {
      sendData.addAll(data);
    }

    var body = json.encode(data);

    var response = await http.post(
      Uri.parse(baseUrl + url),
      headers: {
        "Content-Type": "application/json",
        "x-auth-token": token ?? ""
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      if (response.body != null && response.body != "") {
        return jsonDecode(response.body);
      } else {
        var error = {
          "status": false,
          "msg": "Invalid Request",
        };
        return error;
      }
    }
  }

  static Future<dynamic> get(url) async {
    var token = await PrefManager.getToken();

    var response = await http.get(Uri.parse(baseUrl + url), headers: {
      "Content-Type": "application/json",
      "x-auth-token": token ?? ""
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      if (response.body != null && response.body != "") {
        return jsonDecode(response.body);
      } else {
        var error = {
          "status": false,
          "msg": "Invalid Request",
        };
        return error;
      }
    }
  }

  static Future<dynamic> files2(
      String url, String id, List<String> _image) async {
    List<File> fileList = [];
    List<String?> phtsList = _image;
    for (var i = 0; i < phtsList.length; i++) {
      fileList.add(File(phtsList[i].toString()));
    }
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl + url));
    String token = await PrefManager.getToken();
    request.headers.addAll(
        {'Content-Type': 'application/form-data', 'x-auth-token': token});
    if (fileList.isNotEmpty) {
      for (var f in fileList) {
        request.files.add(http.MultipartFile.fromBytes(
            'photo', f.readAsBytesSync(),
            filename: f.path.split('/').last));
      }
      request.fields['id'] = id;
    }
    // if (_image.isNotEmpty) {
    //   for (String image in _image) {
    //     request.files.add(http.MultipartFile.fromBytes(
    //         'photo', File(image).readAsBytesSync(),
    //         filename: image.split('/').last));
    //   }

    //   request.fields['id'] = id;
    // }
    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var successResponse = {
          "status": true,
          "msg": "Upload Success",
        };
        return successResponse;
      }
      // ignore: empty_catches
    } catch (e) {
      // print(e);
    }
  }

  static Future<dynamic> filesuser(String url, List<String> _image) async {
    List<File> fileList = [];
    List<String?> phtsList = _image;
    for (var i = 0; i < phtsList.length; i++) {
      fileList.add(File(phtsList[i].toString()));
    }
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl + url));
    String token = await PrefManager.getToken();
    request.headers.addAll(
        {'Content-Type': 'application/form-data', 'x-auth-token': token});
    if (fileList.isNotEmpty) {
      for (var f in fileList) {
        request.files.add(http.MultipartFile.fromBytes(
            'image', f.readAsBytesSync(),
            filename: f.path.split('/').last));
      }
    }
    // if (_image.isNotEmpty) {
    //   for (String image in _image) {
    //     request.files.add(http.MultipartFile.fromBytes(
    //         'photo', File(image).readAsBytesSync(),
    //         filename: image.split('/').last));
    //   }

    //   request.fields['id'] = id;
    // }
    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var successResponse = {
          "status": true,
          "msg": "Upload Success",
        };
        return successResponse;
      }
      // ignore: empty_catches
    } catch (e) {
      // print(e);
    }
  }

  static Future<dynamic> rescueFileUpload(
      String url, List<String> _image) async {
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl + url));
    String token = await PrefManager.getToken();
    request.headers
        .addAll({'Content-Type': 'application/form-data', 'token': token});
    if (_image.isNotEmpty) {
      for (String image in _image) {
        request.files.add(http.MultipartFile.fromBytes(
            'photos', File(image).readAsBytesSync(),
            filename: image.split('/').last));
      }

      // request.fields['groupid'] = id;
    }
    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var successResponse = {
          "status": true,
          "msg": "Upload Success",
        };
        return successResponse;
      }
      // ignore: empty_catches
    } catch (e) {
      // print(e);
    }
  }
}
