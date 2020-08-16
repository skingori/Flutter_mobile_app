import 'dart:async';
import 'dart:convert';

import 'package:StPaulUniversity/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:StPaulUniversity/customviews/progress_dialog.dart';
import 'package:StPaulUniversity/futures/app_futures.dart';
import 'package:StPaulUniversity/models/User.dart';
import 'package:StPaulUniversity/models/base/EventObject.dart';
import 'package:StPaulUniversity/utils/app_shared_preferences.dart';
import 'package:StPaulUniversity/utils/constants.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  @override
//  createState() => new HomePageState();
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final globalKey = new GlobalKey<ScaffoldState>();

  User user;

  TextEditingController oldPasswordController =
      new TextEditingController(text: "");

  TextEditingController newPasswordController =
      new TextEditingController(text: "");

//------------------------------------------------------------------------------

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (user == null) {
      await initUserProfile();
    }
  }
//  ----------------------------------------------------------------------------
  Future getData()async{
    var url = 'http://192.168.1.104/php-mysql-flutter-crud/read.php';
    var response = await http.get(url);
    return json.decode(response.body);
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
          title: new Text(((user == null) ? "User Name" : user.name)),
          backgroundColor: Colors.redAccent,
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountEmail:
                    new Text(((user == null) ? "User Name" : user.email)),
                accountName:
                    new Text(((user == null) ? "User Name" : user.name)),
                currentAccountPicture: new GestureDetector(
                  child: new CircleAvatar(
                    backgroundColor: Colors.brown.shade800,
                    child: Text(
                        ((user == null) ? "U" : user.name[0].toUpperCase())),
                  ),
//                  onTap: () => print("This is your current account."),
                ),
//                otherAccountsPictures: <Widget>[
//                  new GestureDetector(
//                    child: new CircleAvatar(
//                      backgroundImage: new NetworkImage(otherProfilePic),
//                    ),
//                    onTap: () => switchAccounts(),
//                  ),
//                ],
                decoration: new BoxDecoration(color: Colors.redAccent
//                    image: new DecorationImage(
//                        image: new NetworkImage("https://img00.deviantart.net/35f0/i/2015/018/2/6/low_poly_landscape__the_river_cut_by_bv_designs-d8eib00.jpg"),
//                        fit: BoxFit.fill
//                    )
                    ),
              ),
              new ListTile(
                  title: new Text("Students"),
                  trailing: new Icon(Icons.supervised_user_circle),
                  onTap: () {
                    Navigator.of(context).pop();
//                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("First Page")));
                  }),
              new ListTile(
                  title: new Text("Lectures"),
                  trailing: new Icon(Icons.folder_open),
                  onTap: () {
                    Navigator.of(context).pop();
//                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("Second Page")));
                  }),
              new ListTile(
                  title: new Text("Courses"),
                  trailing: new Icon(Icons.library_books),
                  onTap: () {
                    Navigator.of(context).pop();
//                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("Second Page")));
                  }),
              new ListTile(
                  title: new Text("Assignments"),
                  trailing: new Icon(Icons.assignment_return),
                  onTap: () {
                    Navigator.of(context).pop();
//                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("Second Page")));
                  }),
              new Divider(),
              new ListTile(
                title: new Text("Change password"),
                trailing: new Icon(Icons.visibility_off),
                onTap: () => Navigator.pop(context),
              ),
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
//        bottomNavigationBar: BottomNavigationBar(
////          onTap: onTabTapped, // new
////          currentIndex: _currentIndex, // new
//          items: [
//            new BottomNavigationBarItem(
//              icon: Icon(Icons.supervised_user_circle),
//              title: Text('Students'),
//            ),
//            new BottomNavigationBarItem(
//              icon: Icon(Icons.library_books),
//              title: Text('Courses'),
//            ),
//            new BottomNavigationBarItem(
//                icon: Icon(Icons.folder_open),
//                title: Text('Lectures')
//            )
//          ],
//        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
//            Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditPage(),),);
            debugPrint('Clicked FloatingActionButton Button');
          },
        ),
//        body: new Center(
//          child: new Text("Welcome home", style: new TextStyle(fontSize: 35.0)),
//
//        )
      body: FutureBuilder(
        future: getData(),
        builder: (context,snapshot){
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context,index){
                List list = snapshot.data;
                return ListTile(
                  leading: GestureDetector(child: Icon(Icons.edit),
                    onTap: (){
//                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditPage(list: list,index: index,),),);
                      debugPrint('Edit Clicked');
                    },),
                  title: Text(list[index]['lastname']),
                  subtitle: Text(list[index]['phone']),
                  trailing: GestureDetector(child: Icon(Icons.delete),
                    onTap: (){
                      setState(() {
                        var url = 'http://192.168.1.104/php-mysql-flutter-crud/delete.php';
                        http.post(url,body: {
                          'id' : list[index]['id'],
                        });
                      });
                      debugPrint('delete Clicked');
                    },),
                );
              }
          )
              : CircularProgressIndicator(
            backgroundColor: Colors.white,
          );
        },
      ),
    );
  }
}

