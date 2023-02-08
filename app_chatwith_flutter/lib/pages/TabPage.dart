import 'package:appchatwithflutter/pages/tabs/HomeTab.dart';
import 'package:flutter/material.dart';
import '../kits/Iconkit.dart';
import 'tabs/ShareTab.dart';
import 'tabs/PersonTab.dart';

class Tabpage extends StatefulWidget {
  @override
  _TabpageState createState() => _TabpageState();
}

class _TabpageState extends State<Tabpage> {
  List _Pagelist = [
    ShareTab(),
    HomeTab(),
    PersonTab(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: this._Pagelist[this._currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          print(index);
          setState(() {
            this._currentIndex = index;
          });
        },
        items: [
          //朋友圈分享
          BottomNavigationBarItem(icon: Icon(Iconkit.share), label: '友圈'),
          //群聊
          BottomNavigationBarItem(icon: Icon(Iconkit.home), label: '聊天'),
          //个人中心
          BottomNavigationBarItem(icon: Icon(Iconkit.Person), label: '我的'),
        ],
      ),
    );
  }
}
