import 'dart:async';

import 'package:flutter/material.dart';
import 'package:galon/helper/token.dart';
import 'package:galon/pages/login.dart';
import 'package:galon/widget/extra_screen/loading.dart';
import 'package:get/get.dart';
// import 'package:puskeu/main.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Token token = Token();
  // String? tknExist;
  bool isLogin = false;

  @override
  void initState() {
    splashStart();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  splashStart() async {
    var duration = const Duration(seconds: 2);
    String tkn = await token.getAccessToken();
    if (tkn.isNotEmpty) {
      setState(() {
        isLogin = true;
        // tknExist = tkn;
      });
    }
    if (isLogin == true) {
      return Timer(duration, () {
        Get.offAll(() => LoadingScreen());
      });
    } else {
      return Timer(duration, () {
        Get.offAll(() => LoginAnimation());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logo.jpg',
              width: 200,
              height: 250,
            ),
            // Text(tknExist!)
          ],
        ),
      ),
    );
  }
}
