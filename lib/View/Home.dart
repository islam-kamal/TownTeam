import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:townteam/Model/AppBarComponents.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:townteam/Model/HorizontalListView.dart';
import 'package:townteam/Model/Products.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  var _typeOfLogin;
  var user_id;
  var user_title;

  Home();
  Home.user({this.user_title,this.user_id});
  Home.login(this._typeOfLogin);

  @override
  State<StatefulWidget> createState() {
    print('${user_id} : ');
    print('${user_title} : ');

    return _HomeState(_typeOfLogin);
  }
}

class _HomeState extends State<Home> {
  var _typeOfLogin;
  List<String> facebookInfo;
  Future<String> url;
  _HomeState(String typeOfLogin) {
    this._typeOfLogin = typeOfLogin;
  }

  @override
  void initState() {
   // getFirebaseImageFolder();
  }

  @override
  Widget build(BuildContext context) {

    Widget image_carousel = new Container(
     // height: MediaQuery.of(context).size.width/2,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
        AssetImage('images/offers/w4.png'),
          AssetImage('images/offers/c1.png'),
          AssetImage('images/offers/back.png'),
          AssetImage( 'images/offers/w3.png'),

        ],
        autoplay: true,
        autoplayDuration: Duration(seconds: 2),
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 6.0,
        dotColor: Colors.deepOrange,
        indicatorBgPadding: 2.0,

      ),


    );


    return new Scaffold(
      appBar: AppBar(
        title: AppBarComponents.HeaderTitle('Home'),
        backgroundColor: Colors.grey,
        actions: <Widget>[
          AppBarComponents.HeaderSearch(),
          AppBarComponents.HeaderCart(),
        ],
        
      ),
      body: Container(
            color: Colors.grey,
            child:  Column(
              children: <Widget>[

                new Container(
                  child:image_carousel ,
                  height: MediaQuery.of(context).size.height/4,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(bottom:10.0),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Categories',
                    style: TextStyle(fontSize: 17, color: Colors.black),
                    textAlign: TextAlign.right,
                  ),

                ),
                HorizontalList(),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Recent Products',
                    style: TextStyle(fontSize: 17, color: Colors.black),
                    textAlign: TextAlign.right,
                  ),
                ),
                //grid view
                Flexible(child: Products()),
              ],
            ),
          ),

      drawer: AppBarComponents.HeaderDrawer(context,_typeOfLogin),
    );
  }
  /*
  // get images from firebaseStorgae
  Future<List> getFirebaseImageFolder(){
    final StorageReference storageRef =
    FirebaseStorage.instance.ref().child('offers');
    storageRef.listAll().then((result) {
      print('result : ${result['items']['back.png']['path']}');

    });
  }

   */

}
