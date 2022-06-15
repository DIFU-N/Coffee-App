import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterloginapp/models/user.dart';
import 'package:flutterloginapp/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  //create user object based on firebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }

  //sign in anon
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

  // sign in with email and pass
  Future signInWithEmailAndPassword(String email, String pass) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and pass
  Future registerWithEmailAndPassword(String email, String pass) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = result.user;
      //create a document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData('0', 'new weird member', 100);
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }

}