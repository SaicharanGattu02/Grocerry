import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpDialog extends StatefulWidget {
  const OtpDialog({super.key});

  @override
  State<OtpDialog> createState() => _OtpDialogState();
}

class _OtpDialogState extends State<OtpDialog> {
  final FocusNode focusNodeOTP = FocusNode();
  final TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    focusNodeOTP.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return

      AlertDialog(
      contentPadding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Make the dialog take minimal height
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: height * 0.05), // Adjust the spacing
              height: 54,
              width: 300,
              child: Image.asset(
                "assets/mainLogo.png",
              ),
            ),
            Text(
              "Let's Verify Your Account",
              style: TextStyle(
                color: Color(0xFF32657B),
                fontFamily: "Inter",
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Text(
              "Enter OTP",
              style: TextStyle(
                color: Color(0xFF32657B),
                fontFamily: "Inter",
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
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
                  // Handle OTP resend logic here
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
                // Handle OTP submission logic here
                Navigator.of(context).pop(); // Close the dialog on submit
              },
              child: Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  color: Color(0xFF330066),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
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
  }
}

// Use this function to show the OTP dialog
void showOtpDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevents dialog from being dismissed on tap outside
    builder: (BuildContext context) {
      return OtpDialog();
    },
  );
}
