import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

String google_user_name;
String google_user_email;
String google_user_image_url;

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount _googleSignInAccount = await _googleSignIn.signIn();
  final GoogleSignInAuthentication _googleSignInAuthentication =
      await _googleSignInAccount.authentication;
  final AuthCredential _authCredential = GoogleAuthProvider.getCredential(
      accessToken: _googleSignInAuthentication.accessToken,
      idToken: _googleSignInAuthentication.idToken);
  final AuthResult _authResult =
      await _firebaseAuth.signInWithCredential(_authCredential);
  final FirebaseUser user = _authResult.user;

  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);

  google_user_name = user.displayName;
  google_user_email = user.email;
  google_user_image_url = user.photoUrl;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);
  final FirebaseUser _currentUser = await _firebaseAuth.currentUser();
  assert(user.uid == _currentUser.uid);

  return 'signInWithGoogle succeeded: $user';
}

Future<String> signOutGoogle() async {
  await _googleSignIn.signOut();
 return "Google Sign Out";
}
