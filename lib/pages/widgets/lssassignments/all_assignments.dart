import 'dart:convert';

import 'package:StPaulUniversity/pages/home_page.dart';
import 'package:StPaulUniversity/pages/widgets/lssassignments/AddEditAssignments.dart';
import 'package:StPaulUniversity/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllAssignments extends StatefulWidget {
  final String title = "Assignments";
  @override
  _AllAssignmentsState createState() => _AllAssignmentsState();
}

class _AllAssignmentsState extends State<AllAssignments> {
  Future getData() async {
    try {
      var url = APIConstants.ASSIGN_ROOT;
      var map = new Map<String, dynamic>();
      map['action'] = APIConstants.ASSIGN_GET_ACTION;
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
                  builder: (BuildContext context) => new HomePage()));
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
                    child: Icon(Icons.edit),
                    onLongPress: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddEditPageAssignments(
                            list: list,
                            index: index,
                          ),
                        ),
                      );
                      debugPrint("Edit not printed");
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddEditPageAssignments(
                            list: list,
                            index: index,
                          ),
                        ),
                      );
                      debugPrint('Edit Clicked');
                    },
                  ),
                  title: Text(list[index]['Assignment_Name']),
                  subtitle: Text(list[index]['Assignment_Description']),
                  trailing: GestureDetector(
                    child: Icon(Icons.delete),
                    onTap: () {
                      setState(() {
                        var map = new Map<String, dynamic>();
                        map['action'] = APIConstants.ASSIGN_DELETE;
                        map['id'] = list[index]['Assignment_ID'];
                        var url = APIConstants.ASSIGN_ROOT;
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
              builder: (context) => AddEditPageAssignments(),
            ),
          );
          debugPrint('Clicked FloatingActionButton Button');
        },
      ),
    );
  }
}