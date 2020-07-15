import 'package:appchatwithflutter/routes/Routes.dart';
import 'package:appchatwithflutter/states/ThemeSatte.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'kits/Colorkit.dart' as colorKit;
import 'package:appchatwithflutter/kits/SharedPreferences.dart' as sp;

String spTheme="";
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  spTheme =await sp.getString("theme");
  print("theme");
  print(spTheme);
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ThemeSate())
      ],
      child: Consumer<ThemeSate>(

        builder: (context,ThemeSate theme,_){
          if (spTheme=="MyTheme.dark"){
            theme.initTheme(MyTheme.dark);
            spTheme='MyTheme.light';
          }else{
            theme.initTheme(MyTheme.light);
            spTheme='MyTheme.dark';
          }
          return MaterialApp(
            title: '测试程序',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: onGenerateRoute,
            initialRoute: '/',
            theme: theme.currentThemeData,
          );
        },
      ),
    );
  }
}


