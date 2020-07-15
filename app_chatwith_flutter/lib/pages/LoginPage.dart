import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
  final arguments;
  LoginPage({this.arguments});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login'),),
      body: Center(
        child: Text('login args:${this.arguments}'),
      ),
    );
  }
}