import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:StPaulUniversity/utils/constants.dart';

import 'all_assignments.dart';

class AddEditPageAssignments extends StatefulWidget {
  final List list;
  final int index;

  AddEditPageAssignments({this.list, this.index});

  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPageAssignments> {
  TextEditingController Assignment_Name = TextEditingController();
  TextEditingController Assignemt_Marks = TextEditingController();
  TextEditingController Assignment_Description = TextEditingController();

  bool editMode = false;

  addUpdateData() {
    if (editMode) {
      var url = APIConstants.ASSIGN_ROOT;
      var map = new Map<String, dynamic>();
      map["action"] = APIConstants.ASSIGN_EDIT_ACTION;
      map["id"] = widget.list[widget.index]['Assignment_ID'];
      map["Assignment_Name"] = Assignment_Name.text;
      map["Assignemt_Marks"] = Assignemt_Marks.text;
      map["Assignment_Description"] = Assignment_Description.text;

      http.post(url, body: map);

    } else {
      var url = APIConstants.ASSIGN_ROOT;
      var map = new Map<String, dynamic>();
      map["action"] = APIConstants.ASSIGN_ADD_ACTION;
      map["Assignment_Name"] = Assignment_Name.text;
      map["Assignemt_Marks"] = Assignemt_Marks.text;
      map["Assignment_Description"] = Assignment_Description.text;
      http.post(url, body: map);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      editMode = true;
      Assignment_Name.text = widget.list[widget.index]['Assignment_Name'];
      Assignemt_Marks.text = widget.list[widget.index]['Assignemt_Marks'];
      Assignment_Description.text = widget.list[widget.index]['Assignment_Description'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editMode ? 'Update' : 'Add Assignment'),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: Assignment_Name,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                labelText: 'Assignment Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: Assignemt_Marks,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                labelText: 'Assignemt Marks',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              controller: Assignment_Description,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                labelText: 'Description',
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
                    builder: (context) => AllAssignments(),
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
