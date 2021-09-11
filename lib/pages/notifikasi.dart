import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotifikasiPage(),
    );
  }
}

class NotifikasiPage extends StatefulWidget {
  _NotifikasiPageState createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "NOTOFIKASI",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
      ),
      body: Center(
        child: Text("Hello"),
      ),
    );
  }
}
