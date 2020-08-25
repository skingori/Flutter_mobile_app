import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:StPaulUniversity/utils/constants.dart';
import 'package:StPaulUniversity/pages/widgets/lsunit/all_units.dart';

class AddEditPageUnits extends StatefulWidget {
  final List list;
  final int index;

  AddEditPageUnits({this.list, this.index});

  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPageUnits> {
  TextEditingController Unit_Code= TextEditingController();
  TextEditingController Unit_Name= TextEditingController();
  TextEditingController Unit_Description= TextEditingController();

  bool editMode = false;

  addUpdateData() {
    if (editMode) {
      var url = APIConstants.UNIT_ROOT;
      var map = new Map<String, dynamic>();
      map["action"] = APIConstants.UNIT_EDIT_ACTION;
      map["id"] = widget.list[widget.index]['Unit_ID'];
      map["Unit_Code"] = Unit_Code.text;
      map["Unit_Name"] = Unit_Name.text;
      map["Unit_Description"] = Unit_Description.text;

      http.post(url, body: map);

    } else {
      var url = APIConstants.UNIT_ROOT;
      var map = new Map<String, dynamic>();
      map["action"] = APIConstants.UNIT_ADD_ACTION;
      map["Unit_Code"] = Unit_Code.text;
      map["Unit_Name"] = Unit_Name.text;
      map["Unit_Description"] = Unit_Description.text;
      http.post(url, body: map);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      editMode = true;
      Unit_Code.text = widget.list[widget.index]['Unit_Code'];
      Unit_Name.text = widget.list[widget.index]['Unit_Name'];
      Unit_Description.text = widget.list[widget.index]['Unit_Description'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editMode ? 'Update' : 'Add Unit'),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: Unit_Name,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                labelText: 'Unit Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: Unit_Code,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                labelText: 'Unit Code',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              controller: Unit_Description,
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
