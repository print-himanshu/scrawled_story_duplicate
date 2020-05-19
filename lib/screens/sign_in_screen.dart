import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/sign_in_form.dart';
import './common_sign_screen.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/sign-in-screen';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isLoading = false;
  final _auth = FirebaseAuth.instance;

  Future<void> _signIn(Map<String, String> data, BuildContext ctx) async {
    try {
      // setState(() {
      //   _isLoading = true;
      // });


      // Firestore.instance.collections("username").document(data['email'].trim()).snapshots().listen((value){
      //   print("value is $value");
      // });

      final _firebaseUser = (await _auth.signInWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      ));

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

  @override
  Widget build(BuildContext context) {
    final _themeData = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: _themeData.backgroundColor,
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
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: <Widget>[
                      CommonSignScreen(mode: 'Sign in'),
                      SignInForm(_signIn),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
