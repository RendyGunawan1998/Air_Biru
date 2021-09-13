import 'package:flutter/material.dart';
import 'package:galon/controller/user_controller.dart';
import 'package:galon/model/notif.dart';

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
  UserController userController = UserController();
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  List<Notif> notifs = [];

  bool loadingNotif = true;
  @override
  void initState() {
    getListNotif();
    super.initState();
    // refreshList();
  }

  getListNotif() async {
    try {
      print("NOTIF");
      var res = await userController.notif();
      setState(() {
        loadingNotif = false;
        notifs = res;
      });
      print("notif success");
    } catch (e) {
      setState(() {
        loadingNotif = false;
      });
      print(e);
    }
  }

  Future refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    setState(() {
      notifs = getListNotif();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            "Notifikasi",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
          ),
        ),
      ),
      body: loadingNotif
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: ListView.builder(
              // scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: notifs.length,
              itemBuilder: (context, i) {
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text(notifs[i].title),
                );
              },
            )),
    );
  }

  // Future _getNotif() async {
  //   try {
  //     await userController.notif();
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
