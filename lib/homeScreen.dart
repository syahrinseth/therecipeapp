import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipe_app/editProfileScreen.dart';
import 'package:recipe_app/loginScreen.dart'; 
import 'package:recipe_app/api.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var userData;

  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Search',
      style: optionStyle,
    ),
    Text(
      'Recipe Book',
      style: optionStyle,
    ),
    Text(
      'Notification',
      style: optionStyle
    ),
    Text(
      'Profile',
      style: optionStyle
    )
  ];

  

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }
  void _getUserInfo() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var userJson = localStorage.getString('user'); 
      var user = json.decode(userJson);
      setState(() {
        userData = user;
      });
  }
  @override
  Widget build(BuildContext context) {
    // widget list
    List<Widget> _widgetBodyOptions = <Widget>[
    Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: <Widget>[
            ////////////// 1st card///////////
            Card(
              elevation: 4.0,
              color: Colors.white,
              margin: EdgeInsets.only(left: 10, right: 10), 
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)), 
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 40),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: <Widget>[
                  ////////////  first name ////////////
                  Card(
                    elevation: 4.0,
                    color: Colors.white,
                    margin: EdgeInsets.only(
                      left: 10, 
                      right: 10, 
                      top: 10, 
                      bottom: 10
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.account_circle,
                                  color: Color(0xFFFF835F),
                                ), 
                              ),
                              Text(
                              'Firstname',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color(0xFF9b9b9b),
                                  fontSize: 17.0,
                                  decoration: TextDecoration.none,
                                  fontWeight:FontWeight.normal,
                                ), 
                              ),
                            ], 
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 35),
                            child: Text(
                              userData!= null ? '${userData['firstName']}' : '',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color(0xFF9b9b9b),
                                fontSize: 15.0,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ), 
                            ),
                          ), 
                        ],
                      ), 
                    ),
                  ),
                  ////////////// last name //////////////
                  Card(
                    elevation: 4.0,
                    color: Colors.white,
                    margin: EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.account_circle,
                                    color: Color(0xFFFF835F),
                                  ), 
                                ),
                                Text(
                                  'Last Name',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 17.0,
                                    decoration: TextDecoration.none,
                                    fontWeight:FontWeight.normal,
                                  ), 
                                ),
                              ], 
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 35),
                              child: Text(
                                userData!= null ? '${userData['lastName']}' : '',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color(0xFF9b9b9b),
                                  fontSize: 15.0,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ), 
                            ),
                          ], 
                        ),
                      ), 
                    ),
                    ////////////  Email/////////
                    Card(
                      elevation: 4.0,
                      color: Colors.white,
                      margin: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Container(
                        padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.mail,
                                  color: Color(0xFFFF835F),
                                ),
                              ),
                              Text(
                                'Email',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color(0xFF9b9b9b),
                                  fontSize: 17.0,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ), 
                              ),
                            ], 
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 35),
                            child: Text(
                            userData!= null ? '${userData['email']}' : '',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color(0xFF9b9b9b),
                                fontSize: 15.0,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ), 
                          ),
                        ], 
                      ),
                    ), 
                  ),
                  ////////////////////// phone /////////// 
                  Card(
                    elevation: 4.0,
                    color: Colors.white,
                    margin: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.phone,
                                  color: Color(0xFFFF835F),
                                ), 
                              ),
                              Text(
                                'Phone',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color(0xFF9b9b9b),
                                  fontSize: 17.0,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ), 
                              ),
                            ], 
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 35),
                            child: Text(
                              userData!= null ? '${userData['phone']}' : '',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color(0xFF9b9b9b),
                                fontSize: 15.0,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ), 
                          ),
                        ],
                      ), 
                    ),
                  ),
              ////////////end  part////////////
                ],
              ), 
            ),
          ),
          /////////////// Button////////////
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              /////////// Edit Button /////////////
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FlatButton(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 8, bottom: 8, left: 10, right: 10
                    ),
                    child: Text(
                      'Edit',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ), 
                    ),
                  ),
                  color: Color(0xFFFF835F),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => Edit()));
                  }
                ),
              ),
              ////////////// logout//////////
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FlatButton(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 8, bottom: 8, left: 10, right: 10
                    ),
                    child: Text(
                      'Logout',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ), 
                    ),
                  ),
                  color: Color(0xFFFF835F),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)
                  ),
                  onPressed: logout
                ),
              ), 
            ],
                ), 
              )
            ], 
          ),
        ),
      ),
    ), 
    Container(
      child: Text('Search')
    ),
    Container(
      child: Text('Recipe Book')
    ),
    Container(
      child: Text('Notification')
    ),
    Container(
      child: Text('Profile')
    ),
  ];

  // build page
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: _widgetOptions.elementAt(_selectedIndex),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber[700],
      ),
      body: _widgetBodyOptions.elementAt(_selectedIndex),
    bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text('Search'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          title: Text('Recipe Book'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          title: Text('Notifications'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile'),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
      unselectedItemColor: Colors.amber[400],
    ),
  );
}
  
      void logout() async {
        // logout from the server ...
        var res = await CallApi().getData('logout');
        var body = json.decode(res.body);
        if(body['success']){
          SharedPreferences localStorage = await SharedPreferences.getInstance();
          localStorage.remove('user');
          localStorage.remove('token');
          Navigator.push(
            context,
            new MaterialPageRoute( builder: (context) => Login() )
          );
        }
      }
}