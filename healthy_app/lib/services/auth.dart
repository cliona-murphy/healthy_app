import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthy_app/models/user.dart';
import 'package:healthy_app/services/database.dart';

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
//sign out
Future signOut() async {
      try {
        return await _auth.signOut();
      } catch(e) {
        print(e.toString());
        return null;
      }
}

Future registerWithEmail(String email, String password) async {
      try {
        AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        FirebaseUser user = result.user;
        return _userFromFirebaseUser(user);
      } catch(e){
        print(e.toString());
        return null;
      }
}

  Future signInWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //create new document for user with uid
      await DatabaseService(uid: user.uid).updateUserData(0, 0, 0.0);
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

}