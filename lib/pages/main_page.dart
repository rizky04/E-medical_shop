import 'package:flutter/material.dart';
import 'package:medical/pages/history_page.dart';
import 'package:medical/pages/home_page.dart';
import 'package:medical/pages/profile_page.dart';
import 'package:medical/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectIndex = 0;
  final _pageList = [const HomePage(), const HistoryPage(), const ProfilePage()];
  onTapBawah(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: whtiteColor,
          selectedItemColor: greenColor,
          unselectedItemColor: greyLightColor,
          currentIndex: _selectIndex,
          onTap: onTapBawah,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.assignment), label: "History"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box_rounded), label: "Profile")
          ]),
    );
  }
}
