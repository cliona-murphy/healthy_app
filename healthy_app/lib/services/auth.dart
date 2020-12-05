import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthy_app/models/user.dart';

class AuthService {

    final FirebaseAuth _auth = FirebaseAuth.instance;
    //create user obj based on FirebaseUser
    User _userFromFirebaseUser(FirebaseUser user){
      return user != null ? User(uid: user.uid) : null;
    }

    // auth change user stream
    Stream<User> get user {
      return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
    }

    //anon sign-in
Future signInAnon() async {
  try {
    AuthResult result = await _auth.signInAnonymously();
    FirebaseUser user = result.user;
    return _userFromFirebaseUser(user);
  } catch(e) {
    print(e.toString());
    return null;
  }
}
}