import 'package:flutter/material.dart';
import 'package:townteam/View/Home.dart';
import 'package:townteam/View/LoginPage.dart';
import 'package:townteam/View/ShowProducts.dart';
import 'package:townteam/View/SplashPage.dart';
import 'Model/Facebook_Login.dart';
import 'Presenter/Notification.dart';
import 'View/RegisterPage.dart';

void main(){
  runApp(
    MaterialApp(
      title: 'Town Team',
      home: Home(),

      debugShowCheckedModeBanner: false,
      routes: <String,WidgetBuilder>{
        '/home':(BuildContext context) =>Home(),
        '/login':(BuildContext context) =>LoginPage(),
        '/register':(BuildContext context) => RegisterPage(),
        '/showproducts':(BuildContext context) => ShowProducts(),

      }

    ),
  );

}