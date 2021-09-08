import 'package:flutter/material.dart';
import 'package:galon/pages/beranda.dart';
import 'package:galon/pages/franchise.dart';
import 'package:galon/pages/notifikasi.dart';
import 'package:galon/pages/profile.dart';
import 'package:galon/pages/scan.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class TabBarPage extends StatefulWidget {
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  int _currentIndex = 0;
  List<Widget> tabs = <Widget>[
    BerandaPage(),
    FranchisePage(),
    ScanPage(),
    NotifikasiPage(),
    ProfilePage(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs.elementAt(_currentIndex),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: GNav(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            activeColor: Colors.blue,
            rippleColor: Colors.blue,
            hoverColor: Colors.transparent,
            gap: 8,
            duration: Duration(milliseconds: 10),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            tabBackgroundColor: Colors.transparent,
            tabs: [
              GButton(
                icon: Icons.home,
                // text: "Beranda",
              ),
              GButton(
                icon: Icons.business_center_rounded,
                // text: "Franchise",
              ),
              GButton(
                icon: Icons.qr_code_scanner_rounded,
                // text: 'New',
              ),
              GButton(
                icon: Icons.notifications,
                // text: "Notifikasi",
              ),
              GButton(
                icon: Icons.person,
                // text: 'Akun Saya',
              ),
            ],
            onTabChange: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
