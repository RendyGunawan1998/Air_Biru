import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:galon/controller/user_controller.dart';
import 'package:galon/widget/input_widget.dart';
import 'package:galon/widget/submit_button_widget.dart';
import 'package:get/get.dart';

class LupaPass extends StatefulWidget {
  _LupaPassState createState() => _LupaPassState();
}

class _LupaPassState extends State<LupaPass> {
  TextEditingController namaTC = new TextEditingController();
  TextEditingController telpTC = new TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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

  Widget _box(double height) {
    return SizedBox(
      height: height,
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _box(15),
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
                  _box(25),
                  SubmitButtonWidget(
                    width: Get.width * 0.9,
                    color: Colors.blue,
                    function: () {
                      // _tryUpdate();
                      print("pressed");
                    },
                    text: "Reset Password",
                    textColor: Colors.white,
                  ),
                  _box(30),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 200),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "Kesulitan dalam verifikasi data anda?\nKlik Disini untuk menghubungi kami",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            _box(10),
                            Text(
                              "https://airminumbiru.com/contact.php",
                              style: TextStyle(color: Colors.blue),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // void _tryUpdate() async {
  //   try {
  //     setState(() {
  //       loading = true;
  //     });
  //     await userController
  //         .updateProfile(
  //             namaTC.text, telpTC.text, emailTC.text, alamatTC.text, ktpTC.text)
  //         .then((value) => {
  //               setState(() {
  //                 message = value;
  //               })
  //             });
  //     print("update profile: $message");
  //     if (message == "Data Berhasil Update !!") {
  //       _alertSuccess(context);
  //     } else if (message == "Access Not Allowed") {
  //       Token().removeToken();
  //       Get.back();
  //     } else {
  //       Get.snackbar("Gagal edit profile", message);
  //     }
  //     setState(() {
  //       loading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       loading = false;
  //     });

  //     Get.snackbar("Gagal", "Terjadi Kesalahan");
  //   }
  // }

  _alertSuccess(BuildContext context) {
    Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Get.back();
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
