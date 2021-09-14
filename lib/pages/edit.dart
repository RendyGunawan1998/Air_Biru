import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galon/controller/user_controller.dart';
import 'package:galon/helper/token.dart';
import 'package:galon/pages/login.dart';
import 'package:galon/pages/profile.dart';
import 'package:galon/widget/submit_button_widget.dart';
import 'package:get/get.dart';

class EditPage extends StatefulWidget {
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController namaTC = new TextEditingController();
  TextEditingController telpTC = new TextEditingController();
  TextEditingController alamatTC = new TextEditingController();
  TextEditingController emailTC = new TextEditingController();
  TextEditingController ktpTC = new TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode myFocusNode = new FocusNode();
  bool loading = false;
  String message = '';

  UserController userController = UserController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    namaTC.dispose();
    telpTC.dispose();
    alamatTC.dispose();
    emailTC.dispose();
    ktpTC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue[100],
        title: Text(
          "Edit Profile",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _textFormField(IconData icon, String label,
      TextEditingController controller, TextInputType input) {
    return TextFormField(
      style: TextStyle(color: Colors.black, fontSize: 16),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.black,
        ),
        labelText: label,
        labelStyle:
            TextStyle(color: myFocusNode.hasFocus ? Colors.blue : Colors.black),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      controller: controller,
      keyboardType: input,
    );
  }

  Widget _box(double height) {
    return SizedBox(
      height: height,
    );
  }

  Widget _buildBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: size.height * 0.85,
                width: double.infinity * 0.1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [Color(0xFF90CAF9), Color(0xFFBBDEFB)]),
                ),
                child: Opacity(
                  opacity: 0.7,
                  child: Image.asset(
                    "assets/icons/iconMascot.png",
                    fit: BoxFit.cover,
                    height: Get.height,
                    width: double.infinity,
                  ),
                ),
              ),
              Form(
                key: formKey,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      _textFormField(
                          Icons.person, "Nama", namaTC, TextInputType.name),
                      _textFormField(
                          Icons.phone, "No Telp", telpTC, TextInputType.number),
                      _textFormField(Icons.location_pin, "Alamat", alamatTC,
                          TextInputType.streetAddress),
                      _textFormField(Icons.email, "Email", emailTC,
                          TextInputType.emailAddress),
                      _textFormField(Icons.contact_mail_rounded, "No KTP",
                          ktpTC, TextInputType.number),
                      _box(25),
                      SubmitButtonWidget(
                        width: Get.width * 0.85,
                        color: Colors.green[300],
                        function: () {
                          print(namaTC.text);
                          print(telpTC.text);
                          print(alamatTC.text);
                          print(emailTC.text);
                          print(ktpTC.text);
                          _tryUpdate();
                        },
                        text: "Update Profile",
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _tryUpdate() async {
    try {
      setState(() {
        loading = true;
      });
      await userController
          .updateProfile(
              namaTC.text, telpTC.text, emailTC.text, alamatTC.text, ktpTC.text)
          .then((value) => {
                setState(() {
                  message = value;
                })
              });
      print("update profile: $message");
      if (message == "Data Berhasil Update !!") {
        _alertSuccess(context);
      } else if (message == "Access Not Allowed") {
        Token().removeToken();
        Get.offAll(LoginAnimation());
      } else {
        Get.snackbar("Gagal edit profile", message);
      }
      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });

      Get.snackbar("Gagal", "Terjadi Kesalahan");
    }
  }

  _alertSuccess(BuildContext context) {
    Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Get.offAll(() => ProfilePage());
        });
    AlertDialog alert = AlertDialog(
      title: Text("Sukses"),
      content: Text("Profile berhasil diperbaharui"),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
