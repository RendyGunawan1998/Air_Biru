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

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
          : notifs.length > 0
              ? SingleChildScrollView(
                  child: ListView.builder(
                  // scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: notifs.length,
                  itemBuilder: (context, i) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text((i + 1).toString()),
                        ),
                        title: Text(notifs[i].title),
                        subtitle: Text(notifs[i].description),
                      ),
                    );
                  },
                ))
              : Center(child: Text('Tidak Ada Data')),
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
