import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:galon/widget/extra_screen/splash.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Air Minum Biru',
      home: SplashScreen(),
    );
  }
}
