import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:StPaulUniversity/pages/home_page.dart';
import 'package:StPaulUniversity/utils/constants.dart';

class AddEditPage extends StatefulWidget {
  final List list;
  final int index;
  AddEditPage({this.list, this.index});
  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();

  bool editMode = false;

  addUpdateData() {
    if (editMode) {
      var url = APIConstants.API_EDIT_LECTURER;
      http.post(url, body: {
        'id': widget.list[widget.index]['Lecturer_ID'],
        'fistname': firstName.text,
        'lastname': lastName.text,
        'phone': phone.text,
        'email': email.text,
      });
    } else {
      var url = APIConstants.API_ADD_LECTURERS;
      http.post(url, body: {
        'fistname': firstName.text,
        'lastname': lastName.text,
        'phone': phone.text,
        'email': email.text,
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      editMode = true;
      firstName.text = widget.list[widget.index]['Lecturer_FirstName'];
      lastName.text = widget.list[widget.index]['Lecturer_LastName'];
      phone.text = widget.list[widget.index]['Lecturer_Mobile'];
      email.text = widget.list[widget.index]['Lecturer_Email'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editMode ? 'Update' : 'Add lecturer'),
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
              controller: phone,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                labelText: 'Phone',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                labelText: 'Email',
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
                    builder: (context) => HomePage(),
                  ),
                );

                debugPrint('Clicked RaisedButton Button');
              },
              color: Colors.redAccent,
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
