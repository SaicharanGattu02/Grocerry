import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helper/utils/ShakeWidget.dart';

class GasBill extends StatefulWidget {
  const GasBill({super.key});

  @override
  State<GasBill> createState() => _GasBillState();
}




class _GasBillState extends State<GasBill> {
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _selectOperatorController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _subNumberController = TextEditingController();

  String _validateMobileNumber = "";
  String _validateAmount = "";
  String _validateOperator = "";
  String _validatesubNumber = "";

  bool _isLoading = false;

  void _validateFields() {
    setState(() {
      _validateMobileNumber = _mobileNumberController.text.isEmpty ||
          _mobileNumberController.text.length != 10
          ? "Please enter a valid mobile number"
          : "";
      _validateAmount = _amountController.text.isEmpty ||
          double.tryParse(_amountController.text) == null
          ? "Please enter a valid amount"
          : "";
      _validateOperator = _selectOperatorController.text.isEmpty
          ? "Please select your operator"
          : "";
      _validatesubNumber = _subNumberController.text.isEmpty
          ? "Please enter your vechile Number"
          : "";

      _isLoading = _validateMobileNumber.isEmpty &&
          _validateAmount.isEmpty &&
          _validateOperator.isEmpty &&
          _validatesubNumber.isEmpty;

      if (_isLoading) {
        // Call your method to proceed with the action
      }
    });
  }

  @override
  void initState() {
    super.initState();

    // Reset validation errors when user types
    _mobileNumberController.addListener(() {
      setState(() {
        _validateMobileNumber = "";
      });
    });

    _selectOperatorController.addListener(() {
      setState(() {
        _validateOperator = "";
      });
    });

    _amountController.addListener(() {
      setState(() {
        _validateAmount = "";
      });
    });

    _subNumberController.addListener(() {
      setState(() {
        _validatesubNumber = "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_sharp,
          color: const Color(0xff1F1F1F),
          size: 24,
        ),
        title: const Text(
          "Gas Bills",
          style: TextStyle(
              fontFamily: "Inter", fontSize: 18, fontWeight: FontWeight.w500),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    _buildSectionLabel("Operator"),
                    _buildTextFormField(
                      controller: _selectOperatorController,
                      label: 'Select operator',
                      validation: _validateOperator,
                      suffixIcon: const Icon(Icons.keyboard_arrow_down),
                    ),
                    _buildSectionLabel("Sub Number"),
                    _buildTextFormField(
                      controller: _subNumberController,
                      validation: _validatesubNumber,
                      label: ' Enter Sub Number',
                      keyboardType: TextInputType.text,
                    ),


                    _buildSectionLabel("Customer Mobile Number"),
                    _buildTextFormField(
                      controller: _mobileNumberController,
                      label: ' Enter Customer Mobile Number',
                      validation: _validateMobileNumber,
                      length: 10,
                      keyboardType: TextInputType.phone,
                    ),
                    _buildSectionLabel("Amount"),
                    _buildTextFormField(
                      controller: _amountController,
                      label: 'Enter amount',
                      validation: _validateAmount,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    _buildSubmitButtons(w)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontFamily: "Inter",
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildSubmitButtons(double width) {
    return _buildButton(
      width: width,
      color: const Color(0xff330066),
      label: 'Pay Bill',
      onTap: _validateFields,
    );
  }

  Widget _buildButton({
    required double width,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      decoration: BoxDecoration(
        color: color, // Background color
        borderRadius: BorderRadius.circular(8), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2), // Shadow position
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String validation,
    Widget? suffixIcon,
    int? length,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Color suffixIconColor = const Color(0xff2C2C2C),
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 48.0,
            child: TextFormField(
              controller: controller,
              cursorColor: Colors.black,
              maxLength: length,
              decoration: InputDecoration(
                counterText: "", // Hides the character counter
                hintText: label,
                hintStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Inter",
                  color: Color(0xff8298AF),
                ),
                filled: true,
                fillColor: const Color(0xffF2F8FF),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 14.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(width: 1, color: Color(0xff8298AF)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(width: 1, color: Color(0xff8298AF)),
                ),
                suffixIcon: suffixIcon != null
                    ? IconTheme(
                  data: IconThemeData(color: suffixIconColor),
                  child: suffixIcon,
                )
                    : null,
              ),
              obscureText: obscureText,
              keyboardType: keyboardType,
            ),
          ),
          if (validation.isNotEmpty) ...[
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 8, bottom: 10, top: 5),
              width: MediaQuery.of(context).size.width * 0.6,
              child: ShakeWidget(
                key: const Key("validation"),
                duration: const Duration(milliseconds: 700),
                child: Text(
                  validation,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 12,
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ] else ...[
            const SizedBox(height: 15),
          ]
        ],
      ),
    );
  }
}

