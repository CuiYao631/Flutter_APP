import 'package:appchatwithflutter/kits/HttpKit.dart';
import 'package:appchatwithflutter/kits/Iconkit.dart';
import 'package:appchatwithflutter/states/ThemeSatte.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:appchatwithflutter/kits/Colorkit.dart' as colorKit;
import 'package:provider/provider.dart';
import 'package:appchatwithflutter/kits/SharedPreferences.dart' as sp;

class PersonTab extends StatefulWidget {
  @override
  _PersonTabState createState() => _PersonTabState();
}

class _PersonTabState extends State<PersonTab> {
  bool _darkmode = false;
  bool _iflogin = false;

  void init() async {
    String spTheme = await sp.getString("theme");
    if (spTheme == "MyTheme.dark") {
      setState(() {
        this._darkmode = spTheme == "MyTheme.dark" ? true : false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void _changeDarkmode(bool flag) {
    Provider.of<ThemeSate>(context, listen: false).switchTheme();
    String afterTheme =
        Provider.of<ThemeSate>(context, listen: false).currentTheme.toString();
    sp.setString("theme", afterTheme);
    setState(() {
      this._darkmode = flag;
    });
  }

//  void _login() {
//    setState(() {
//      _iflogin = true;
//    });
//  }

  void _loginout() {
    setState(() {
      this._iflogin = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 0, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TopMenus(),
          this._iflogin ? logined() : login(),
          MenuList(this._darkmode, this._changeDarkmode, this._loginout),
          //Divider(),
        ],
      ),
    );
  }
}

//顶部控件
class TopMenus extends StatefulWidget {
  @override
  _TopMenusState createState() => _TopMenusState();
}

class _TopMenusState extends State<TopMenus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 53, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            child: Icon(
              Iconkit.Message,
              size: 20,
            ),
            margin: EdgeInsets.only(right: 30),
          ),
          Container(
            child: Icon(Iconkit.Setting, size: 20),
          ),
        ],
      ),
    );
  }
}

//登陆控件
class login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 50, 0, 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            child: Text('注册/登陆', style: Theme.of(context).textTheme.headline1),
            onTap: () {
              Navigator.pushNamed(context, "/login",arguments: "hello");
            },
          ),
          Container(
            child: Image.asset(
              'assets/images/login.png',
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

//为登陆控件
class logined extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 50, 0, 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  "小崔",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              GestureDetector(
                child: Container(
                  child: Text('查看并编辑个人资料',
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(color: Theme.of(context).accentColor)),
                ),
                onTap: () {
                  print("查看个人资料");
                },
              )
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ClipOval(
                child: Container(
                  color: Theme.of(context).primaryColor,
                  width: 80,
                  height: 80,
                ),
              ),
              Text(
                "小",
                style: Theme.of(context).textTheme.headline1.copyWith(
                      color: colorKit.hexToColor("#FFFFFF"),
                      fontWeight: FontWeight.bold,
                    ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

//菜单控件
class MenuList extends StatelessWidget {
  final bool _darkmode;
  final Function _changeDarkmode;
  final Function _loginout;

  MenuList(this._darkmode, this._changeDarkmode, this._loginout);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Divider(),
        Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("深色模式", style: Theme.of(context).textTheme.headline2),
                Switch(
                  value: this._darkmode,
                  onChanged: _changeDarkmode,
                  activeColor: Theme.of(context).accentColor,
                  inactiveTrackColor: Theme.of(context).dividerColor,
                )
              ],
            )),
        Divider(),
        Container(
            child: GestureDetector(
              child:new InkWell(
                onTap: (){
                  HttpKit.post("", {"name":"","password":""}, (data) {
                    final snackbar = SnackBar(
                      content: Text("版本信息：" + data,style: Theme.of(context).textTheme.headline3),
                      backgroundColor: Theme.of(context).backgroundColor,
                      behavior: SnackBarBehavior.floating,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    //Scaffold.of(context).showSnackBar(snackbar);
                  }, (err) {
                   print("请求失败");

                  });
                },
                child: new Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  //设置child 居中
                  alignment:FractionalOffset(0,0),
                  child: Text("版本信息", style: Theme.of(context).textTheme.headline2),
                ),
              )
            )),
        Divider(),
        Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: GestureDetector(
              child: Text("退出登陆", style: Theme.of(context).textTheme.headline2),
              onTap: () => this._loginout(),
            )),
      ],
    );
  }
}

//分割线控件
class Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 2,
          color: Theme.of(context).dividerColor,
        )
      ],
    );
  }
}

