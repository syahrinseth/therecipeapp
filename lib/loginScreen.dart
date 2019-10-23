import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/homeScreen.dart'; 
import 'package:flutter_app/signUpScreen.dart'; 
import 'package:flutter_app/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;

  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ScaffoldState scaffoldState;
  _showMsg(msg){
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {

        },
      )
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0,0.4,0.9],
                  colors: [
                    Color(0xFFFF835F),
                    Color(0xFFFC663C), 
                    Color(0xFFFF3F1A),
                  ]
                )
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      elevation: 4.0,
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextField(
                              style: TextStyle(color: Color(0xFF000000)),
                              controller: mailController,
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  color: Colors.grey,
                                ),
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  color: Color(0xFF9b9b9b), 
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal
                                )
                              ),
                            ),
                            // Password
                            TextField(
                              style: TextStyle(color: Color(0xFF000000)), 
                              cursorColor: Color(0xFF9b9b9b), 
                              controller: passwordController, 
                              keyboardType: TextInputType.text, 
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.vpn_key,
                                  color: Colors.grey,
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  color: Color(0xFF9b9b9b), 
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal
                                )
                              ),
                            ),
                            // Login Button
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FlatButton(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 8, bottom: 8, left: 10, right: 10
                                  ), 
                                  child: Text(
                                    _isLoading? 'Loging...' : 'Login', textDirection: TextDirection.ltr, 
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      decoration: TextDecoration.none, 
                                      fontWeight: FontWeight.normal,
                                    ), 
                                  ),
                                ),  
                                color: Color(0xFFFF835F),
                                disabledColor: Colors.grey,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0)
                                ),
                                onPressed: _isLoading ? null : _login,
                              ),
                            ),
                        ],
                      ),
                    )
                  ),
                  // New account
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context, 
                          new MaterialPageRoute(
                            builder: (context) => SignUp()
                          )  
                        );
                      },
                      child: Text(
                        'Create new Account',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal
                        )
                      ),
                    ),
                  )
                ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  void _login() async {
    setState((){
      _isLoading = true;
    });

    var data = {
      'email': mailController.text,
      'password': passwordController.text
    };

    var res = await CallApi().postData(data, 'login');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => Home()
        )  
      );
    }else{
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = false;
    });
  }
}