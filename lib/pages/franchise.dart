import 'package:flutter/material.dart';
import 'package:galon/controller/user_controller.dart';
import 'package:galon/widget/input_widget.dart';
import 'package:galon/widget/submit_button_widget.dart';
import 'package:get/get.dart';

class FranchisePage extends StatefulWidget {
  _FranchisePageState createState() => _FranchisePageState();
}

class _FranchisePageState extends State<FranchisePage> {
  UserController userController = UserController();

  String message = "";
  bool loading = false;

  TextEditingController _namaTxt = TextEditingController();
  TextEditingController _noHP = TextEditingController();
  TextEditingController _sbujek = TextEditingController();
  TextEditingController _pesan = TextEditingController();
  final formkey = new GlobalKey<FormState>();

  //INI KOMENTAR UNTUK PUSH
  //SEBAGAI PEMBEDAs

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Center(
            child: Text(
              "Mari Bertanya Franchise Depo Air Minum Biru",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black),
            ),
          ),
        ),
        body: loading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: Get.width,
                        height: 590,
                        color: Colors.grey[200],
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Tertarik Usaha\nFranchise Depo Air Minum Biru?\nInvestasi Start-Up Usaha Rp.479.260.000,-\n(belum termasuk lokasi dan renovasi)\nJangka Waralaba 10 tahun.\nSilahkan mengisi kolom dibawah ini",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black87),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, right: 40),
                              child: Column(
                                children: [
                                  InputWidget(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          // hintText: "Nama",
                                          labelText: "Nama",
                                          border: InputBorder.none),
                                      controller: _namaTxt,
                                      onSaved: (value) {
                                        _namaTxt.text = value!;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  InputWidget(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          // hintText: "No Handphone / WA",
                                          labelText: "No Handphone / WA",
                                          border: InputBorder.none),
                                      keyboardType: TextInputType.number,
                                      controller: _noHP,
                                      onSaved: (value) {
                                        _noHP.text = value!;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  InputWidget(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          // hintText: "Subjek",
                                          labelText: "Subjek",
                                          border: InputBorder.none),
                                      controller: _sbujek,
                                      onSaved: (value) {
                                        _sbujek.text = value!;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  InputWidget(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          // contentPadding:
                                          //     EdgeInsets.symmetric(vertical: 50),
                                          // prefixText: "Pesan", ini
                                          labelText: "Pesan",
                                          border: InputBorder.none),
                                      controller: _pesan,
                                      maxLines: 3,
                                      onSaved: (value) {
                                        _pesan.text = value!;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  SubmitButtonWidget(
                                    function: () {
                                      _buttonKirim();
                                    },
                                    text: "KIRIM",
                                  ),
                                  // SizedBox(
                                  //   width: 300,
                                  //   height: 50,
                                  //   child: Container(
                                  //     decoration: BoxDecoration(
                                  //       color: Colors.blue,
                                  //       borderRadius: BorderRadius.all(
                                  //         Radius.circular(30),
                                  //       ),
                                  //     ),
                                  //     child: Center(
                                  //       child: TextButton(
                                  //         onPressed: () {
                                  //           print(_namaTxt.text);
                                  //           print(_noHP.text);
                                  //           print(_sbujek.text);
                                  //           print(_pesan.text);
                                  //           _buttonKirim();
                                  //         },
                                  //         child: Text(
                                  //           "KIRIM",
                                  //           style: TextStyle(
                                  //               color: Colors.black,
                                  //               fontWeight: FontWeight.bold,
                                  //               fontSize: 20),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }

  void _buttonKirim() async {
    if (_namaTxt.text.isEmpty ||
        _noHP.text.isEmpty ||
        _sbujek.text.isEmpty ||
        _pesan.text.isEmpty) {
      Get.snackbar("Gagal", "Isi Semua Field");
    } else {
      try {
        setState(() {
          loading = true;
        });
        await userController
            .franchiese(_namaTxt.text, _noHP.text, _sbujek.text, _pesan.text)
            .then((value) => {
                  setState(() {
                    message = value;
                  })
                });
        print("ini franchiese: $message");
        if (message == "Data Berhasil Ditambahkan !!") {
          // _showAlertDialoSuccess(context);
          Get.dialog(AlertDialog(
            title: Text("Success"),
            content: Text(
              "Pertanyaan Bisnis anda sudah kami terima!\nKami akan segera menghubungi anda melalui kontak yang sudah anda kirim.\nTerima Kasih",
              textAlign: TextAlign.justify,
            ),
            actions: [
              TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    // Navigator.pop(context);
                    Get.back();
                  }),
            ],
          ));
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
        print(e);
        Get.snackbar("Gagal", "Terjadi Kesalahan");
      }
    }
  }
}
