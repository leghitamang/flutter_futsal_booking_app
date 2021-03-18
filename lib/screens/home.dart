import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nepsal/components/arenaLists.dart';
import 'package:nepsal/components/drawer.dart';
import 'package:nepsal/components/searchbutton.dart';
import 'package:http/http.dart' as http;
import 'package:nepsal/models/arenaModel.dart';
import 'package:nepsal/models/userModel.dart';
import 'package:nepsal/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;
  List<Arena> arenas = [];
  var user;
  @override
  void initState() {
    super.initState();
    getData();
  }

  DateTime backButtonPressTime;
  static const snackBarDuration = Duration(seconds: 3);

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final snackBar = SnackBar(
    content: Text('Press back again to leave'),
    duration: snackBarDuration,
  );

  getData() async {
    setState(() {
      loading = true;
    });
    try {
      var response = await http.get(Utility.url+'arenas');
      var body = response.body;
      var parsedData = jsonDecode(body);
      print(parsedData['data']);

      for (var each in parsedData['data']) {
        arenas.add(Arena.fromJson(each));
      }
      print(arenas);

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var userData = localStorage.get('user');
      Map userDetails = jsonDecode(userData);
      user = User(
        id: userDetails['id'],
        name: userDetails['name'],
        email: userDetails['email'],
        address: userDetails['address'],
        contact: userDetails['contact'],
      );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Arenas', style: TextStyle(fontSize: 22)),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.filter_list), onPressed: () {}),
          SearchButton(),
        ],
      ),
      drawer: ItemDrawer(user),
      body: WillPopScope(
        onWillPop: () => onWillPop(context),
        child: loading
            ? Center(child: CircularProgressIndicator())
            : ArenaList(arenas),
      ),
    );
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
