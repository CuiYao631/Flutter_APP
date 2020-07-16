
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  final arguments;
  LoginPage({this.arguments});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //焦点
  FocusNode _focusNodeUserName=new FocusNode();
  FocusNode _focusNodePassWord=new FocusNode();
  //用户名输入框控制器，此控制器可以监听用户输入框操作
  TextEditingController _userNameContller=new TextEditingController();
  //表单状态
  GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  var _username="";//用户名
  var _password="";//密码
  var _isShowPwd=false;//是否显示密码
  var _isShowClear=false;//是否显示输入框尾部的清除按钮

  @override
  void initState() {
    // TODO: implement initState
    //设置焦点监听
    _focusNodeUserName.addListener(_focusNodeListener);
    _focusNodePassWord.addListener(_focusNodeListener);
    //监听用户名框的输入改变
    _userNameContller.addListener(() { 
      print(_userNameContller.text);
      //监听文本框输入变化，当有内容的时候，显示尾部清除按钮，否则不显示
      if(_userNameContller.text.length>0){
        _isShowClear=true;
      }else{
        _isShowClear=false;
      }
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //移除焦点监听
    _focusNodeUserName.removeListener(_focusNodeListener);
    _focusNodePassWord.removeListener(_focusNodeListener);
    _userNameContller.dispose();
    super.dispose();
  }

  // 监听焦点
  Future<Null> _focusNodeListener() async{
    if(_focusNodeUserName.hasFocus){
      print("用户名框获取焦点");
      // 取消密码框的焦点状态
      _focusNodePassWord.unfocus();
    }
    if (_focusNodePassWord.hasFocus) {
      print("密码框获取焦点");
      // 取消用户名框焦点状态
      _focusNodeUserName.unfocus();
    }
  }

  /**
   * 验证用户名
   */
  String validateUsername(value){
    //正则匹配手机号
    RegExp exp=RegExp(r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    if(value.isEmpty){
      return "用户名不能为空";
    }else if(!exp.hasMatch(value)){
      return "请输入正确的手机号";
    }
    return null;
  }

  /**
   * 验证密码
   */
  String validatePassword(value){
    if(value.isEmpty){
      return "密码不能为空";
    }else if(value.trim().length<6||value.trim().length>18){
      return "密码长度不正确";
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance=ScreenUtil(width: 705,height: 1334 )..init(context);
    print(ScreenUtil().scaleHeight);
    //logo图片区域
    Widget logoImageArea=new Container(
      alignment: Alignment.topCenter,
      //设置图片为圆形
      child: ClipOval(
        child: Image.asset(
          "assets/images/login.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
    //输入文本框区域
    Widget inputTextArea=new Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Theme.of(context).backgroundColor
      ),
      child: new Form(
        key: _formKey,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new TextFormField(
              controller: _userNameContller,
              focusNode: _focusNodeUserName,
              //设置键盘类型
              keyboardType:TextInputType.number,
              decoration: InputDecoration(
                labelText: "用户名",
                hintText: "请输入手机号",
                prefixIcon: Icon(Icons.person),
                //尾部添加清除按钮
                suffixIcon: (_isShowClear)?IconButton(
                  icon: Icon(Icons.clear),
                    onPressed: (){
                    _userNameContller.clear();//清除输入内容框
                    },
                )
                    :null
              ),
              //验证用户名
              validator: validateUsername,
              //保存数据
              onSaved: (String value){
                _username=value;
              },
            ),
            new TextFormField(
              focusNode: _focusNodePassWord,
              decoration: InputDecoration(
                labelText: "密码",
                hintText: "请输入密码",
                prefixIcon: Icon(Icons.lock),
                //是否显示密码
                suffixIcon: IconButton(
                  icon: Icon((_isShowPwd)?Icons.visibility:Icons.visibility_off),
                  //点击改变显示或隐藏密码
                  onPressed: (){
                    setState(() {
                      _isShowPwd=!_isShowPwd;
                    });
                  },
                )
              ),
              obscureText: !_isShowClear,
              //密码验证
              validator: validatePassword,
              //保存数据
              onSaved: (String value){
                _password=value;
              },
            ),
          ],
        ),
      ),
    );

    //登录按钮区域
    Widget loginButtonArea=new Container(
      margin: EdgeInsets.only(left: 50,right: 50),
      height: 45.0,
      child: new RaisedButton(
        color: Colors.blue[400],
        child: Text("登录",style: TextStyle(fontSize: 25.0),),
        //设置按钮圆角
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        onPressed: (){
          //点击登录按钮，解除焦点，回收键盘
          _focusNodePassWord.unfocus();
          _focusNodeUserName.unfocus();
          if(_formKey.currentState.validate()){
            //只有输入通过验证才会执行这里
            _formKey.currentState.save();
            //todo 登录操作
             print("$_username+$_password");
          }
        },
      ),
    );
    //第三方登录区域
      Widget thirdLoginArea =new Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        child: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:<Widget> [
                Container(
                  width: 80,
                  height: 1.0,
                  color: Colors.grey,
                ),
                Text("第三方登录"),
                Container(
                  width: 80,
                  height: 1.0,
                  color: Colors.grey,
                )
              ],
            ),
            new SizedBox(
              height: 18,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  color: Colors.green,
                  //第三方图标库
                  icon: Icon(FontAwesomeIcons.weixin),
                  iconSize: 40.0,
                  onPressed: (){

                  },
                ),
                IconButton(
                  color: Colors.brown,
                  //第三方图标库
                  icon: Icon(FontAwesomeIcons.github),
                  iconSize: 40.0,
                  onPressed: (){

                  },
                ),
                IconButton(
                  color: Colors.black,
                  //第三方图标库
                  icon: Icon(FontAwesomeIcons.apple),
                  iconSize: 40.0,
                  onPressed: (){

                  },
                ),
              ],
            ),
          ],
        ),
      );
      //忘记密码 立即注册
    Widget bottomArea=new Container(
      margin: EdgeInsets.only(left: 20,right: 30),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            child: Text("忘记密码？",style: TextStyle(color: Colors.blue[400],fontSize: 16.0),),
            //忘记密码按钮，点击执行事件
            onPressed: (){

            },
          ),
          FlatButton(
            child: Text("快速注册",style: TextStyle(color: Colors.blue[400],fontSize: 16.0),),
            //点击快速注册，执行事件
            onPressed: (){

            },
          ),
        ],
      ),
    );
    return Scaffold(
     backgroundColor: Theme.of(context).backgroundColor,
      body: new GestureDetector(
        onTap: (){
          //点击空白区域，回收键盘
          print("点击了空白区域");
          _focusNodeUserName.unfocus();
          _focusNodePassWord.unfocus();
        },
        child: new ListView(
          children: <Widget>[
            new SizedBox(height: ScreenUtil().setHeight(80),),
            logoImageArea,
            new SizedBox(height: ScreenUtil().setHeight(70),),
            inputTextArea,
            new SizedBox(height: ScreenUtil().setHeight(80),),
            loginButtonArea,
            new SizedBox(height: ScreenUtil().setHeight(60),),
            thirdLoginArea,
            new SizedBox(height: ScreenUtil().setHeight(60),),
            bottomArea,
          ],
        ),
      ),
    );
  }






}



