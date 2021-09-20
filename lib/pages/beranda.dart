import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:galon/controller/user_controller.dart';
import 'package:galon/model/banners.dart';
import 'package:galon/model/model_profile.dart';
import 'package:galon/model/posts.dart';
import 'package:galon/pages/baca.dart';
import 'package:galon/pages/lihat.dart';
import 'package:get/get.dart';

class BerandaPage extends StatefulWidget {
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  late FlutterLocalNotificationsPlugin fltNotification;

  UserController userController = UserController();

  List<Posts> posts = [];
  List<Banners> banners = [];

  bool loadingPosts = true;
  bool loadingBanner = true;
  bool loadingProfile = true;

  Profile? profile;

  @override
  void initState() {
    getListPosts();
    getListBanner();
    getProfile();
    super.initState();
    notitficationPermission();
    initMessaging();
    updateFcmToken();
  }

  void notitficationPermission() async {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void initMessaging() {
    var androiInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    var iosInit = IOSInitializationSettings();

    var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);

    fltNotification = FlutterLocalNotificationsPlugin();

    fltNotification.initialize(initSetting);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message);
    });
  }

  void showNotification(RemoteMessage message) async {
    var androidDetails =
        AndroidNotificationDetails('1', 'channelName', 'channel Description');

    var iosDetails = IOSNotificationDetails();

    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    // fltNotification.show(0, generalNotificationDetails)
    RemoteNotification? notification = message.notification;

    await fltNotification.show(notification.hashCode, notification?.title,
        notification?.body, generalNotificationDetails,
        payload: 'Notification');
  }

  updateFcmToken() async {
    String? token = await messaging.getToken();
    await userController.updateFCMToken(token!);
  }

  getListPosts() async {
    try {
      print("getListPosts");
      var res = await userController.getPosts();
      setState(() {
        loadingPosts = false;
        posts = res;
      });
      print("getListPosts selesai");
    } catch (e) {
      setState(() {
        loadingPosts = false;
      });
      print(e);
    }
  }

  getListBanner() async {
    try {
      print("getListBanner");
      var resBanner = await userController.getBanner();
      setState(() {
        loadingBanner = false;
        banners = resBanner;
      });
      print("getListBanner selesai");
    } catch (e) {
      setState(() {
        loadingBanner = false;
      });
      print(e);
    }
  }

  getProfile() async {
    try {
      print("NOTIF");
      var res = await userController.profil();
      setState(() {
        loadingProfile = false;
        profile = res;
      });
      print("notif success");
    } catch (e) {
      setState(() {
        loadingProfile = false;
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
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   title: ,
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: Get.width,
                height: 50,
                margin: const EdgeInsets.fromLTRB(0, 12, 0, 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 1,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 2, color: Colors.blue),
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 6,
                      child: Text(
                        profile?.name ?? '-',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 3),
                        child: Image.asset("assets/images/logo.jpg"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            loadingBanner
                ? Center(child: CircularProgressIndicator())
                : CarouselSlider(
                    options: CarouselOptions(height: 230),
                    items: banners.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return InkWell(
                            onTap: () {
                              Get.to(() => Lihat(
                                    posts: i,
                                  ));
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                // decoration: BoxDecoration(color: Colors.amber),
                                child:
                                    Image.network(i.image, fit: BoxFit.cover)),
                          );
                        },
                      );
                    }).toList(),
                  ),
            Expanded(
              child: loadingPosts
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      padding: EdgeInsets.all(15),
                      child: StaggeredGridView.countBuilder(
                        crossAxisCount: 2,
                        itemCount: posts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CardBerita(posts: posts[index]);
                        },
                        staggeredTileBuilder: (int index) =>
                            StaggeredTile.fit(1),
                        mainAxisSpacing: 2.0,
                        crossAxisSpacing: 2.0,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardBerita extends StatelessWidget {
  final Posts posts;
  const CardBerita({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => Baca(posts: posts));
      },
      child: Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(posts.image),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              posts.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      )),
    );
  }
}
