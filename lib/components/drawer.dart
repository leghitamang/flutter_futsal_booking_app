import 'package:flutter/material.dart';
import 'package:nepsal/models/userModel.dart';
import 'package:nepsal/screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemDrawer extends StatefulWidget {
  final User user;
  ItemDrawer(this.user);
  @override
  _ItemDrawerState createState() => _ItemDrawerState();
}

class _ItemDrawerState extends State<ItemDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                accountName: Text(
                  widget.user.name,
                  style: TextStyle(fontSize: 20),
                ),
                accountEmail: Text(
                  widget.user.email,
                  style: TextStyle(fontSize: 16),
                ),
                currentAccountPicture: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen(widget.user)));
                  },
                  child: Hero(
                    tag: 'avatar',
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          'https://widgetwhats.com/app/uploads/2019/11/free-profile-photo-whatsapp-4.png'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.home, size: 30),
                title: Text('Home', style: TextStyle(fontSize: 18)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.person, size: 30),
                title: Text('Profile', style: TextStyle(fontSize: 18)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileScreen(widget.user)));
                },
              ),
              ListTile(
                leading: Icon(Icons.book, size: 30),
                title: Text('Bookings', style: TextStyle(fontSize: 18)),
                onTap: () {
                  Navigator.pushNamed(context, '/bookings');
                },
              ),
              ListTile(
                leading: Icon(Icons.history, size: 30),
                title: Text('History', style: TextStyle(fontSize: 18)),
                onTap: () {
                  Navigator.pushNamed(context, '/history');
                },
              ),
              ListTile(
                leading: Icon(Icons.delete_outline, size: 30),
                title: Text('Logout', style: TextStyle(fontSize: 18)),
                onTap: () {
                  _exitApp(context);
                },
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            height: 50,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.brightness_2),
                    onPressed: () {
                      print('dark mode');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      print('settings');
                    },
                  ),
                ]),
          )
        ],
      ),
    );
  }

  Future<bool> _exitApp(BuildContext context) {
    return showDialog(
          context: context,
          child: AlertDialog(
            // title: Text('Do you want to exit this application?'),
            content: Text('Are you sure you want to Logout?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  print("you choose no");
                  Navigator.of(context).pop(false);
                },
                child: Text('Cancel'),
              ),
              FlatButton(
                onPressed: () {
                  logout();
                },
                child: Text('Logout'),
              ),
            ],
          ),
        ) ??
        false;
  }

  logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('token');
    localStorage.remove('user');
    Navigator.pushReplacementNamed(context, '/login');
  }
}
