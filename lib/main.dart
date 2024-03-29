import 'package:flutter/material.dart';
import 'package:recipe_app/homeScreen.dart'; 
import 'package:recipe_app/loginScreen.dart'; 
import 'package:shared_preferences/shared_preferences.dart'; 
import 'package:recipe_app/util/const.dart';
import 'package:flutter/services.dart';


void main() => runApp(MyApp());
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState(); 
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  bool isDark = true;

  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isDark ? Constants.darkPrimary : Constants.lightPrimary,
      statusBarIconBrightness: isDark?Brightness.light:Brightness.dark,
    ));
  }

  void _checkIfLoggedIn() async {
    // check if token is there
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token'); 
    if(token!= null){
      setState(() {
          _isLoggedIn = true;
      }); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _isLoggedIn ? Home() :  Login(),
      ),
      theme: isDark ? Constants.darkTheme : Constants.lightTheme,
    ); 
  }
}