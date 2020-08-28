import 'dart:async';
import 'dart:convert';

import 'package:StPaulUniversity/pages/splash_page.dart';
import 'package:StPaulUniversity/pages/widgets/lsstudents/all_students.dart';
import 'package:flutter/material.dart';
//import 'package:StPaulUniversity/customviews/progress_dialog.dart';
//import 'package:StPaulUniversity/futures/app_futures.dart';
import 'package:StPaulUniversity/models/User.dart';
//import 'package:StPaulUniversity/models/base/EventObject.dart';
import 'package:StPaulUniversity/utils/app_shared_preferences.dart';
import 'package:StPaulUniversity/utils/constants.dart';
import 'package:StPaulUniversity/pages/student/all_courses.dart';
import 'package:StPaulUniversity/pages/student/all_assignments.dart';
import 'package:StPaulUniversity/pages/student/all_units.dart';
import 'package:http/http.dart' as http;

class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => new _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final globalKey = new GlobalKey<ScaffoldState>();

  User user;

//------------------------------------------------------------------------------

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (user == null) {
      await initUserProfile();
    }
  }

//  ----------------------------------------------------------------------------
  Future getData() async {
    try {
      var url = APIConstants.API_GET_LECTURERS;
      var response = await http.get(url).timeout(
        Duration(seconds: 25),
        onTimeout: () {
          // time has run out, do what you wanted to do
          return null;
        },
      );
      return json.decode(response.body);
    } catch (e) {
      debugPrint('Check your internet');
    }
  }
//------------------------------------------------------------------------------

  Future<void> initUserProfile() async {
    User up = await AppSharedPreferences.getUserProfile();
    setState(() {
      user = up;
    });
  }

  String currentProfilePic = "";
  String otherProfilePic = "";

  void switchAccounts() {
    String picBackup = currentProfilePic;
    this.setState(() {
      currentProfilePic = otherProfilePic;
      otherProfilePic = picBackup;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(((user == null) ? "User Name" : user.email)),
        backgroundColor: Colors.redAccent,
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountEmail:
              new Text(((user == null) ? "User Name" : user.email)),
              accountName: new Text(((user == null) ? "User Name" : '')),
              currentAccountPicture: new GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.brown.shade800,
                  child:
                  Text(((user == null) ? "U" : user.email[0].toUpperCase())),
                ),
              ),
              decoration: new BoxDecoration(color: Colors.redAccent),
            ),
            new ListTile(
                title: new Text("Courses"),
                trailing: new Icon(Icons.library_books),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new AllCourses()));
                }),
            new ListTile(
                title: new Text("Units"),
                trailing: new Icon(Icons.book),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new AllUnits()));
                }),
            new ListTile(
                title: new Text("Assignments"),
                trailing: new Icon(Icons.assignment),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new AllAssignments()));
                }),
            new Divider(),
            new ListTile(
              title: new Text("Logout"),
              trailing: new Icon(Icons.exit_to_app),
              onTap: () {
                AppSharedPreferences.clear();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new SplashPage()));
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                List list = snapshot.data;
                return ListTile(
                  title: Text(list[index]['Lecturer_LastName']),
                  subtitle: Text(list[index]['Lecturer_Email']),
                );
              })
              : Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
