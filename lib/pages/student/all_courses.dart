import 'dart:convert';

import 'package:StPaulUniversity/pages/home_page.dart';
import 'package:StPaulUniversity/pages/students_page.dart';
import 'package:StPaulUniversity/pages/widgets/lsscourses/AddEditCourses.dart';
import 'package:StPaulUniversity/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllCourses extends StatefulWidget {
  final String title = "Courses";
  @override
  _AllCoursesState createState() => _AllCoursesState();
}

class _AllCoursesState extends State<AllCourses> {
  Future getData() async {
    try {
      var url = APIConstants.COURSE_ROOT;
      var map = new Map<String, dynamic>();
      map['action'] = APIConstants.COURSE_GET_ACTION;
      var response = await http.post(url, body: map).timeout(
        Duration(seconds: 20),
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
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent,
        title: Text(widget.title),
        actions: <Widget>[
        IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new StudentPage()));
            },
          ),
        ],
      ),
      // body is the majority of the screen.
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
                  title: Text(list[index]['Course_Name']),
                  subtitle: Text(list[index]['Course_Description']),
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