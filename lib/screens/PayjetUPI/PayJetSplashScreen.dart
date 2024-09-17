import 'package:egrocer/screens/PayjetUPI/PayjetDashboard.dart';
import 'package:egrocer/screens/PayjetUPI/services/Preferances.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'PayjetHomeScreen.dart';
import 'Register.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  String token="";
  String status="";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
   var  token = PreferenceService().getString("access_token");


    // Navigate to the next screen after the animation
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 3), () {
        if(token == null){
          print("Token>>>${token}");
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => RegistrationScreen()));
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => PayjetDashboard()));
        }

      });
    });

  }


  // Fetchdetails() async {
  //   var Token = (await PreferenceService().getString('token'))??"";
  //   setState(() {
  //     token=Token;
  //   });
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff51BD88),
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Center(
              child: Image.asset(
                "assets/logo.png",
                width: 260,
                height: 150,
                fit:BoxFit.contain,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
