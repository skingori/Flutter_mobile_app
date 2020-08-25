import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:StPaulUniversity/utils/constants.dart';
import 'package:StPaulUniversity/pages/widgets/lsunit/all_units.dart';

class AddEditPageStudentUnit extends StatefulWidget {
  final List list;
  final int index;

  AddEditPageStudentUnit({this.list, this.index});

  @override
  _AddEditPageStudentUnitState createState() => _AddEditPageStudentUnitState();
}

class _AddEditPageStudentUnitState extends State<AddEditPageStudentUnit> {
  TextEditingController Unit_Student_Student_ID = TextEditingController();
  TextEditingController Unit_Student_Unit_ID = TextEditingController();

  bool editMode = false;

  addUpdateData() {
    if (editMode) {
      var url = APIConstants.UNIT_ROOT;
      var map = new Map<String, dynamic>();
      map["action"] = APIConstants.UNIT_EDIT_ACTION;
      map["id"] = widget.list[widget.index]['Unit_ID'];
      map["Unit_Student_Student_ID"] = Unit_Student_Student_ID.text;
//      map["Unit_Student_Unit_ID"] = Unit_Student_Unit_ID.text;

      http.post(url, body: map);

    } else {
      var url = APIConstants.STUDENT_UNIT_ROOT;
      var map = new Map<String, dynamic>();
      map["action"] = APIConstants.STUDENT_UNIT_ADD_ACTION;
      map["Unit_Student_Student_ID"] = Unit_Student_Student_ID.text;
      map["Unit_Student_Unit_ID"] = Unit_Student_Unit_ID.text;
      http.post(url, body: map);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      editMode = true;
//      editMode = true;
//      Unit_Code.text = widget.list[widget.index]['Unit_Code'];
//      Unit_Name.text = widget.list[widget.index]['Unit_Name'];
//      Unit_Description.text = widget.list[widget.index]['Unit_Description'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editMode ? 'Update' : 'Add Student to unit'),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: Unit_Student_Student_ID,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                labelText: 'Student ID',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: Unit_Student_Unit_ID,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                labelText: 'Unit ID',
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
                    builder: (context) => AllUnits(),
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
