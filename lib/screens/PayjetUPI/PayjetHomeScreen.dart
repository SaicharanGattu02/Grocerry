import 'package:carousel_slider/carousel_slider.dart';
import 'package:egrocer/helper/utils/generalImports.dart';
import 'package:egrocer/screens/PayjetUPI/CreditCardBillPayment.dart';
import 'package:egrocer/screens/PayjetUPI/Login.dart';
import 'package:egrocer/screens/PayjetUPI/MobileRecharge.dart';
import 'package:egrocer/screens/PayjetUPI/services/Preferances.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DthRecharge.dart';
import 'ElectricityBills.dart';
import 'FastTagRecharge.dart';
import 'GasBill.dart';
import 'Profile.dart';

class Mainhome extends StatefulWidget {
  final ScrollController scrollController;
  const Mainhome({Key? key, required this.scrollController}) : super(key: key);


  @override
  State<Mainhome> createState() => _MainhomeState();
}


class _MainhomeState extends State<Mainhome> {

  bool onclick = false;
  String profile_image = "";
  String name = "";
  String Accesstoken = "";
  bool _loading = true;
  int currentIndex = 0;


  final List<String> imgList = [
    'assets/carosaal.png',
    'assets/banner.png',
    'assets/banner.png',
  ];

  final List<Map<String, String>> items = [
    {'image': 'assets/mobilerecharge.png', 'text': 'Mobile Recharge'},
    {'image': 'assets/cardpayment.png', 'text': 'Card Payment'},
    {'image': 'assets/moneytransfer.png', 'text': 'Money Transfer'},
    {'image': 'assets/aadharpay.png', 'text': 'Aadhar Pay'},
    {'image': 'assets/paymentgateway.png', 'text': 'Payment Gateway'},
    {'image': 'assets/mobilerecharge.png', 'text': 'Post Paid'},
    {'image': 'assets/Insurance.png', 'text': 'Insurance'},
    {'image': 'assets/viewmore.png', 'text': 'View More'},
  ];

