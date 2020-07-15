
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appchatwithflutter/kits/Colorkit.dart' as colorKit;

enum MyTheme{
  light,
  dark,
}
class ThemeSate with ChangeNotifier{
  static List<ThemeData> themes=[
      //浅色
      ThemeData(
          //深色还是浅色
          brightness: Brightness.light,
          //主题颜色
          primarySwatch: Colors.red,
          //主色，决定导航蓝颜色
          primaryColor: colorKit.hexToColor("#1a8287"),
          //次级颜色 决定大多数Widget的颜色
          accentColor: colorKit.hexToColor("#1a8287"),
          //卡片颜色
          //cardColor: Colors.yellow,
          //背景颜色
          backgroundColor: Colors.white,
          //分割线颜色
          dividerColor: colorKit.hexToColor("#f2f2f2"),
          //按钮主题
          //输入框光标颜色
          //对话框背景颜色
          //文本字体
          //字体主题，包括标题，body等文字样式
          textTheme: TextTheme(
          headline1:TextStyle(
          fontSize: 32.0,
          color: colorKit.hexToColor("#3e3e3e"),
          fontWeight: FontWeight.bold,
          ),
          headline2:TextStyle(
          fontSize: 20.0,
          color: colorKit.hexToColor("#3e3e3e"),
          fontWeight: FontWeight.bold,
          ),
          ),
          //Icon的默认样式
          //指定平台，应用特定平台空间风格

      ),
      //深色
      ThemeData(
      //深色还是浅色
      brightness: Brightness.dark,
      //主题颜色
      primarySwatch: Colors.red,
      //主色，决定导航蓝颜色
      primaryColor: colorKit.hexToColor("#1a8287"),
      //次级颜色 决定大多数Widget的颜色
      accentColor: colorKit.hexToColor("#1a8287"),
      //卡片颜色
      //cardColor: Colors.yellow,
      //背景颜色
      backgroundColor: Colors.white,
      //分割线颜色
      dividerColor: colorKit.hexToColor("#363636"),
      //按钮主题
      //输入框光标颜色
      //对话框背景颜色
      //文本字体
      //字体主题，包括标题，body等文字样式
      textTheme: TextTheme(
        headline1:TextStyle(
          fontSize: 32.0,
          color: colorKit.hexToColor("#F1F1F1"),
          fontWeight: FontWeight.bold,
        ),
        headline2:TextStyle(
          fontSize: 20.0,
          color: colorKit.hexToColor("#F1F1F1"),
          fontWeight: FontWeight.bold,
        ),
      ),
      //Icon的默认样式
      //指定平台，应用特定平台空间风格

    ),
  ];
    MyTheme _currrentTheme=MyTheme.light;

    ThemeData _currentThemeData=themes[0];

    void initTheme(MyTheme t){
      if(t==MyTheme.dark){
        this._currrentTheme=MyTheme.dark;
        this._currentThemeData=themes[1];
      }else{
        this._currrentTheme=MyTheme.light;
        this._currentThemeData=themes[0];
      }
    }
    get currentTheme=>_currrentTheme;

    get currentThemeData=> _currentThemeData;

    set currentTheme(MyTheme theme){
      if(theme!=null){
        _currrentTheme=theme;
        _currentThemeData=_currrentTheme==MyTheme.light?themes[0]:themes[1];
        notifyListeners();
      }
    }

    void switchTheme()=>currentTheme==MyTheme.light?currentTheme=MyTheme.dark:currentTheme=MyTheme.light;
}