import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class SignUpForm extends StatefulWidget {
  final Function _signUp;

  SignUpForm(this._signUp);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _userNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();
  final _passwordController = TextEditingController();

  Map<String, String> _data = {
    'first': '',
    'last': '',
    'username': '',
    'email': '',
    'password': '',
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _lastNameFocus.dispose();
    _userNameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
  }

  void _validateForm() {
    FocusScope.of(context).unfocus();
    print("Inside validate form ");
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    print("form validate and save");

    print("Map : $_data");
    widget._signUp(_data,context);
  }

  @override
  Widget build(BuildContext context) {
    final _themeData = Theme.of(context);
    final _mediaQuery = MediaQuery.of(context);
    return Column(
      children: <Widget>[
        Card(
          elevation: 10,
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "First Name",
                    contentPadding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 20,
                    ),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  focusNode: _firstNameFocus,
                  onFieldSubmitted: (_) {
                    _firstNameFocus.unfocus();
                    FocusScope.of(context).requestFocus(_lastNameFocus);
                  },
                  validator: (data) {
                    if (_firstNameFocus.hasFocus) {
                      data = data.trim();
                      print("Validating the first name");
                      if (data == null) return "Please enter First Name";
                      if (data.length <= 1)
                        return "Well, I don't know anyone First Name having less than 2 character";
                      RegExp _reg = new RegExp(r'\d+');
                      if (_reg.hasMatch(data))
                        return "I don't think so, First name should contain any numerical digit";
                      _reg = RegExp(r'^[a-zA-Z]+$');
                      if (!_reg.hasMatch(data))
                        return "First Name should not have special character";
                      if (data.contains(" "))
                        return "Please enter a single word for the First name";
                    }
                    return null;
                  },
                  autocorrect: false,
                  onSaved: (data) {
                    _data['first'] = data.trim();
                  },
                  autovalidate: true,
                  textCapitalization: TextCapitalization.sentences,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Last Name",
                    contentPadding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 20,
                    ),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  focusNode: _lastNameFocus,
                  onFieldSubmitted: (_) {
                    _lastNameFocus.unfocus();

                    FocusScope.of(context).requestFocus(_userNameFocus);
                  },
                  validator: (data) {
                    if (_lastNameFocus.hasFocus) {
                      data = data.trim();

                      if (data == null) return "Please enter Last Name";
                      if (data.length <= 1)
                        return "Well, I don't know anyone Last Name having less than 2 character";
                      RegExp _reg = new RegExp(r'\d+');
                      if (_reg.hasMatch(data))
                        return "I don't think so, Last name should contain any numerical digit";
                      _reg = RegExp(r'^[a-zA-Z]+$');
                      if (!_reg.hasMatch(data))
                        return "First Name should not have special character";
                      if (data.contains(" "))
                        return "Please enter a single word for the last name";
                    }
                    return null;
                  },
                  autocorrect: false,
                  onSaved: (data) {
                    _data['last'] = data.trim();
                  },
                  autovalidate: true,
                  textCapitalization: TextCapitalization.sentences,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Username",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    contentPadding: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                      bottom: 10,
                    ),
                    hintText: "Only underscore is allowed as special character",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  focusNode: _userNameFocus,
                  onFieldSubmitted: (_) {
                    _userNameFocus.unfocus();

                    FocusScope.of(context).requestFocus(_emailFocus);
                  },
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  autovalidate: true,
                  validator: (value) {
                    if (_userNameFocus.hasFocus) {
                      if (value == null) return "Please Enter UserName";
                      final _reg = RegExp(r'^[a-zA-Z0-9_]+$');
                      if (!_reg.hasMatch(value.trim()))
                        return "Use Combination of Alphabet, Number and Underscore";
                    }
                    return null;
                  },
                  onSaved: (data) {
                    _data['username'] = data.trim();
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email Address",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    contentPadding: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                      bottom: 10,
                    ),
                    // hintText: "Only underscore is allowed as special character",
                    // hintStyle: TextStyle(
                    //   fontWeight: FontWeight.bold,
                    // ),
                  ),
                  focusNode: _emailFocus,
                  onFieldSubmitted: (_) {
                    _emailFocus.unfocus();

                    FocusScope.of(context).requestFocus(_passwordFocus);
                  },
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  autovalidate: true,
                  validator: (value) {
                    if (_emailFocus.hasFocus) {
                      if (value == null) return "Please Enter Email Address";
                      if(!EmailValidator.validate(value.trim()))
                        return "Please Check your Email Address";
                    }
                    return null;
                  },
                  onSaved: (data) {
                    _data['email'] = data.trim();
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    contentPadding: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                      bottom: 10,
                    ),
                    hintText: "Password should be 8 character long",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  obscureText: true,
                  controller: _passwordController,
                  //readOnly: true,
                  toolbarOptions: ToolbarOptions(
                    copy: false,
                    cut: false,
                    paste: false,
                    selectAll: false,
                  ),
                  focusNode: _passwordFocus,
                  onFieldSubmitted: (_) {
                    _passwordFocus.unfocus();

                    FocusScope.of(context).requestFocus(_confirmPasswordFocus);
                  },
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  autovalidate: true,
                  validator: (value) {
                    if (_passwordFocus.hasFocus) {
                      if (value == null) return "Please Enter Passord";
                      if (value.length < 8)
                        return "Password should be atleast 8 character long";
                    }
                    return null;
                  },
                  onSaved: (data) {
                    _data['password'] = data.trim();
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    contentPadding: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                      bottom: 10,
                    ),
                    //hintText: "Password should be 8 character long",
                    // hintStyle: TextStyle(
                    //   fontWeight: FontWeight.bold,
                    // ),
                  ),
                  obscureText: true,
                  //readOnly: true,
                  toolbarOptions: ToolbarOptions(
                    copy: false,
                    cut: false,
                    paste: false,
                    selectAll: false,
                  ),
                  focusNode: _confirmPasswordFocus,
                  onFieldSubmitted: (_) {
                    _confirmPasswordFocus.unfocus();
                    _validateForm();
                    // _confirmFlag = true;
                  },
                  textInputAction: TextInputAction.done,
                  autocorrect: false,
                  autovalidate: true,
                  validator: (value) {
                    if (_confirmPasswordFocus.hasFocus) {
                      if (value == null) return "Please Enter Confirm Passord";
                      if (_passwordController.text != value)
                        return "Confirm Password Doesnot Match with the Password";
                    }
                    return null;
                  },
                  onSaved: (data) {
                    _data['password'] = data.trim();
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 30),
        SizedBox(
          height: 60,
          width: _mediaQuery.size.width * 0.70,
          child: RaisedButton(
            child: Text(
              "SIGN UP",
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
