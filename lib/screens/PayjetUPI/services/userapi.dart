import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/LogInModel.dart';
import '../model/OtpModel.dart';
import '../model/RegisterModel.dart';

class Userapi {
  static const host = "http://192.168.0.230:8000/api";

  static Future<RegisterModel?> RegisterPost(
      String fname,
      String mobilenumber,
      String email,
      String password,
      String confirmpassword,
      String dob,
      String address) async {
    try {
      final body = jsonEncode({
        "fullname": fname,
        "mobile": mobilenumber,
        "email": email,
        "password": password,
        "password_confirmation": confirmpassword,
        "date_of_birth": dob,
        "address": address
      });
      print(" body>>${body}");
      final headers = {'Content-Type': 'application/json'};
      String url ="${host}/register";
      print("${url}");

      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.body != null) {


        final jsonResponse = jsonDecode(response.body);
        // print("Response JSON: ${jsonResponse}");
        print("Register Data:${response.body}");


        return RegisterModel.fromJson(jsonResponse);
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }



  static Future<LogInModel?> LogInPost(

      String email,
      String password) async {
    try {
      final body = jsonEncode({
        "email": email,
        "password": password,

      });
      print(" body>>${body}");
      final headers = {'Content-Type': 'application/json'};
      String url ="http://192.168.0.230:8000/api/login";
      print("${url}");

      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );
      if (response.body != null) {
        final jsonResponse = jsonDecode(response.body);
        // print("Response JSON: ${jsonResponse}");
        print("Register Data:${response.body}");
        return LogInModel.fromJson(jsonResponse);
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }


  static Future<OTPModel?> OtpPost(

  String fname,
  String mobilenumber,
  String email,
  String password,
  String confirmpassword,
  String dob,
  String address,
      String otp

   ) async {
    try {
      final body = jsonEncode({
        "fullname": fname,
        "mobile": mobilenumber,
        "email": email,
        "password": password,
        "password_confirmation": confirmpassword,
        "date_of_birth": dob,
        "address": address,
        "otp" :otp
      });
      print(" body>>${body}");

      final headers = {'Content-Type': 'application/json'};
      String url ="${host}/verify_customer_registration_otp";
      print("${url}");

      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.body != null) {
        final jsonResponse = jsonDecode(response.body);
        // print("Response JSON: ${jsonResponse}");
        print("otp Data:${response.body}");

        return OTPModel.fromJson(jsonResponse);
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

}
