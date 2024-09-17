import 'package:egrocer/screens/PayjetUPI/PayjetHomeScreen.dart';
import 'package:egrocer/screens/PayjetUPI/services/userapi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../helper/utils/ShakeWidget.dart';


class Forgotpassword extends StatefulWidget {
  @override
  _ForgotpasswordState createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  final TextEditingController _emailController = TextEditingController();

  String _validateEmail = "";


  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {_validateEmail="";});
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }


  void _validateFields() {
    setState(() {
      _validateEmail = _emailController.text.isEmpty || !RegExp(r'\S+@\S+\.\S+').hasMatch(_emailController.text) ? "Please enter a valid email address" : "";
      _isLoading = _validateEmail.isEmpty;
      if (_isLoading) {

        ForgetApi();

      }else{
        _isLoading=false;
      }
    });
  }


  Future<void> ForgetApi() async{
    String email =_emailController.text;
    final res = await Userapi.ForgetPasswordApi(email);
    if(res!= null){
      setState(() {
        _isLoading=false;
      });
      print("forget done");


    }else{
      setState(() {
        _isLoading=false;
      });
      print("forget failure");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50),
              InkResponse(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.topLeft,
                    child: Icon(Icons.arrow_back)),
              ),
              SizedBox(height: 16),
              Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Inter",
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Don’t worry It Occurs. Please Enter The Email Address Linked With Your Account.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Inter",
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 70),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildSectionTitle('Email Address'),
                  _buildTextFormField(
                    controller: _emailController,
                    label: 'Email Address',
                    validation: _validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 30),
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
                    child: InkWell(onTap: (){
                      if(_isLoading){

                      }else{
                        setState(() {
                          _isLoading=true;
                        });
                        _validateFields();

                      }
                    },
                      child: Center(
                        child: _isLoading ? CircularProgressIndicator(color: Color(0xffffffff),):
                        Text(
                          'SEND CODE',
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
                  SizedBox(height: MediaQuery.of(context).size.width*0.7,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Remember Password?",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 7),
                      Text(
                        "Login",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff330066),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
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
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
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
