import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:townteam/View/LoginPage.dart';
import 'Google_Login.dart';
import 'Facebook_Login.dart';


class AppBarComponents extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

  static Widget HeaderTitle(String _pageName) {
    return Text(
      _pageName,
      style: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  static Widget HeaderCart() {
    return IconButton(
      icon: Icon(Icons.add_shopping_cart),
      onPressed: () {
        print("cart");
      },
    );
  }

  static Widget HeaderSearch(){
    return IconButton(
      icon: Icon(Icons.search,size: 25,),
      onPressed: (){
        print('search');
      },
    );
  }

  static Widget HeaderDrawer(BuildContext context,String _loginType) {

    var user_name;
    var user_email;
    var user_photo;
    print('welcome drawer');
    switch(_loginType) {
      case 'email':
        break;
      case 'google':
        user_name = google_user_name;
        user_email = google_user_email;
        user_photo = google_user_image_url;
        break;
      case 'facebook':
        user_name = facebook_user_name;
        user_email = facebook_user_email;
        user_photo = facebook_user_image_url;
        break;
    }
    return  Drawer(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[

              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                ),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage:  NetworkImage("$user_photo"),
                      radius: 40,
                    ),
                    Text(
                      '$user_name',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$user_email',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home',style: TextStyle(color: Colors.black,fontSize: 15),),
              ),
              Divider(color: Colors.black,),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('My Account',style: TextStyle(color: Colors.black,fontSize: 15),),
              ),
              Divider(color: Colors.black,),
              ListTile(
                leading: Icon(Icons.local_mall),
                title: Text('My Orders',style: TextStyle(color: Colors.black,fontSize: 15),),
              ),
              Divider(color: Colors.black,),
              ListTile(
                leading: Icon(Icons.category),
                title: Text('Categories',style: TextStyle(color: Colors.black,fontSize: 15),),
              ),
              Divider(color: Colors.black,),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Favorite',style: TextStyle(color: Colors.black,fontSize: 15),),
              ),
              Divider(color: Colors.black,),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings',style: TextStyle(color: Colors.black,fontSize: 15),),
              ),
              Divider(color: Colors.black,),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About',style: TextStyle(color: Colors.black,fontSize: 15),),
              ),
              Divider(color: Colors.black,),
              ListTile(
                onTap: (){
                  /*
                  switch(_loginType){
                    case 'email':
                      break;
                    case 'google':
                      signOutGoogle().whenComplete((){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginPage();
                            },
                          ),
                        );
                      });
                      break;
                    case 'facebook':
                      _logoutFromFB().whenComplete((){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginPage();
                            },
                          ),
                        );
                      });
                      break;

                   */

                  FirebaseAuth.instance.signOut().then((result) => {
                  //The Navigator method pushAndRemoveUntil is used to make the Home page the first page in the stack.
                  Navigator.pushAndRemoveUntil(
                  context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage()),
                          (_) => false),
                  });
                },
                leading: Icon(Icons.exit_to_app),
                title: Text('LogOut',style: TextStyle(color: Colors.black,fontSize: 15),),
              ),

            ],
          ),
        );




    }



  static _logoutFromFB() {
    facebookLogin.logOut();
    print('Facebook logout');

  }

}
