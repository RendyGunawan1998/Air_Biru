import 'package:flutter/material.dart';
import 'package:galon/widget/extra_screen/splash.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Galon',
      home: SplashScreen(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Galon"),
//         ),
//         body: Center(
//           child: LoadingScreen(),
//         ) // This trailing comma makes auto-formatting nicer for build methods.
//         );
//   }
// }
