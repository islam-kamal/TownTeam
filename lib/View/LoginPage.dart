import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:townteam/Model/Google_Login.dart';
import 'package:townteam/View/Home.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;


import 'FirstScreen.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
 // TextEditingController _emailController = new TextEditingController();
 // TextEditingController _passwordController = new TextEditingController();
  Map userProfile;
  FacebookLogin facebookLogin = FacebookLogin();
  List _loginType=['email','google','facebook'];

  //login form code
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new Container(
        alignment: Alignment.center,
        color: Colors.blueGrey,
        padding: EdgeInsets.all(10.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage('images/logo.png'),
                  radius: 80,
                ),
                new Container(
                  padding: EdgeInsets.all(30.0),
                  width: 350.0,
                  child: new Column(
                    textDirection: TextDirection.rtl,
                    // mainAxisSize: MainAxisSize.min,
                    //  mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    Form(
                    key: _loginFormKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Email*', hintText: "john.doe@gmail.com"),
                          controller: emailInputController,
                          keyboardType: TextInputType.emailAddress,
                          validator: emailValidator,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Password*', hintText: "********"),
                          controller: pwdInputController,
                          obscureText: true,
                          validator: pwdValidator,
                        ),
                        SizedBox(height: 10,),
                        new Center(
                          widthFactor: 200.0,
                          child: new Row(
                            children: <Widget>[
                              new SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: new RaisedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/register");
                                  },
                                  child: new Text(
                                    "عضو جديد",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(2.0),
                                    side: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  color: Colors.grey,
                                ),
                              ),
                              Spacer(),
                              new SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: new RaisedButton(
                                  onPressed: () {
                                    if (_loginFormKey.currentState.validate()) {
                                      FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                          email: emailInputController.text,
                                          password: pwdInputController.text)
                                          .then((currentUser) => Firestore.instance
                                          .collection("users")
                                          .document(currentUser.user.uid)
                                          .get()
                                          .then((DocumentSnapshot result) =>
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Home.user(
                                                    user_title: result["fname"]+' ' + result["surname"],
                                                    user_id: currentUser.user.uid,
                                                  ))))
                                          .catchError((err) => print(err)))
                                          .catchError((err) => print(err));
                                    }
                                  },
                                  child: new Text(
                                    "تسجيل الدخول",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  //use to make circle border for button
                                  shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(2.0),
                                    side: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    ),
                      
                      new Container(
                        padding: EdgeInsets.only(top: 30),
                        child: new Column(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child:  _googleSignInButton(),

                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child:  _facebookSignInButton(),

                          ),

                        ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _loginWithFB() async{
    /*
    final result = await facebookLogin.logIn(['email','public profile']);
    if(result.status == FacebookLoginStatus.loggedIn) {
      final token = result.accessToken.token;
      final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
      final profile = JSON.jsonDecode(graphResponse.body);
      print(profile);
      userProfile = profile;

     */

    final result = await facebookLogin.logIn(['email','public profile']);
    if(result.status == FacebookLoginStatus.loggedIn) {
      final token = result.accessToken.token;
    AuthCredential credential= FacebookAuthProvider.getCredential(accessToken: token);
    FirebaseUser firebaseUser = (
        await FirebaseAuth.instance.signInWithCredential(credential)
    ).user;
    print(firebaseUser.displayName);
      print(firebaseUser.email);
      print(firebaseUser.uid);
  }


  }

  _logout(){
    facebookLogin.logOut();
  }

  Widget _googleSignInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        print('type of login : ${_loginType[1]}');
        signInWithGoogle().whenComplete((){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return Home.login(_loginType[1]);
              },
            ),
          );
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 8, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
       //     Image(image: AssetImage("images/google.png"), height: 35.0),
            CircleAvatar(
              backgroundImage:
              AssetImage('images/google.png'),
              radius:20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget _facebookSignInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        print('type of login : ${_loginType[2]}');
        _loginWithFB().whenComplete((){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return Home.login(_loginType[2]);
              },
            ),
          );
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //     Image(image: AssetImage("images/google.png"), height: 35.0),
            CircleAvatar(
              backgroundImage:
              AssetImage('images/facebook.png'),
              radius: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Facebook',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
