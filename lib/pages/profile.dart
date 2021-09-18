// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:galon/controller/user_controller.dart';
// import 'package:galon/controller/user_controller.dart';
import 'package:galon/helper/token.dart';
import 'package:galon/model/model_profile.dart';
import 'package:galon/pages/edit.dart';
// import 'package:galon/model/model_profile.dart';
import 'package:galon/pages/login.dart';
import 'package:galon/pages/password.dart';
import 'package:galon/pages/upload_ktp.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatefulWidget {
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  UserController userController = UserController();
  Profile? profile;

  GoogleSignIn _googleSignIn = GoogleSignIn();

  bool loading = true;

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  getProfile() async {
    try {
      print("NOTIF");
      var res = await userController.profil();
      setState(() {
        loading = false;
        profile = res;
      });
      print("notif success");
    } catch (e) {
      setState(() {
        loading = false;
      });
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            "My Account",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
          ),
        ),
      ),
      body: loading ? Center(child: CircularProgressIndicator()) : _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildName(),
          _buildBodyForm(),
        ],
      ),
    );
  }

  //========================= AppBarDone==================
  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue[200],
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          title: Text(
            profile?.name ?? '-',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
          subtitle: Text(
            profile?.email ?? '-',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              print('edit');
              Get.to(() => EditPage(
                    profile: profile!,
                  ));
            },
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
          SizedBox(
            height: 5,
          ),
          _buildKTP(),
          _buildPassword(),
          _buildLogOut(),
        ],
      ),
    );
  }

  Widget _buildKTP() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.transparent)),
      child: Stack(
        children: [
          ListTile(
            onTap: () {
              Get.to(() => UploadKTPPage());
            },
            title: Text(
              'Upload KTP',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            subtitle: Text(
              'Upload Foto KTP',
              style: TextStyle(color: Colors.black54, fontSize: 13),
            ),
            trailing: Icon(
              Icons.upload,
              color: Colors.black,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPassword() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.transparent)),
      child: Stack(
        children: [
          ListTile(
            onTap: () {
              Get.to(() => PasswordPage());
            },
            title: Text(
              'Ubah Password',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            subtitle: Text(
              'Ubah Passowrd Anda',
              style: TextStyle(color: Colors.black54, fontSize: 13),
            ),
            trailing: Icon(
              Icons.lock,
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
              _googleSignIn.signOut();
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
