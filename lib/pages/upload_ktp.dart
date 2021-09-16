import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:galon/helper/token.dart';
import 'package:galon/pages/profile.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UploadKTPPage extends StatefulWidget {
  @override
  _UploadKTPPageState createState() => _UploadKTPPageState();
}

class _UploadKTPPageState extends State<UploadKTPPage> {
  // ============================= Variabel ====================
  File? _selectedImage;
  final selectedIndexes = [];
  final picker = ImagePicker();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  reset() {
    setState(() {
      _selectedImage = null;
    });
  }
  // ============================= Init ====================

  // ============================= Function ====================

  Widget getImageWidget() {
    if (_selectedImage != null) {
      return Image.file(
        _selectedImage!,
        width: 300,
        height: 300,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        "assets/images/no_data.png",
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      );
    }
  }

  getImage(ImageSource source) async {
    final image = await picker.getImage(
      source: ImageSource.gallery,
      maxHeight: 1920,
      maxWidth: 1080,
      imageQuality: 96,
    );
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    } else {
      print("foto kosong");
    }
  }

  // =============================Fungsi upload ============================
  Future<String> addTreatment(String photo) async {
    print("ini data di fungsi addTreadment");

    print(photo);

    Map<String, String> headers = {
      // "Accept": "application/json",
      // "Content-Type": "application/json",
      "Authorization": "Bearer " + await Token().getAccessToken(),
    };

    print("ini data headers : $headers");
    var token = Token().getAccessToken();
    print("ini token di fungsi addTreadment: $token");

    var uri = Uri.parse('https://gebyarairminumbiru.com/api/user/upload/ktp');
    var request = new http.MultipartRequest("POST", uri);

    request.headers.addAll(headers);

    request.fields['extension'] = photo;

    if (photo != '') {
      var photoFile = await http.MultipartFile.fromPath("image", photo);
      request.files.add(photoFile);
    }

    http.Response response =
        await http.Response.fromStream(await request.send());
    print("ini response : $response");
    print("ini response body : ${response.body}");
    if (response.statusCode == 200) {
      print(response.body);
      _showAlertDialoSuccess(context, response.statusCode);
      return "Berhasil";
    } else {
      print(response.body);
      _showAlertFieldKosong(context);
      // _showAlertDialog(context, response.body);
      throw (json.decode(response.body));
    }
  }
  // ============================= Function ====================

  // ============================= Body ====================
  @override
  Widget build(BuildContext context) {
    print(_selectedImage?.lengthSync());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[200],
          elevation: 0,
          title: Row(
            children: <Widget>[
              Text("Upload Foto KTP"),
            ],
          ),
        ),
        bottomNavigationBar: _selectedImage != null
            ? MaterialButton(
                color: Colors.blue[200],
                onPressed: () {
                  print(_selectedImage!.path);
                  addTreatment(_selectedImage!.path);
                  _selectedImage = null;
                },
                child: Text("Upload"),
              )
            : _buildBody(context),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getImageWidget(),
                MaterialButton(
                  minWidth: 120,
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  color: Colors.green,
                  child: Text("Ambil Foto"),
                ),
                MaterialButton(
                  minWidth: 120,
                  color: Colors.green,
                  child: Text("Hapus Foto"),
                  onPressed: () {
                    reset();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // ============================= Body ====================

  _showAlertDialoSuccess(BuildContext context, int err) {
    Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          // Navigator.pop(context);
          Get.offAll(() => ProfilePage());
        });
    AlertDialog alert = AlertDialog(
      title: Text("Success"),
      content: Text("KTP berhasil di upload"),
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

  _showAlertFieldKosong(BuildContext context) {
    Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context);
        });
    AlertDialog alert = AlertDialog(
      title: Text("Masalah"),
      content: Text("Foto gagal di upload"),
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
