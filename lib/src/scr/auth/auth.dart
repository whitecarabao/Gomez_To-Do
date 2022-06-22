import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:gomez_todo/src/scr/auth/auth_ctrl.dart';

import '../dash/dashboard.dart';
//import hive

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);

  final AuthCtrl _authCtrl = AuthCtrl();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _authCtrl,
        builder: (context, Widget? w) {
          if (_authCtrl.currUsr == null) {
            return AuthScr(_authCtrl);
          } else {
            return DashScreen(_authCtrl);
          }
        });
  }
}

class AuthScr extends StatefulWidget {
  final AuthCtrl auth;
  const AuthScr(
    this.auth, {
    Key? key,
  }) : super(key: key);

  @override
  State<AuthScr> createState() => _AuthScrState();
}

class _AuthScrState extends State<AuthScr> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _unCon = TextEditingController(),
      _pwdCon = TextEditingController();
  String prompts = '';
  AuthCtrl get _authCtrl => widget.auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication Zone'),
        backgroundColor: const Color(0xFF2C2C2C),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _unCon,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pwdCon,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                obscureText: true,
              ),

              //button for registration
              RaisedButton(
                child: Text('Register'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _authCtrl.register(_unCon.text, _pwdCon.text);
                  }
                },
              ),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _authCtrl.authenticate(_unCon.text, _pwdCon.text);
                  }
                },
                child: Text('Login'),
              ),
              Text(prompts),
            ],
          ),
        ),
      ),
    );
  }
}
