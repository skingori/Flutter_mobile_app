import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:StPaulUniversity/utils/constants.dart';

import 'all_students.dart';

class AddEditPageStudents extends StatefulWidget {
  final List list;
  final int index;

  AddEditPageStudents({this.list, this.index});

  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPageStudents> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController stdnumber = TextEditingController();
  TextEditingController gender = TextEditingController();

  bool editMode = false;

  addUpdateData() {
    if (editMode) {
      var url = APIConstants.STUDENT_ROOT;
      var map = new Map<String, dynamic>();
      map["action"] = APIConstants.STUDENT_EDIT_ACTION;
      map["id"] = widget.list[widget.index]['Student_ID'];
      map["fistname"] = firstName.text;
      map["lastname"] = lastName.text;
      map["stdnumber"] = stdnumber.text;
      map["gender"] = gender.text;
      map["action"] = "EDIT_STUDENT";

      http.post(url, body: map);

    } else {
      var url = APIConstants.STUDENT_ROOT;
      var map = new Map<String, dynamic>();
      map["action"] = APIConstants.STUDENTS_ADD_ACTION;
      map["fistname"] = firstName.text;
      map["lastname"] = lastName.text;
      map["stdnumber"] = stdnumber.text;
      map["gender"] = gender.text;
      http.post(url, body: map);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      editMode = true;
      firstName.text = widget.list[widget.index]['Student_FirstName'];
      lastName.text = widget.list[widget.index]['Student_LastName'];
      stdnumber.text = widget.list[widget.index]['Student_AdmissionNumber'];
      gender.text = widget.list[widget.index]['Student_Gender'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editMode ? 'Update' : 'Add Student'),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: firstName,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                labelText: 'First Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: lastName,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                labelText: 'Last Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: stdnumber,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                labelText: 'Admission Number',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: gender,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                labelText: 'Gender',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  addUpdateData();
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllStudents(),
                  ),
                );

                debugPrint('Clicked RaisedButton Button');
              },
              color: Colors.redAccent,
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              child: Text(
                editMode ? 'Update' : 'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),

          ),
        ],
      ),
    );
  }
}
