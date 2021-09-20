import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:galon/controller/user_controller.dart';
import 'package:galon/helper/token.dart';
import 'package:galon/pages/lupa_pass_part2.dart';
import 'package:galon/widget/input_widget.dart';
import 'package:galon/widget/submit_button_widget.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LupaPass extends StatefulWidget {
  _LupaPassState createState() => _LupaPassState();
}

class _LupaPassState extends State<LupaPass> {
  TextEditingController emailTC = new TextEditingController();
  TextEditingController telpTC = new TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool loading = false;
  String message = '';

  String _url = "https://airminumbiru.com/contact.php";

  UserController userController = UserController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailTC.dispose();
    telpTC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      // backgroundColor: Colors.blue[200],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Lupa Password",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
        ),
      ),
      body: loading ? Center(child: CircularProgressIndicator()) : _buildBody(),
    );
  }

  Widget _textFormField(IconData icon, String label,
      TextEditingController controller, TextInputType input) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: InputWidget(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
          ),
          controller: controller,
          keyboardType: input,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  _textFormField(Icons.person, "Email", emailTC,
                      TextInputType.emailAddress),
                  _textFormField(
                      Icons.phone, "No Telp", telpTC, TextInputType.number),
                  SizedBox(
                    height: 10,
                  ),
                  SubmitButtonWidget(
                    width: Get.width * 0.9,
                    color: Colors.blue,
                    function: () {
                      _tryUpdate();
                      // print("pressed");
                    },
                    text: "Reset Password",
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                    child: RichText(
                        text: TextSpan(
                            text: "Kesulitan dalam verifikasi data anda ? ",
                            style: TextStyle(color: Colors.black),
                            children: [
                          TextSpan(text: "klik "),
                          TextSpan(
                            text: "disini ",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () {
                                _launchURL();
                              },
                          ),
                          TextSpan(text: "klik disini untuk menghubungi kami"),
                        ])),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  void _tryUpdate() async {
    if (emailTC.text.isEmpty || telpTC.text.isEmpty) {
      Get.snackbar("Gagal", "Isi Semua Field");
    } else {
      try {
        setState(() {
          loading = true;
        });
        await userController
            .cariUserByEmailPhone(emailTC.text, telpTC.text)
            .then((value) => {
                  setState(() {
                    message = value;
                  })
                });
        print("update profile: $message");
        if (message ==
            "Identifikasi User Berhasil. Silahkan Masukkan Password Baru Anda.") {
          _alertSuccess(context, message);
        } else if (message == "Access Not Allowed") {
          Token().removeToken();
          Get.back();
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
  }

  _alertSuccess(BuildContext context, String message) {
    Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Get.to(() => LupaPassPart2(
                email: emailTC.text,
                phone: telpTC.text,
              ));
        });
    AlertDialog alert = AlertDialog(
      title: Text("Sukses"),
      content: Text(message),
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