//class HomePageState extends State<HomePage> {
//  final globalKey = new GlobalKey<ScaffoldState>();
//
//  User user;
//
//  TextEditingController oldPasswordController =
//      new TextEditingController(text: "");
//
//  TextEditingController newPasswordController =
//      new TextEditingController(text: "");
//
////------------------------------------------------------------------------------
//
//  @override
//  Future<void> didChangeDependencies() async {
//    super.didChangeDependencies();
//    if (user == null) {
//      await initUserProfile();
//    }
//  }
//
////------------------------------------------------------------------------------
//
//  Future<void> initUserProfile() async {
//    User up = await AppSharedPreferences.getUserProfile();
//    setState(() {
//      user = up;
//    });
//  }
//
////------------------------------------------------------------------------------
//
//  static ProgressDialog progressDialog = ProgressDialog.getProgressDialog(
//      ProgressDialogTitles.USER_CHANGE_PASSWORD);
//
////------------------------------------------------------------------------------
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      key: globalKey,
//      body: new Stack(
//        children: <Widget>[homeText(), progressDialog],
//      ),
//    );
//  }
//
////------------------------------------------------------------------------------
//
//  void _logoutFromTheApp() {
//    AppSharedPreferences.clear();
//    setState(() {
//      Navigator.pushReplacement(
//        context,
//        new MaterialPageRoute(builder: (context) => new SplashPage()),
//      );
//    });
//  }
//
////------------------------------------------------------------------------------
//
//  Widget homeText() {
//    return Container(
//        height: double.infinity,
//        width: double.infinity,
//        child: new Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          mainAxisSize: MainAxisSize.max,
//          children: <Widget>[
//            new Container(
//              child: new Text(
//                "Welcome : " + ((user == null) ? "User Name" : user.name),
//                style: new TextStyle(color: Colors.pink, fontSize: 26.0),
//              ),
//              margin: EdgeInsets.only(bottom: 10.0),
//            ),
//            new Container(
//              margin: EdgeInsets.only(bottom: 10.0),
//              child: new Text(
//                ((user == null) ? "User Email" : user.email),
//                style: new TextStyle(color: Colors.grey, fontSize: 22.0),
//              ),
//            ),
//            new Container(
//              margin: EdgeInsets.only(bottom: 10.0),
//              child: new Text(
//                ((user == null) ? "User Unique Id" : user.unique_id),
//                style: new TextStyle(color: Colors.grey, fontSize: 22.0),
//              ),
//            ),
//            new Container(
//              margin: EdgeInsets.only(bottom: 10.0),
//              decoration: new BoxDecoration(color: Colors.blue[400]),
//              child: new MaterialButton(
//                textColor: Colors.white,
//                padding: EdgeInsets.all(15.0),
//                onPressed: () {
//                  showDialog(
//                      barrierDismissible: false,
//                      context: globalKey.currentContext,
//                      child: _changePasswordDialog());
//                },
//                child: new Text(
//                  Texts.CHANGE_PASSWORD,
//                  style: new TextStyle(
//                      fontWeight: FontWeight.bold, fontSize: 16.0),
//                ),
//              ),
//            ),
//            new Container(
//              decoration: new BoxDecoration(color: Colors.blue[400]),
//              child: new MaterialButton(
//                textColor: Colors.white,
//                padding: EdgeInsets.all(15.0),
//                onPressed: () {
//                  showDialog(
//                      barrierDismissible: false,
//                      context: globalKey.currentContext,
//                      child: _logOutDialog());
//                },
//                child: new Text(
//                  Texts.LOGOUT,
//                  style: new TextStyle(
//                      fontWeight: FontWeight.bold, fontSize: 16.0),
//                ),
//              ),
//            ),
//          ],
//        ));
//  }
//
////------------------------------------------------------------------------------
//
//  Widget _logOutDialog() {
//    return new AlertDialog(
//      title: new Text(
//        "Logout",
//        style: new TextStyle(color: Colors.blue[400], fontSize: 20.0),
//      ),
//      content: new Text(
//        "Are you sure you want to Logout from the App",
//        style: new TextStyle(color: Colors.grey, fontSize: 20.0),
//      ),
//      actions: <Widget>[
//        new FlatButton(
//          child: new Text("OK",
//              style: new TextStyle(color: Colors.blue[400], fontSize: 20.0)),
//          onPressed: () {
//            AppSharedPreferences.clear();
//            Navigator.pushReplacement(
//              globalKey.currentContext,
//              new MaterialPageRoute(builder: (context) => new SplashPage()),
//            );
//          },
//        ),
//        new FlatButton(
//          child: new Text("Cancel",
//              style: new TextStyle(color: Colors.blue[400], fontSize: 20.0)),
//          onPressed: () {
//            Navigator.of(globalKey.currentContext).pop();
//          },
//        ),
//      ],
//    );
//  }
//
////------------------------------------------------------------------------------
//
//  Widget _changePasswordDialog() {
//    return new AlertDialog(
//      title: new Text(
//        "Change Password",
//        style: new TextStyle(color: Colors.blue[400], fontSize: 20.0),
//      ),
//      content: new Container(
//        child: new Form(
//            child: new Theme(
//                data: new ThemeData(primarySwatch: Colors.pink),
//                child: new Column(
//                  mainAxisSize: MainAxisSize.min,
//                  children: <Widget>[
//                    new Container(
//                        child: new TextFormField(
//                          controller: oldPasswordController,
//                          decoration: InputDecoration(
//                              suffixIcon: new Icon(
//                                Icons.vpn_key,
//                                color: Colors.pink,
//                              ),
//                              labelText: Texts.OLD_PASSWORD,
//                              labelStyle: TextStyle(fontSize: 18.0)),
//                          keyboardType: TextInputType.text,
//                          obscureText: true,
//                        ),
//                        margin: EdgeInsets.only(bottom: 10.0)),
//                    new Container(
//                        child: new TextFormField(
//                          controller: newPasswordController,
//                          decoration: InputDecoration(
//                              suffixIcon: new Icon(
//                                Icons.vpn_key,
//                                color: Colors.pink,
//                              ),
//                              labelText: Texts.NEW_PASSWORD,
//                              labelStyle: TextStyle(fontSize: 18.0)),
//                          keyboardType: TextInputType.text,
//                          obscureText: true,
//                        ),
//                        margin: EdgeInsets.only(bottom: 10.0)),
//                  ],
//                ))),
//      ),
//      actions: <Widget>[
//        new FlatButton(
//          child: new Text("OK",
//              style: new TextStyle(color: Colors.blue[400], fontSize: 20.0)),
//          onPressed: () {
//            if (oldPasswordController.text == "") {
//              globalKey.currentState.showSnackBar(new SnackBar(
//                content: new Text(SnackBarText.ENTER_OLD_PASS),
//              ));
//              return;
//            }
//
//            if (newPasswordController.text == "") {
//              globalKey.currentState.showSnackBar(new SnackBar(
//                content: new Text(SnackBarText.ENTER_NEW_PASS),
//              ));
//              return;
//            }
//
//            FocusScope.of(globalKey.currentContext)
//                .requestFocus(new FocusNode());
//            Navigator.of(globalKey.currentContext).pop();
//            progressDialog.showProgress();
//            _changePassword(user.email, oldPasswordController.text,
//                newPasswordController.text);
//          },
//        ),
//        new FlatButton(
//          child: new Text("Cancel",
//              style: new TextStyle(color: Colors.blue[400], fontSize: 20.0)),
//          onPressed: () {
//            Navigator.of(globalKey.currentContext).pop();
//          },
//        ),
//      ],
//    );
//  }
//
////------------------------------------------------------------------------------
//
//  void _changePassword(
//      String emailID, String oldPassword, String newPassword) async {
//    EventObject eventObject =
//        await changePassword(emailID, oldPassword, newPassword);
//    switch (eventObject.id) {
//      case EventConstants.CHANGE_PASSWORD_SUCCESSFUL:
//        {
//          setState(() {
//            oldPasswordController.text = "";
//            newPasswordController.text = "";
//            globalKey.currentState.showSnackBar(new SnackBar(
//              content: new Text(SnackBarText.CHANGE_PASSWORD_SUCCESSFUL),
//            ));
//            progressDialog.hideProgress();
//          });
//        }
//        break;
//      case EventConstants.CHANGE_PASSWORD_UN_SUCCESSFUL:
//        {
//          setState(() {
//            oldPasswordController.text = "";
//            newPasswordController.text = "";
//            globalKey.currentState.showSnackBar(new SnackBar(
//              content: new Text(SnackBarText.CHANGE_PASSWORD_UN_SUCCESSFUL),
//            ));
//            progressDialog.hideProgress();
//          });
//        }
//        break;
//      case EventConstants.INVALID_OLD_PASSWORD:
//        {
//          setState(() {
//            oldPasswordController.text = "";
//            newPasswordController.text = "";
//            globalKey.currentState.showSnackBar(new SnackBar(
//              content: new Text(SnackBarText.INVALID_OLD_PASSWORD),
//            ));
//            progressDialog.hideProgress();
//          });
//        }
//        break;
//      case EventConstants.NO_INTERNET_CONNECTION:
//        {
//          setState(() {
//            oldPasswordController.text = "";
//            newPasswordController.text = "";
//            globalKey.currentState.showSnackBar(new SnackBar(
//              content: new Text(SnackBarText.NO_INTERNET_CONNECTION),
//            ));
//            progressDialog.hideProgress();
//          });
//        }
//        break;
//    }
//  }
//}
