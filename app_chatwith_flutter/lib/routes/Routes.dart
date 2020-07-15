import 'package:appchatwithflutter/pages/LoginPage.dart';
import 'package:appchatwithflutter/pages/TabPage.dart';
import 'package:flutter/material.dart';
final routes={
  "/":(context)=>Tabpage(),
  "/login":(context,{arguments})=>LoginPage(arguments:arguments)
};
var onGenerateRoute=(RouteSettings settings){
  final String name=settings.name;
  final Function builderContext=routes[name];
  Route route;
  print(settings);
  print(builderContext);
  if(builderContext!=null) {
    if (settings.arguments != null) {
      route = MaterialPageRoute(builder: (context) =>
          builderContext(context, arguments: settings.arguments));
    } else {
      route = MaterialPageRoute(builder: (context) => builderContext(context));
    }
  }else{

  }
  return route;
};