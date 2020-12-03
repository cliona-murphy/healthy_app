import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

    final FirebaseAuth auth = FirebaseAuth.instance;

    //anon sign-in
Future signInAnon() async {
  try {
    AuthResult result = await auth.signInAnonymously();
    FirebaseUser user = result.user;
    return user;
  } catch(e) {
    print(e.toString());
    return null;
  }
}
}