import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:rxdart/rxdart.dart';

class GoogleAuth {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Stream<FirebaseUser> user;
  Stream<Map<String, dynamic>> profile;
  PublishSubject _loading = PublishSubject();

  GoogleAuth() {
    user = _auth.onAuthStateChanged;
    profile = user.switchMap((FirebaseUser u) {
      if (u != null)
        return _db
            .collection('users')
            .document(u.uid)
            .snapshots()
            .map((snap) => snap.data);
      else
        return Stream.value({});
    });
  }

  Future<void> signInWithGoogle() async {
    try{
    _loading.add(true);
    final GoogleSignInAccount _account = await _googleSignIn.signIn();
    //print("Sign in method started");
    final GoogleSignInAuthentication _authentication =
        await _account.authentication;
    //print("Detail found");
    // print("IdToken: ${_authentication.idToken}");
    // print("accessToken: ${_authentication.accessToken}");
    final AuthCredential _credential = GoogleAuthProvider.getCredential(
      idToken: _authentication.idToken,
      accessToken: _authentication.accessToken,
    );
    // print("Credential : ${_credential}");
    final AuthResult _result = await _auth.signInWithCredential(_credential);
    FirebaseUser _firebaseUser = _result.user;
    updateUserData(_firebaseUser);
    _loading.add(false);
     } // print("SignIn done");}
    catch(error){
      print("Error occurred: $error");
      print("${error.message}");
    }
  }

  void updateUserData(FirebaseUser user) async {
    DocumentReference _ref = _db.collection('users').document(user.uid);
    return _ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoUrl': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);
  }

  void signOut() {
    _auth.signOut();
  }
}

final GoogleAuth googleService = GoogleAuth();
