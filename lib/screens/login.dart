import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nepsal/utility.dart' as url;
import 'package:nepsal/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  DateTime backButtonPressTime;
  static const snackBarDuration = Duration(seconds: 3);

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final snackBar = SnackBar(
    content: Text('Press back again to leave'),
    duration: snackBarDuration,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: WillPopScope(
        onWillPop: () => onWillPop(context),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: FractionallySizedBox(
                  heightFactor: 0.6,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(color: Colors.black),
                      Hero(
                        tag: 'logo',
                        child: FlutterLogo(
                          size: 150,
                        ),
                      ),
                    ],
                  )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: 0.45,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                                contentPadding: EdgeInsets.all(8),
                              ),
                              controller: emailController,
                              validator: (input) {
                                if (input.isEmpty) {
                                  return 'Email Required';
                                }
                                else if(!input.contains('@')){
                                  return 'Invalid Email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                                contentPadding: EdgeInsets.all(8),
                              ),
                              controller: passwordController,
                              validator: (input) =>
                                  input.isEmpty ? 'Password Required' : null,
                            ),
                            SizedBox(height: 30),
                            FloatingActionButton(
                              child: Icon(Icons.arrow_forward),
                              elevation: 3,
                              onPressed: () {
                                check();
                                if (_formKey.currentState.validate()) {
                                  var details = {
                                    'email': emailController.text,
                                    'password': passwordController.text,
                                  };
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  login(details);
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Don\'t have an account?'),
                                SizedBox(width: 5),
                                GestureDetector(
                                  child: Text('SignUp',
                                      style: TextStyle(color: Colors.red)),
                                  onTap: () {
                                    print('register');
                                    Navigator.pushNamed(context, '/register');
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ),
            loading
                ? Container(
                    color: Colors.black54,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  check() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    print(localStorage.get('user'));
  }

  login(details) async {
    setState(() {
      loading = true;
    });

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };  
    try {
      var res = await http.post(Utility.url+'login',
          body: jsonEncode(details), headers: headers);

      setState(() {
        loading = false;
      });

      var body = jsonDecode(res.body);
      // print(body);

      if (res.statusCode == 200) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', body['token']);
        localStorage.setString('user', jsonEncode(body['user']));
        Navigator.pushReplacementNamed(context, '/home');
      } else if (res.statusCode == 401) {
        _showMsg('Invalid Email or Password');
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      print(e);
    }
  }

  //On double press exit applicaton
  Future<bool> onWillPop(BuildContext context) async {
    DateTime currentTime = DateTime.now();

    bool backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            currentTime.difference(backButtonPressTime) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = currentTime;
      _scaffoldKey.currentState.showSnackBar(snackBar);
      return false;
    }

    return true;
  }
}
