import '../auth.dart';
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

      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: myAppBar(),
        body: FutureBuilder(
          future: ref.get(),
            builder: (context, snapshot){
              if (snapshot.data == null){
                return Center(
                  child: Text(
                    'Click on the add button to add a new note!',
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
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "${data['title']}",
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: getPriorityColor(data['priority']),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${data['description']}",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black87,
                                ),
                              ),
                            )
                          ],
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
        return Colors.orange.shade700;
        break;
      case 3:
        return Colors.green.shade900;
        break;

      default:
        return Colors.green.shade900;
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

  void updateListView() {
    setState(() { });
  }
}
