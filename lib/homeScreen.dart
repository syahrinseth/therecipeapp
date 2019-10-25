import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipe_app/editProfileScreen.dart';
import 'package:recipe_app/loginScreen.dart'; 
import 'package:recipe_app/api.dart';
import 'package:recipe_app/recipeScreen.dart';
import 'package:recipe_app/widgets/slide_item.dart';
import 'package:recipe_app/util/recipes.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var userData;
  final colorPrimary = Colors.blue[700];
  final TextEditingController _searchControl = new TextEditingController();
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text(
  //     'Home',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Search',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Recipe Book',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Notification',
  //     style: optionStyle
  //   ),
  //   Text(
  //     'Profile',
  //     style: optionStyle
  //   )
  // ];

  

  // Widget RecipePage() {
  //   Return 
  // }


  

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _getUserInfo();
    // TrendingRecipes();
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

    Widget TrandingRecipes({int i}) {

    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Trending Recipes",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800
                ),
              ),
              FlatButton(
                child: Text(
                  "See all (43)",
                  style: TextStyle(
                    color: colorPrimary
                  ),
                ),
                onPressed: () => null,
              )
            ],
          ),
          SizedBox(height: 10.00),
          Container(
            height: MediaQuery.of(context).size.height/2.4,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                Map recipe = recipes[index];
                return Padding(
                  padding: EdgeInsets.only(right: 10.00),
                  child: SlideItem(
                    img: recipe["img"],
                    title: recipe['title'],
                    rating: recipe['rating']
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10.0,)
        ],
      ),
    );

      // return Container(
      //   child: Center(
      //     child: Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: <Widget>[
      //           Card(
      //               elevation: 4.0,
      //               color: Colors.white,
      //               margin: EdgeInsets.only(left: 10, right: 10), 
      //               child: Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: <Widget>[
      //                     ListTile(
      //                       leading: Icon(Icons.fastfood),
      //                       title: Text('Food $i'),
      //                       subtitle: Text('Food Desc'),
      //                       onTap: () {
      //                         Navigator.push(
      //                           context,
      //                           MaterialPageRoute(
      //                             builder: (context) => RecipeScreen(title: "text $i")
      //                           )
      //                         );
      //                       },
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             ),
      //         ],
      //       ),
      //     ),
      //   )
      // );
    }

    // app bar list
    List<Widget> _appBarOptions = <Widget>[
    PreferredSize(
          preferredSize: Size.fromHeight(0.0), // here the desired height
      child: AppBar(
        // ...
      )
    ),
    PreferredSize(
        child: Padding(
          padding: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
          child: Card(
            elevation: 6.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Colors.white,),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Search..",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  suffixIcon: Icon(
                    Icons.filter_list,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: _searchControl,
              ),
            ),
          ),
        ),
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          60.0,
        ),
      ),
      PreferredSize(
          preferredSize: Size.fromHeight(0.0), // here the desired height
          child: AppBar(
            // ...
          )
      ),
      PreferredSize(
          preferredSize: Size.fromHeight(0.0), // here the desired height
          child: AppBar(
            // ...
          )
      ),
      PreferredSize(
          preferredSize: Size.fromHeight(0.0), // here the desired height
          child: AppBar(
            // ...
          )
      ),
  ];

    // app body list
    List<Widget> _widgetBodyOptions = <Widget>[ 
    TrandingRecipes(),
    Container(
      child: Text('Search')
    ),
    Container(
      child: Text('Recipe Book')
    ),
    Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                  width: 190.0,
                  height: 190.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                              "https://i.imgur.com/BoN9kdC.png")
                      )
                  )
              ),
              Text("John Doe",
                    textScaleFactor: 1.5
              ),
            ],
          ),
        ),
      )
    ),
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
                                  color: colorPrimary,
                                ), 
                              ),
                              Text(
                              'Firstname',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: colorPrimary,
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
                                color: colorPrimary,
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
                                    color: colorPrimary,
                                  ), 
                                ),
                                Text(
                                  'Last Name',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: colorPrimary,
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
                                  color: colorPrimary,
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
                                  color: colorPrimary,
                                ),
                              ),
                              Text(
                                'Email',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: colorPrimary,
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
                                color: colorPrimary,
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
                                  color: colorPrimary,
                                ), 
                              ),
                              Text(
                                'Phone',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: colorPrimary,
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
                                color: colorPrimary,
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
                  color: Colors.blue[700],
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
                  color: Colors.blue[700],
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
  ];


  // build page
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      appBar: _appBarOptions.elementAt(_selectedIndex),
      body: _widgetBodyOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(width: 7),
            IconButton(
              icon: Icon(
                Icons.home,
                size: 24.0,
              ),
              color: _selectedIndex == 0 ? colorPrimary : null,
              onPressed: () =>_onItemTapped(0),
            ),
            IconButton(
              icon: Icon(
                Icons.search,
                size: 24.0,
              ),
              color: _selectedIndex == 1 ? colorPrimary : null,
              onPressed: () =>_onItemTapped(1),
            ),
            Text(""),
            // IconButton(
            //   icon: Icon(
            //     Icons.book,
            //     size: 24.0,
            //   ),
            //   color: _selectedIndex == 2 ? colorPrimary : null,
            //   onPressed: () =>_onItemTapped(2),
            // ),
            IconButton(
              icon: Icon(
                Icons.notifications,
                size: 24.0,
              ),
              color: _selectedIndex == 3 ? colorPrimary : null,
              onPressed: () =>_onItemTapped(3),
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                size: 24.0,
              ),
              color: _selectedIndex == 4 ? colorPrimary : null,
              onPressed: () =>_onItemTapped(4),
            ),
            SizedBox(width:7),
          ],
        ),
        shape: CircularNotchedRectangle(),
      ),
       floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        child: Icon(
          Icons.book,
        ),
        onPressed: ()=>_onItemTapped(2),
      ),
    // bottomNavigationBar: BottomNavigationBar(
    //   items: const <BottomNavigationBarItem>[
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.home),
    //       title: Text('Home'),
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.search),
    //       title: Text('Search'),
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.book),
    //       title: Text('Recipe Book'),
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.notifications),
    //       title: Text('Notifications'),
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.person),
    //       title: Text('Profile'),
    //     ),
    //   ],
    //   currentIndex: _selectedIndex,
    //   selectedItemColor: Colors.blue[800],
    //   onTap: _onItemTapped,
    //   unselectedItemColor: Colors.blue[400],
    // ),
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