import 'package:flutter/material.dart';
import 'package:galon/controller/user_controller.dart';
import 'package:galon/pages/lupa_pass.dart';
import 'package:galon/pages/register.dart';
import 'package:galon/widget/extra_screen/loading.dart';
import 'package:galon/widget/input_widget.dart';
import 'package:galon/widget/submit_button_widget.dart';
import 'package:galon/widget/text_putih.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginAnimation extends StatefulWidget {
  _LoginAnimationState createState() => _LoginAnimationState();
}

class _LoginAnimationState extends State<LoginAnimation>
    with SingleTickerProviderStateMixin {
  GoogleSignIn _googleSignIn = GoogleSignIn();

  UserController userController = UserController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _obsecureText = true;

  TextEditingController userTC = new TextEditingController();
  TextEditingController passTC = new TextEditingController();

  // LoginRequestModel requestModel;
  bool loading = false;

  String message = '';

  GoogleSignInAccount? user;

  @override
  void initState() {
    super.initState();
    // cekLogin();
  }

  @override
  void dispose() {
    userTC.dispose();
    passTC.dispose();
    super.dispose();
  }

  String validatePassword(value) {
    if (value.isEmpty) {
      return "Password tidak boleh kosong";
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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 50),
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
                          labelText: "Email",
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: userTC),
                  ),
                  SizedBox(height: 20),
                  InputWidget(
                    child: TextFormField(
                        decoration: InputDecoration(
                            labelText: "Password",
                            // hintText: "Masukkan Kata Sandi",
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obsecureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obsecureText = !_obsecureText;
                                });
                              },
                            ),
                            border: InputBorder.none),
                        obscureText: _obsecureText,
                        controller: passTC),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          _buildButtonLogin(),
          SizedBox(height: 20),
          _buildButtonGoogle(),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    Get.to(() => RegisterPage());
                  },
                  child: TextPutih(text: 'Daftar Akun')),
              InkWell(
                  onTap: () {
                    Get.to(() => LupaPass());
                  },
                  child: TextPutih(text: 'Lupa Sandi?')),
              TextPutih(text: 'Privacy Policy'),
            ],
          ),
          SizedBox(height: 20),
          Image.asset(
            "assets/icons/iconMascot.png",
            width: Get.width * 0.3,
          ),
          Expanded(child: Container()),
          Text(
            'Air Minum Biru | Versi 1.0.10',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    // ============================================
    setState(() {
      loading = true;
    });
    try {
      //login gmail
      GoogleSignInAccount? googleUser;
      googleUser = await _googleSignIn.signIn();

      // Return null to prevent further exceptions if googleSignInAccount is null
      if (googleUser == null) {
        setState(() {
          loading = false;
        });
        return null;
      }
      // print(googleUser);
      // var = {displayName: Frose Kid, email: frosekid@gmail.com, id: 100147284752486204497, photoUrl: https://lh5.googleusercontent.com/-YeOs3WgWIeI/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucmULKisnvcbEj9JhktK_X3IK6Kggw/s96-c/photo.jpg};

      // // get token if success
      await userController.loginGoogle(
          googleUser.email, googleUser.displayName!);
      // get UserInfo
      // await _getAccountInfo();

      // _dismissLoading();
      Get.offAll(() => LoadingScreen());
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        loading = false;
      });
    }
  }

  Widget _buildButtonLogin() {
    return SubmitButtonWidget(
      width: Get.width * 0.85,
      color: Colors.blueAccent[100],
      function: () {
        _testLogin();
      },
      text: "Masuk Dengan Email",
      textColor: Colors.white,
    );
  }

  Widget _buildButtonGoogle() {
    return SubmitButtonWidget(
      width: Get.width * 0.85,
      color: Colors.red,
      function: () {
        signInWithGoogle();
      },
      text: "Masuk Dengan Google",
      textColor: Colors.white,
    );
  }

  void _testLogin() async {
    if (userTC.text.isEmpty || passTC.text.isEmpty) {
      Get.snackbar("Gagal", "Isi Semua Field");
    } else {
      try {
        setState(() {
          loading = true;
        });
        await userController.login(userTC.text, passTC.text).then((value) => {
              setState(() {
                message = value;
              })
            });
        print("_testLogin: $message");
        if (message == "Login Berhasil !!") {
          Get.offAll(() => LoadingScreen());
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
}
