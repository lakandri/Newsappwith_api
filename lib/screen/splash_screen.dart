import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapiapp/screen/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/splash_pic.jpg',
              fit: BoxFit.cover,
              width: width * 1,
              height: height * .5,
            ),
            SizedBox(
              height: height * .04,
            ),
            Text(
              'Top Headlines',
              style: GoogleFonts.anton(letterSpacing: .6, color: Colors.grey),
            ),
            SizedBox(
              height: height * .04,
            ),
            const SpinKitChasingDots(
              color: Colors.black,
              size: 40,
            )
          ],
        ),
      ),
    );
  }
}
