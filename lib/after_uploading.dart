import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AfterUploading extends StatefulWidget {
  @override
  _AfterUploading createState() => _AfterUploading();
}

class _AfterUploading extends State<AfterUploading> {
  String storedImage;
  @override
  void initState() {
    super.initState();
    storedImage = " ";
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 15,
          title: Center(
            child: Text(
              'Uploaded Image',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                  child: Image.network(
                storedImage,
                height: 200,
                width: 200,
                fit: BoxFit.fill,
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You have uploaded above image',
                    style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Successfully',
                  style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
            RaisedButton(color: Colors.teal,
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text(
                'Back',
                style: TextStyle(
                  color: Colors.white
                ),
              ),

            )
          ],
        ),
      ),
    );
  }

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    storedImage = prefs.getString("url");
    print("Image: $storedImage");
  }
}
