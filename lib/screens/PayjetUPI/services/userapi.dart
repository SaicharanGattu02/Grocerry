import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/BanksListModel.dart';
import '../model/BannersModel.dart';
import '../model/LogInModel.dart';
import '../model/OperaterModel.dart';
import '../model/OtpModel.dart';
import '../model/RegisterModel.dart';
import '../model/UserProfileModel.dart';

class Userapi {
  static const host = "http://192.168.0.230:8000/api";
  static const token = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4wLjIzMDo4MDAwL2FwaS9sb2dpbiIsImlhdCI6MTcyNjU3Njc3OSwiZXhwIjoxNzI2NTgwMzc5LCJuYmYiOjE3MjY1NzY3NzksImp0aSI6ImJVbncwVnlSTHBpeHhyRkQiLCJzdWIiOiI0NSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.wcXcT2hyeRQ6YEsj7GKW5D5jo4_swErgMMjIBUURPvY";

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
      String url ="${host}/api/login";
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


  static Future<UserProfileModel?> GetUserProfileData() async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',  // Add the Bearer token here
      };
      String url = "${host}/api/profile";
      print("${url}");

      http.Response response = await http.get(Uri.parse(url), headers: headers);

      if (response.body.isNotEmpty) {
        final jsonResponse = jsonDecode(response.body);
        print("GetUserProfileData Data:${response.body}");
        return UserProfileModel.fromJson(jsonResponse);
      } else {
        print("No data found");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<BannersModel?> GetBannersApi() async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',  // Add the Bearer token here
      };
      String url ="${host}/api/all_banners";
      print("${url}");
      http.Response response = await http.get(Uri.parse(url), headers: headers,);
      if (response.body != null) {
        final jsonResponse = jsonDecode(response.body);

        print("GetBannersApi Data:${response.body}");
        return BannersModel.fromJson(jsonResponse);
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }


  static Future<LogInModel?> ForgetPasswordApi(

      String email,
     ) async {


    try {
      final body = jsonEncode({
        "email": email,

      });
      print(" body>>${body}");
      final headers = {'Content-Type': 'application/json'};
      String url ="${host}/api/password/send-otp";
      print("${url}");

      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );
      if (response.body != null) {
        final jsonResponse = jsonDecode(response.body);
        print("Register Data:${response.body}");
        return LogInModel.fromJson(jsonResponse);
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }


  static Future<LogInModel?> MobileRechargeApi(
      String utilityacntno,
      String amount,
      String confirmation_mobile_no,
      String operator_id
      ) async {
    try {
      final body = jsonEncode({
        "utility_ac_no": utilityacntno,
        "amount": amount,
        "confirmation_mobile_no": confirmation_mobile_no,
        "operator_id":operator_id,
      });
      print(" body>>${body}");
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',  // Add the Bearer token here
      };
      String url ="${host}/api/password/send-otp";
      print("${url}");

      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );
      if (response.body != null) {
        final jsonResponse = jsonDecode(response.body);
        print("Recharge:${response.body}");
        return LogInModel.fromJson(jsonResponse);
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<List<BanksListModel>?> GetBanksListApi() async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      String url = "${host}/bank_details";
      print("${url}");
      http.Response response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        print("GetBanksListApi Data: ${response.body}");
        return jsonResponse.map((json) => BanksListModel.fromJson(json)).toList();
      } else {
        print("Failed to load banks list");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<GetOperaterModel?> OperatoerDetailsApi(String accessToken) async {
    try {
      final headers = {
        'Authorization': 'Bearer $accessToken'};
      String url = "${host}/api/list_of_mobile_prepaid_operators";
      print("${url}");

      http.Response response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      if (response.body!=null) {
        final jsonResponse = jsonDecode(response.body);
        print("Register Data:${response.body}");
        return GetOperaterModel.fromJson(jsonResponse);
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }




}
