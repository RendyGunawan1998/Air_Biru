import 'package:flutter/material.dart';
import 'package:galon/model/banners.dart';
import 'package:galon/widget/submit_button_widget.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Lihat extends StatelessWidget {
  final Banners posts;
  const Lihat({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            isi(),
            Container(
              margin: EdgeInsets.only(left: 8.0, top: 8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget isi() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.network(posts.image),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 8, 25, 15),
            child: Column(
              children: [
                Text(
                  posts.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  posts.description,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                _buildButtonIsi(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtonIsi() {
    return SubmitButtonWidget(
      width: Get.width * 0.75,
      color: Colors.blueAccent[100],
      function: () {
        print("ini button isi");
        _launchURL();
      },
      text: posts.actionUrlLabel,
      textColor: Colors.white,
    );
  }

  void _launchURL() async => await canLaunch(posts.actionUrl)
      ? await launch(posts.actionUrl)
      : throw 'Could not launch ${posts.actionUrl}';
}
