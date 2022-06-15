import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterloginapp/services/auth.dart';
import 'package:flutterloginapp/shared/constants.dart';
import 'package:flutterloginapp/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({ this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  // text field state
  String email = '';
  String pass = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in Here'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (val) => val.length < 6 ? 'Password must be 6 or more characters' : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      pass = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text('Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.signInWithEmailAndPassword(email, pass);
                      if (result == null) {
                        setState(() {
                          error = 'Wrong Email or Password';
                          loading = false;
                        });
                      }
                    }
                  }
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
        ),
      ),
    );
  }
}
