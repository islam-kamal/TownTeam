import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

Map userProfile;
String facebook_user_name;
String facebook_user_email;
String facebook_user_image_url;
final facebookLogin = FacebookLogin();

  _loginWithFB() async {
  final result = await facebookLogin.logIn(['email']);
  switch (result.status) {
    case FacebookLoginStatus.loggedIn:
      final token = result.accessToken.token;
      final graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
      final profile = JSON.jsonDecode(graphResponse.body);
      print(profile);
      userProfile = profile;
      facebook_user_name = userProfile['name'];
      facebook_user_email = userProfile['email'];
      facebook_user_image_url = userProfile["picture"]["data"]["url"];
      break;
    case FacebookLoginStatus.cancelledByUser:
      print('Facebook cancelledByUser');
      break;
    case FacebookLoginStatus.error:
      print('Facebook error');
      break;
  }
  return userProfile;
}

 _logoutFromFB() async{
  await facebookLogin.logOut();
  return "Facebook Sign Out";
}
