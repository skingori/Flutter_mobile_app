// import 'package:flutter/material.dart';
// import 'package:StPaulUniversity/utils/constants.dart';
// import 'package:StPaulUniversity/futures/app_futures.dart';

// class ChangePassword extends StatefulWidget {
//   @override
// //  createState() => new HomePageState();
//   _ChangePasswordState createState() => new _ChangePasswordState();
// }

// class _ChangePasswordState extends State<ChangePassword> {
//   final globalKey = new GlobalKey<ScaffoldState>();

//   TextEditingController oldPasswordController =
//       new TextEditingController(text: "");

//   TextEditingController newPasswordController =
//       new TextEditingController(text: "");

// Widget _changePasswordDialog() {
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

//            if (newPasswordController.text == "") {
//              globalKey.currentState.showSnackBar(new SnackBar(
//                content: new Text(SnackBarText.ENTER_NEW_PASS),
//              ));
//              return;
//            }

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

// //------------------------------------------------------------------------------

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

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
