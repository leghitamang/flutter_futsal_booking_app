import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:nepsal/models/userModel.dart';
import 'package:nepsal/screens/profile.dart';
import 'package:nepsal/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditProfileScreen extends StatefulWidget {
  final User user;
  EditProfileScreen(this.user);
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool loading = false;

  Future<File> file;

  String status = '';

  String base64Image;

  File tmpFile;

  String errMsg = 'Error Uploading Image';

  selectImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  Widget showImage() {
    return FutureBuilder(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return CircleAvatar(
              radius: 80,
              child: Image.file(
                snapshot.data,
                fit: BoxFit.cover,
              ));
        } else if (snapshot.error != null) {
          return CircleAvatar(
            radius: 80,
            backgroundColor: Colors.red,
          );
        } else {
          return CircleAvatar(
            radius: 80,
            backgroundImage: NetworkImage(
                'https://cdn1.vectorstock.com/i/1000x1000/20/65/man-avatar-profile-vector-21372065.jpg'),
          );
        }
      },
    );
  }

  uploadImage() {
    Timer(Duration(seconds: 3), setStatus('Uploading....'));
    if (tmpFile == null) {
      setStatus(errMsg);
    } else {
      //http request for uploading image.
      setStatus('Upload Successfull.');
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Edit Profile',
            style: TextStyle(color: Colors.black),
          ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(5),
                        // color: Colors.orange,
                        child: showImage(),
                      ),
                      ClipOval(
                        child: Container(
                          color: Colors.red,
                          child: IconButton(
                            color: Colors.white,
                            iconSize: 25,
                            icon: Icon(Icons.camera_alt),
                            onPressed: selectImage,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration:
                              InputDecoration(hintText: widget.user.name),
                          controller: nameController,
                          validator: (input) =>
                              input.isEmpty ? 'Name Required' : null,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                            decoration: InputDecoration(
                              hintText: widget.user.address,
                            ),
                            controller: addressController,
                            validator: (input) =>
                                input.isEmpty ? 'Adress Required' : null),
                        SizedBox(height: 10),
                        TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: widget.user.contact,
                            ),
                            controller: contactController,
                            validator: (input) =>
                                input.isEmpty ? 'Contact Required' : null),
                        SizedBox(height: 40),
                        Container(
                          height: 45,
                          width: double.infinity,
                          child: RaisedButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            child: Text(
                              'Update',
                              style: TextStyle(fontSize: 18),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                var details = {
                                  'name': nameController.text,
                                  'address': addressController.text,
                                  'contact': contactController.text,
                                };
                                updateProfile(details);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
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

  updateProfile(Map data) async {
    setState(() {
      loading = true;
    });
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    Map userDetails = jsonDecode(localStorage.get('user'));
    data['id'] = userDetails['id'].toString();
    print(data);
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    try {
      var res = await http.patch(Utility.url+'user/update',
          body: jsonEncode(data), headers: headers);

      print(res.body);
      if (res.statusCode == 200) {
        var resMsg = jsonDecode(res.body);
        print(resMsg['user']);
        var userData = User(
          id: resMsg['user']['id'],
          name: resMsg['user']['name'],
          email: resMsg['user']['email'],
          address: resMsg['user']['address'],
          contact: resMsg['user']['contact'],
        );
        // localStorage.remove('user');
        localStorage.setString('user', jsonEncode(resMsg['user']));
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProfileScreen(userData)));
      } else if (res.statusCode == 404) {
        String message = 'Invalid Credential';
        showDialog(
          context: context,
          builder: (_) => UserUpdateAlert(message),
        );
      }

      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      print(e);
    }
  }
}

class UserUpdateAlert extends StatelessWidget {
  final String message;
  UserUpdateAlert(this.message);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(message),
    );
  }
}
