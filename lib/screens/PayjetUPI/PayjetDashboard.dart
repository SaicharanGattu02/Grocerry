import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../PharmaDashboard.dart';
import '../mainHomeScreen/homeScreen/homeScreen.dart';
import '../mainHomeScreen/mainHomeScreen.dart';
import 'PayjetHomeScreen.dart';

class PayjetDashboard extends StatefulWidget {
  const PayjetDashboard({super.key});
  @override
  State<PayjetDashboard> createState() => _DashboardState();
}

class _DashboardState extends State<PayjetDashboard> {
  PageController pageController = PageController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void onItemTapped(int selectedItems) {
    pageController.jumpToPage(selectedItems);
    setState(() {
      _selectedIndex = selectedItems;
    });
  }
  List<ScrollController> scrollController = [
    ScrollController(),
    ScrollController(),
    ScrollController(),
    ScrollController()
  ];


  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Container(),
          leadingWidth: 0,
          title: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _buildTabButton('PayJet', 0,"assets/payjetlogo1.png"),
                  _buildTabButton('Grocery', 1,"assets/grocery.png"),
                  _buildTabButton('Pharma', 2,"assets/cap.png"),
                ],
              ),
            ],
          ),
        ),
        body: PageView(
          onPageChanged: (value) {
            HapticFeedback.lightImpact();
          },
          controller: pageController,
          children: [
            Mainhome(),
          ],
          physics: const NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, -1),
                blurRadius: 8,
                color: Colors.black.withOpacity(0.1), // Optional: Adds shadow effect
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent, // Ensure transparency
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black,
              selectedFontSize: 12.0,
              unselectedFontSize: 9.0,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      _selectedIndex == 0
                          ? Image.asset(
                        'assets/activehome.png',
                        width: 25,
                        height: 25,
                      )
                          : Image.asset(
                        'assets/inactivehome.png',
                        width: 20,
                        height: 20,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                          color: _selectedIndex == 0
                              ? Color(0xff330066)
                              : Color(0xff000000),
                        ),
                      ),
                    ],
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      _selectedIndex == 1
                          ? Image.asset(
                        'assets/activedoc.png',
                        width: 25,
                        height: 25,
                      )
                          : Image.asset(
                        'assets/inactiveDoc.png',
                        width: 20,
                        height: 20,
                      ),
                      Text(
                        "Epos Settlement",
                        style: TextStyle(
                          color: _selectedIndex == 1
                              ? Color(0xff330066)
                              : Color(0xff000000),
                        ),
                      ),
                    ],
                  ),
                  label: 'Epos Settlement',
                ),
                BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      _selectedIndex == 2
                          ? Image.asset(
                        'assets/activeabout.png',
                        width: 25,
                        height: 25,
                        color: _selectedIndex == 2
                            ? Color(0xff330066)
                            : Color(0xff00000),
                      )
                          : Image.asset(
                        'assets/about.png',
                        width: 20,
                        height: 20,
                      ),
                      Text(
                        "Complain",
                        style: TextStyle(
                          color: _selectedIndex == 2
                              ? Color(0xff330066)
                              : Color(0xff000000),
                        ),
                      ),
                    ],
                  ),
                  label: 'Complain',
                ),
                BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      _selectedIndex == 3
                          ? Image.asset(
                        'assets/activeperson.png',
                        width: 25,
                        height: 25,
                        color: _selectedIndex == 3
                            ? Color(0xff330066)
                            : Color(0xff00000),
                      )
                          : Image.asset(
                        'assets/inactiveperson.png',
                        width: 20,
                        height: 20,
                      ),
                      Text(
                        "Payout",
                        style: TextStyle(
                          color: _selectedIndex == 3
                              ? Color(0xff330066)
                              : Color(0xff000000),
                        ),
                      ),
                    ],
                  ),
                  label: 'Payout',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: onItemTapped,
            ),
          ),
        ),

      ),
    );

  }
  Widget _buildTabButton(String text, int index,String asset) {
    var h=MediaQuery.of(context).size.height;
    var w=MediaQuery.of(context).size.width;
    return InkResponse(
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
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: EdgeInsets.only(right: 5),
        width: w*0.288,
        decoration: BoxDecoration(
          color:(text=="PayJet")?Color(0xff330066): Color(0xffEFF4F8),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(asset,
                width: 20, height: 15, fit: BoxFit.cover),
            SizedBox(width: w * 0.02),
            Text(text,
                style: TextStyle(
                    color:(text=="PayJet")?Colors.white: Color(0xff161531),
                    fontSize: 15,
                    fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