  void  _navigateToScreen(BuildContext context,String text){
    Widget  navscreen;
    switch (text) {
      case 'Mobile Recharge':
        navscreen = MobileRecharge();
        break;
      case 'Card Payment':
        navscreen = CreditCardpayment();
        break;
      case 'Money Transfer':
        navscreen = MobileRecharge();
        break;
      case 'Aadhar Pay':
        navscreen = MobileRecharge();
        break;
      case 'Payment Gateway':
        navscreen = MobileRecharge();
        break;
      case'Post Paid':
        navscreen = MobileRecharge();
        break;
      case 'Insurance':
        navscreen = MobileRecharge();
        break;
      case 'View More':
        navscreen = MobileRecharge();
        break;
      default:
        navscreen = Scaffold(
          appBar: AppBar(title: Text('Unknown')),
          body: Center(child: Text('No details available')),
        );
    }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => navscreen),
          );
  }

  final List<Map<String, String>> items1 = [
    {"image": "assets/electricity.png", "text": "Electricity"},
    {"image": "assets/gas.png", "text": "Gas"},
    {"image": "assets/dth.png", "text": "DTH"},
    {"image": "assets/fastag.png", "text": "Fastag"},
  ];


  void _navigateToScreens(BuildContext context, String text) {
    Widget detailsScreen;

    switch (text) {
      case 'Electricity':
        detailsScreen = Electricitybills();
        break;
      case 'Gas':
        detailsScreen = GasBill();
        break;
      case 'DTH':
        detailsScreen = DTHRecharge();
        break;
      case 'Fastag':
        detailsScreen = FasTagRechrge();
        break;
      default:

        detailsScreen = Scaffold(
          appBar: AppBar(title: Text('Unknown')),
          body: Center(child: Text('No details available')),
        );
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => detailsScreen),
    );
  }


  Future<void> _refreshData() async {}
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: h * 0.07,
        leadingWidth: 0,
        leading: Container(),
        title: Column(
          children: [
            Row(
              children: [
                InkWell(onTap: (){
                  Navigator.pushReplacementNamed(context, payjetprofile);
                },
                  child: Image.asset(
                    'assets/profile.png',
                    fit: BoxFit.contain,
                    height: 52,
                    width: 52, // Adjust the height as needed
                  ),
                ),
                SizedBox(
                  width: w * 0.02,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Add Address",
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color(0xff000000)),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                          size: 25,
                        )
                      ],
                    ),
                    Text(
                      "The Platina",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Color(0xff000000)),
                    )
                  ],
                ),
                Spacer(),
                Image.asset(
                  "assets/calc.png",
                  height: 24,
                  width: 24,
                ),
                SizedBox(width: w * 0.025),
                Image.asset(
                  "assets/notify.png",
                  height: 24,
                  width: 24,
                ),
                SizedBox(width: w * 0.025),
                InkWell(onTap: (){
                 PreferenceService().remove("access_token");
               var  Accesstoken=PreferenceService().getString("access_token");
                 print("hii >>>${Accesstoken}");
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                },
                  child: Image.asset(
                    "assets/menubar.png",
                    height: 24,
                    width: 24,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        color: Color(0xFFF6821F),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 3,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  autoPlay: true,
                  viewportFraction: 1,
                  pauseAutoPlayOnTouch: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
                items: imgList.map((item) {
                  return InkWell(
                    onTap: () async {
                      // Your onTap functionality here
                    },
                    child: Builder(
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Image.asset(
                            item,
                            fit: BoxFit.contain,
                            height: 112,
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.asMap().entries.map((entry) {
                  bool isActive = currentIndex == entry.key;
                  return Container(
                    width: isActive ? 17.0 : 7.0,
                    height: 7.0,
                    margin: EdgeInsets.symmetric(horizontal: 3.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive ? Color(0xFF000000) : Color(0xFFD3D3D3),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: h * 0.025),
              Container(
                padding: EdgeInsets.all(20),
                height: h*0.73,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.1),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: h * 0.018),
                    // Adjusted to ensure it fits the container
                    SizedBox(
                      height: 200, // Set a fixed height to the GridView
                      child: GridView.builder(
                        physics:
                        NeverScrollableScrollPhysics(), // Disable scrolling
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 20.0,
                          childAspectRatio: 0.9,
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Column(
                            children: [
                              InkWell(onTap:()=> _navigateToScreen(context,item['text']!),

                                child: Container(
                                  width: 45,
                                  height: 45,
                                  child: Image.asset(
                                    item['image']!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 2),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  item['text']!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Inter",
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w * 0.011, vertical: h * 0.010),
                              width: w*0.28,
                              // height:48,
                              decoration: BoxDecoration(
                                color: Color(0xff7209B7),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 6.6,
                                        right: 6.6,
                                        top: 5.4,
                                        bottom: 5.4),
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                        color: Color(0xffffffff),
                                        borderRadius:
                                        BorderRadius.circular(1000)),
                                    child: Image.asset("assets/train.png"),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Bus Ticket",
                                        style: TextStyle(
                                            color: Color(0xffFFFFFF),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 11,
                                            fontFamily: "Inter"),
                                      ),
                                      Text(
                                        "Booking",
                                        style: TextStyle(
                                            color: Color(0xffFFFFFF),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 11,
                                            fontFamily: "Inter"),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w * 0.011, vertical: h * 0.010),
                              width: w*0.30,
                              // height:48,
                              decoration: BoxDecoration(
                                color: Color(0xffF72585),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 6.6,
                                        right: 6.6,
                                        top: 5.4,
                                        bottom: 5.4),
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                        color: Color(0xffffffff),
                                        borderRadius:
                                        BorderRadius.circular(1000)),
                                    child: Image.asset("assets/train.png"),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Flight Ticket",
                                        style: TextStyle(
                                            color: Color(0xffFFFFFF),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 11,
                                            fontFamily: "Inter"),
                                      ),
                                      Text(
                                        "Booking",
                                        style: TextStyle(
                                            color: Color(0xffFFFFFF),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 11,
                                            fontFamily: "Inter"),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w * 0.011, vertical: h * 0.010),
                              width: w*0.28,
                              // height: 46,
                              decoration: BoxDecoration(
                                color: Color(0xff3A0CA3),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 6.6,
                                        right: 6.6,
                                        top: 5.4,
                                        bottom: 5.4),
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                        color: Color(0xffffffff),
                                        borderRadius:
                                        BorderRadius.circular(1000)),
                                    child: Image.asset("assets/train.png"),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Whole sale",
                                        style: TextStyle(
                                            color: Color(0xffFFFFFF),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 11,
                                            fontFamily: "Inter"),
                                      ),
                                      Text(
                                        "Booking",
                                        style: TextStyle(
                                            color: Color(0xffFFFFFF),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 11,
                                            fontFamily: "Inter"),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: w,
                      height: h * 0.180,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        border: Border.all(
                          color: Color(0xff0000001A).withOpacity(0.1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bill Payments",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                              height: h *
                                  0.012), // Adjusted spacing between title and list
                          Expanded(
                            // This will allow the ListView.builder to take the available space
                            child: ListView.builder(
                              scrollDirection:
                              Axis.horizontal, // Scroll horizontally
                              itemCount: items1.length,
                              itemBuilder: (context, index) {
                                final item =items1[index];
                                return InkWell(onTap:()=> _navigateToScreens(context,item['text']!),
                                  child: AspectRatio(
                                    aspectRatio:
                                    0.99, // Aspect ratio (you can adjust this)
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          items1[index]["image"]!,
                                          width: w * 0.040,
                                          height: h * 0.040,
                                        ),
                                        SizedBox(height: h * 0.004),
                                        Text(
                                          items1[index]["text"]!,
                                          style: TextStyle(
                                            color: Color(0xff242424),
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: h * 0.016,
                    ),

                    Row(
                      children: [
                        Container(
                          width: w * 0.28,
                          height: 80,
                          // padding:EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            border: Border.all(
                              color: Color(0xff0000001A).withOpacity(0.1),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/wallet.png",
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(
                                height: h * 0.004,
                              ),
                              Text(
                                "PhonePe Wallet",
                                style: TextStyle(
                                    color: Color(0xff330066),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: w * 0.007,
                        ),
                        Container(
                          width: w * 0.29,
                          height: 80,
                          // padding:EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            border: Border.all(
                              color: Color(0xff0000001A).withOpacity(0.1),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/rewards.png",
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(
                                height: h * 0.004,
                              ),
                              Text(
                                "PhonePe Wallet",
                                style: TextStyle(
                                    color: Color(0xff330066),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: w * 0.007,
                        ),
                        Container(
                          width: w * 0.29,
                          height: 80,
                          // padding:EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            border: Border.all(
                              color: Color(0xff0000001A).withOpacity(0.1),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/referenow.png",
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(
                                height: h * 0.004,
                              ),
                              Text(
                                "PhonePe Wallet",
                                style: TextStyle(
                                    color: Color(0xff330066),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),

      ),


      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        margin: EdgeInsets.only(bottom: 10,top: 15),
        width: w* 0.35,
        height: 45,
        decoration: BoxDecoration(
          color: Color(0xff330066),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/scan.png",
                width: 20,
                height: 15,
                fit: BoxFit.fill,
              ),
              SizedBox(width: w * 0.006),
              Text(
                "Scan Now",
                style: TextStyle(
                  color: Color(0xffFFFFFF),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
