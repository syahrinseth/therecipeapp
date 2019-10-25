import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:recipe_app/homeScreen.dart'; 
import 'package:recipe_app/signUpScreen.dart'; 
import 'package:recipe_app/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeScreen extends StatefulWidget {
  String _title = "";
  RecipeScreen({String title}) {
    _title = title;
  }
  
  @override
  _RecipeScreen createState() => _RecipeScreen(title: _title);
}

class _RecipeScreen extends State<RecipeScreen> {
  String _title = "";

  _RecipeScreen({String title}) {
    _title = title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Container(
        child: Column(
          children: <Widget>[
            BackButton(),
            Text("$_title")
          ],
        ),
      )
    );
  }

  
}