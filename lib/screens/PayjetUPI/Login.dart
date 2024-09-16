import 'dart:math';

import 'package:egrocer/screens/PayjetUPI/PayjetDashboard.dart';
import 'package:egrocer/screens/PayjetUPI/services/Preferances.dart';
import 'package:egrocer/screens/PayjetUPI/services/userapi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../helper/utils/ShakeWidget.dart';
import 'Register.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _validateMobileNumber = "";
  String _validatePassword = "";
  bool is_Loading = false;
  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      _validateMobileNumber = "";
    });
    _passwordController.addListener(() {
      _validatePassword = "";
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateFields() {
    setState(() {
      _validateMobileNumber = _emailController.text.isEmpty
          ? "Please enter a valid mobile number"
          : "";
      _validatePassword = _passwordController.text.isEmpty
          ? "Please enter a valid password"
          : "";
      var isLoading = _validateMobileNumber.isEmpty && _validatePassword.isEmpty;
      if (isLoading) {
        LoginApi();
      }else{
        is_Loading=false;
      }
    });
  }

  Future<void> LoginApi() async {
    String email = _emailController.text;
    String pwd = _passwordController.text;
    final login = await Userapi.LogInPost(email, pwd);
    if (login != null) {
      setState(() {
        is_Loading=false;
      });

      print("Sucesss >>>${login}");

      PreferenceService().saveString("access_token", "${login.accessToken}");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>PayjetDashboard()));

    }else{
      setState(() {
        is_Loading=false;
      });

      print("failure >>>${login}");

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50),
            Image.asset('assets/mainLogo.png', height: 57),
            SizedBox(height: 20),
            Text(
              'Welcome to PayJet Login',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                fontFamily: "Inter",
                color: Color(0xff0c2f54),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child:
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildSectionTitle('Email'),
                    _buildTextFormField(
                      controller: _emailController,
                      label: 'Email Address',
                      validation: _validateMobileNumber,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    _buildSectionTitle('Password'),
                    _buildTextFormField(
                      controller: _passwordController,
                      label: 'Password',
                      validation: _validatePassword,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff330066)),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      height: 47,
                      decoration: BoxDecoration(
                        color: Color(0xff330066),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap:(){
                          if(is_Loading){

                          }else{
                            setState(() {
                              is_Loading=true;
                            });
                            _validateFields();
                          }
                        },
                        child: Center(
                          child: is_Loading ? CircularProgressIndicator():
                          Text(
                            'LOGIN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 7),
                        InkWell(onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationScreen()));
                        },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff330066),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: "Inter",
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String validation,
    String? pattern,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 48.0,
          child: TextFormField(
            controller: controller,
            cursorColor: Colors.black,
            onChanged: (v) => setState(() {
              validation = "";
            }),
            decoration: InputDecoration(
              hintText: label,
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: "Inter",
                color: Color(0xff8298AF),
              ),
              filled: true,
              fillColor: Color(0xffF2F8FF),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(width: 1, color: Color(0xff8298AF)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(width: 1, color: Color(0xff8298AF)),
              ),
            ),
            obscureText: obscureText,
            keyboardType: keyboardType,
            inputFormatters: [
              if (pattern != null && pattern.isNotEmpty)
                FilteringTextInputFormatter.allow(RegExp(pattern)),
            ],
          ),
        ),
        if (validation.isNotEmpty) ...[
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
            width: MediaQuery.of(context).size.width * 0.85,
            child: ShakeWidget(
              key: Key("field_error"),
              duration: Duration(milliseconds: 700),
              child: Text(
                validation,
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ] else ...[
          SizedBox(height: 15),
        ]
      ],
    );
  }
}
