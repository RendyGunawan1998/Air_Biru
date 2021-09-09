import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:galon/extra_screen/tab.dart';
import 'package:galon/token/get_data.dart';
import 'package:galon/token/token.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import '../../extra_screen/loading.dart';

class LoginAnimation extends StatefulWidget {
  _LoginAnimationState createState() => _LoginAnimationState();
}

class _LoginAnimationState extends State<LoginAnimation>
    with SingleTickerProviderStateMixin {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _obsecureText = true;

  TextEditingController userTC = new TextEditingController();
  TextEditingController passTC = new TextEditingController();

  // LoginRequestModel requestModel;
  bool visible = false;

  String message = '';

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

  void cekLogin() async {
    try {
      // get token from local storage
      var token = await Token().getAccessToken();
      if (token != null) {
        Get.offAll(() => TabBarPage());
      }
    } catch (e) {
      print(e);
    }
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
      backgroundColor: Colors.blue[100],
      // Color(0xff21254A),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                // padding: const EdgeInsets.only(left: 7),
                child: Image.asset(
                  "assets/images/puskeu.png",
                  width: 100,
                  height: 100,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                autovalidate: true,
                key: formKey,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                          decoration: InputDecoration(
                              hintText: "Masukkan Email",
                              labelText: "Email",
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          keyboardType: TextInputType.emailAddress,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Email tidak boleh kosong'),
                            EmailValidator(errorText: "Perlu @ untuk email"),
                          ]),
                          controller: userTC,
                          onSaved: (value) {
                            userTC.text = value;
                          }),
                      SizedBox(height: 15),
                      TextFormField(
                          decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "Masukkan Kata Sandi",
                            prefixIcon: Icon(Icons.lock, color: Colors.grey),
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
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          obscureText: _obsecureText,
                          validator: validatePassword,
                          controller: passTC,
                          onSaved: (value) {
                            passTC.text = value;
                          }),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        _buildButtonLogin(),
      ],
    );
  }

  Widget _buildButtonLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 200,
          child: MaterialButton(
            onPressed: () {
              _testLogin();
            },
            color: Colors.blueAccent,
            child: Text(
              "LOGIN",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }

  void _testLogin() async {
    if (formKey.currentState.validate()) {
      setState(() {
        visible = true;
      });

      var _body = {'email': userTC.text, 'password': passTC.text};
      print("email " + json.encode(_body));
      try {
        var response = await http.post(
          Uri.parse("https://gebyarairminumbiru.com/api/user/login"),
          body: json.encode(_body),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        );
        if (response.statusCode == 200) {
          Token().saveToken(response.body);
          print('ini token login : ' + response.body);
          setState(() {
            visible = false;
          });

          await getInfo();
          Get.offAll(() => LoadingScreen());
        } else {
          setState(() {
            visible = false;
          });
          _showAlertDialog(context);
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("validate unsuccess");
    }
  }
}

_showAlertDialog(BuildContext context) {
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () => Navigator.pop(context),
  );
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text("Email atau password yang dimasukkan salah"),
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
