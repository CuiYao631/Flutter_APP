import 'dart:convert';

import 'package:http/http.dart' as http;

String baseUrl="http://192.168.1.103:8090";
class HttpKit{
  static void post(String api,Map<String,dynamic> params,Function successCallback,Function errorCollback) async{
    http.Response res=await http.post(baseUrl+api,body: params);

    if(successCallback!=null){
      print('返回数据 ');
      switch(res.statusCode){
        case 200:
          final result=json.decode(res.body);
          String data=result["data"];
          print(result["message"]);
          successCallback(data);//回调函数，返回数据
          break;
        case 404:
          print('404');
          break;
        case 500:
          print('500');
          break;
      }
    }
  }
}