import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class SignInForm extends StatefulWidget {
final Function _signIn;
  SignInForm(this._signIn);
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final FocusNode _passwordFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();
  Map<String, String> _data = {
    'email': '',
    'password': '',
  };

  

  @override
  void dispose() {
    super.dispose();

    _passwordFocus.dispose();
  }

  void _validateForm() {
    print("Inside validate form method");
    if (!_formKey.currentState.validate()) return;
    print("Validation Done");
    _formKey.currentState.save();
    widget._signIn(_data,context);
  }

  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final _themeData = Theme.of(context);
    return  Column(
        children: <Widget>[
          Card(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 10,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    key: ValueKey("email"),
                    decoration: InputDecoration(
                        labelText: "Username or Email",
                        contentPadding: const EdgeInsets.only(
                          left: 20.0,
                          top: 10.0,
                          bottom: 10.0,
                        ),
                        labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                    keyboardType: TextInputType.emailAddress,
                    validator: (data) {
                      if (data == null)
                        return "Please Enter Email Address for the validation....";
                      // if (!EmailValidator.validate(data))
                      //   return "Please Enter correct Email Address.";
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).unfocus();
                      FocusScope.of(context).requestFocus(_passwordFocus);
                    },
                    onSaved: (data) {
                      _data['email'] = data;
                      //_validateForm();
                    },
                    autocorrect: false,
                  ),
                  TextFormField(
                      key: ValueKey('password'),
                      decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          contentPadding: const EdgeInsets.only(
                            left: 20.0,
                            top: 10.0,
                            bottom: 10.0,
                          )),
                      obscureText: true,
                      focusNode: _passwordFocus,
                      textInputAction: TextInputAction.done,
                      onSaved: (data) {
                        _data['password'] = data;
                        //_validateForm();
                      },
                      validator: (data) {
                        if (data == null)
                          return "Please Enter the Password for the authentication";
                      }),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
              ),
          FlatButton(
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              onPressed: () {}),
          SizedBox(height: 30),
          SizedBox(
            height: 60,
            width: _mediaQuery.size.width * 0.70,
            child: RaisedButton(
              child: Text(
                "SIGN IN",
                style: _themeData.textTheme.button,
              ),
              onPressed: _validateForm,
              color: Color.fromARGB(0xff, 0x03, 0x5a, 0xa6),
              elevation: 10,
            ),
          ),
        ],
      
    );
  }
}
