import 'package:flutter/material.dart';
import 'package:galon/controller/user_controller.dart';
import 'package:galon/pages/login.dart';
import 'package:galon/widget/extra_screen/loading.dart';
import 'package:galon/widget/input_widget.dart';
import 'package:galon/widget/submit_button_widget.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  UserController userController = UserController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _obsecureText = true;

  TextEditingController namaTC = new TextEditingController();
  TextEditingController telpTC = new TextEditingController();
  TextEditingController emailTC = new TextEditingController();
  TextEditingController addressTC = new TextEditingController();
  TextEditingController ktpTC = new TextEditingController();
  TextEditingController passTC = new TextEditingController();

  // LoginRequestModel requestModel;
  bool loading = false;

  String message = '';

  @override
  void initState() {
    super.initState();
    // cekLogin();
  }

  @override
  void dispose() {
    namaTC.dispose();
    telpTC.dispose();
    emailTC.dispose();
    addressTC.dispose();
    ktpTC.dispose();
    passTC.dispose();
    super.dispose();
  }

  String validatePassword(value, text) {
    if (value.isEmpty || value == "" || value == null) {
      return "$text tidak boleh kosong";
    } else {
      return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      // Color(0xff21254A),
      resizeToAvoidBottomInset: false,
      body: loading == false
          ? _buildBody()
          : Center(
              child: CircularProgressIndicator(
              color: Colors.white,
            )),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          Expanded(child: Container()),
          Image.asset(
            "assets/images/logo.jpg",
            width: Get.width * 0.3,
          ),
          SizedBox(height: 20),
          Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  InputWidget(
                    child: TextFormField(
                        decoration: InputDecoration(
                          // hintText: "Masukkan Email",
                          labelText: "Nama",
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: namaTC),
                  ),
                  SizedBox(height: 10),
                  InputWidget(
                    child: TextFormField(
                        decoration: InputDecoration(
                          // hintText: "Masukkan Email",
                          labelText: "No Telp",
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        controller: telpTC),
                  ),
                  SizedBox(height: 10),
                  InputWidget(
                    child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "No KTP",
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        controller: ktpTC),
                  ),
                  SizedBox(height: 10),
                  InputWidget(
                    child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Alamat",
                          border: InputBorder.none,
                        ),
                        controller: addressTC),
                  ),
                  SizedBox(height: 10),
                  InputWidget(
                    child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: InputBorder.none,
                        ),
                        controller: emailTC),
                  ),
                  SizedBox(height: 10),
                  InputWidget(
                    child: TextFormField(
                        decoration: InputDecoration(
                            labelText: "Password", border: InputBorder.none),
                        controller: passTC),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          _buildButtonRegis(),
          SizedBox(height: 20),
          Expanded(child: Container()),
          Text(
            'Air Minum Biru | Versi 1.0.10',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRegis() {
    return SubmitButtonWidget(
      width: Get.width * 0.85,
      color: Colors.blueAccent[100],
      function: () {
        print(namaTC.text);
        print(telpTC.text);
        print(ktpTC.text);
        print(addressTC.text);
        print(emailTC.text);
        print(passTC.text);
        _registration();
      },
      text: "Registrasi",
      textColor: Colors.white,
    );
  }

  void _registration() async {
    try {
      setState(() {
        loading = true;
      });
      await userController
          .regis(namaTC.text, telpTC.text, emailTC.text, addressTC.text,
              ktpTC.text, passTC.text)
          .then((value) => {
                setState(() {
                  message = value;
                })
              });
      print("_regis: $message");
      if (message == "Data Berhasil Ditambahkan !!") {
        Get.offAll(() => LoginAnimation());
      } else {
        Get.snackbar("Gagal", message);
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
