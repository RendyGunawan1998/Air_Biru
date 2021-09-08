import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FranchisePage extends StatefulWidget {
  _FranchisePageState createState() => _FranchisePageState();
}

class _FranchisePageState extends State<FranchisePage> {
  TextEditingController _namaTxt = TextEditingController();
  TextEditingController _noHP = TextEditingController();
  TextEditingController _sbujek = TextEditingController();
  TextEditingController _pesan = TextEditingController();
  final formkey = new GlobalKey<FormState>();

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
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: Get.width,
                  height: 590,
                  color: Colors.blue[50],
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Tertarik Usaha\nFranchise Depo Air Minum Biru?\nInvestasi Start-Up Usaha Rp.479.260.000,-\n(belum termasuk lokasi dan renovasi)\nJangka Waralaba 10 tahun.\nSilahkan mengisi kolom dibawah ini",
                        style: TextStyle(fontSize: 15, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: Form(
                          key: formkey,
                          autovalidate: true,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                    hintText: "Nama",
                                    labelText: "Nama",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                controller: _namaTxt,
                                onChanged: (value) {
                                  _namaTxt.text = value;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    hintText: "No Handphone / WA",
                                    labelText: "No Handphone / WA",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                keyboardType: TextInputType.number,
                                controller: _noHP,
                                onChanged: (value) {
                                  _noHP.text = value;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    hintText: "Subjek",
                                    labelText: "Subjek",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                controller: _sbujek,
                                onChanged: (value) {
                                  _sbujek.text = value;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 50),
                                    prefixText: "Pesan",
                                    labelText: "Pesan",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                controller: _pesan,
                                onChanged: (value) {
                                  _pesan.text = value;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: 300,
                                height: 50,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "KIRIM",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                              )
                              // MaterialButton(
                              //   color: Colors.blue,
                              //   onPressed: () {},
                              //   child: Text("KIRIM"),
                              // ),
                            ],
                          ),
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
}
