import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'expansion_tile.dart';



class CustomDrawer extends StatefulWidget {

//  void customLaunch(command) async {
//    if (await canLaunch(command)) {
//      await launch(command);
//    } else {
//      print(' could not launch $command');
//    }
//  }


  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {

    setState(() {

    });
    //print('Here drawer');
  }

  @override
  Widget build(BuildContext context) {
//    var _pageSize = MediaQuery.of(context).size.height;
//    var _notifySize = MediaQuery.of(context).padding.top;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.maxFinite,
      child: Drawer(
          child: Container(
            color: Color(0xfff1f0ec),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/logo_login.png',
                        height: 30,
                        fit: BoxFit.fill,
                      ),
                      new IconButton(
                        icon: new Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.grey,
                        ),
                        onPressed: () => Navigator.of(context).pop(null),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 15, 25, 10),
                  child: Row(
                    children: <Widget>[
//                      Container(
//                          height: 52,
//                          width: 52,
//                          child: Padding(
//                            padding: const EdgeInsets.all(2.0),
//                            child: CircleAvatar(
//                              radius: 30,
//                              backgroundImage:
//                              NetworkImage(UserDetailsModel.userImg),
//                            ),
//                          ),
//                          decoration: new BoxDecoration(
//                            shape: BoxShape.circle,
//                            border: new Border.all(color: Colors.green, width: 2),
//                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('Hello '),
//                              Text(UserDetailsModel.userName)
                            ],
                          ),

                          Text(
                            "sjh",
                            style: TextStyle(
                                color: Color(0xFF5CC4BE),
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          //                    LinearProgressIndicator(
//                      backgroundColor: Colors.brown,
//                      // TODO: Linear progress bar left
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                  child: Divider(
                    color: Colors.grey.shade600,
                    height: 6.0,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'My Profile',
                        style: TextStyle(fontSize: 18, color: Color(0xFF6d7dbc)),
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Upgrade your account',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF6d7dbc),
                        ),
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Walkthrough Screens',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF6d7dbc),
                        ),
                      )),
                ),
                ExpansionTile2(
                  title: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 9.5, vertical: 0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Help & Support',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF6d7dbc),
                              fontWeight: FontWeight.w400),
                        )),
                  ),
                  children: <Widget>[
                    Divider(
                      height: 5,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35, 10, 5, 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Frequently Asked Question',
                          style:
                          TextStyle(fontSize: 16, color: Color(0xFF6d7dbc)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35, 10, 5, 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Report a problem',
                          style:
                          TextStyle(fontSize: 16, color: Color(0xFF6d7dbc)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35, 10, 5, 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Suggest an improvement',
                          style:
                          TextStyle(fontSize: 16, color: Color(0xFF6d7dbc)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Divider(
                        height: 5,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Terms & Conditions',
                        style: TextStyle(fontSize: 18, color: Color(0xFF6d7dbc)),
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(fontSize: 18, color: Color(0xFF6d7dbc)),
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
//                                  mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                        children: <Widget>[
                          Text(
                            'Notifications',
                            style:
                            TextStyle(fontSize: 18, color: Color(0xFF6d7dbc)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                         ],
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                  },
                  child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0),
                      child: Image.asset(
                        'assets/images/recommend_btn_xxhdpi.png',
                        width: double.infinity,
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                  child: Row(
                    children: <Widget>[
                      Text('App Version 1.0.1'),
                    ],
                  ),
                ),

                Expanded(
                  child:
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                        onTap: (){
                          showDialogHere(context);
                        },

                        child: Text('aksja')),
                  ),
                )

              ],
            ),
          )),
    );
  }

  void showDialogHere(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text(
            "Are You sure you want to logout?",
            style: TextStyle(fontSize: 18),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  child: new Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: new Text("Okay"),
                  onPressed: () async {

                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  String text = 'Hey, I have created a memory with the FiveTies app to be released to my loved ones upon passing. You should check it out too! Visit www.fiveties.com';

  String subject = 'Fiveties';


}

//Todo: making the contents fit the whole screen
