import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../helpers/google_auth.dart';

class CommonSignScreen extends StatelessWidget {
  final String mode;
  CommonSignScreen({
    @required this.mode,
  });
  @override
  Widget build(BuildContext context) {
    final _themeData = Theme.of(context);
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "$mode",
            style: _themeData.textTheme.button,
            textDirection: TextDirection.ltr,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Card(
          elevation: 10,
          child: Container(
            color: const Color.fromARGB(0xff, 0x3b, 0x59, 0x98),
            child: ListTile(
              leading: FaIcon(FontAwesomeIcons.facebook, color: Colors.white),
              title: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Connect with Facebook",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
              onTap: () {},
              enabled: true,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Card(
          elevation: 10,
          child: Container(
            color: Colors.white,
            child: ListTile(
              // leading: FaIcon(FontAwesomeIcons.google),
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/google.png',
                ),
                backgroundColor: Colors.white,
              ),
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  "Connect with Google",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              onTap: () => googleService
                  .signInWithGoogle()
                  .whenComplete(() => print("Method done")),
              enabled: true,
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Row(children: <Widget>[
          Expanded(
            child: new Container(
                margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.white,
                  // height: 36,
                  thickness: 2,
                )),
          ),
          Text(
            "OR",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Expanded(
            child: new Container(
                margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                child: Divider(
                  color: Colors.white,
                  thickness: 2,
                  //height: 36,
                )),
          ),
        ]),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
