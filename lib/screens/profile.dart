import 'package:flutter/material.dart';
import 'package:nepsal/components/profileImage.dart';
import 'package:nepsal/models/userModel.dart';
import 'package:nepsal/screens/editProfile.dart';


class ProfileScreen extends StatelessWidget {
  final User user;
  ProfileScreen(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: TextStyle(color: Colors.black),
          ),
          // centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.edit,
                  size: 25,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfileScreen(user)),
                  );
                }),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(           
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    ProfileImage(),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(user.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(width: 5),
                        Icon(Icons.check_circle_outline,color: Colors.green)
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        RichText(
                          // textAlign: TextAlign.left,
                          text: TextSpan(children: [
                            TextSpan(
                              text: '1 ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: 'Bookings',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            )
                          ]),
                        ),
                        RichText(
                          // textAlign: TextAlign.left,
                          text: TextSpan(children: [
                            TextSpan(
                              text: '3 ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: 'Match Played',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            )
                          ]),
                        ),
                        
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color.fromRGBO(255, 45, 85, 1),
                        child: Icon(Icons.person_outline, color: Colors.white),
                      ),
                      title: Text((user.name)),
                      subtitle: Text('Name'),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color.fromRGBO(255, 45, 85, 1),
                        child: Icon(Icons.email, color: Colors.white),
                      ),
                      title: Text((user.email)),
                      subtitle: Text('Email'),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color.fromRGBO(255, 45, 85, 1),
                        child: Icon(Icons.phone, color: Colors.white),
                      ),
                      title: Text((user.contact == null
                          ? 'Not Included'
                          : user.contact)),
                      subtitle: Text('Contact No'),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color.fromRGBO(255, 45, 85, 1),
                        child: Icon(Icons.location_on, color: Colors.white),
                      ),
                      title: Text((user.address == null
                          ? 'Not Included'
                          : user.address)),
                      subtitle: Text('Address'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
