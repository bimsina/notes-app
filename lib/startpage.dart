import 'package:flutter/material.dart';
import 'package:notes_app/Login.dart';
import 'package:notes_app/screens/note_list.dart';
import 'package:notes_app/Auth.dart';
import 'package:notes_app/Signup.dart';

class startpage extends StatefulWidget {

  @override
  _startpageState createState() => _startpageState();
}

class _startpageState extends State<startpage> {
  AuthClass authClass = AuthClass();
  Widget currentPage = Login();

  @override
  void initState() {
    super.initState();
    checkLogin();
    // authClass.signOut();
  }

  checkLogin() async {
    String tokne = await authClass.getToken();
    print("tokne");
    if (tokne != null)
      setState(() {
        currentPage = NoteList();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
    );
  }
}
