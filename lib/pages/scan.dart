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
      home: ScanPage(),
    );
  }
}

class ScanPage extends StatefulWidget {
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            "QR",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
          ),
        ),
      ),
      body: Center(
        child: Card(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Event sudah selesai. \nTunggu event menarik berikutnya",
            textAlign: TextAlign.center,
          ),
        )),
      ),
    );
  }
}
