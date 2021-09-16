import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galon/controller/user_controller.dart';
import 'package:galon/helper/token.dart';
import 'package:galon/widget/input_widget.dart';
import 'package:galon/widget/submit_button_widget.dart';
import 'package:get/get.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({Key? key}) : super(key: key);
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  TextEditingController oldCtrl = new TextEditingController();
  TextEditingController passCtrl = new TextEditingController();
  TextEditingController reCtrl = new TextEditingController();
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
    oldCtrl.dispose();
    passCtrl.dispose();
    reCtrl.dispose();
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
          "Ubah Password",
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
          Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  _textFormField(
                      Icons.lock, "Password Lama", oldCtrl, TextInputType.text),
                  _textFormField(Icons.lock, "Password Baru", passCtrl,
                      TextInputType.text),
                  _textFormField(Icons.lock, "Konformasi Password Baru", reCtrl,
                      TextInputType.text),
                  _box(25),
                  SubmitButtonWidget(
                    width: Get.width * 0.9,
                    color: Colors.blue,
                    function: () {
                      _tryUpdate();
                    },
                    text: "Update Password",
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

  void _tryUpdate() async {
    if (oldCtrl.text.isNotEmpty &&
        passCtrl.text.isNotEmpty &&
        reCtrl.text.isNotEmpty) {
      if (passCtrl.text == reCtrl.text) {
        try {
          setState(() {
            loading = true;
          });
          await userController
              .updatePassword(oldCtrl.text, passCtrl.text, reCtrl.text)
              .then((value) => {
                    setState(() {
                      message = value;
                    })
                  });
          print("update Password: $message");
          if (message == "Password Berhasil Diubah") {
            _alertSuccess(context);
          } else if (message == "Access Not Allowed") {
            Token().removeToken();
            Get.back();
          } else {
            Get.snackbar("Gagal edit Password", message);
          }
          setState(() {
            loading = false;
          });
        } catch (e) {
          setState(() {
            loading = false;
          });

          Get.snackbar("Gagal", e.toString());
        }
      } else {
        Get.snackbar("Gagal", "Password & Konfirmasi Password Tidak Sama");
      }
    } else {
      Get.snackbar("Gagal", "Isi Semua Data");
    }
  }

  _alertSuccess(BuildContext context) {
    Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Get.back();
        });
    AlertDialog alert = AlertDialog(
      title: Text("Sukses"),
      content: Text("Password berhasil diperbaharui"),
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
