import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nepsal/utility.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: FractionallySizedBox(
              heightFactor: 0.4,
              child: Stack(
                children: <Widget>[
                  Container(color: Colors.black),
                  Positioned(
                    right: 20,
                    bottom: 100,
                    child: Hero(
                      tag: 'logo',
                      child: FlutterLogo(
                        size: 100,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: 0.65,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            contentPadding: EdgeInsets.all(8),
                          ),
                          controller: nameController,
                          validator: (input) =>
                              input.isEmpty ? 'Name Required' : null,
                        ),
                        SizedBox(height: 10),
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
                              } else if (!input.contains('@')) {
                                return 'Invalid Email';
                              }
                              return null;
                            }),
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
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Empty Password';
                            } else if (!(input.length > 8)) {
                              return 'The password must be at least 8 characters.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            contentPadding: EdgeInsets.all(8),
                          ),
                          controller: cpasswordController,
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Empty Password';
                            } else if (!(cpasswordController.text ==
                                passwordController.text)) {
                              return ' The password Confirmation doesnot match';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        FloatingActionButton(
                          child: Icon(Icons.arrow_forward),
                          elevation: 3,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              var details = {
                                'name': nameController.text,
                                'email': emailController.text,
                                'password': passwordController.text,
                                'confirmpassword': cpasswordController.text,
                              };
                              FocusScope.of(context).requestFocus(FocusNode());
                              register(details);
                            }
                          },
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Already have an account?'),
                            SizedBox(width: 5),
                            GestureDetector(
                              child: Text('Login',
                                  style: TextStyle(color: Colors.red)),
                              onTap: () {
                                print('register');
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
    );
  }

  register(details) async {
    setState(() {
      loading = true;
    });
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    try {
      var res = await http.post(Utility.url+'register',
          body: jsonEncode(details), headers: headers);
      setState(() {
        loading = false;
      });
      var parsedResponse = jsonDecode(res.body);
      print(parsedResponse);
      if (res.statusCode == 200) {
        String message = 'Registration Successfully';
        showDialog(
          context: context,
          builder: (_) => RegisterMsgAlert(message),
        );
      } else if (res.statusCode == 401) {
        String message = 'Invalid Credential';
        showDialog(
          context: context,
          builder: (_) => RegisterMsgAlert(message),
        );
      } else {
        String message = 'The email is already taken.';
        showDialog(
          context: context,
          builder: (_) => RegisterMsgAlert(message),
        );
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      String message = 'Network Connection Error!';
      showDialog(
        context: context,
        builder: (_) => RegisterMsgAlert(message),
      );
    }
  }
}

class RegisterMsgAlert extends StatelessWidget {
  final String message;
  RegisterMsgAlert(this.message);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(message),
    );
  }
}
