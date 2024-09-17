import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'others/dottedborder.dart';


class PayJetProfileScreen extends StatefulWidget {
  const PayJetProfileScreen({super.key});

  @override
  State<PayJetProfileScreen> createState() => _PayJetProfileScreenState();
}

class _PayJetProfileScreenState extends State<PayJetProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/profilesc.png",
                  width: w,
                  height: h * 0.3,
                  fit: BoxFit.fitWidth,
                ),
                Positioned(
                  top: 20,
                  left: 10,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Positioned(
                    top: 30,
                    right: 10,
                    child: InkWell(
                        onTap: () {},
                        child: Image.asset(
                          "assets/about.png",
                          width: 24,
                          height: 24,
                        ))),
              ],
            ),
            Container(
              width: w,
              margin: EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              padding:
                  EdgeInsets.only(top: 10, left: 24, right: 24, bottom: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(

                        color: Colors.grey.withOpacity(0.5), // Color of the shadow
                        offset: Offset(0, 4),                // Horizontal and vertical offset
                        blurRadius: 6,                       // Blur radius of the shadow
                        spreadRadius: 1,                     // Spread radius of the shadow (optional)

                  ),
                ],
                  color: Color(0xffF2F8FF),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Personal Details",
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.mode_edit_outlined,
                        size: 24,
                        color: Color(0xff5F6368),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Icon(
                        Icons.camera_alt_outlined,
                        size: 24,
                        color: Color(0xff5F6368),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Harika",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Color(0xff474747),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "+91 123456789",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Color(0xff474747),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Text(
                        "harika@gmail.com",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: Color(0xff474747),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                          onTap: () {},
                          child: Image.asset(
                            "assets/verify.png",
                            width: 24,
                            height: 24,
                          ))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: w,
              margin: EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              padding:
                  EdgeInsets.only(top: 10, left: 24, right: 24, bottom: 10),

              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: Offset(0, 4),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
                  color: Color(0xffF2F8FF),
                  borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Saved Addresses",
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.mode_edit_outlined,
                        size: 24,
                        color: Color(0xff5F6368),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Icon(
                        Icons.camera_alt_outlined,
                        size: 24,
                        color: Color(0xff5F6368),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(height: 16),
                  // Dashed Border Container
                  CustomPaint(
                    painter: DashedBorderPainter(

                      color: Color(0xff00000066).withOpacity(0.5),
                      dashWidth: 5.0,
                      dashSpace: 3.0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add,
                            size: 14,
                            color: Color(0xff5F6368),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Add New",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 18,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
                ],
              ),
      ));

  }
}
