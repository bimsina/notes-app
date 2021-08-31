import 'dart:convert';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/utils/widgets.dart';

import '../auth.dart';
import 'auth_screen.dart';
import 'view_note.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/modal_class/notes.dart';
import 'package:notes_app/screens/note_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'note_detail.dart';


class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {

  AuthClass authClass = AuthClass();

  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('notes');

  // CollectionReference ref = FirebaseFirestore.instance.collection('notes');
  @override
  Widget build(BuildContext context) {

    Widget myAppBar() {
      return AppBar(
        title: Text(
            'Notes',
            style: Theme.of(context).textTheme.bodyText2
        ) ,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,

        leading: IconButton(
          icon: Icon(
            Icons.logout,
            color: Colors.black,
          ),
          onPressed: () {
            authClass.signOut();
            navigateToSignUp();
          },
        ),

      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(),
        body:FutureBuilder(
          future: ref.get(),
            builder: (context, snapshot){
              if (snapshot.data.docs.length==0){
                return Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Center(
                    child: Text(
                      'Click on the add button to add a new note!',

                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            else{
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index){
                  Map data= snapshot.data.docs[index].data();
                  DateTime mydateTime = data['created'].toDate();
                  String formattedTime =
                  DateFormat.yMMMd().add_jm().format(mydateTime);

                  return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (context) => ViewNote(
                            data,
                            // formattedTime,
                            snapshot.data.docs[index].reference,
                          ),
                        ),
                      )
                          .then((value) {
                        setState(() {});
                      });
                    },
                          child:Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: 190,
                              child: Card(
                                elevation: 10.0,
                                color: colors[int.parse("${data['color']}")],
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              child: Text(
                                                "${data['title']}",
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            getPriorityText(data['priority']),
                                            style: TextStyle(
                                              color:
                                              getPriorityColor(data['priority']),
                                            ),
                                          )],
                                      ),

                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "${data['description']}",
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                    );
                }
              );
            }

            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigateToDetail(Note('', '', 3, 0), 'Add Note');
          },
          tooltip: 'Add Note',
          shape: CircleBorder(side: BorderSide(color: Colors.black, width: 2.0)),
          child: Icon(Icons.add, color: Colors.black),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow[800];
        break;
      case 3:
        return Colors.green;
        break;

      default:
        return Colors.yellow;
    }
  }

  // Returns the priority icon
  String getPriorityText(int priority) {
    switch (priority) {
      case 1:
        return '!!!';
        break;
      case 2:
        return '!!';
        break;
      case 3:
        return '!';
        break;

      default:
        return '!';
    }
  }

  void navigateToDetail(Note note, String title) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => NoteDetail(note, title)));

    if (result == true) {
      updateListView();
    }
  }

  void navigateToSignUp() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  void updateListView() {
    setState(() { });
  }
}
