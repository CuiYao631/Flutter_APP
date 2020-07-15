import 'package:flutter/material.dart';
class HomeTab extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('聊天')),
      body: Center(
        child: Text('聊天页'),
      ),
    );
  }
}