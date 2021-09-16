import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:galon/helper/token.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class UploadKTPPage extends StatefulWidget {
  @override
  _UploadKTPPageState createState() => _UploadKTPPageState();
}

class _UploadKTPPageState extends State<UploadKTPPage> {
  // ============================= Variabel ====================
  File? _selectedImage;
  bool _inProgress = false;
  final selectedIndexes = [];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

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
    setState(() {
      _inProgress = true;
    });
    File? image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      File? cropped = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxHeight: 1920,
        maxWidth: 1080,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.deepOrange.shade900,
            statusBarColor: Colors.deepOrange.shade900,
            backgroundColor: Colors.white,
            // hideBottomControls: true,
            toolbarTitle: "Cropper"),
      );
      this.setState(() {
        _selectedImage = cropped;
        _inProgress = false;
      });
      _selectedImage!.path;
    } else {
      setState(() {
        _inProgress = false;
      });
    }
  }

  // =============================Fungsi upload ============================
  Future<String> addTreatment(String photo) async {
    print("ini data di fungsi addTreadment");

    print(photo);

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer " + await Token().getAccessToken(),
    };

    print("ini data headers : $headers");
    var token = Token().getAccessToken();
    print("ini token di fungsi addTreadment: $token");

    var uri = Uri.parse(
        'https://app.puskeu.polri.go.id:2216/umkm/mobile/penerima-foto/');
    var request = new http.MultipartRequest("POST", uri);

    print("ini uri di fungsi addTreadment: $uri");
    print("ini req di fungsi addTreadment: $request");

    request.headers.addAll(headers);

    if (photo != '') {
      var photoFile = await http.MultipartFile.fromPath("FOTO", photo);
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
                    // getImage(ImageSource.camera);

                    print(_selectedImage!.path);
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
          (_inProgress)
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.95,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Center(),
        ],
      ),
    );
  }
  // ============================= Body ====================

  _showAlertDialoSuccess(BuildContext context, int err) {
    Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context);
        });
    AlertDialog alert = AlertDialog(
      title: Text("Success"),
      content: Text("Data berhasil diinput"),
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
      content: Text("Data gagal di upload"),
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
// ============================= Function Alert ====================

}

// ============================= Function Alert ====================

