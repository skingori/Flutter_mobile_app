import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:StPaulUniversity/utils/constants.dart';
import 'package:StPaulUniversity/pages/widgets/lsscourses/all_courses.dart';

class AddEditPageCourses extends StatefulWidget {
  final List list;
  final int index;

  AddEditPageCourses({this.list, this.index});

  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPageCourses> {
  TextEditingController Course_Name = TextEditingController();
  TextEditingController Course_Description = TextEditingController();

  bool editMode = false;

  addUpdateData() {
    if (editMode) {
      var url = APIConstants.COURSE_ROOT;
      var map = new Map<String, dynamic>();
      map["action"] = APIConstants.COURSE_EDIT_ACTION;
      map["id"] = widget.list[widget.index]['Course_ID'];
      map["Course_Name"] = Course_Name.text;
      map["Course_Description"] = Course_Description.text;

      http.post(url, body: map);

    } else {
      var url = APIConstants.COURSE_ROOT;
      var map = new Map<String, dynamic>();
      map["action"] = APIConstants.COURSE_ADD_ACTION;
      map["Course_Name"] = Course_Name.text;
      map["Course_Description"] = Course_Description.text;
      http.post(url, body: map);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      editMode = true;
      Course_Name.text = widget.list[widget.index]['Course_Name'];
      Course_Description.text = widget.list[widget.index]['Course_Description'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editMode ? 'Update' : 'Add Course'),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: Course_Name,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                labelText: 'Course Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: Course_Description,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                labelText: 'Decription',
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
                    builder: (context) => AllCourses(),
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
