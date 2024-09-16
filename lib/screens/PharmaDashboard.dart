import 'package:flutter/material.dart';

import 'PayjetUPI/PayjetDashboard.dart';
import 'mainHomeScreen/mainHomeScreen.dart';

class ComingSoonScreen extends StatefulWidget {
  @override
  _ComingSoonScreenState createState() => _ComingSoonScreenState();
}

class _ComingSoonScreenState extends State<ComingSoonScreen> {

  // Method to build tab buttons
  Widget _buildTabButton(String title, int index, String assetPath) {
    var h=MediaQuery.of(context).size.height;
    var w=MediaQuery.of(context).size.width;
    return Expanded(
      child: InkResponse(
        onTap: () {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PayjetDashboard()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeMainScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ComingSoonScreen()),
            );
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          margin: EdgeInsets.only(right: 5),
          width: w*0.29,
          decoration: BoxDecoration(
            color:(title=="Pharma")?Colors.blue: Color(0xffEFF4F8),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(assetPath,
                  width: 20, height: 15, fit: BoxFit.cover),
              SizedBox(width: 8),
              Text(title,
                  style: TextStyle(
                      color:(title=="Pharma")?Colors.white: Color(0xff161531),
                      fontSize: 15,
                      fontWeight: FontWeight.w400)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(),
        leadingWidth: 0,
        title: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildTabButton('PayJet', 0, "assets/payjeyb.png"),
                _buildTabButton('Grocery', 1, "assets/grocery.png"),
                _buildTabButton('Pharma', 2, "assets/cap.png"),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Coming Soon',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
