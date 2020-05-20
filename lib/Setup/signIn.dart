import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator:(input) {
                if(input.isEmpty){
                  return 'Please type an email';
                }
              } ,
              onSaved:(input) => _email = input,
              decoration: InputDecoration(
                labelText: 'Email'
              ),
            ),
             TextFormField(
              validator:(input) {
                if(input.length<6){
                  return 'Password should be at least 6 characters!';
                }
              } ,
              onSaved:(input) => _password = input,
              decoration: InputDecoration(
                labelText: 'Password',
            
              ),
              obscureText: true,
            ),
            RaisedButton(onPressed: () {},
            child: Text('Sign in'))
          ],
        ),
      ),
    );



  }


  void signIn() {
    final formState=_formKey.currentState;
    if(formState.validate()){
      
    }
  }
}