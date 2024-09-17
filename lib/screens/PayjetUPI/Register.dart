import 'package:egrocer/screens/PayjetUPI/services/userapi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../helper/utils/ShakeWidget.dart';
import 'Login.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();




  String _validateFullName = "";
  String _validateMobileNumber = "";
  String _validateEmail = "";
  String _validatePassword = "";
  String _validateConfirmPassword = "";
  String _validateDob = "";
  String _validateAddress = "";

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _fullNameController.addListener(() {
      _validateFullName = "";
    });
    _mobileNumberController.addListener(() {
      _validateMobileNumber = "";
    });
    _emailController.addListener(() {
      _validateEmail = "";
    });
    _passwordController.addListener(() {
      _validatePassword = "";
    });
    _confirmPasswordController.addListener(() {
      _validateConfirmPassword = "";
    });
    _dobController.addListener(() {
      _validateDob = "";
    });
    _addressController.addListener(() {
      _validateAddress = "";
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _mobileNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _clearValidation(String validation) {
    setState(() {
      validation = "";
    });
  }

  void _validateFields() {
    setState(() {
      _validateFullName =
          _fullNameController.text.isEmpty ? "Please enter your full name" : "";
      _validateMobileNumber = _mobileNumberController.text.isEmpty ||
              _mobileNumberController.text.length < 10
          ? "Please enter a valid mobile number"
          : "";
      _validateEmail = _emailController.text.isEmpty ||
              !RegExp(r'\S+@\S+\.\S+').hasMatch(_emailController.text)
          ? "Please enter a valid email address"
          : "";
      _validatePassword = _passwordController.text.length < 6
          ? "Password must be at least 6 characters long"
          : "";
      _validateConfirmPassword =
          _confirmPasswordController.text != _passwordController.text
              ? "Passwords do not match"
              : "";
      _validateDob =
          _dobController.text.isEmpty ? "Please enter your date of birth" : "";
      _validateAddress =
          _addressController.text.isEmpty ? "Please enter your address" : "";

      _isLoading = _validateFullName.isEmpty &&
          _validateMobileNumber.isEmpty &&
          _validateEmail.isEmpty &&
          _validatePassword.isEmpty &&
          _validateConfirmPassword.isEmpty &&
          _validateDob.isEmpty &&
          _validateAddress.isEmpty;

      if (_isLoading) {
        RegisterApi();

      }
      else{
        _isLoading=false;
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null) {
      setState(() {
        _dobController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  Future<void> RegisterApi() async {
    String fullname = _fullNameController.text;
    String mobilenum = _mobileNumberController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmpwd = _confirmPasswordController.text;
    String dob = _dobController.text;
    String address = _addressController.text;

    final res = await Userapi.RegisterPost(
        fullname, mobilenum, email, password, confirmpwd, dob, address);

      if (res?.status == false) {

        setState(() {
          _isLoading=false;
        });
        _showSuccessDialog();
        print("Register Api :${res?.message}");


        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "${res?.message}",
            style: TextStyle(color: Color(0xFFFFFFFF),
                fontFamily: "Inter"
            ),
          ),
          duration: Duration(seconds: 1),
          backgroundColor:  Color(0xFF32657B),
        ));
      } else {
        setState(() {
         _isLoading=false;
        });
        print("Register Api :${res?.message}");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "${res?.message}",
            style: TextStyle(color: Color(0xFFFFFFFF),
                fontFamily: "Inter"
            ),
          ),
          duration: Duration(seconds: 1),
          backgroundColor:  Color(0xFF32657B),
        ));
      }

  }


  Future<void> OtpVerify(otp) async {
    String fullname = _fullNameController.text;
    String mobilenum = _mobileNumberController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmpwd = _confirmPasswordController.text;
    String dob = _dobController.text;
    String address = _addressController.text;

    final res = await Userapi.OtpPost( fullname, mobilenum, email, password, confirmpwd, dob, address,otp);
    if(res?.status == true){
      setState(() {
        _isLoading = false;
      });

      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      print("otp :${res?.message}");

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "${res?.message}",
          style: TextStyle(color: Color(0xFFFFFFFF),
              fontFamily: "Inter"
          ),
        ),
        duration: Duration(seconds: 1),
        backgroundColor:  Color(0xFF32657B),
      ));
    }else{
      print("otp :${res?.message}");

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "${res?.message}",
          style: TextStyle(color: Color(0xFFFFFFFF),
              fontFamily: "Inter"
          ),
        ),
        duration: Duration(seconds: 1),
        backgroundColor:  Color(0xFF32657B),
      ));

      setState(() {
        _isLoading = false;
      });

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
              'Welcome to PayJet Register',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                fontFamily: "Inter",
                color: Color(0xff0c2f54),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildSectionTitle('Full Name'),
                    _buildTextFormField(
                      controller: _fullNameController,
                      label: 'Full Name',
                      validation: _validateFullName,
                      pattern: r'^[a-zA-Z\s]+$',
                      keyboardType: TextInputType.text,
                    ),
                    _buildSectionTitle('Mobile Number'),
                    _buildTextFormField(
                      controller: _mobileNumberController,
                      label: 'Mobile Number',
                      validation: _validateMobileNumber,
                      pattern: r'^\d{0,10}$',
                      keyboardType: TextInputType.phone,
                    ),
                    _buildSectionTitle('Email Address'),
                    _buildTextFormField(
                      controller: _emailController,
                      label: 'Email Address',
                      validation: _validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    _buildSectionTitle('Password'),
                    _buildTextFormField(
                      controller: _passwordController,
                      label: 'Password',
                      validation: _validatePassword,
                      obscureText: true,
                    ),
                    _buildSectionTitle('Confirm Password'),
                    _buildTextFormField(
                      controller: _confirmPasswordController,
                      label: 'Confirm Password',
                      validation: _validateConfirmPassword,
                    ),
                    _buildSectionTitle('Date of Birth'),
                    _buildDateField(
                        "Date of Birth", _dobController, _validateDob, context),
                    _buildSectionTitle('Address'),
                    _buildTextFormField(
                      controller: _addressController,
                      validation: _validateAddress,
                      label: 'Address',
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
                          if(_isLoading){

                          }else{
                            setState(() {
                              _isLoading=true;
                            });
                            _validateFields();
                          }
                        },


                        child: Center(
                          child:_isLoading ? CircularProgressIndicator():
                          Text(
                            'REGISTER',
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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                        },
                          child: Text(
                            "Login",
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

  Widget _buildDateField(String label, TextEditingController controller,
      String validation, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 48,
          child: TextFormField(
            controller: controller,
            cursorColor: Colors.black,
            readOnly: true,
            onTap: () => _selectDate(context),
            decoration: InputDecoration(
              hintText: "Select your $label",
              suffix: Icon(Icons.calendar_month, color: Color(0xff330066)),
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: "Inter",
                color: Color(0xff8298AF),
              ),
              filled: true,
              fillColor: Color(0xffF2F8FF),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(width: 1, color: Color(0xff8298AF)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(width: 1, color: Color(0xff8298AF)),
              ),
            ),
          ),
        ),
        if (validation.isNotEmpty) ...[
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
            width: MediaQuery.of(context).size.width * 0.8,
            child: ShakeWidget(
              key: Key("date_error"),
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


  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController otpController = TextEditingController();
        final FocusNode focusNodeOTP = FocusNode();
        return
          AlertDialog(
            contentPadding: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min, // Make the dialog take minimal height
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Center(
                    child:

                    PinCodeTextField(
                      autoUnfocus: true,
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 3, // Change OTP length to 3 digits
                      blinkWhenObscuring: true,
                      autoFocus: true,
                      autoDismissKeyboard: false,
                      showCursor: true,
                      animationType: AnimationType.fade,
                      focusNode: focusNodeOTP,
                      hapticFeedbackTypes: HapticFeedbackTypes.heavy,
                      controller: otpController,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(50),
                        fieldHeight: 45,
                        fieldWidth: 45,
                        fieldOuterPadding: EdgeInsets.only(left: 0, right: 3),
                        activeFillColor: Color(0xFFF4F4F4),
                        activeColor: Color(0xFF330066),
                        selectedColor: Color(0xFF330066),
                        selectedFillColor: Color(0xFFF4F4F4),
                        inactiveFillColor: Color(0xFFF4F4F4),
                        inactiveColor: Color(0xFFD2D2D2),
                        inactiveBorderWidth: 1.5,
                        selectedBorderWidth: 2.2,
                        activeBorderWidth: 2.2,
                      ),
                      textStyle: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                      cursorColor: Colors.black,
                      enableActiveFill: true,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      enablePinAutofill: true,
                      useExternalAutoFillGroup: true,
                      beforeTextPaste: (text) {
                        return true;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {

                        RegisterApi();
                      },
                      child: Text(
                        "Resend OTP",
                        style: TextStyle(
                          color: Color(0xFF330066),
                          fontFamily: "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  InkWell(
                    onTap: () {
                      OtpVerify(otpController.text);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Color(0xFF330066),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: _isLoading? CircularProgressIndicator():
                        Text(
                          "Verify OTP",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
      },
    );
}}
