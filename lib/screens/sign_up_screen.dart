import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import './common_sign_screen.dart';
import '../widgets/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/sign-up-screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  bool _isLoading = false;

  Future<void> _signUp(Map<String, String> data, BuildContext ctx) async {
    try {
      // setState(() {
      //   _isLoading = true;
      // });
      final _firebaseUser = (await _auth.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      )).user;

      final String _displayName = data['first'] + " " + data['last'];
      print("DisplayName: $_displayName");

      _firestore.collection("users").document(_firebaseUser.uid).setData({
        'email': data['email'],
        'username': data['username'],
        'displayname': _displayName,
        'lastSeen': DateTime.now()
      }, merge: true);

      _firestore
          .collection("username")
          .document(data['username'])
          .setData({'email': data['email']}, merge: true);

      // setState(() {
      //   _isLoading = false;
      // });
    } on PlatformException catch (error) {
      String _globalMessage = "An error occurred, please try again later";
      if (error.message != null) _globalMessage = error.message;
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(_globalMessage),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    } catch (error) {
      print("Internal Error occurred during signup method in sign up screen");
    }
  }

  final String mode = 'Sign Up';

  @override
  Widget build(BuildContext context) {
    final _themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: _themeData.backgroundColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Back to Welcome",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: (_) {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: <Widget>[
                      CommonSignScreen(mode: mode),
                      SignUpForm(_signUp),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
