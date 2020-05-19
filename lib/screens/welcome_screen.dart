import 'package:flutter/material.dart';

import './sign_in_screen.dart';
import './sign_up_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _themeData = Theme.of(context);
    final _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: _themeData.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/creator.jpg'),
              minRadius: 45,
              maxRadius: 50,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Welcome",
            style: _themeData.textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Sign in to Scrawled Stories to read,share and save relatable stories, musings, poetries with people around the world",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'roboto',
              fontSize: 18,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: 60,
                width: _mediaQuery.size.width * 0.70,
                child: RaisedButton(
                  child: Text(
                    "SIGN IN",
                    style: _themeData.textTheme.button,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(SignInScreen.routeName);
                  },
                  color: Color.fromARGB(0xff, 0x03, 0x5a, 0xa6),
                  elevation: 10,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 60,
                width: _mediaQuery.size.width * 0.7,
                child: RaisedButton(
                  child: Text(
                    "SIGN UP",
                    style: _themeData.textTheme.button,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(SignUpScreen.routeName);
                  },
                  color: const Color.fromARGB(0xff, 0x70, 0x6c, 0x61),
                  //color: const Color.fromARGB(0xff, 0x30, 0x30, 0x30),
                  elevation: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
