import 'dart:convert';

import 'package:StPaulUniversity/pages/widgets/lsunit/all_units.dart';
import 'package:StPaulUniversity/pages/widgets/unitstudent/AddEditStudentUnit.dart';
import 'package:StPaulUniversity/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllStudentUnit extends StatefulWidget {
  final String title = "Registered students";

  final List list;
  final int index;

  AllStudentUnit({this.list, this.index});
  @override
  _AllStudentUnitState createState() => _AllStudentUnitState();
}

class _AllStudentUnitState extends State<AllStudentUnit> {
  Future getData() async {
    try {
      var url = APIConstants.STUDENT_UNIT_ROOT;
      var map = new Map<String, dynamic>();
      map['action'] = APIConstants.STUDENT_UNIT_GET_ACTION;
      map['id'] = widget.list[widget.index]['Unit_ID'];
      debugPrint(widget.list[widget.index]['Unit_ID']);
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
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new AllUnits()));
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
                  leading: GestureDetector(
                    child: Icon(Icons.account_circle),
                  ),
                  title: Text(list[index]['Unit_Student_Student_ID']),
                  subtitle: Text(list[index]['Unit_Student_Unit_ID']),
                  trailing: GestureDetector(
                    child: Icon(Icons.delete),
                    onTap: () {
                      setState(() {
                        var map = new Map<String, dynamic>();
                        map['action'] = APIConstants.STUDENT_UNIT_DELETE_ACTION;
                        map['id'] = list[index]['Unit_Student_ID'];
                        var url = APIConstants.STUDENT_UNIT_ROOT;
                        http.post(url, body:map);
                      });

                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Deleted"),
                        backgroundColor: Colors.red,
                      ));
                      debugPrint('delete Clicked');
                    },
                  ),
                );
              })
              : Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditPageStudentUnit(),
            ),
          );
          debugPrint('Clicked FloatingActionButton Button');
        },
      ),
    );
  }
}