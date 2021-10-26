import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galon/controller/user_controller.dart';
import 'package:galon/helper/token.dart';
import 'package:galon/model/model_profile.dart';
// import 'package:galon/pages/login.dart';
// import 'package:galon/pages/profile.dart';
import 'package:galon/widget/input_widget.dart';
import 'package:galon/widget/submit_button_widget.dart';
import 'package:get/get.dart';

class EditPage extends StatefulWidget {
  final Profile profile;
  const EditPage({Key? key, required this.profile}) : super(key: key);
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
    setState(() {
      namaTC.text = widget.profile.name;
      telpTC.text = widget.profile.phone;
      alamatTC.text = widget.profile.address;
      emailTC.text = widget.profile.email;
      ktpTC.text = widget.profile.noKtp;
    });
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
          "Ubah Profile",
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
    // var size = MediaQuery.of(context).size;
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
                      Icons.person, "Nama", namaTC, TextInputType.name),
                  _textFormField(
                      Icons.phone, "No Telp", telpTC, TextInputType.number),
                  _textFormField(Icons.location_pin, "Alamat", alamatTC,
                      TextInputType.streetAddress),
                  _textFormField(Icons.email, "Email", emailTC,
                      TextInputType.emailAddress),
                  _textFormField(Icons.contact_mail_rounded, "No KTP", ktpTC,
                      TextInputType.number),
                  _box(25),
                  SubmitButtonWidget(
                    width: Get.width * 0.9,
                    color: Colors.blue,
                    function: () {
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
    );
  }

  void _tryUpdate() async {
    if (namaTC.text.isEmpty ||
        telpTC.text.isEmpty ||
        emailTC.text.isEmpty ||
        alamatTC.text.isEmpty ||
        ktpTC.text.isEmpty) {
      Get.snackbar("Gagal", "Isi Semua Field",
          backgroundColor: Colors.white, colorText: Colors.red);
    } else {
      try {
        setState(() {
          loading = true;
        });
        await userController
            .updateProfile(namaTC.text, telpTC.text, emailTC.text,
                alamatTC.text, ktpTC.text)
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
          Get.back();
        } else {
          Get.snackbar("Gagal edit profile", message,
              backgroundColor: Colors.white, colorText: Colors.red);
        }
        setState(() {
          loading = false;
        });
      } catch (e) {
        setState(() {
          loading = false;
        });

        Get.snackbar("Gagal", "Terjadi Kesalahan",
            backgroundColor: Colors.white, colorText: Colors.red);
      }
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
