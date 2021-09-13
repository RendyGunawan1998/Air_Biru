// import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:galon/controller/user_controller.dart';
import 'package:galon/helper/token.dart';
// import 'package:galon/model/model_profile.dart';
import 'package:galon/pages/login.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

// class ProfilePage extends StatefulWidget {
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   UserController userController = UserController();
//   bool loading = true;
//   late Future<Profile> futureProfile;

//   @override
//   void initState() {
//     super.initState();
//     futureProfile = getInfo();
//   }

//   Future<Profile> getInfo() async {
//     String url = 'https://gebyarairminumbiru.com/api/user/info';

//     var response = await http.get(
//       Uri.parse(url),
//       headers: {
//         "Authorization": "Bearer" + await Token().getAccessToken()
//         //access token dlm bentuk bearer //disini udh ada auth untuk access
//       },
//     );
//     //var toJson = jsonDecode(response.body);
//     if (response.statusCode == 200) {
//       final res = json.decode(response.body);
//       Token().saveUserData(json.encode(res));
//       return Profile.fromJson(jsonDecode(response.body));
//     } else {
//       // throw Exception("Failed to load data");
//       throw response;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<Profile>(
//         future: futureProfile,
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.hasData) {
//             return _buildBody(snapshot.data);
//           } else if (snapshot.hasError) {
//             return Text('${snapshot.error}');
//           }
//           return const CircularProgressIndicator();
//         },
//       ),
//     );
//   }

//   Widget _buildBody(Profile data) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           _buildName(data),
//           _buildBodyForm(data),
//         ],
//       ),
//     );
//   }

//   Widget _buildName(Profile data) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 15,
//         ),
//         SizedBox(
//           height: 90,
//           width: 90,
//           child: Stack(
//             // overflow: Overflow.visible,
//             fit: StackFit.expand,
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.deepOrange[300],
//                 child: Icon(Icons.person),
//                 radius: 30,
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 5,
//         ),
//         Text(
//           data.name,
//           style: TextStyle(
//             fontSize: 18,
//             color: Colors.white,
//           ),
//         ),
//         SizedBox(
//           height: 7,
//         ),
//         Text(
//           data.noKtp,
//           style: TextStyle(
//             fontSize: 18,
//             color: Colors.white,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildBodyForm(Profile data) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: <Widget>[
//         Container(
//           padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//           child: Column(
//             children: <Widget>[
//               _buildFormProfile(data),
//               SizedBox(
//                 height: 65,
//               ),
//               _buildLogOut(),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildFormProfile(Profile data) {
//     return Card(
//       elevation: 3,
//       child: Column(
//         children: <Widget>[
//           // _buildPangkat(data),
//           Divider(
//             height: 1,
//             color: Colors.black54,
//             indent: 7,
//             endIndent: 5,
//           ),
//           // _buildSatker(data),
//           Divider(
//             height: 1,
//             color: Colors.black54,
//             indent: 7,
//             endIndent: 5,
//           ),
//           // _buildPhone(data),
//         ],
//       ),
//     );
//   }

//   Widget _buildLogOut() {
//     return Stack(
//       children: [
//         ListTile(
//           onTap: () async {
//             await Token().removeToken();
//             Get.offAll(LoginAnimation());
//           },
//           title: Text(
//             'Logout',
//             style: TextStyle(color: Colors.black, fontSize: 16),
//           ),
//           subtitle: Text(
//             'Keluar dari Aplikasi',
//             style: TextStyle(color: Colors.black54, fontSize: 13),
//           ),
//           trailing: Icon(
//             Icons.power_settings_new,
//             color: Colors.red,
//             size: 30,
//           ),
//         ),
//       ],
//     );
//   }
// }

class ProfilePage extends StatefulWidget {
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 0.0,
      duration: Duration(seconds: 40),
      upperBound: 1,
      lowerBound: -1,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.blue[200],
          ),
        ),
        elevation: 1,
        title: Text(
          "My Account",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildAnimation(),
          _buildBodyForm(),
        ],
      ),
    );
  }

  Widget _buildAnimation() {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  return ClipPath(
                    clipper: DrawClip(_controller.value),
                    child: Container(
                      height: size.height * 0.25,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [Color(0xFF90CAF9), Color(0xFFBBDEFB)]),
                      ),
                      child: Opacity(
                        opacity: 0.7,
                        child: Image.asset(
                          "assets/images/logo.jpg",
                          fit: BoxFit.cover,
                          height: 80,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  );
                }),
            _buildName(),
          ],
        ),
      ],
    );
  }

  //========================= AppBarDone==================
  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.grey[200],
        elevation: 0.7,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue[200],
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          title: Text(
            "Ini Nama",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
          subtitle: Text(
            "Ini ktp",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBodyForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // SizedBox(
                //   height: 20,
                // ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      // color: Colors.grey[300],
                      elevation: 0.5,
                      child: Column(
                        children: [
                          _buildFormProfile(),
                        ],
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                    child: Text("Versi 1.0",
                        style: TextStyle(color: Colors.black))),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // BUILD FORM 2
  Widget _buildFormProfile() {
    return Card(
      // color: Colors.grey[300],
      elevation: 0.5,
      child: Column(
        children: <Widget>[
          _buildEmail(),
          Divider(
            height: 1,
            color: Colors.black54,
            indent: 7,
            endIndent: 5,
          ),
          _buildTelp(),
          Divider(
            height: 1,
            color: Colors.black54,
            indent: 7,
            endIndent: 5,
          ),
          _buildAddress(),
          Divider(
            height: 1,
            color: Colors.black54,
            indent: 7,
            endIndent: 5,
          ),
          SizedBox(
            height: 5,
          ),
          _buildSetting(),
          _buildLogOut(),
        ],
      ),
    );
  }

  Widget _buildItemData(String tag) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          tag,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildEmail() {
    return Container(
      padding: EdgeInsets.all(10),
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Icon(
              Icons.email,
              color: Colors.blue[100],
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
            VerticalDivider(
              thickness: 1,
              color: Colors.black54,
              width: 1,
              indent: 5,
              endIndent: 5,
            ),
            SizedBox(
              width: 20,
            ),
            _buildItemData("Ini email user")
          ],
        ),
      ),
    );
  }

  Widget _buildTelp() {
    return Container(
      padding: EdgeInsets.all(10),
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Icon(
              Icons.phone,
              color: Colors.red[300],
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
            VerticalDivider(
              thickness: 1,
              color: Colors.black54,
              width: 1,
              indent: 5,
              endIndent: 5,
            ),
            SizedBox(
              width: 20,
            ),
            _buildItemData("Ini no telp user")
          ],
        ),
      ),
    );
  }

  Widget _buildAddress() {
    return Container(
      padding: EdgeInsets.all(10),
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Icon(
              Icons.location_pin,
              color: Colors.green,
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
            VerticalDivider(
              thickness: 1,
              color: Colors.black54,
              width: 1,
              indent: 5,
              endIndent: 5,
            ),
            SizedBox(
              width: 20,
            ),
            _buildItemData("Alamat user"),
          ],
        ),
      ),
    );
  }

  Widget _buildSetting() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.transparent)),
      child: Stack(
        children: [
          ListTile(
            onTap: () async {},
            title: Text(
              'Setting',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            subtitle: Text(
              'Pengaturan aplikasi',
              style: TextStyle(color: Colors.black54, fontSize: 13),
            ),
            trailing: Icon(
              Icons.settings,
              color: Colors.black,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogOut() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.transparent)),
      child: Stack(
        children: [
          ListTile(
            onTap: () async {
              await Token().removeToken();
              Get.offAll(() => LoginAnimation());
            },
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            subtitle: Text(
              'Keluar dari Aplikasi',
              style: TextStyle(color: Colors.black54, fontSize: 13),
            ),
            trailing: Icon(
              Icons.power_settings_new,
              color: Colors.red,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

class DrawClip extends CustomClipper<Path> {
  double move = 0;
  double slice = math.pi;
  DrawClip(this.move);
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.8);
    double xCenter =
        size.width * 0.5 + (size.width * 0.6 + 1) * math.sin(move * slice);
    double yCenter = size.height * 0.8 + 69 * math.cos(move * slice);
    path.quadraticBezierTo(xCenter, yCenter, size.width, size.height * 0.8);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
