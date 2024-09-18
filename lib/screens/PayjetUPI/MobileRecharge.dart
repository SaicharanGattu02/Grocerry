import 'package:egrocer/screens/PayjetUPI/services/Preferances.dart';
import 'package:egrocer/screens/PayjetUPI/services/userapi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../helper/utils/ShakeWidget.dart';
import '../../helper/utils/generalImports.dart';
import '../../models/languageJsonData.dart';

enum InputType { numeric, text }

class MobileRecharge extends StatefulWidget {
  const MobileRecharge({super.key});

  @override
  State<MobileRecharge> createState() => _MobileRechargeState();
}

class _MobileRechargeState extends State<MobileRecharge> {
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _tpinController = TextEditingController();
  final TextEditingController _sendernameController = TextEditingController();
  final TextEditingController _operaterController = TextEditingController();

  String _selectedOperator = "";
  String _validateMobileNumber = "";
  String _validateAmount = "";
  String _validateName = "";
  String _validateOperator = "";
  String _validateTpin = "";

  bool _isLoading = false;
  Map<String, int> operatorMap = {};
  int? selectedOperatorId;

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
      _validateOperator = _selectedOperator.isEmpty
          ? "Please select your operator"
          : "";
      _validateTpin = _tpinController.text.isEmpty ||
          _tpinController.text.length < 4
          ? "Please enter your transaction pin"
          : "";

      _isLoading = _validateMobileNumber.isEmpty &&
          _validateAmount.isEmpty &&
          _validateOperator.isEmpty &&
          _validateTpin.isEmpty;

      if (_isLoading) {
        // Call your method to proceed with the action
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _mobileNumberController.addListener(() {
      setState(() {
        _validateMobileNumber = "";
      });
    });

    _amountController.addListener(() {
      setState(() {
        _validateAmount = "";
      });
    });

    _tpinController.addListener(() {
      setState(() {
        _validateTpin = "";
      });
    });
    GetOperateDetails();
  }


  Future<void> GetOperateDetails() async {
      final response = await Userapi.OperatoerDetailsApi();
      if (response != null) {
        setState(() {
          operatorMap = {
            for (var item in response.data ?? [])
              item.name ?? '': item.operatorId ?? 0,
          };
        });

    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mobile Recharge",
          style: TextStyle(
              fontFamily: "Inter",
              fontSize: 18,
              fontWeight: FontWeight.w500),
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
                    _buildSectionLabel("Mobile Number"),
                    _buildTextFormField(
                      controller: _mobileNumberController,
                      label: 'Mobile Number',
                      length: 10,
                      validation: _validateMobileNumber,
                      keyboardType: InputType.numeric,
                    ),
                    _buildSectionLabel("Select Your Operator"),
                    _buildDropdownField(),
                    _buildSectionLabel("Amount"),
                    _buildTextFormField(
                      controller: _amountController,
                      label: 'Enter amount',
                      validation: _validateAmount,
                      keyboardType: InputType.numeric,
                    ),
                    _buildSectionLabel("Sender Name"),
                    _buildTextFormField(
                      controller: _sendernameController,
                      label: 'Enter name',
                      validation: _validateName,
                      keyboardType: InputType.text,
                    ),
                    // _buildTextFormField(
                    //   controller: _tpinController,
                    //   validation: _validateTpin,
                    //   label: 'Enter Tpin',
                    //   obscureText: true,
                    //   keyboardType: TextInputType.number,
                    // ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildButton(
          width: width * 0.4,
          color: const Color(0xff330066),
          label: 'Submit',
          onTap: _validateFields,
        ),
        const SizedBox(width: 20),
        _buildButton(
          width: width * 0.4,
          color: const Color(0xff28A745),
          label: 'View Plans',
          onTap: () {
            // Handle View Plans action
          },
        ),
      ],
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
    InputType keyboardType = InputType.text, // New parameter to specify input type
    Color suffixIconColor = const Color(0xff2C2C2C),
  }) {
    // Create a list of input formatters
    List<TextInputFormatter> inputFormatters = [];

    // Determine input formatters based on inputType
    if (keyboardType == InputType.numeric) {
      inputFormatters.add(FilteringTextInputFormatter.digitsOnly); // Allow only digits
      if (length != null && length > 0) {
        inputFormatters.add(LengthLimitingTextInputFormatter(length)); // Restrict to specified length
      }
    } else {
      // For text input, you can customize further if needed
      // For example, to allow letters only (you can adjust this as required)
      inputFormatters.add(FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))); // Allow letters and spaces
    }

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
              decoration: InputDecoration(
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
              keyboardType: keyboardType == InputType.numeric
                  ? TextInputType.number
                  : TextInputType.text,
              inputFormatters: inputFormatters, // Use the dynamically created list
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

  // Dropdown field for selecting an operator
  Widget _buildDropdownField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      TypeAheadFormField<String>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: _operaterController,
        onTap: () {
          setState(() {});
        },
        onChanged: (v) {
          setState(() {});
        },
        style: TextStyle(
          fontSize: 16,
          letterSpacing: 0,
          height: 1.2,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: "Enter operator name",
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: "Inter",
            color: Color(0xff8298AF),
          ),
          suffixIcon: Icon(Icons.arrow_drop_down),
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
        ),
      ),
        suggestionsCallback: (pattern) {
          return operatorMap.keys.where((item) =>
              item.toLowerCase().contains(pattern.toLowerCase())).toList();
        },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion,
            style: TextStyle(
              fontSize: 15,
              fontFamily: "Inter",
              fontWeight: FontWeight.w400,
            ),
          ),
        );
      },
        onSuggestionSelected: (suggestion) {
          _operaterController.text = suggestion;
          selectedOperatorId = operatorMap[suggestion];
          print("id:${operatorMap[suggestion]}");// Set selected ID
        },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select an item';
        }
        return null;
      },
    ),
          if (_validateOperator.isNotEmpty) ...[
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 8, bottom: 10, top: 5),
              width: MediaQuery.of(context).size.width * 0.6,
              child: ShakeWidget(
                key: const Key("validation"),
                duration: const Duration(milliseconds: 700),
                child: Text(
                  _validateOperator,
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
