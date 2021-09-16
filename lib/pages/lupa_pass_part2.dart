import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:galon/controller/user_controller.dart';
import 'package:galon/helper/token.dart';
import 'package:galon/pages/login.dart';
import 'package:galon/widget/input_widget.dart';
import 'package:galon/widget/submit_button_widget.dart';
import 'package:get/get.dart';

class LupaPassPart2 extends StatefulWidget {
  final String email;
  final String phone;
  const LupaPassPart2({required this.email, required this.phone});
  _LupaPassPart2State createState() => _LupaPassPart2State();
}

class _LupaPassPart2State extends State<LupaPassPart2> {
  TextEditingController passTC = new TextEditingController();
  TextEditingController reTC = new TextEditingController();

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
    passTC.dispose();
    reTC.dispose();
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
          obscureText: true,
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
                  _textFormField(Icons.person, "Password Baru", passTC,
                      TextInputType.text),
                  _textFormField(Icons.phone, "Konfimasi Password", reTC,
                      TextInputType.text),
                  SizedBox(
                    height: 10,
                  ),
                  SubmitButtonWidget(
                    width: Get.width * 0.9,
                    color: Colors.blue,
                    function: () {
                      _tryUpdatePart2();
                      // print("pressed");
                    },
                    text: "Simpan",
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _tryUpdatePart2() async {
    if (passTC.text.isEmpty || reTC.text.isEmpty) {
      Get.snackbar("Gagal", "Isi Semua Field");
    } else {
      if (passTC.text != reTC.text) {
        Get.snackbar("Gagal", "Password & Konfirmasi Password Tidak Sama");
      } else {
        try {
          setState(() {
            loading = true;
          });
          await userController
              .ubahPasswordByEmailPhone(
                  widget.email, widget.phone, passTC.text, reTC.text)
              .then((value) => {
                    setState(() {
                      message = value;
                    })
                  });
          print("update profile: $message");
          if (message == "Password Berhasi Diubah.") {
            _alertSuccess(context, message);
          } else if (message == "Access Not Allowed") {
            Token().removeToken();
            Get.back();
          } else {
            Get.snackbar("Gagal Ubah Password", message);
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
  }

  _alertSuccess(BuildContext context, String message) {
    Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Get.offAll(() => LoginAnimation());
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
