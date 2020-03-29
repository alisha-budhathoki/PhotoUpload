import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AfterUploading extends StatefulWidget{
  @override
  _AfterUploading createState() => _AfterUploading();

}
class _AfterUploading extends State<AfterUploading>{
  String storedImage;
  @override
  void initState() {
super.initState();
storedImage= " ";
getSharedPrefs();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.grey.shade50,
            elevation: 15,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Image.asset('assets/images/back2.png')),
                  Text(
                    'Uploaded Image',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(width: 20),
                  Text(''),
                ])),

        body: Column(
        children: <Widget>[
          Image.network(storedImage, height: 200, width: 200, fit: BoxFit.fill,),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('You have uploaded above image successfully'),
          ),

        ],
      ),
      ),
    );
    }

  Future<Null> getSharedPrefs() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    storedImage = prefs.getString("url");
    print("Image: $storedImage");
  }

}