import 'dart:convert';

import 'package:http/http.dart' as http;

String baseUrl="http://localhost:7999";
class HttpKit{
  static void post(String api,Map<String,dynamic> params,Function successCallback,Function errorCollback) async{
    http.Response res=await http.post(baseUrl+api,body: params);

    if(successCallback!=null){
      switch(res.statusCode){
        case 200:
          Utf8Decoder utf8= Utf8Decoder();
          successCallback(json.encode(utf8.convert(res.bodyBytes)));
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